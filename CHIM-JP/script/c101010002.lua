--海晶乙女マンダリン
--Marincess Mandarin
local s,id=GetID()
function s.initial_effect(c)
	--special summon
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1,id)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e1:SetCondition(s.spcon)
	e1:SetTarget(s.sptg)
	e1:SetOperation(s.spop)
end
s.listed_series={0x12b}
function s.spfiltercon(c)
	return c:IsFaceup() and c:IsSetCard(0x12b)
end
function s.spfiltertg(c)
	return c:IsSetCard(0x12b) and c:IsType(TYPE_LINK) and c:IsAttribute(ATTRIBUTE_WATER) and c:GetController(tp)

function s.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(s.spfiltercon,tp,LOCATION_ONFIELD,0,2,nil)
end

function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local zone=Duel.GetZoneWithLinkedCount(1,tp)
	if chk==0 then return Duel.IsExistingMatchingCard(s.filtertg,tp,LOCATION_MZONE,0,1,nil,e,tp,zone) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	local zone=Duel.GetZoneWithLinkedCount(1,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,s.filtertg,tp,LOCATION_MZONE,0,1,1,nil,e,tp,zone)
	if #g>0 then
		Duel.SpecialSummonStep(g,0,tp,tp,false,false,POS_FACEUP,zone)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetReset(RESET_EVENT+RESETS_REDIRECT)
		e2:SetValue(LOCATION_REMOVED)
		c:RegisterEffect(e2,true)
		Duel.SpecialSummonComplete()
	end
end