--Odd-Eyes Synchro Gate
function c511015105.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511015105.cost)
	e1:SetTarget(c511015105.target)
	e1:SetOperation(c511015105.activate)
	c:RegisterEffect(e1)
	Duel.AddCustomActivityCounter(511015105,ACTIVITY_SPSUMMON,c511015105.counterfilter)
end
c511015105.listed_names={16178681,16178681,511015106}
function c511015105.counterfilter(c)
	return not c:IsSummonType(SUMMON_TYPE_PENDULUM)
end
function c511015105.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return sumtype&SUMMON_TYPE_PENDULUM==SUMMON_TYPE_PENDULUM
end
function c511015105.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCustomActivityCount(511015105,tp,ACTIVITY_SPSUMMON)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c511015105.splimit)
	Duel.RegisterEffect(e1,tp)
	if e:IsHasType(EFFECT_TYPE_ACTIVATE) then
		aux.RemainFieldCost(e,tp,eg,ep,ev,re,r,rp,1)
	end
end
function c511015105.filter1(c,e,tp)
	return c:IsCode(16178681) and c:IsFaceup() and c:IsCanBeSpecialSummoned(e,0,tp,false,false) 
		and Duel.IsExistingTarget(c511015105.filter2,tp,LOCATION_GRAVE,0,1,nil,e,tp,c)
end
function c511015105.filter2(c,e,tp,odd)
	return c:IsType(TYPE_SYNCHRO) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and Duel.IsExistingMatchingCard(c511015105.filter3,tp,LOCATION_EXTRA,0,1,odd,e,tp,c,odd)
end
function c511015105.filter3(c,e,tp,syn,odd)
	if not c:IsType(TYPE_PENDULUM) then return false end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_LEVEL)
	e1:SetValue(1)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	odd:RegisterEffect(e1)
	odd:AssumeProperty(ASSUME_TYPE,odd:GetType()|TYPE_TUNER)
	local result=c:IsSynchroSummonable(nil,Group.FromCards(syn,odd))
	e1:Reset()
	Duel.AssumeReset()
	return result
end
function c511015105.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local ect=c29724053 and Duel.IsPlayerAffectedByEffect(tp,29724053) and c29724053[tp]
	if chkc then return false end
	if chk==0 then return not Duel.IsPlayerAffectedByEffect(tp,59822133) and Duel.IsPlayerCanSpecialSummonCount(tp,2) 
		and (not ect or ect>=2) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.GetLocationCountFromEx(tp)>0 and Duel.GetUsableMZoneCount(tp)>1 
		and Duel.IsExistingTarget(c511015105.filter1,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local c1=Duel.SelectTarget(tp,c511015105.filter1,tp,LOCATION_EXTRA,0,1,1,nil,e,tp):GetFirst()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local c2=Duel.SelectTarget(tp,c511015105.filter2,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,c1):GetFirst()
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,Group:FromCards(c1,c2),2,0,0)
end
function c511015105.activate(e,tp,eg,ep,ev,re,r,rp)
	local ect=c29724053 and Duel.IsPlayerAffectedByEffect(tp,29724053) and c29724053[tp]
	if Duel.IsPlayerAffectedByEffect(tp,59822133) or Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 
		or Duel.GetLocationCountFromEx(tp)<=0 or Duel.GetUsableMZoneCount(tp)<=1 then return false end
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	if not aux.MainAndExtraSpSummonLoop(c511015105.disop,0,0,0,false,false)(e,tp,eg,ep,ev,re,r,rp,sg) then return end
	Duel.BreakEffect()
	local g=Duel.GetMatchingGroup(function(sc) return sc:IsType(TYPE_PENDULUM) and sc:IsSynchroSummonable(nil,sg) end,tp,LOCATION_EXTRA,0,nil)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sc=g:Select(tp,1,1,nil):GetFirst()
		Duel.SynchroSummon(tp,sc,nil,sg)
		local c=e:GetHandler()
		if not c:IsRelateToEffect(e) or not e:IsHasType(EFFECT_TYPE_ACTIVATE) then return end
		local e1=Effect.CreateEffect(c)
		e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
		e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
		e1:SetRange(LOCATION_SZONE)
		e1:SetCode(EVENT_LEAVE_FIELD)
		e1:SetCondition(c511015105.descon)
		e1:SetTarget(c511015105.destg)
		e1:SetOperation(c511015105.desop)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetLabelObject(sc)
		c:RegisterEffect(e1)
	end
end
function c511015105.disop(e,tp,eg,ep,ev,re,r,rp,tc)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	tc:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_DISABLE_EFFECT)
	tc:RegisterEffect(e2)
	if tc:IsCode(16178681) then
		local e3=Effect.CreateEffect(e:GetHandler())
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_CHANGE_LEVEL)
		e3:SetValue(1)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e3)
		local e4=Effect.CreateEffect(e:GetHandler())
		e4:SetType(EFFECT_TYPE_SINGLE)
		e4:SetCode(EFFECT_ADD_TYPE)
		e4:SetReset(RESET_EVENT+0x1fe0000)
		e4:SetValue(TYPE_TUNER)
		tc:RegisterEffect(e4)
	end
end
function c511015105.descon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	return tc and eg:IsContains(tc) and tc:IsReason(REASON_DESTROY)
end
function c511015105.thfilter(c)
	return c:IsAbleToHand() and c:IsCode(511015106)
end
function c511015105.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGrave() 
		and Duel.IsExistingMatchingCard(c511015105.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c511015105.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SendtoGrave(c,REASON_EFFECT)~=0 and c:IsLocation(LOCATION_GRAVE) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,c511015105.thfilter,tp,LOCATION_DECK,0,1,1,nil)
		if g:GetCount()>0 then
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		end
	end
end
