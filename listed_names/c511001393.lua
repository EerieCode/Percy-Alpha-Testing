--Scab Scream
function c511001393.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_TOGRAVE+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetCondition(c511001393.condition)
	e1:SetTarget(c511001393.target)
	e1:SetOperation(c511001393.activate)
	c:RegisterEffect(e1)
end
c511001393.listed_names={100000224,511001394,100000224}
function c511001393.condition(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local at=Duel.GetAttackTarget()
	return at and at:IsControler(tp) and at:IsFaceup() and at:IsCode(100000224) and a:IsAttackAbove(2000)
end
function c511001393.filter(c,e,tp)
	return c:IsCode(511001394) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c511001393.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local a=Duel.GetAttacker()
	local at=Duel.GetAttackTarget()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if chk==0 then return a:IsOnField() and at:IsAbleToGrave() and ft>-1 and (ft>0 or at:GetSequence()<5)
		and Duel.IsExistingMatchingCard(c511001393.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetTargetCard(a)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,a,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c511001393.activate(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local at=Duel.GetAttackTarget()
	if a and a:IsRelateToEffect(e) and Duel.Destroy(a,REASON_EFFECT)>0 and at and at:IsCode(100000224) then
		Duel.BreakEffect()
		if Duel.SendtoGrave(at,REASON_EFFECT)>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local g=Duel.SelectMatchingCard(tp,c511001393.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
			if g:GetCount()>0 then
				Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)
			end
		end
	end
end
