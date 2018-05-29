--Ancient Gate
function c511000125.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511000125.condition)
	e1:SetCost(aux.RemainFieldCost)
	e1:SetTarget(c511000125.target)
	e1:SetOperation(c511000125.activate)
	c:RegisterEffect(e1)
end
c511000125.listed_names={511000122}
function c511000125.cfilter(c)
	return c:IsFaceup() and c:IsCode(511000122)
end
function c511000125.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511000125.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c511000125.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:IsHasType(EFFECT_TYPE_ACTIVATE) end
end
function c511000125.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsStatus(STATUS_LEAVE_CONFIRMED) then return end
	if not Duel.SelectYesNo(tp,aux.Stringid(511000125,0)) then
		c:CancelToGrave(false)
	end
end
