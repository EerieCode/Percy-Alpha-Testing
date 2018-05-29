--督戦官コヴィントン
function c22666164.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(22666164,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c22666164.cost)
	e1:SetTarget(c22666164.target)
	e1:SetOperation(c22666164.operation)
	c:RegisterEffect(e1)
end
c22666164.listed_names={58054262}
function c22666164.cfilter(c,...)
	return c:IsFaceup() and c:IsCode(...) and c:IsAbleToGraveAsCost()
end
function c22666164.rescon(sg,e,tp,mg)
	return aux.ChkfMMZ(1)(sg,e,tp,mg) and sg:IsExists(c22666164.chk,1,nil,sg,Group.CreateGroup(),60999392,23782705,96384007)
end
function c22666164.chk(c,sg,g,code,...)
	if not c:IsCode(code) then return false end
	local res
	if ... then
		g:AddCard(c)
		res=sg:IsExists(c22666164.chk,1,g,sg,g,...)
		g:RemoveCard(c)
	else
		res=true
	end
	return res
end
function c22666164.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local g1=Duel.GetMatchingGroup(c22666164.cfilter,tp,LOCATION_ONFIELD,0,nil,60999392)
	local g2=Duel.GetMatchingGroup(c22666164.cfilter,tp,LOCATION_ONFIELD,0,nil,23782705)
	local g3=Duel.GetMatchingGroup(c22666164.cfilter,tp,LOCATION_ONFIELD,0,nil,96384007)
	local g=g1:Clone()
	g:Merge(g2)
	g:Merge(g3)
	if chk==0 then return g1:GetCount()>0 and g2:GetCount()>0 and g3:GetCount()>0
		and aux.SelectUnselectGroup(g,e,tp,3,3,c22666164.rescon,0) end
	local sg=aux.SelectUnselectGroup(g,e,tp,3,3,c22666164.rescon,1,tp,HINTMSG_TOGRAVE)
	Duel.SendtoGrave(sg,REASON_COST)
end
function c22666164.filter(c,e,tp)
	return c:IsCode(58054262) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c22666164.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-3
		and Duel.IsExistingMatchingCard(c22666164.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c22666164.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c22666164.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)
	end
end
