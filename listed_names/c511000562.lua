--Deepsea Warrior (DM)
--Scripted by edo9300
function c511000562.initial_effect(c)
	--immune spell
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c511000562.econ)
	e1:SetValue(c511000562.efilter)
	c:RegisterEffect(e1)
	--battle target
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetDescription(aux.Stringid(51100567,4))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BE_BATTLE_TARGET)
	e2:SetRange(0xff)
	e2:SetCost(c511000562.cbcost)
	e2:SetCondition(c511000562.cbcon)
	e2:SetOperation(c511000562.cbop)
	c:RegisterEffect(e2)
	aux.CallToken(300)
end
c511000562.listed_names={22702055}
c511000562.dm=true
function c511000562.filter(c)
	return c:IsFaceup() and c:IsCode(22702055)
end
function c511000562.econ(e)
	return Duel.IsExistingMatchingCard(c511000562.filter,0,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
		or Duel.IsEnvironment(22702055)
end
function c511000562.efilter(e,te)
	return te:IsActiveType(TYPE_SPELL)
end
function c511000562.cbcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,nil,2,nil) end
	local g=Duel.SelectReleaseGroup(tp,nil,2,2,nil)
	Duel.Release(g,REASON_COST)
end
function c511000562.cbcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bt=eg:GetFirst()
	return bt:GetControler()==c:GetControler() and c:IsDeckMaster()
end
function c511000562.cbop(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetAttacker()
	if Duel.NegateAttack() then
		Duel.Damage(1-tp,tg:GetAttack(),REASON_EFFECT)
	end
end
