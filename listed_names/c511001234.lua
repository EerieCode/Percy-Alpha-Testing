--Battle Constant
function c511001234.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511001234.cost)
	e1:SetTarget(c511001234.target)
	e1:SetOperation(c511001234.activate)
	c:RegisterEffect(e1)
end
c511001234.listed_names={511001235}
function c511001234.cfilter(c,tpe)
	return c:IsFaceup() and c:GetType()&tpe==tpe and c:IsAbleToRemoveAsCost()
end
function c511001234.rescon(sg,e,tp,mg)
	return aux.ChkfMMZ(1)(sg,e,tp,mg) and sg:IsExists(c511001234.chk,1,nil,sg,Group.CreateGroup(),TYPE_MONSTER,TYPE_SPELL+TYPE_CONTINUOUS,TYPE_TRAP+TYPE_CONTINUOUS)
end
function c511001234.chk(c,sg,g,tpe,...)
	if c:GetType()&tpe~=tpe then return false end
	local res
	if ... then
		g:AddCard(c)
		res=sg:IsExists(c511001234.chk,1,g,sg,g,...)
		g:RemoveCard(c)
	else
		res=true
	end
	return res
end
function c511001234.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local g1=Duel.GetMatchingGroup(Card.IsAbleToRemoveAsCost,tp,LOCATION_MZONE,0,nil)
	local g2=Duel.GetMatchingGroup(c511001234.cfilter,tp,LOCATION_ONFIELD,0,nil,TYPE_SPELL+TYPE_CONTINUOUS)
	local g3=Duel.GetMatchingGroup(c511001234.cfilter,tp,LOCATION_ONFIELD,0,nil,TYPE_TRAP+TYPE_CONTINUOUS)
	local g=g1:Clone()
	g:Merge(g2)
	g:Merge(g3)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-3 and g1:GetCount()>0 and g2:GetCount()>0 and g3:GetCount()>0 
		and aux.SelectUnselectGroup(g,e,tp,3,3,c511001234.rescon,0) end
	local sg=aux.SelectUnselectGroup(g,e,tp,3,3,c511001234.rescon,1,tp,HINTMSG_REMOVE)
	Duel.Remove(sg,POS_FACEUP,REASON_COST)
end
function c511001234.filter(c,e,tp)
	return c:IsCode(511001235) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511001234.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()==0 and Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return false end
		e:SetLabel(0)
		return Duel.IsExistingMatchingCard(c511001234.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c511001234.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511001234.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
	Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
end
