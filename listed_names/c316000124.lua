--Dimension Dice
function c316000124.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c316000124.con)
	e1:SetCost(c316000124.cost)
	e1:SetTarget(c316000124.target)
	e1:SetOperation(c316000124.activate)
	c:RegisterEffect(e1)
end
c316000124.listed_names={140000074}
function c316000124.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsEnvironment(511001152)
end
function c316000124.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return Duel.CheckReleaseGroupCost(tp,nil,2,false,aux.ReleaseCheckMMZ,nil) end
	local sg=Duel.SelectReleaseGroupCost(tp,nil,2,2,false,aux.ReleaseCheckMMZ,nil)
	Duel.Release(sg,REASON_COST)
end
function c316000124.filter(c,e,tp)
	return c:IsCode(140000074) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c316000124.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()==0 and Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return false end
		e:SetLabel(0)
		return Duel.IsExistingMatchingCard(c316000124.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,e,tp)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,LOCATION_DECK+LOCATION_HAND)
end
function c316000124.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,c316000124.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,e,tp):GetFirst()
	if tc and Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)>0 then
		tc:CompleteProcedure()
	end
end
