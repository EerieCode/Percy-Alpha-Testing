--Sky Union
function c140000082.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c140000082.cost)
	e1:SetTarget(c140000082.target)
	e1:SetOperation(c140000082.activate)
	c:RegisterEffect(e1)
end
c140000082.listed_names={140000083}
function c140000082.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return Duel.CheckReleaseGroupCost(tp,nil,3,false,aux.ReleaseCheckMMZ,nil) end
	local sg=Duel.SelectReleaseGroupCost(tp,nil,3,3,false,aux.ReleaseCheckMMZ,nil)
	Duel.Release(sg,REASON_COST)
end
function c140000082.filter(c,e,tp)
	return c:IsCode(140000083) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c140000082.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()==0 and Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return false end
		e:SetLabel(0)
		return Duel.IsExistingMatchingCard(c140000082.filter,tp,LOCATION_DECK,0,1,nil,e,tp)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c140000082.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,c140000082.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp):GetFirst()
	if tc and Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP) then
		tc:CompleteProcedure()
	end
end
