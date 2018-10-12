--Capture Drone
--Credits to Cybercatman

function c511009745.initial_effect(c)
	--Activate, need to control a "Drone" monster
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511009745.actcon)
	e1:SetTarget(c511009745.target)
	e1:SetOperation(c511009745.operation)
	c:RegisterEffect(e1)
	--Self-destruction
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetCondition(c511009745.descon)
	e2:SetOperation(c511009745.desop)
	c:RegisterEffect(e2)
	--Tokens
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c511009745.tkcon)
	e3:SetTarget(c511009745.tktg)
	e3:SetOperation(c511009745.tkop)
	c:RegisterEffect(e3)
	--Opponent's link monsters cannot attack
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_CANNOT_ATTACK)
	e4:SetRange(LOCATION_SZONE)
	e4:SetTargetRange(0,LOCATION_MZONE)
	e4:SetTarget(c511009745.atktg)
	c:RegisterEffect(e4)
end
	--Check for "Drone" monster
function c511009745.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x581)
end
	--Check if you do control "Drone" monster
function c511009745.actcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511009745.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
	--Check for link monster controlled by opponent
function c511009745.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_LINK)
end
	--Activation legality
function c511009745.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511009745.filter(chkc) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(c511009745.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c511009745.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,g,1,0,0)
end
	--Performing the multiple limitations effect
function c511009745.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) then
		c:SetCardTarget(tc)
		--c:CreateRelation(tc,RESET_EVENT+RESETS_STANDARD) <-- No idea what I copied do
		--e:GetLabelObject():SetLabelObject(tc)
		--Negate its effects
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		c:RegisterEffect(e1,true)
		--Cannot be tributed for tribute summon
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UNRELEASABLE_SUM)
		c:RegisterEffect(e2,true)
		--Cannot be tributed
		local e3=e1:Clone()
		e3:SetCode(EFFECT_UNRELEASABLE_NONSUM)
		c:RegisterEffect(e3,true)
		--Cannot be used as link material
		local e4=e1:Clone()
		e4:SetCode(EFFECT_CANNOT_BE_LINK_MATERIAL)
		c:RegisterEffect(e4,true)
	end
end
	--Check for link monster
function c511009745.atktg(e,c)
	return c:IsType(TYPE_LINK)
end
	--If monster left the field
function c511009745.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsStatus(STATUS_DESTROY_CONFIRMED) then return false end
	local tc=c:GetFirstCardTarget()
	return tc and eg:IsContains(tc) and tc:IsReason(REASON_DESTROY)
end
	--Destroy this card
function c511009745.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
	--Activate only during your Main Phases
function c511009745.tkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
		and (Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2)
end
	--Activation legality
function c511009745.tktg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tc=c:GetFirstCardTarget()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsPlayerCanSpecialSummonMonster(tp,511009746,0x581,0x4011,0,0,1,RACE_MACHINE,ATTRIBUTE_WIND) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,tp,0)
end
	--Performing the effect of special summoning tokens
function c511009745.tkop(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE) --Check amount of open monster zones
	local c=e:GetHandler()
	local tc=c:GetFirstCardTarget()
	if ft<=0 then return end --If no monster zones, stop
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,511009746,0x581,0x4011,0,0,1,RACE_MACHINE,ATTRIBUTE_WIND) then return end
	local ct=tc:GetLink() --Get link rating
	if ct<1 then return end --If link rating less than one, stop
	if ct>ft then ct=ft end --If the link rating is more than monster zones, set link rating equal to monster zones
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then ct=1 end --If Blue-Eyes Spirit Dragon is on the field, set link rating to 1
	repeat
		local token=Duel.CreateToken(tp,511009746)
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
		ct=ct-1
	until ct<=0 or not Duel.SelectYesNo(tp,aux.Stringid(511009745,0))
	Duel.SpecialSummonComplete()
end
