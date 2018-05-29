--王家の神殿
function c511000821.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Trap activate in set turn
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_TRAP_ACT_IN_SET_TURN)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_SZONE,0)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetDescription(aux.Stringid(511000821,0))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCost(c511000821.cost)
	e3:SetTarget(c511000821.target)
	e3:SetOperation(c511000821.operation)
	c:RegisterEffect(e3)
end
c511000821.listed_names={89194033}
function c511000821.cfilter(c,e,tp)
	return c:IsFaceup() and c:IsCode(89194033) and c:IsAbleToGraveAsCost() 
		and Duel.IsExistingMatchingCard(c511000821.filter,tp,0x43,0,1,nil,e,tp,c)
end
function c511000821.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToGraveAsCost()
		and Duel.IsExistingMatchingCard(c511000821.cfilter,tp,LOCATION_ONFIELD,0,1,c,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c511000821.cfilter,tp,LOCATION_ONFIELD,0,1,1,c,e,tp)
	g:AddCard(c)
	Duel.SendtoGrave(g,REASON_COST)
end
function c511000821.filter(c,e,tp,mc)
	if not c:IsCanBeSpecialSummoned(e,0,tp,false,false) then return false end
	local g=Group.CreateGroup()
	if mc then
		g:AddCard(mc)
	end
	local res
	if c:IsLocation(LOCATION_EXTRA) then
		res=Duel.GetLocationCountFromEx(tp,tp,g,c)>0
	else
		res=(not mc and Duel.GetLocationCount(tp,LOCATION_MZONE)>0) or (mc and mc:IsLocation(LOCATION_MZONE) and mc:GetSequence()<5)
	end
	if mc then
		g:RemoveCard(mc)
	end
	return res
end
function c511000821.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0x43)
end
function c511000821.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511000821.filter,tp,0x43,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
