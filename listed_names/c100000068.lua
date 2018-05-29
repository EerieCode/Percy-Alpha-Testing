--機皇創世
function c100000068.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c100000068.condition)
	e1:SetCost(c100000068.cost)
	e1:SetTarget(c100000068.target)
	e1:SetOperation(c100000068.operation)
	c:RegisterEffect(e1)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_SZONE)
	--e2:SetCondition(c100000068.decon)
	e2:SetTarget(c100000068.destg)
	e2:SetValue(c100000068.desval)
	c:RegisterEffect(e2)
	aux.CallToken(420)
end
c100000068.listed_names={63468625,63468625}
function c100000068.filter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,true,false) and c:IsCode(63468625)
end
function c100000068.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c100000068.filter,tp,0x13,0,1,nil,e,tp)
end
function c100000068.costfilter(c,code)
	return c:IsCode(code) and c:IsAbleToRemoveAsCost() and aux.SpElimFilter(c,true)
end
function c100000068.rescon(sg,e,tp,mg)
	return aux.ChkfMMZ(1)(sg,e,tp,mg) and sg:IsExists(c100000068.chk,1,nil,sg,Group.CreateGroup(),100000055,100000066,100000067)
end
function c100000068.chk(c,sg,g,code,...)
	if not c:IsCode(code) then return false end
	local res
	if ... then
		g:AddCard(c)
		res=sg:IsExists(c100000068.chk,1,g,sg,g,...)
		g:RemoveCard(c)
	else
		res=true
	end
	return res
end
function c100000068.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	local g1=Duel.GetMatchingGroup(c100000068.costfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,nil,100000055)
	local g2=Duel.GetMatchingGroup(c100000068.costfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,nil,100000066)
	local g3=Duel.GetMatchingGroup(c100000068.costfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,nil,100000067)
	local g=g1:Clone()
	g:Merge(g2)
	g:Merge(g3)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-3 and g1:GetCount()>0 and g2:GetCount()>0 and g3:GetCount()>0 
 		and aux.SelectUnselectGroup(g,e,tp,3,3,c100000068.rescon,0) end
	local sg=aux.SelectUnselectGroup(g,e,tp,3,3,c100000068.rescon,1,tp,HINTMSG_REMOVE)
	Duel.Remove(sg,POS_FACEUP,REASON_COST)
	aux.RemainFieldCost(e,tp,eg,ep,ev,re,r,rp,1)
end
function c100000068.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()==0 and Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return false end
		e:SetLabel(0)
		return e:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsExistingMatchingCard(c100000068.filter,tp,0x13,0,1,nil,e,tp)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0x13)
end
function c100000068.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsStatus(STATUS_LEAVE_CONFIRMED) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,c100000068.filter,tp,0x13,0,1,1,nil,e,tp):GetFirst()
	if tc and Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)>0 then
		Duel.Equip(tp,c,tc)
		--Equip limit
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(c100000068.eqlimit)
		e1:SetReset(RESET_EVENT+0x1fe0000)		
		c:RegisterEffect(e1)
	else
		c:CancelToGrave(false)
	end
end
function c100000068.eqlimit(e,c)
	return c:IsCode(63468625)
end
function c100000068.cfilter(c)
	return (c:IsWisel() or c:IsGranel() or c:IsSkiel()) and c:IsAbleToRemove() and aux.SpElimFilter(c,true)
end
function c100000068.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetEquipTarget() and eg:IsContains(e:GetHandler():GetEquipTarget())
		and Duel.IsExistingMatchingCard(c100000068.cfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,nil) end
	if Duel.SelectYesNo(tp,aux.Stringid(100000068,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local g=Duel.SelectMatchingCard(tp,c100000068.cfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,1,nil)
		Duel.Remove(g,POS_FACEUP,REASON_EFFECT+REASON_REPLACE)
		return true
	else return false end
end
function c100000068.desval(e,c)
	return c==e:GetHandler():GetEquipTarget()
end
