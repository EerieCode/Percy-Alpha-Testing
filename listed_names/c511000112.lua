--拘束解除
function c511000112.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetLabel(0)
	e1:SetCost(c511000112.cost)
	e1:SetTarget(c511000112.target)
	e1:SetOperation(c511000112.activate)
	c:RegisterEffect(e1)
end
c511000112.listed_names={511000110,511000111,511000111,511000110,511000110,511000111,511000110}
function c511000112.cfilter(c,e,tp)
	local code=c:GetCode()
	if c:IsCode(511000110) and c:IsCode(511000111) then
		code=0
	end
	return c:IsCode(511000110,511000111) 
		and Duel.IsExistingMatchingCard(c511000112.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp,c,code)
end
function c511000112.filter(c,e,tp,mc,code)
	local g=Group.CreateGroup()
	if mc then
		g:AddCard(mc)
	end
	if Duel.GetLocationCountFromEx(tp,tp,g,c)<=0 then return false end
	if mc then
		g:RemoveCard(mc)
	end
	if code==0 or code==511000110 then
		if c:IsCode(511000111) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) then return true end
	end
	if code==0 or code==511000111 then
		if c:IsCode(511000110) and c:IsCanBeSpecialSummoned(e,0,tp,true,false) then return true end
	end
	return false
end
function c511000112.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroupCost(tp,c511000112.cfilter,1,false,nil,nil,e,tp) end
	local g=Duel.SelectReleaseGroupCost(tp,c511000112.cfilter,1,1,false,nil,nil,e,tp)
	local code=g:GetFirst():GetCode()
	if g:GetFirst():IsCode(511000110) and g:GetFirst():IsCode(511000111) then
		code=0
	end
	e:SetLabel(code)
	Duel.Release(g,REASON_COST)
end
function c511000112.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000112.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp,nil,0) end
	local code=e:GetLabel()
	e:SetLabel(0)
	Duel.SetTargetParam(code)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511000112.activate(e,tp,eg,ep,ev,re,r,rp)
	local code=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511000112.filter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,nil,code)
	if g:GetCount()>0 then
		local ignore=g:GetFirst():IsCode(511000110)
		Duel.SpecialSummon(g,0,tp,tp,ignore,false,POS_FACEUP)
	end
end
