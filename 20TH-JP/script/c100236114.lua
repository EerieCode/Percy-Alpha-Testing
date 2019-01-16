--Cubic Ascension
local s,id=GetID()
function s.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(s.condition)
	e1:SetTarget(s.target)
	e1:SetOperation(s.operation)
	c:RegisterEffect(e1)
	--banish to summon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,id)
	e2:SetCondition(s.gscondition)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(s.gstarget)
	e2:SetOperation(s.gsoperation)
	c:RegisterEffect(e2)
end
function s.condition(e,tp,eg,ep,ev,re,r,rp)
	local a = Duel.GetAttacker()
	return a:IsControler(1-tp)
end
function s.spfilter(c,e,tp)
	return c:IsCode(15610297) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk == 0 then return Duel.GetLocationCount(tp,LOCATION_MZONE) > 0
		and Duel.IsExistingMatchingCard(s.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function s.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE) <= 0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,s.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp):GetFirst()
	if tc and Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP) ~= 0 then
		Duel.CalculateDamage(Duel.GetAttacker(),tc)
	end
end
function s.gscondition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLP(1-tp) - Duel.GetLP(tp) >= 2000
end
function s.gstarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk == 0 then return Duel.GetLocationCount(tp,LOCATION_MZONE) > 0
		and Duel.IsExistingMatchingCard(s.spfilter,tp,LOCATION_DECK|LOCATION_HAND|LOCATION_GRAVE,0,1,nil,e,tp) end
	local count = (Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0) == 0 and Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE) > 0) and 3 or 1
	e:SetLabel(count)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK|LOCATION_HAND|LOCATION_GRAVE)
end
function s.gsoperation(e,tp,eg,ep,ev,re,r,rp)
	local ft = Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft <= 0 then return end
	local count = e:GetLabel()
	ft = Duel.IsPlayerAffectedByEffect(tp,CARD_BLUEEYES_SPIRIT) and 1 or math.min(count,ft)
	local sg=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(s.spfilter),tp,LOCATION_DECK|LOCATION_HAND|LOCATION_GRAVE,0,1,ft,nil,e,tp)
	if #sg > 0 then
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
	end
end
