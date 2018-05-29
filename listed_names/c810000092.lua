--Luminous Clouds
--scripted by: UnknownGuest
function c810000092.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c810000092.cost)
	e1:SetTarget(c810000092.target)
	e1:SetOperation(c810000092.activate)
	c:RegisterEffect(e1)
end
c810000092.listed_names={810000093}
function c810000092.spcheck(sg,tp)
	return aux.ReleaseCheckMMZ(sg,tp) and sg:IsExists(c810000092.chk,1,nil,sg,Group.CreateGroup(),24530661,810000091)
end
function c810000092.chk(c,sg,g,code,...)
	if not c:IsCode(code) then return false end
	local res
	if ... then
		g:AddCard(c)
		res=sg:IsExists(c810000092.chk,1,g,sg,g,...)
		g:RemoveCard(c)
	else
		res=true
	end
	return res
end
function c810000092.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return Duel.CheckReleaseGroupCost(tp,Card.IsCode,2,nil,c810000092.spcheck,nil,24530661,810000091) end
	local sg=Duel.SelectReleaseGroupCost(tp,Card.IsCode,2,2,nil,c810000092.spcheck,nil,24530661,810000091)
	Duel.Release(sg,REASON_COST)
end
function c810000092.filter(c,e,tp)
	return c:IsCode(810000093) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c810000092.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()==0 and Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return false end
		e:SetLabel(0)
		return Duel.IsExistingMatchingCard(c810000092.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c810000092.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,c810000092.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp):GetFirst()
	if tc and Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)>0 then
		tc:CompleteProcedure()
	end
end
