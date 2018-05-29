--Illegal Modding
function c511001960.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511001960.cost)
	e1:SetTarget(c511001960.target)
	e1:SetOperation(c511001960.activate)
	c:RegisterEffect(e1)
end
c511001960.listed_names={511001959}
function c511001960.spcheck(sg,tp)
	return aux.ReleaseCheckMMZ(sg,tp) and sg:IsExists(c511001960.chk,1,nil,sg,Group.CreateGroup(),511000813,511000827,511001958)
end
function c511001960.chk(c,sg,g,code,...)
	if not c:IsCode(code) then return false end
	local res
	if ... then
		g:AddCard(c)
		res=sg:IsExists(c511001960.chk,1,g,sg,g,...)
		g:RemoveCard(c)
	else
		res=true
	end
	return res
end
function c511001960.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return Duel.CheckReleaseGroupCost(tp,Card.IsCode,3,nil,c511001960.spcheck,nil,511000813,511000827,511001958) end
	local sg=Duel.SelectReleaseGroupCost(tp,Card.IsCode,3,3,nil,c511001960.spcheck,nil,511000813,511000827,511001958)
	Duel.Release(sg,REASON_COST)
end
function c511001960.spfilter(c,e,tp)
	return c:IsCode(511001959) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511001960.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()==0 and Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return false end
		e:SetLabel(0)
		return Duel.IsExistingMatchingCard(c511001960.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c511001960.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=Duel.SelectMatchingCard(tp,c511001960.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
	if sg:GetCount()>0 then
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
	end
end
