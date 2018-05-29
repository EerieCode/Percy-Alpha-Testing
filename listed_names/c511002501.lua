--グレート・モス (Anime)
--Great Moth (Anime)
function c511002501.initial_effect(c)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c511002501.spcon)
	e1:SetOperation(c511002501.spop)
	c:RegisterEffect(e1)
	--gain
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_DAMAGE_STEP_END)
	e2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
	e2:SetCountLimit(1)
	e2:SetOperation(c511002501.atkop)
	c:RegisterEffect(e2)
end
c511002501.listed_names={40240595,58192742}
function c511002501.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_PHASE_START+PHASE_DRAW)
	e1:SetOperation(c511002501.atkval)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_PHASE_START+PHASE_STANDBY)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_PHASE_START+PHASE_MAIN1)
	c:RegisterEffect(e3)
	local e4=e1:Clone()
	e4:SetCode(EVENT_PHASE_START+PHASE_BATTLE_START)
	c:RegisterEffect(e4)
	local e5=e1:Clone()
	e5:SetCode(EVENT_PHASE_START+PHASE_MAIN2)
	c:RegisterEffect(e5)
	local e6=e1:Clone()
	e6:SetCode(EVENT_PHASE_START+PHASE_END)
	c:RegisterEffect(e6)
end
function c511002501.atkval(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
	for c in aux.Next(g) do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-100)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		c:RegisterEffect(e2)
	end
end
function c511002501.eqfilter(c)
	return c:IsCode(40240595) and c:GetTurnCounter()>=4
end
function c511002501.rfilter(c)
	return c:IsCode(58192742) and c:GetEquipGroup():IsExists(c511002501.eqfilter,1,nil)
end
function c511002501.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-1
		and Duel.CheckReleaseGroup(c:GetControler(),c511002501.rfilter,1,nil)
end
function c511002501.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.SelectReleaseGroup(c:GetControler(),c511002501.rfilter,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c511002501.atkfilter(e,c)
	return c:IsAttribute(ATTRIBUTE_EARTH)
end