--Consolation Prize
--Logical Nonsense
function c101006081.initial_effect(c)
	--Special summon from the GY
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(101006081,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCountLimit(1,101006081)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c101006081.condition)
	e1:SetTarget(c101006081.target)
	e1:SetOperation(c101006081.operation)
	c:RegisterEffect(e1)
end
	--Check for monsters that were sent from the hand
function c101006081.filter(c,tp)
	return c:IsType(TYPE_MONSTER) and c:IsPreviousLocation(LOCATION_HAND) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
	--Check if this ever happened
function c101006081.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c101006081.filter,1,nil,tp)
end
	--Activation legality
function c101006081.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c101006081.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c101006081.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c101006081.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
	--Performing the effect
function c101006081.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end