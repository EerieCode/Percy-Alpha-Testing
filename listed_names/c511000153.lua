--Kuribah
function c511000153.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(86585274,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c511000153.spcost)
	e1:SetTarget(c511000153.sptg)
	e1:SetOperation(c511000153.spop)
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
c511000153.listed_names={511000150}
function c511000153.rescon(sg,e,tp,mg)
	return aux.ChkfMMZ(1)(sg,e,tp,mg) and sg:IsExists(c511000153.chk,1,nil,sg,Group.CreateGroup(),511000152,511000151,40640057,511000154)
end
function c511000153.chk(c,sg,g,code,...)
	if not c:IsCode(code) then return false end
	local res
	if ... then
		g:AddCard(c)
		res=sg:IsExists(c511000153.chk,1,g,sg,g,...)
		g:RemoveCard(c)
	else
		res=true
	end
	return res
end
function c511000153.cfilter(c,code)
	return c:IsCode(code) and c:IsAbleToRemoveAsCost()
end
function c511000153.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local g1=Duel.GetMatchingGroup(c511000153.cfilter,tp,LOCATION_ONFIELD,0,nil,511000152)
	local g2=Duel.GetMatchingGroup(c511000153.cfilter,tp,LOCATION_ONFIELD,0,nil,511000151)
	local g3=Duel.GetMatchingGroup(c511000153.cfilter,tp,LOCATION_ONFIELD,0,nil,40640057)
	local g4=Duel.GetMatchingGroup(c511000153.cfilter,tp,LOCATION_ONFIELD,0,nil,511000154)
	local g=g1:Clone()
	g:Merge(g2)
	g:Merge(g3)
	g:Merge(g4)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-5 and g1:GetCount()>0 and g2:GetCount()>0 and g3:GetCount()>0 and g4:GetCount()>0 
		and c:IsAbleToRemoveAsCost() and aux.SelectUnselectGroup(g,e,tp,4,4,c511000153.rescon,0) end
	local sg=aux.SelectUnselectGroup(g,e,tp,4,4,c511000153.rescon,1,tp,HINTMSG_REMOVE)
	sg:AddCard(c)
	sg:KeepAlive()
	e:SetLabelObject(sg)
	Duel.Remove(sg,POS_FACEUP,REASON_COST)
end
function c511000153.filter(c,e,tp)
	return c:IsCode(511000150) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000153.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000153.filter,tp,0x13,0,1,nil,e,tp) end
	Duel.SetTargetCard(e:GetLabelObject())
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0x13)
end
function c511000153.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,c511000153.filter,tp,0x13,0,1,1,nil,e,tp):GetFirst()
	if tc then
		tc:SetMaterial(g)
		Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)
		tc:CompleteProcedure()
	end
end
