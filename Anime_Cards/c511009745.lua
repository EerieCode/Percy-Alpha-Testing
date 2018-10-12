--キャプチャー・ドローン
--Capture Drone
--Credits to Cybercatman
--fixed by Logical Nonsense & Larry126

local s,id=GetID()

function s.initial_effect(c)
	--Activate, need to control a "Drone" monster
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(s.actcon)
	e1:SetTarget(s.target)
	e1:SetOperation(s.operation)
	c:RegisterEffect(e1)
	--Self-destruction
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetCondition(s.descon)
	e2:SetOperation(s.desop)
	c:RegisterEffect(e2)
	--Tokens
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(s.tkcon)
	e3:SetTarget(s.tktg)
	e3:SetOperation(s.tkop)
	c:RegisterEffect(e3)
	--Opponent's link monsters cannot attack
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_CANNOT_ATTACK)
	e4:SetRange(LOCATION_SZONE)
	e4:SetTargetRange(0,LOCATION_MZONE)
	e4:SetTarget(s.atktg)
	c:RegisterEffect(e4)
end
--Check for "Drone" monster
function s.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x581)
end
--Check if you do control "Drone" monster
function s.actcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(s.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
--Check for link monster controlled by opponent
function s.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_LINK)
end
--Activation legality
function s.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and s.filter(chkc) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(s.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,s.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,g,1,0,0)
end
--Performing the multiple limitations effect
function s.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) then
		c:SetCardTarget(tc)
		--Negate its effects
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		--Cannot be tributed for tribute summon
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UNRELEASABLE_SUM)
		tc:RegisterEffect(e2)
		--Cannot be tributed
		local e3=e1:Clone()
		e3:SetCode(EFFECT_UNRELEASABLE_NONSUM)
		tc:RegisterEffect(e3)
		--Cannot be used as link material
		local e4=e1:Clone()
		e4:SetCode(EFFECT_CANNOT_BE_LINK_MATERIAL)
		e4:SetValue(1)
		tc:RegisterEffect(e4)
	end
end
--Check for link monster
function s.atktg(e,c)
	return c:IsType(TYPE_LINK) and c:IsFaceup()
end
--If monster left the field
function s.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsStatus(STATUS_DESTROY_CONFIRMED) then return false end
	local tc=c:GetFirstCardTarget()
	return tc and eg:IsContains(tc) and tc:IsReason(REASON_DESTROY)
end
--Destroy this card
function s.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
--Activate only during your Main Phases
function s.tkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
		and (Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2)
end
--Activation legality
function s.tktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,511009746,0x581,0x4011,0,0,1,RACE_MACHINE,ATTRIBUTE_WIND)
		and e:GetHandler():GetFirstCardTarget():GetLink()>0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,tp,0)
end
--Performing the effect of special summoning tokens
function s.tkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local ft=math.min(c:GetFirstCardTarget():GetLink(),Duel.GetLocationCount(tp,LOCATION_MZONE))
	if ft<=0 or not Duel.IsPlayerCanSpecialSummonMonster(tp,511009746,0x581,0x4011,0,0,1,RACE_MACHINE,ATTRIBUTE_WIND) then return end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end --If Blue-Eyes Spirit Dragon is on the field, set link rating to 1
	local ct=ft
	if ft~=1 then
		local selct = {}
		for i=1,ft do
			selct[i]=i
		end
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(15341821,0))
		ct=Duel.AnnounceNumber(tp,table.unpack(selct))
	end
	for i=1,ct do
		local token=Duel.CreateToken(tp,511009746)
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
	end
	Duel.SpecialSummonComplete()
end
