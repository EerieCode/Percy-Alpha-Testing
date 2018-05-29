--トゥーン・マーメイド
function c511003017.initial_effect(c)
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetCondition(c511003017.sumlimit)
	c:RegisterEffect(e1)
	--special summon rule
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c511003017.spcon)
	e2:SetOperation(c511003017.spop)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetCondition(c511003017.sdescon)
	e3:SetOperation(c511003017.sdesop)
	c:RegisterEffect(e3)
	--direct attack
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_DIRECT_ATTACK)
	e4:SetCondition(c511003017.dircon)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e5:SetCondition(c511003017.atcon)
	e5:SetValue(c511003017.atlimit)
	c:RegisterEffect(e5)
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	e6:SetCondition(c511003017.atcon)
	c:RegisterEffect(e6)
	--cannot attack
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e7:SetCode(EVENT_SPSUMMON_SUCCESS)
	e7:SetOperation(c511003017.atklimit)
	c:RegisterEffect(e7)
	--attack cost
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE)
	e8:SetCode(EFFECT_ATTACK_COST)
	e8:SetCost(c511003017.atcost)
	e8:SetOperation(c511003017.atop)
	c:RegisterEffect(e8)
end
c511003017.listed_names={15259703}
function c511003017.cfilter(c)
	return c:IsFaceup() and c:IsCode(15259703)
end
function c511003017.sumlimit(e)
	return not Duel.IsExistingMatchingCard(c511003017.cfilter,e:GetHandlerPlayer(),LOCATION_ONFIELD,0,1,nil)
end
function c511003017.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	if not Duel.IsExistingMatchingCard(c511003017.cfilter,tp,LOCATION_ONFIELD,0,1,nil)  then return false end
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local rg=Duel.GetReleaseGroup(tp)
	if c:IsLevelBelow(4) then return ft>0
	elseif c:IsLevelAbove(7) then return ft>-2 and aux.SelectUnselectGroup(rg,e,tp,2,2,aux.ChkfMMZ(1),0)
	else return ft>-1 and aux.SelectUnselectGroup(rg,e,tp,1,1,aux.ChkfMMZ(1),0) end
end
function c511003017.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local rg=Duel.GetReleaseGroup(tp)
	if c:IsLevel(5) or c:IsLevel(6) then
		local sg=aux.SelectUnselectGroup(rg,e,tp,1,1,aux.ChkfMMZ(1),1,tp,HINTMSG_RELEASE)
		Duel.Release(sg,REASON_COST)
	elseif c:IsLevelAbove(7) then
		local sg=aux.SelectUnselectGroup(rg,e,tp,2,2,aux.ChkfMMZ(1),1,tp,HINTMSG_RELEASE)
		Duel.Release(sg,REASON_COST)
	end
end
function c511003017.sfilter(c)
	return c:IsReason(REASON_DESTROY) and c:IsPreviousPosition(POS_FACEUP) and c:GetPreviousCodeOnField()==15259703 and c:IsPreviousLocation(LOCATION_ONFIELD)
end
function c511003017.sdescon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511003017.sfilter,1,nil)
end
function c511003017.sdesop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
function c511003017.atkfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_TOON)
end
function c511003017.dircon(e)
	return not Duel.IsExistingMatchingCard(c511003017.atkfilter,e:GetHandlerPlayer(),0,LOCATION_MZONE,1,nil)
end
function c511003017.atcon(e)
	return Duel.IsExistingMatchingCard(c511003017.atkfilter,e:GetHandlerPlayer(),0,LOCATION_MZONE,1,nil)
end
function c511003017.atlimit(e,c)
	return not c:IsType(TYPE_TOON) or c:IsFacedown()
end
function c511003017.atklimit(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e:GetHandler():RegisterEffect(e1)
end
function c511003017.atcost(e,c,tp)
	return Duel.CheckLPCost(tp,500)
end
function c511003017.atop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsAttackCostPaid()~=2 and e:GetHandler():IsLocation(LOCATION_MZONE) then
		Duel.PayLPCost(tp,500)
		Duel.AttackCostPaid()
	end
end
