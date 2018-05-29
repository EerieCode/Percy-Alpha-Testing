--New Year Drum
function c511002146.initial_effect(c)
	aux.AddEquipProcedure(c)
	--sp summon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BE_BATTLE_TARGET)
	e2:SetCondition(c511002146.spcon)
	e2:SetTarget(c511002146.sptg)
	e2:SetOperation(c511002146.spop)
	e2:SetRange(LOCATION_SZONE)
	c:RegisterEffect(e2)
end
c511002146.listed_names={511002145}
function c511002146.spcon(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	return d and d==e:GetHandler():GetEquipTarget()
end
function c511002146.filter(c,e,tp)
	return c:IsCode(511002145) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511002146.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c511002146.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511002146.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 and Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)>0 then
		Duel.ChangeAttackTarget(g:GetFirst())
	end
end
