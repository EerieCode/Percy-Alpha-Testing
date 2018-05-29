--Performapal Sky Illusion
--fixed by MLD
function c511009404.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511009404.condition)
	e1:SetTarget(c511009404.target)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_SPELLCASTER))
	e2:SetValue(1)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	c:RegisterEffect(e3)
	--cannot be battle target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetValue(c511009404.atlimit)
	c:RegisterEffect(e2)
	 --Self Destruct
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetRange(LOCATION_SZONE)
	e3:SetOperation(c511009404.desop)
	c:RegisterEffect(e3)
end
c511009404.listed_names={73734821,73734821}
function c511009404.cfilter(c)
	return c:IsFaceup() and c:IsCode(73734821) and Duel.IsExistingMatchingCard(c511009404.filter,tp,LOCATION_MZONE,0,1,c)
end
function c511009404.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_SPELLCASTER) 
end
function c511009404.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511009404.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c511009404.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	e:GetHandler():RegisterFlagEffect(511009404,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,0)
end
function c511009404.atlimit(e,c)
	return c:IsFaceup() and c:IsRace(RACE_SPELLCASTER) and not c:IsCode(73734821)
end
function c511009404.desop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():GetFlagEffect(511009404)>0 then
		Duel.Destroy(e:GetHandler(),REASON_EFFECT)
	end
end
