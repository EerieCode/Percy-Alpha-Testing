--セクステット・サモン
--Sextet Summon
--Scripted by Eerie Code
local s,id=GetID()
local TYPE_FULL=TYPE_FUSION+TYPE_RITUAL+TYPE_SYNCHRO+TYPE_XYZ+TYPE_PENDULUM+TYPE_LINK 
function s.initial_effect(c)
    --activate
    local e1=Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
    e1:SetTarget(s.target)
    e1:SetOperation(s.activate)
    c:RegisterEffect(e1)
end
function s.cfilter(c)
    return c:IsType(TYPE_FULL)
        and (c:IsFaceup() or not c:IsLocation(LOCATION_MZONE)) and c:IsAbleToRemove()
end
function s.spfilter(c,e,tp,rc)
    return c:GetOriginalRace()==rc and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function s.tcheck(c,sg,cg,tps)
    if tps==0 then return true end
    local ct=c:GetOriginalType()
    for _,ty in {TYPE_FUSION,TYPE_RITUAL,TYPE_SYNCHRO,TYPE_XYZ,TYPE_PENDULUM,TYPE_LINK } do
        if ct&ty~=0 and ct&tps~=0 then
            local mg=cg:Clone()
            mg:AddCard(c)
            if sg:IsExists(s.tcheck,1,mg,sg,mg,tps-ty) then return true end
        end
    end
    return false
end
function s.check(sg,e,tp,mg)
    local loc=0
    if aux.ChkfMMZ(1)(sg,e,tp,mg) then loc=loc+LOCATION_MZONE end
    if Duel.GetLocationCountFromEx(tp,tp,sg)>0 then loc=loc+LOCATION_EXTRA end
    return #sg==6 and sg:GetClassCount(Card.GetOriginalRace)==1 and loc~=0 
        and Duel.IsExistingMatchingCard(s.spfilter,tp,loc,0,1,nil,e,tp,sg:GetFirst():GetOriginalRace())
        and sg:IsExists(s.tcheck,1,nil,sg,Group.CreateGroup(),TYPE_FULL)
end
function s.cost(e,tp,eg,ep,ev,re,r,rp,chk)
    e:SetLabel(100)
    return true
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then
        local g=Duel.GetMatchingGroup(s.cfilter,tp,LOCATION_HAND+LOCATION_MZONE+LOCATION_GRAVE,0,nil)
        return aux.SelectUnselectGroup(g,e,tp,6,6,s.check,0)
    end
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_EXTRA)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
    local g=Duel.GetMatchingGroup(s.cfilter,tp,LOCATION_HAND+LOCATION_MZONE+LOCATION_GRAVE,0,nil)
    local rg=aux.SelectUnselectGroup(g,e,tp,6,6,s.check,1,tp,HINTMSG_REMOVE)
    if #rg==6 and Duel.Remove(rg,POS_FACEUP,REASON_EFFECT)==6 then
        Duel.BreakEffect()
        local rc=rg:GetFirst():GetOriginalRace()
        local loc=0
        if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then loc=loc+LOCATION_MZONE end
        if Duel.GetLocationCountFromEx(tp)>0 then loc=loc+LOCATION_EXTRA end
        if loc==0 then return end
        Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
        local sg=Duel.SelectMatchingCard(tp,s.spfilter,tp,loc,0,1,1,nil,e,tp,rc)
        if #sg>0 then
            Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
        end
    end
end
