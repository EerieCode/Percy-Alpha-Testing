--海晶乙女の決意
--Marincess Decision
local s,id=GetID()
function s.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
	--atk down
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(10971759,1))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCost(s.atkcost)
	e2:SetTarget(s.atktg)
	e2:SetOperation(s.atkop)
	c:RegisterEffect(e2)
end
s.listed_series={0x12b}
function s.cfilter(c)
	return c:IsSetCard(0x12b) and c:IsAbleToRemoveAsCost() and aux.SpElimFilter(c,true)
end
function s.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.cfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,s.cfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function s.filter(c,e)
	return c:IsPosition(POS_FACEDOWN_DEFENSE) and c:IsCanChangePosition() and (not e or c:IsCanBeEffectTarget(e))
end
function s.spfilter(c,e,tp)
	return s.filter(c)
		and Duel.IsExistingMatchingCard(s.lkfilter,tp,LOCATION_EXTRA,0,1,nil,c,tp)
end
function s.lkfilter(c,mc,tp)
	return c:IsType(TYPE_LINK) and (not mc or mc:IsCanBeLinkMaterial(c,tp)) and c:IsSpecialSummonable(SUMMON_TYPE_LINK)
end
function s.extramat(chk,summon_type,e,...)
	local c=e:GetHandler()
	if chk==0 then
		local tp,sc=...
		if not summon_type==SUMMON_TYPE_LINK then
			return Group.CreateGroup()
		else
			return Group.FromCards(c)
		end
	end
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local og=Duel.GetMatchingGroup(s.filter,tp,LOCATION_MZONE,0,nil,e)
	local c=e:GetHandler()
	local oeff={}
	for oc in aux.Next(og) do
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD)
		e2:SetRange(LOCATION_MZONE)
		e2:SetCode(EFFECT_EXTRA_MATERIAL)
		e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e2:SetTargetRange(1,0)
		e2:SetValue(s.extramat)
		oc:RegisterEffect(e2,true)
		table.insert(oeff,e2)
	end
	if chk==0 then
		local check=Duel.IsExistingMatchingCard(s.spfilter,tp,LOCATION_MZONE,0,1,nil,e,tp)
		for _,oe in ipairs(oeff) do
			oe:Reset()
		end
		return check
	end
	for _,oe in ipairs(oeff) do
		oe:Reset()
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local og=Duel.GetMatchingGroup(s.filter,tp,LOCATION_MZONE,0,nil,e,tp)
	local oeff={}
	for oc in aux.Next(og) do
		local e0=Effect.CreateEffect(c)
		e0:SetType(EFFECT_TYPE_FIELD)
		e0:SetRange(LOCATION_MZONE)
		e0:SetCode(EFFECT_EXTRA_MATERIAL)
		e0:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e0:SetTargetRange(1,0)
		e0:SetValue(s.extramat)
		e0:SetReset(RESET_CHAIN)
		oc:RegisterEffect(e0,true)
		table.insert(oeff,e0)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEDOWNDEFENSE)
	local tc=Duel.SelectMatchingCard(tp,s.spfilter,tp,LOCATION_MZONE,0,1,1,nil,e,tp):GetFirst()
	if tc and Duel.ChangePosition(tc,0,0,0,POS_FACEUP_DEFENSE,true)>0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCode(EFFECT_MUST_BE_MATERIAL)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetTargetRange(1,0)
		e1:SetValue(REASON_LINK)
		e1:SetReset(RESET_CHAIN)
		tc:RegisterEffect(e1,true)
		for _,oe in ipairs(oeff) do
			oe:Reset()
		end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sc=Duel.SelectMatchingCard(tp,s.lkfilter,tp,LOCATION_EXTRA,0,1,1,nil):GetFirst()
		if sc then
			Duel.BreakEffect()
			Duel.SpecialSummonRule(tp,sc,SUMMON_TYPE_LINK)
		end
	else
		for _,oe in ipairs(oeff) do
			oe:Reset()
		end
	end
end
function s.cfilter(c)
	return c:IsSetCard(0x12b) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost() and aux.SpElimFilter(c,true)
end
function s.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	return true
end
function s.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsFaceup() end
	if chk==0 then
		if e:GetLabel()~=1 then return false end
		e:SetLabel(0)
		return e:GetHandler():IsAbleToRemoveAsCost()
			and Duel.IsExistingMatchingCard(s.cfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,nil,e,tp)
			and Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,s.cfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.Remove((g+e:GetHandler()),POS_FACEUP,REASON_COST)
	e:SetLabelObject(g:GetFirst())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
end
function s.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(-e:GetLabelObject():GetTextAttack())
		tc:RegisterEffect(e1)
	end
end
