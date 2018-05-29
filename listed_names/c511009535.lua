--En Winds
--fixed by MLD
function c511009535.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511009535.condition)
	c:RegisterEffect(e1)
	--disable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE+LOCATION_GRAVE+LOCATION_REMOVED,LOCATION_MZONE+LOCATION_GRAVE+LOCATION_REMOVED)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsType,TYPE_SYNCHRO))
	e2:SetCode(EFFECT_DISABLE)
	c:RegisterEffect(e2)
	--type
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_MZONE+LOCATION_GRAVE+LOCATION_REMOVED,LOCATION_MZONE+LOCATION_GRAVE+LOCATION_REMOVED)
	e3:SetCode(EFFECT_CHANGE_TYPE)
	e3:SetTarget(aux.TargetBoolFunction(Card.IsType,TYPE_SYNCHRO))
	e3:SetValue(TYPE_NORMAL)
	c:RegisterEffect(e3)
end
c511009535.listed_names={511009536}
function c511009535.filter(c)
	return c:IsFaceup() and c:IsCode(511009536) and c:GetSequence()<5
end
function c511009535.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511009535.filter,tp,LOCATION_SZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_GRAVE,0,3,nil,TYPE_SYNCHRO)
end
