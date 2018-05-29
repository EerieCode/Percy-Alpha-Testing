--竜殺者
function c511003018.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(276357,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_CHANGE_POS)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c511003018.condition)
	e1:SetTarget(c511003018.target)
	e1:SetOperation(c511003018.operation)
	c:RegisterEffect(e1)
end
c511003018.listed_names={28563545}
function c511003018.cfilter(c)
	return bit.band(c:GetPreviousPosition(),POS_DEFENSE)~=0 and c:IsFaceup() and c:IsAttackPos() 
		and c:IsCode(28563545)
end
function c511003018.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511003018.cfilter,1,nil)
end
function c511003018.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_DRAGON)
end
function c511003018.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511003018.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511003018.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c511003018.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c511003018.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and c511003018.filter(tc) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
