--無限の降魔鏡
function c100000080.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)	
	--SpSummon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_SZONE)		
	e2:SetCondition(c100000080.spcon)
	e2:SetTarget(c100000080.sptg)
	e2:SetOperation(c100000080.spop)
	c:RegisterEffect(e2)	
	--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e4:SetRange(LOCATION_FZONE)
	e4:SetCode(EVENT_DESTROYED)
	e4:SetCondition(c100000080.descon)
	e4:SetOperation(c100000080.desop)
	c:RegisterEffect(e4)	
end
c100000080.listed_names={100000081,100000081}
function c100000080.cfilter(c)
	return c:IsFaceup() and c:IsCode(100000081)
end
function c100000080.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c100000080.cfilter,Duel.GetTurnPlayer(),LOCATION_MZONE,0,1,nil)
end
function c100000080.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local p=Duel.GetTurnPlayer()
	local ct=Duel.GetLocationCount(p,LOCATION_MZONE,p,LOCATION_REASON_COUNT)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,ct,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,ct,p,0)
end
function c100000080.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local p=Duel.GetTurnPlayer()
	local ct=Duel.GetLocationCount(p,LOCATION_MZONE,p,LOCATION_REASON_COUNT)
	local ft=Duel.GetLocationCount(p,LOCATION_MZONE)
	if Duel.IsPlayerAffectedByEffect(p,59822133) then ft=math.min(ft,1) end
	if ft~=ct or ct<=0 
		or not Duel.IsPlayerCanSpecialSummonMonster(p,100000082,0,0x4011,3000,1000,10,RACE_FIEND,ATTRIBUTE_DARK) then return end
	for i=1,ft do
		local token=Duel.CreateToken(p,100000082)
		Duel.SpecialSummonStep(token,0,p,p,false,false,POS_FACEUP)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		token:RegisterEffect(e1,true)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e2:SetValue(1)
		token:RegisterEffect(e2,true)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e3:SetCode(EVENT_BATTLE_DESTROYING)
		e3:SetCondition(aux.bdocon)
		e3:SetLabel(p)
		e3:SetOperation(c100000080.damop)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		token:RegisterEffect(e3,true)
	end
	Duel.SpecialSummonComplete()
end
function c100000080.desfilter(c)
	return c:IsCode(100000081) and c:IsPreviousLocation(LOCATION_ONFIELD)
end
function c100000080.descon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c100000080.desfilter,1,nil)
end
function c100000080.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_MZONE,LOCATION_MZONE,nil,100000082)
	Duel.Destroy(g,REASON_EFFECT)
end
function c100000080.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Damage(1-e:GetLabel(),700,REASON_EFFECT)
end
