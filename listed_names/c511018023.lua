--Fusion Destruction
--fixed by MLD
function c511018023.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511018023.cost)
	e1:SetTarget(c511018023.target)
	e1:SetOperation(c511018023.activate)
	c:RegisterEffect(e1)
	--Negate
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c511018023.negcon)
	e2:SetTarget(c511018023.negtg)
	e2:SetOperation(c511018023.negop)
	c:RegisterEffect(e2)
end
c511018023.listed_names={24094653}
function c511018023.cfilter(c)
	return c:IsCode(24094653) and c:IsAbleToGraveAsCost()
end
function c511018023.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511018023.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local tc=Duel.SelectMatchingCard(tp,c511018023.cfilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.SendtoGrave(tc,REASON_COST)
end
function c511018023.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsSetCard(0x46) and c:IsAbleToRemove()
end
function c511018023.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk then return Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)>0 end
	local g=Duel.GetMatchingGroup(c511018023.filter,tp,0,LOCATION_DECK,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,300)
end
function c511018023.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetFieldGroup(tp,0,LOCATION_DECK)
	Duel.ConfirmCards(tp,g)
	local rg=g:FilterSelect(tp,c511018023.filter,1,3,nil)
	if rg:GetCount()>0 and Duel.Remove(rg,0,REASON_EFFECT)>0 then
		local ct=rg:FilterCount(Card.IsLocation,nil,LOCATION_REMOVED)
		if ct>0 then
			Duel.BreakEffect()
			Duel.Damage(1-tp,ct*300,REASON_EFFECT)
		end
	end
end
function c511018023.negcon(e,tp,eg,ep,ev,re,r,rp)
	if rp==tp then return false end
	local rc=re:GetHandler()
	return rc:IsSetCard(0x46) and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev)
end
function c511018023.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,300)
	end
end
function c511018023.negop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) and Duel.Destroy(eg,REASON_EFFECT)>0 then
		Duel.BreakEffect()
		Duel.Damage(1-tp,300,REASON_EFFECT)
	end
end
