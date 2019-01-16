--Death Control of the Evil Eye
local s,id = GetID()
function s.initial_effect(c)
	--activate and use effect
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetDescription(aux.Stringid(id,1))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(s.condition)
	e1:SetTarget(s.target)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_CHAIN_SOLVED)
	e2:SetLabelObject(e1)
	e2:SetCondition(aux.PersistentTgCon)
	e2:SetOperation(s.tgop)
	c:RegisterEffect(e2)
	--control
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_SET_CONTROL)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetTarget(aux.PersistentTargetFilter)
	e3:SetValue(s.tg)
	c:RegisterEffect(e3)
	--treats
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_ADD_SETCODE)
	e4:SetRange(LOCATION_SZONE)
	e4:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e4:SetTarget(aux.PersistentTargetFilter)
	e4:SetCondition(s.sccon)
	e4:SetValue(0x226)
	c:RegisterEffect(e4)
	--destroy
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCode(EVENT_LEAVE_FIELD)
	e5:SetCondition(s.descon)
	e5:SetOperation(s.desop)
	c:RegisterEffect(e5)
end
function s.cfilter1(c)
	return c:IsFaceup() and c:IsSetCard(0x226)
end
function s.cfilter2(c,sp,cg)
	return c:GetSummonPlayer() == sp and c:IsLocation(LOCATION_MZONE) and c:IsPosition(POS_FACEUP_ATTACK)
		and cg:IsExists(s.cfilter3,1,nil,c)
end
function s.cfilter3(c,sc)
	return c:GetAttack() > sc:GetAttack()
end
function s.condition(e,tp,eg,ep,ev,re,r,rp)
	local g = Duel.GetMatchingGroup(s.cfilter1,tp,LOCATION_MZONE,0,nil)
	return eg:IsExists(s.cfilter2,1,nil, 1 - tp, g)
end
function s.filter(c,g,sp,cg)
	return g and g:IsContains(c) and c:IsAbleToChangeControler() and s.cfilter2(c,sp,cg)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local g = Duel.GetMatchingGroup(s.cfilter1,tp,LOCATION_MZONE,0,nil)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and s.filter(chkc,eg,1 - tp,g) end
	if chk == 0 then return Duel.IsExistingTarget(s.filter,tp,0,LOCATION_MZONE,1,nil,eg,1 - tp,g) end
	local g = Duel.SelectTarget(tp,s.filter,tp,0,LOCATION_MZONE,1,1,nil,eg,1 - tp,g)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,1,g,tp,0)
end
function s.tgop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS):GetFirst()
	if c:IsRelateToEffect(re) and tc and tc:IsFaceup() and tc:IsRelateToEffect(re) then
		c:SetCardTarget(tc)
	end
end
function s.tg(e,c)
	return e:GetHandlerPlayer()
end
function s.sccon(e)
	return Duel.IsExistingMatchingCard(aux.FilterFaceupFunction(Card.IsCode),e:GetHandlerPlayer(),LOCATION_SZONE,0,1,nil,CARD_CURSED_EYE_SELENE)
end
function s.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsStatus(STATUS_DESTROY_CONFIRMED) then return false end
	local tc=c:GetFirstCardTarget()
	return tc and eg:IsContains(tc) and tc:IsReason(REASON_DESTROY)
end
function s.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
