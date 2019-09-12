--クロス・オーバー
--Cross Over
--Scripted by Eerie Code
local s,id=GetID()
function s.initial_effect(c)
    --activate
    local e1=Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_EQUIP)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
    e1:SetTarget(s.target)
    e1:SetOperation(s.activate)
    c:RegisterEffect(e1)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    local f1=aux.FilterFaceupFunction(Card.IsRace,RACE_WARRIOR)
    if chkc then return false end
    if chk==0 then return Duel.IsExistingTarget(f1,tp,LOCATION_MZONE,0,1,nil)
        and Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil)
        and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
    local g=Duel.SelectTarget(tp,f1,tp,LOCATION_MZONE,0,1,1,nil)
    e:SetLabelObject(g:GetFirst())
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
    Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
    local g=Duel.GetTargetCards(e)
    if #g<2 then return end
    local tc=g:GetFirst()
    local oc=g:GetNext()
    if oc==e:GetLabelObject() then tc,oc=oc,tc end
    if tc:IsFaceup() and tc:IsLocation(LOCATION_MZONE) then
        Duel.Equip(tp,tc,oc)
        --no battle damage
        local e1=Effect.CreateEffect(e:GetHandler())
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_NO_BATTLE_DAMAGE)
        e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
        tc:RegisterEffect(e1)
        --substitute
        local e2=Effect.CreateEffect(e:GetHandler())
        e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
        e2:SetCode(EFFECT_DESTROY_REPLACE)
        e2:SetReset(RESET_EVENT+RESETS_STANDARD)
        e2:SetLabelObject(oc)
        e2:SetTarget(s.reptg)
        e2:SetOperation(s.repop)
        tc:RegisterEffect(e2)   
        --Equip limit
        local e3=Effect.CreateEffect(e:GetHandler())
        e3:SetType(EFFECT_TYPE_SINGLE)
        e3:SetCode(EFFECT_EQUIP_LIMIT)
        e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
        e3:SetValue(s.eqlimit)
        e3:SetReset(RESET_EVENT+RESETS_STANDARD)
        e3:SetLabelObject(ec)
        oc:RegisterEffect(e3)
    else Duel.SendtoGrave(oc,REASON_RULE) end
end
function s.eqlimit(e,c)
    return c==e:GetLabelObject()
end
function s.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
    local c=e:GetHandler()
    local ec=e:GetLabelObject()
    if chk==0 then return not c:IsReason(REASON_REPLACE) and c:IsOnField() and c:IsFaceup() 
        and ec and c:GetEquipGroup():IsContains(ec) 
        and ec:IsDestructable(e) and not ec:IsStatus(STATUS_DESTROY_CONFIRMED) end
    if Duel.SelectEffectYesNo(tp,c,96) then
        ec:SetStatus(STATUS_DESTROY_CONFIRMED,true)
        return true
    else return false end
end
function s.repop(e,tp,eg,ep,ev,re,r,rp)
    Duel.Destroy(e:GetLabelObject(),REASON_EFFECT+REASON_REPLACE)
end
