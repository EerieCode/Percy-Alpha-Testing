--Machina Force (Manga)
function c511015116.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddFusionProcMixRep(c,true,true,aux.FilterBoolFunction(Card.IsFusionSetCard,0x36),2,99)
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c511015116.splimit)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SET_BASE_ATTACK)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c511015116.atkval)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_SET_BASE_DEFENSE)
	e3:SetValue(c511015116.defval)
	c:RegisterEffect(e3)
	--attack cost
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_ATTACK_COST)
	e4:SetCost(c511015116.atcost)
	e4:SetOperation(c511015116.atop)
	c:RegisterEffect(e4)
end
c511015116.listed_names={22666164}
function c511015116.splimit(e,se,sp,st)
	return se:GetHandler():IsCode(22666164)
end
function c511015116.atkfilter(c)
	return c:IsSetCard(0x36) and c:GetAttack()>=0
end
function c511015116.atkval(e,c)
	local g=e:GetHandler():GetOverlayGroup():Filter(c511015116.atkfilter,nil)
	return g:GetSum(Card.GetAttack)
end
function c511015116.deffilter(c)
	return c:IsSetCard(0x36) and c:GetDefense()>=0
end
function c511015116.defval(e,c)
	local g=e:GetHandler():GetOverlayGroup():Filter(c511015116.deffilter,nil)
	return g:GetSum(Card.GetDefense)
end
function c511015116.atcost(e,c,tp)
	return Duel.CheckLPCost(tp,1000)
end
function c511015116.atop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsAttackCostPaid()~=2 and e:GetHandler():IsLocation(LOCATION_MZONE) then
		Duel.PayLPCost(tp,1000)
		Duel.AttackCostPaid()
	end
end