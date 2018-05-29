--Thorn Fangs of Violet Poison
--fixed by MLD
function c511009546.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511009546.cost)
	e1:SetTarget(c511009546.target)
	e1:SetOperation(c511009546.activate)
	c:RegisterEffect(e1)
	Duel.AddCustomActivityCounter(51109546,ACTIVITY_ATTACK,c511009546.counterfilter)
end
c511009546.listed_names={41209827,41209827,41209827}
function c511009546.counterfilter(c)
    return not c:IsCode(41209827)
end
function c511009546.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
		g:RemoveCard(e:GetHandler())
		return g:GetCount()>0 and g:FilterCount(Card.IsDiscardable,nil)==g:GetCount() 
			and Duel.GetCustomActivityCount(51109546,tp,ACTIVITY_ATTACK)==0
	end
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	Duel.SendtoGrave(g,REASON_COST+REASON_DISCARD)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e1:SetProperty(EFFECT_FLAG_OATH+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsCode,41209827))
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c511009546.cfilter(c)
	return c:IsFaceup() and c:IsCode(41209827)
end
function c511009546.filter(c,atk)
	return c:IsFaceup() and not c:IsCode(41209827) and c:GetAttack()<atk
end
function c511009546.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c511009546.cfilter,tp,LOCATION_MZONE,0,nil)
	if chk==0 then 
		if g:GetCount()<=0 then return false end
		local atk=g:GetMaxGroup(Card.GetAttack):GetFirst():GetAttack()
		return Duel.IsExistingMatchingCard(c511009546.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,atk) end
	local atk=g:GetMaxGroup(Card.GetAttack):GetFirst():GetAttack()
	local sg=Duel.GetMatchingGroup(c511009546.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,atk)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,PLAYER_ALL,0)
end
function c511009546.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511009546.cfilter,tp,LOCATION_MZONE,0,nil)
	if g:GetCount()<=0 then return end
	local atk=g:GetMaxGroup(Card.GetAttack):GetFirst():GetAttack()
	local sg=Duel.GetMatchingGroup(c511009546.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,atk)
	if Duel.Destroy(sg,REASON_EFFECT)>0 then
		Duel.BreakEffect()
		local dg=Duel.GetOperatedGroup()
		local sum1=dg:Filter(aux.FilterEqualFunction(Card.GetPreviousControler,tp),nil):GetSum(Card.GetAttack)
		local sum2=dg:Filter(aux.FilterEqualFunction(Card.GetPreviousControler,1-tp),nil):GetSum(Card.GetAttack)
		Duel.Damage(tp,sum1,REASON_EFFECT,true)
		Duel.Damage(1-tp,sum2,REASON_EFFECT,true)
		Duel.RDComplete()
	end
end
