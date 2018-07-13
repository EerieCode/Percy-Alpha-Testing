--ダイプレクサ・キマイラ
--Diplexer Chimera
--Scripted by Eerie Code
function c101006038.initial_effect(c)
    --fusion material
    aux.AddFusionProcMixN(c,true,true,aux.FilterBoolFunctionEx(Card.IsRace,RACE_CYBERSE),2)
    c:EnableReviveLimit()
    --lock
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(101006038,0))
    e1:SetType(EFFECT_TYPE_IGNITION)
    e1:SetRange(LOCATION_MZONE)
    e1:SetCountLimit(1)
    e1:SetCost(c101006038.cost)
    e1:SetOperation(c101006038.operation)
    c:RegisterEffect(e1)
    --search
    local e2=Effect.CreateEffect(c)
    e2:SetDescription(aux.Stringid(101006038,1))
    e2:SetCategory(CATEGORY_TOHAND)
    e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e2:SetCode(EVENT_TO_GRAVE)
    e2:SetProperty(EFFECT_FLAG_DELAY)
    e2:SetCountLimit(1,101006038)
    e2:SetCondition(c101006038.thcon)
    e2:SetTarget(c101006038.thtg)
    e2:SetOperation(c101006038.thop)
    c:RegisterEffect(e2)
end
function c101006038.cost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.CheckReleaseGroupCost(tp,Card.IsRace,1,false,nil,nil,RACE_CYBERSE) end
    local sg=Duel.SelectReleaseGroupCost(tp,Card.IsRace,1,1,false,nil,nil,RACE_CYBERSE)
    Duel.Release(sg,REASON_COST)
end
function c101006038.operation(e,tp,eg,ep,ev,re,r,rp)
    local e1=Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetCode(EFFECT_CANNOT_ACTIVATE)
    e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e1:SetTargetRange(1,1)
    e1:SetCondition(c101006038.accon)
    e1:SetValue(c101006038.aclimit)
    e1:SetReset(RESET_PHASE+PHASE_END)
    Duel.RegisterEffect(e1,tp)
end
function c101006038.accon(e)
    local ph=Duel.GetCurrentPhase()
    return ph>PHASE_MAIN1 and ph<PHASE_MAIN2
end
function c101006038.aclimit(e,re,tp)
    return re:IsActiveType(TYPE_SPELL+TYPE_TRAP)
end
function c101006038.thcon(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    return c:IsPreviousLocation(LOCATION_MZONE) and c:IsSummonType(SUMMON_TYPE_FUSION)
end
function c101006038.filter1(c)
    return c:IsRace(RACE_CYBERSE) and c:IsAbleToHand()
end
function c101006038.filter2(c)
    return c:IsCode(101006050) and c:IsAbleToHand()
end
function c101006038.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chkc then return false end
    if chk==0 then return Duel.IsExistingTarget(c101006038.filter1,tp,LOCATION_GRAVE,0,1,e:GetHandler())
        and Duel.IsExistingTarget(c101006038.filter2,tp,LOCATION_GRAVE,0,1,nil) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
    local g1=Duel.SelectTarget(tp,c101006038.filter1,tp,LOCATION_GRAVE,0,1,1,e:GetHandler())
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
    local g2=Duel.SelectTarget(tp,c101006038.filter2,tp,LOCATION_GRAVE,0,1,1,nil)
    g1:Merge(g2)
    Duel.SetOperationInfo(0,CATEGORY_TOHAND,g1,2,0,0)
end
function c101006038.thop(e,tp,eg,ep,ev,re,r,rp)
    local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
    local sg=g:Filter(Card.IsRelateToEffect,nil,e)
    if sg:GetCount()>0 then
        Duel.SendtoHand(sg,nil,REASON_EFFECT)
        Duel.ConfirmCards(1-tp,sg)
    end
end
