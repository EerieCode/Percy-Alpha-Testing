--Delta Reactor
function c511000843.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511000843.cost)
	e1:SetTarget(c511000843.target)
	e1:SetOperation(c511000843.activate)
	c:RegisterEffect(e1)
end
c511000843.listed_names={16898077}
function c511000843.spcfilter(c,code)
	return c:IsCode(code) and c:IsAbleToGraveAsCost()
end
function c511000843.rescon(sg,e,tp,mg)
	return aux.ChkfMMZ(1)(sg,e,tp,mg) and sg:IsExists(c511000843.chk,1,nil,sg,Group.CreateGroup(),52286175,15175429,89493368)
end
function c511000843.chk(c,sg,g,code,...)
	if not c:IsCode(code) then return false end
	local res
	if ... then
		g:AddCard(c)
		res=sg:IsExists(c511000843.chk,1,g,sg,g,...)
		g:RemoveCard(c)
	else
		res=true
	end
	return res
end
function c511000843.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	local g1=Duel.GetMatchingGroup(c511000843.spcfilter,tp,LOCATION_ONFIELD,0,nil,52286175)
	local g2=Duel.GetMatchingGroup(c511000843.spcfilter,tp,LOCATION_ONFIELD,0,nil,15175429)
	local g3=Duel.GetMatchingGroup(c511000843.spcfilter,tp,LOCATION_ONFIELD,0,nil,89493368)
	local g=g1:Clone()
	g:Merge(g2)
	g:Merge(g3)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-3 and g1:GetCount()>0 and g2:GetCount()>0 and g3:GetCount()>0 
		and aux.SelectUnselectGroup(g,e,tp,3,3,c511000843.rescon,0) end
	local sg=aux.SelectUnselectGroup(g,e,tp,3,3,c511000843.rescon,1,tp,HINTMSG_TOGRAVE)
	Duel.SendtoGrave(sg,REASON_COST)
end
function c511000843.spfilter(c,e,tp)
	return c:IsCode(16898077) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c511000843.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()~=1 and Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return false end
		e:SetLabel(0)
		return Duel.IsExistingMatchingCard(c511000843.spfilter,tp,0x13,0,1,nil,e,tp)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,0,tp,0x13)
end
function c511000843.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c511000843.spfilter),tp,0x13,0,1,1,nil,e,tp):GetFirst()
	if tc and Duel.SpecialSummon(tc,0,tp,tp,true,true,POS_FACEUP)>0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DESTROY_REPLACE)
		e1:SetCountLimit(1)
		e1:SetTarget(c511000843.reptg)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		tc:CompleteProcedure()
	end
end
function c511000843.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	return true
end
