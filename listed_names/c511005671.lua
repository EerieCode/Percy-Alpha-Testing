--Anti Raigeki (DOR)
--scripted by GameMaster (GM)
function c511005671.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c511005671.condition)
	e1:SetTarget(c511005671.target)
	e1:SetOperation(c511005671.activate)
	c:RegisterEffect(e1)
	--negate rageki
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_NEGATE)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_QUICK_F)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c511005671.condition)
	e2:SetTarget(c511005671.target)
	e2:SetOperation(c511005671.activate)
	c:RegisterEffect(e2)
end
c511005671.listed_names={12580477}
function c511005671.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return re:IsActiveType(TYPE_SPELL,12580477) and c:GetFieldID(12580477) and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev) 
end
function c511005671.filter(c)
	return c:IsCode(12580477)
end
function c511005671.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511005671.filter,tp,LOCATION_SZONE,LOCATION_SZONE,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end
function c511005671.activate(e,tp,eg,ep,ev,re,r,rp)
	if not re:GetHandler(12580477) then end
	Duel.NegateActivation(ev)
end
