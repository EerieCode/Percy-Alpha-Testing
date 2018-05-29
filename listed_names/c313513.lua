--魔法の歯車
function c313513.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c313513.cost)
	e1:SetTarget(c313513.target)
	e1:SetOperation(c313513.activate)
	c:RegisterEffect(e1)
	if not c313513.global_check then
		c313513.global_check=true
		c313513[0]={}
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_TURN_END)
		ge1:SetCountLimit(1)
		ge1:SetOperation(c313513.endop)
		Duel.RegisterEffect(ge1,0)
	end
end
c313513.listed_names={83104731}
function c313513.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x7) and c:IsAbleToGraveAsCost()
end
function c313513.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local tg=Duel.GetMatchingGroup(c313513.cfilter,tp,LOCATION_ONFIELD,0,nil)
	if chk==0 then
		e:SetLabel(1)
		return Duel.GetLocationCount(tp,LOCATION_MZONE)>-3 and tg:GetCount()>=3 and aux.SelectUnselectGroup(tg,e,tp,3,3,aux.ChkfMMZ(1),0)
	end
	local c=e:GetHandler()
	local g=aux.SelectUnselectGroup(tg,e,tp,3,3,aux.ChkfMMZ(1),1,tp,HINTMSG_TOGRAVE)
	Duel.SendtoGrave(g,REASON_COST)
	if not e:IsHasType(EFFECT_TYPE_ACTIVATE) then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetReset(RESET_SELF_TURN+RESET_PHASE+PHASE_END,2)
	e1:SetTargetRange(1,0)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_MSET)
	Duel.RegisterEffect(e2,tp)
	local descnum=tp==c:GetOwner() and 0 or 1
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetDescription(aux.Stringid(313513,descnum))
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_SET_AVAILABLE)
	e3:SetCode(1082946)
	e3:SetOwnerPlayer(tp)
	e3:SetLabel(0)
	e3:SetOperation(c313513.reset)
	e3:SetReset(RESET_SELF_TURN+RESET_PHASE+PHASE_END,2)
	c:RegisterEffect(e3)
	table.insert(c313513[0],e3)
	c313513[0][e3]={e1,e2}
end
function c313513.reset(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local label=e:GetLabel()
	label=label+1
	e:SetLabel(label)
	if ev==1082946 then
		c:SetTurnCounter(label)
	end
	c:SetTurnCounter(0)
	if label==2 then
		local e1,e2=table.unpack(c313513[0][e])
		e:Reset()
		if e1 then e1:Reset() end
		if e2 then e2:Reset() end
		c313513[0][e]=nil
		for i,te in ipairs(c313513[0]) do
			if te==e then
				table.remove(c313513[0],i)
				break
			end
		end
	end
end
function c313513.endop(e,tp,eg,ep,ev,re,r,rp)
	for _,te in ipairs(c313513[0]) do
		if Duel.GetTurnPlayer()==te:GetOwnerPlayer() then
			c313513.reset(te,te:GetOwnerPlayer(),nil,0,0,0,0,0)
		end
	end
end
function c313513.filter(c,e,tp)
	return c:IsCode(83104731) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c313513.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()==0 and Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return false end
		e:SetLabel(0)
		return Duel.IsExistingMatchingCard(c313513.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c313513.dfilter(c)
	return c:IsFacedown() or c:GetCode()~=83104731
end
function c313513.spcheck(sg,e,tp,mg)
	return sg:FilterCount(Card.IsLocation,nil,LOCATION_HAND)<2 and sg:FilterCount(Card.IsLocation,nil,LOCATION_DECK)<2
end
function c313513.activate(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 then return end
	if ft>2 then ft=2 end
	local g=Duel.GetMatchingGroup(c313513.filter,tp,LOCATION_HAND+LOCATION_DECK,0,nil,e,tp)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) or g:FilterCount(Card.IsLocation,nil,LOCATION_HAND)<=0 
		or g:FilterCount(Card.IsLocation,nil,LOCATION_DECK)<=0 then ft=1 end
	local sg=aux.SelectUnselectGroup(g,e,tp,ft,ft,c313513.spcheck,1,tp,HINTMSG_SPSUMMON)
	if Duel.SpecialSummon(sg,0,tp,tp,true,false,POS_FACEUP)>0 then
		local dg=Duel.GetMatchingGroup(c313513.dfilter,tp,LOCATION_MZONE,0,nil)
		if dg:GetCount()>0 then
			Duel.BreakEffect()
			Duel.Destroy(dg,REASON_EFFECT)
		end
	end
end
