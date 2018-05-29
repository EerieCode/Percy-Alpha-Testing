--魔法の歯車
--fixed by MLD
function c511777004.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511777004.cost)
	e1:SetTarget(c511777004.target)
	e1:SetOperation(c511777004.activate)
	c:RegisterEffect(e1)
end
c511777004.listed_names={83104731}
function c511777004.cfilter(c)
	return c:IsSetCard(0x7) and c:IsAbleToGraveAsCost()
end
function c511777004.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	local g=Duel.GetMatchingGroup(c511777004.cfilter,tp,LOCATION_MZONE,0,nil)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-3 and g:GetCount()>2 and aux.SelectUnselectGroup(g,e,tp,3,3,aux.ChkfMMZ(1),0) end
	local sg=aux.SelectUnselectGroup(g,e,tp,3,3,aux.ChkfMMZ(1),1,tp,HINTMSG_TOGRAVE)
	Duel.SendtoGrave(g,REASON_COST)
end
function c511777004.filter(c,e,tp)
	return c:IsCode(83104731) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c511777004.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()==0 and Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return false end
		e:SetLabel(0)
		return Duel.IsExistingMatchingCard(c511777004.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c511777004.activate(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 then return end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	local dg=Duel.GetMatchingGroup(c511777004.filter,tp,LOCATION_DECK,0,nil,e,tp)
	local hg=Duel.GetMatchingGroup(c511777004.filter,tp,LOCATION_HAND,0,nil,e,tp)
	if dg:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sc=dg:Select(tp,0,1,nil):GetFirst()
		if sc and Duel.SpecialSummonStep(sc,0,tp,tp,true,false,POS_FACEUP) then ft=ft-1 end
	end
	if ft>0 and hg:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=hg:Select(tp,ft,ft,nil)
		local tc=sg:GetFirst()
		while tc do
			Duel.SpecialSummonStep(tc,0,tp,tp,true,false,POS_FACEUP)
			tc=sg:GetNext()
		end
	end
	Duel.SpecialSummonComplete()
end
