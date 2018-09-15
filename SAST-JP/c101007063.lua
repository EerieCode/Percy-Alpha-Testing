--Shiranui Story Saga
--Logical Nonsense
function c101007063.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,101007063+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c101007063.condition)
	e1:SetCost(c101007063.cost)
	e1:SetTarget(c101007063.target)
	e1:SetOperation(c101007063.activate)
	c:RegisterEffect(e1)
end
	--Checks if opponent controls a monster
function c101007063.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>0
end
	--delay cost until target because cost depends on it
function c100200151.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(100)
	return true
end
function c101007063.costfilter(c,e,tp)
	return c:IsDiscardable() and c:IsRace(RACE_ZOMBIE) and Duel.IsExistingMatchingCard(c101007063.spfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil,e,tp,c:GetCode())
end
	--Checks in the deck or GY for a "Shiranui" monster
function c101007063.spfilter(c,e,tp,code)
	return c:IsSetCard(0xd9) and c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and not c:IsCode(code)
end
	--perform cost while checking activation legality
function c101007063.target(c)
	if chk==0 then
		if e:GetLabel()~=100 then return false end
		e:SetLabel(0)
		return Duel.IsExistingMatchingCard(c101007063.costfilter,tp,LOCATION_HAND,0,1,nil,e,tp)
	end
	local g=Duel.SelectMatchingCard(tp,c101007063.costfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	e:SetLabelObject(g:GetFirst())
	Duel.SendtoGrave(g,REASON_COST+REASON_DISCARD)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
	--Performing the special summon
function c101007063.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local dc=e:GetLabelObject()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c101007063.spfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,e,tp,dc:GetCode())
	if #g>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c101007063.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
	--Restricts to zombie monsters for the rest of the turn
function c101007063.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsRace(RACE_ZOMBIE)
end