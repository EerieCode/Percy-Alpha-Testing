--鉄の王 ドヴェルグス
--Dvergs, Generaid of Iron
--Scripted by AlphaKretin and [anyone else who helps optimise/fix it]
local s,id=GetID()
function s.initial_effect(c)
	c:SetUniqueOnField(1,0,id)
	--destroy
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(id,0))
    e1:SetCategory(CATEGORY_SPSUMMON)
    e1:SetType(EFFECT_TYPE_QUICK_O)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetCountLimit(1,id)
    e1:SetRange(LOCATION_MZONE)
    e1:SetCost(s.spcost)
    e1:SetTarget(s.sptg)
    e1:SetOperation(s.spop)
    c:RegisterEffect(e1)
end
function s.cfilter(c)
    return c:IsSetCard(0x232) or c:IsRace(RACE_MACHINE)
end
function s.spfilter(c,e,tp)
    return (c:IsSetCard(0x232) or c:IsRace(RACE_MACHINE)) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
end
function Group.GetClass(g,f,...)
    local t={}
    for tc in aux.Next(g) do
        table.insert(t,f(tc,table.unpack({...})))
    end
    return t
end
function s.codefilter(c,g)
    for tc in aux.Next(g) do
        if c:IsCode(g:GetCode()) then
            return false
        end
    end
    return true
end
function s.rescon(g)
	local cd=g:GetClass(Card.GetCode)
    return function(sg,e,tp,mg)
        return sg:GetClassCount(Card.GetCode)==#sg and not sg:IsExists(Card.IsCode,1,nil,table.unpack(cd)) --(s.codefilter,1,nil,g)
    end
end
function s.spcheck(sg,tp,e)
    local g=Duel.GetMatchingCard(s.spfilter,tp,LOCATION_HAND,0,nil,e,tp)
	local cd=sg:GetClass(Card.GetCode)
    return Duel.GetLocationCount(tp,LOCATION_MZONE)+sg:FilterCount(Card.IsInMainMZone,nil,tp)>0 
        --and aux.SelectUnselectGroup(g,e,tp,#sg,#sg,s.rescon(sg),chk)
	and g:Filter(aux.NOT(Card.IsCode,table.unpack({cd})),nil):GetClassCount(Card.GetCode)>=#sg
end
function s.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.CheckReleaseGroupCost(tp,s.cfilter,1,false,s.spcheck,nil,e) end
    local max=99
    if Duel.IsPlayerAffectedByEffect(tp,CARD_BLUEEYES_SPIRIT) then max=1 end
    local g=Duel.SelectReleaseGroupCost(tp,s.cfilter,1,max,false,s.spcheck,nil,e)
    local ct=Duel.Release(g,REASON_COST)
    g:KeepAlive()
    e:SetLabelObject(g)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
    --local g=Duel.GetMatchingCard(s.spfilter,tp,LOCATION_HAND,0,nil,e,tp)
    if chk==0 then return true end
    local rg=e:GetLabelObject()
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,#rg,tp,LOCATION_HAND)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
    local g=Duel.GetMatchingCard(s.spfilter,tp,LOCATION_HAND,0,nil,e,tp)
    local rg=e:GetLabelObject()
    local ct=math.min(#rg,Duel.GetLocationCount(tp,LOCATION_MZONE))
    if not ct>0 then return end
    if Duel.IsPlayerAffectedByEffect(tp,CARD_BLUEEYES_SPIRIT) then ct=1 end
    local sg=aux.SelectUnselectGroup(g,e,tp,ct,ct,s.rescon(rg),1,tp,HINTMSG_SPSUMMON)
    if #sg>0 then
        Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
    end
end
