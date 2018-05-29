--Big Bang Dragon Blow
function c170000196.initial_effect(c)
    --fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcMix(c,true,true,110000110,46232525)
	aux.AddEquipProcedure(c)
	--Big Bang Attack!
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(170000196,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c170000196.descost)
	e2:SetTarget(c170000196.destg)
	e2:SetOperation(c170000196.desop)
	c:RegisterEffect(e2)
end
c170000196.listed_names={110000110}
function c170000196.hermos_filter(c)
	return c:IsCode(110000110)
end
function c170000196.cfilter(c)
	return c:IsRace(RACE_DRAGON)
end
function c170000196.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	local dg=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
	if chk==0 then return Duel.CheckReleaseGroupCost(tp,c170000196.cfilter,1,false,aux.ReleaseCheckTarget,nil,dg) end
	local g=Duel.SelectReleaseGroupCost(tp,c170000196.cfilter,1,1,false,aux.ReleaseCheckTarget,nil,dg)
	Duel.Release(g,REASON_COST)
end
function c170000196.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil) end
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0,nil)
end
function c170000196.desop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
	if Duel.Destroy(g,REASON_EFFECT)>0 then
		Duel.BreakEffect()
		local sum=g:GetSum(Card.GetAttack)
		Duel.Damage(1-tp,sum,REASON_EFFECT)
	end
end
