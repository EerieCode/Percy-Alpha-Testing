--Cubic Karma (movie)
function c511004442.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511004442.target)
	e1:SetOperation(c511004442.operation)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c511004442.condition0)
	e2:SetCost(c511004442.cost0)
	e2:SetTarget(c511004442.target0)
	e2:SetOperation(c511004442.operation0)
	c:RegisterEffect(e2)
	if not c511004442.global_check then
		c511004442.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511004442.archchk)
		Duel.RegisterEffect(ge2,0)
	end
end
c511004442.listed_names={15610297}
function c511004442.archchk(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(0,420)==0 then 
		Duel.CreateToken(tp,420)
		Duel.CreateToken(1-tp,420)
		Duel.RegisterFlagEffect(0,420,0,0,0)
	end
end
function c511004442.filter1(c)
	return c:IsType(TYPE_MONSTER) and c:IsFaceup() and c:IsSetCard(0xe3)
end
function c511004442.filter2(c)
	return c:IsCode(15610297)
end
function c511004442.target(e,tp,eg,ev,ep,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511004442.filter1,tp,LOCATION_MZONE,0,1,nil) and Duel.GetMatchingGroupCount(c511004442.filter2,tp,LOCATION_HAND,0,nil)~=0 end
	local tg=Duel.SelectMatchingCard(tp,c511004442.filter1,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetTargetCard(tg)
end
function c511004442.operation(e,tp,eg,ev,ep,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) then return end
	local mg=Duel.GetMatchingGroup(c511004442.filter2,tp,LOCATION_HAND,0,nil)
	if mg:GetCount()==0 then return end
	Duel.Overlay(tc,mg)
end
function c511004442.filter3(c,tp)
	return c:IsType(TYPE_MONSTER) and c:IsCubicSeed()
end
function c511004442.condition0(e,tp,eg,ev,ep,re,r,rp)
	return eg:IsExists(c511004442.filter3,1,nil,tp) and re:GetHandler():IsType(TYPE_MONSTER) and re:GetHandler():IsSetCard(0xe3) and Duel.GetTurnPlayer()~=tp
end
function c511004442.cost0(e,tp,eg,ev,ep,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToGraveAsCost() end
	Duel.SendtoGrave(c,REASON_COST)
end
function c511004442.target0(e,tp,eg,ev,ep,re,r,rp,chk)
	if chk==0 then return true end
end
function c511004442.operation0(e,tp,eg,ev,ep,re,r,rp)
	local lp=Duel.GetLP(1-tp)
	Duel.SetLP(1-tp,math.floor(lp/2))
end
--15610297 vijam