--Ｂ・Ｆ・Ｎ
--Battlewasp - Nest
--Scripted by AlphaKretin
local CTR_BEE_NEST
local s,id=GetID()
function s.initial_effect(c)
    c:EnableCounterPermit(CTR_BEE_NEST)
    --Activate
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    c:RegisterEffect(e1)
    --Special Summon
    local e2=Effect.CreateEffect(c)
    e2:SetDescription(aux.Stringid(id,0))
    e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
    e2:SetCode(EVENT_BE_BATTLE_TARGET)
    e2:SetRange(LOCATION_SZONE)
    e2:SetCountLimit(1,id)
    e2:SetCondition(s.spcon)
    e2:SetTarget(s.sptg)
    e2:SetOperation(s.spop)
    c:RegisterEffect(e2)
    --To grave
    local e3=Effect.CreateEffect(c)
    e3:SetDescription(aux.Stringid(id,1))
    e3:SetCategory(CATEGORY_TOGRAVE)
    e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    e3:SetCode(EVENT_PHASE+PHASE_END)
    e3:SetRange(LOCATION_SZONE)
    e3:SetCondition(s.tgcon)
    e3:SetOperation(s.tgop)
    c:RegisterEffect(e3)
end
function s.spcon(e,tp,eg,ep,ev,re,r,rp)
    local d=Duel.GetAttackTarget()
    return d and d:IsControler(tp) and d:IsFaceup() and d:IsSetCard(0x22c)
end
function s.spfilter(c,e,tp)
    return c:IsSetCard(0x22c) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
    local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
    if e:GetHandler():GetSequence()<5 then ft=ft+1 end
    if chk==0 then return ft>0 and Duel.IsExistingMatchingCard(s.spfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,e,tp) end
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_HAND)
end 
function s.spop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler(c)
    if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
        Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
        local g=Duel.SelectMatchingCard(tp,s.spfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,e,tp)
        if #g>0 and Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)~=0 
            and c:IsCanAddCounter(CTR_BEE_NEST,1) and c:AddCounter(CTR_BEE_NEST,1) then
                Duel.BreakEffect()
                Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE_STEP,1)
        end
    end
end
function s.tgcon(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():GetCounter(CTR_BEE_NEST)>=2
end
function s.tgop(e,tp,eg,ep,ev,re,r,rp)
    Duel.SendtoGrave(e:GetHandler(),REASON_EFFECT)
end
