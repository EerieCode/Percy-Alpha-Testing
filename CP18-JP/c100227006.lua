--Iron Hans
--e1 scripted by Naim
function c100227006.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(100227006,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCountLimit(100227004,1)
	e1:SetTarget(c100227006.target)
	e1:SetOperation(c100227006.operation)
	c:RegisterEffect(e1)
end
function c100227006.cfilter(c)
	return c:IsFaceup() and c:IsCode(50319138)
end
function c100227004.equipcond(c)
	return c:IsFaceup() and c:IsCode(100227010) and c:GetSequence()==5
end
function c100227006.spfilter(c,e,tp)
	return c:IsCode(87526784) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c100227006.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c100227006.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c100227006.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c100227006.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c100227006.operation(e,tp,eg,ep,ev,re,r,rp,chk)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if not Duel.IsExistingMatchingCard(c100227006.cfilter,tp,LOCATION_ONFIELD,0,1,nil) then return end
	local tc=Duel.GetFirstMatchingCard(c100227006.spfilter,tp,LOCATION_DECK,0,nil,e,tp)
	if tc then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c100227006.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
end