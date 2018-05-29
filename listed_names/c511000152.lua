--Kuribeh
function c511000152.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(86585274,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c511000152.spcost)
	e1:SetTarget(c511000152.sptg)
	e1:SetOperation(c511000152.spop)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UNRELEASABLE_SUM)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
c511000152.listed_names={16404809}
function c511000152.rescon(sg,e,tp,mg)
	return aux.ChkfMMZ(1)(sg,e,tp,mg) and sg:IsExists(c511000152.chk,1,nil,sg,Group.CreateGroup(),511000153,511000151,40640057,511000154)
end
function c511000152.chk(c,sg,g,code,...)
	if not c:IsCode(code) then return false end
	local res
	if ... then
		g:AddCard(c)
		res=sg:IsExists(c511000152.chk,1,g,sg,g,...)
		g:RemoveCard(c)
	else
		res=true
	end
	return res
end
function c511000152.cfilter(c,code)
	return c:IsCode(code) and c:IsAbleToRemoveAsCost()
end
function c511000152.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local g1=Duel.GetMatchingGroup(c511000152.cfilter,tp,LOCATION_ONFIELD,0,nil,511000153)
	local g2=Duel.GetMatchingGroup(c511000152.cfilter,tp,LOCATION_ONFIELD,0,nil,511000151)
	local g3=Duel.GetMatchingGroup(c511000152.cfilter,tp,LOCATION_ONFIELD,0,nil,40640057)
	local g4=Duel.GetMatchingGroup(c511000152.cfilter,tp,LOCATION_ONFIELD,0,nil,511000154)
	local g=g1:Clone()
	g:Merge(g2)
	g:Merge(g3)
	g:Merge(g4)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-5 and g1:GetCount()>0 and g2:GetCount()>0 and g3:GetCount()>0 and g4:GetCount()>0 
		and c:IsAbleToRemoveAsCost() and aux.SelectUnselectGroup(g,e,tp,4,4,c511000152.rescon,0) end
	local sg=aux.SelectUnselectGroup(g,e,tp,4,4,c511000152.rescon,1,tp,HINTMSG_REMOVE)
	sg:AddCard(c)
	Duel.Remove(sg,POS_FACEUP,REASON_COST)
end
function c511000152.filter(c,e,tp)
	return c:IsCode(16404809) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c511000152.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000152.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c511000152.spop(e,tp,eg,ep,ev,re,r,rp,c)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,c511000152.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp):GetFirst()
	if tc and Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)>0 then
		tc:CompleteProcedure()
	end
end
