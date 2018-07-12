--Orphegel Scherzon
function c101006015.initial_effect(c)
	
	-- special summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(101006015,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCost(aux.bfgcost)
	e3:SetCountLimit(1,101006015)
	e3:SetTarget(c101006015.sptg)
	e3:SetOperation(c101006015.spop)
	c:RegisterEffect(e3)
end
function c101006015.spfilter(c,e,tp)
	return c:IsSetCard(0x226) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and not c:IsCode(101006015)
end
function c101006015.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c101006015.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c101006015.spfilter,tp,LOCATION_GRAVE,0,1,e:GetHandler(),e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tg=Duel.SelectTarget(tp,c101006015.spfilter,tp,LOCATION_GRAVE,0,1,1,e:GetHandler(),e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,tg,1,0,0)
end
function c101006015.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end

