--Commander Covington (Manga)
--fixed by MLD
function c511015115.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511015115,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c511015115.cost)
	e1:SetTarget(c511015115.target)
	e1:SetOperation(c511015115.operation)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetOperation(c511015115.regop2)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(511015116)
	e3:SetLabelObject(e2)
	e3:SetTarget(c511015115.destg2)
	e3:SetOperation(c511015115.desop)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetCode(EVENT_ADJUST)
	e4:SetRange(LOCATION_MZONE)
	e4:SetOperation(c511015115.regop)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON)
	e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e5:SetCode(511015116)
	e5:SetRange(LOCATION_MZONE)
	e5:SetTarget(c511015115.destg)
	e5:SetOperation(c511015115.desop)
	c:RegisterEffect(e5)
end
c511015115.listed_names={58054262}
function c511015115.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c511015115.cfilter,tp,LOCATION_MZONE,0,nil)
	if chk==0 then return g:GetCount()>1 and Duel.GetLocationCountFromEx(tp,tp,g)>0 end
	g:KeepAlive()
	e:SetLabelObject(g)
	local tc=Duel.GetFirstMatchingCard(c511015115.filter,tp,LOCATION_EXTRA,0,nil,e,tp)
	Duel.Overlay(tc,g)
end
function c511015115.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x36)
end
function c511015115.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511015115.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	local g=e:GetLabelObject()
	g:KeepAlive()
	Duel.SetTargetCard(g)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAIN_NEGATED)
	e1:SetCondition(c511015115.discon)
	e1:SetOperation(c511015115.disop)
	e1:SetLabelObject(e)
	e1:SetReset(RESET_CHAIN)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EVENT_CHAIN_DISABLED)
	Duel.RegisterEffect(e2,tp)
	local e3=Effect.CreateEffect(e:GetHandler())
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(511015115)
	e3:SetOperation(c511015115.resetop)
	e3:SetLabelObject(g)
	e3:SetReset(RESET_CHAIN)
	Duel.RegisterEffect(e3,tp)
	e:SetLabelObject(nil)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511015115.discon(e,tp,eg,ep,ev,re,r,rp)
	return re==e:GetLabelObject()
end
function c511015115.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.RaiseEvent(re:GetHandler(),511015115,e,REASON_EFFECT,tp,tp,0)
end
function c511015115.resetop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	Duel.SendtoGrave(g,REASON_RULE)
end
function c511015115.filter(c,e,tp)
	return c:IsCode(58054262) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511015115.operation(e,tp,eg,ep,ev,re,r,rp)
	local og=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then Duel.SendtoGrave(g,REASON_RULE) return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,c511015115.filter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp):GetFirst()
	if tc then
		Duel.Overlay(tc,og)
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
		tc:CompleteProcedure()
		c:SetCardTarget(tc)
		c:RegisterFlagEffect(511015115,RESET_EVENT+0x1fe0000,0,0)
	else
		Duel.SendtoGrave(g,REASON_RULE)
	end
end
function c511015115.regop2(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetHandler():GetCardTarget()
	Duel.RaiseSingleEvent(e:GetHandler(),511015116,e,REASON_EFFECT,tp,tp,0)
	if g and g:GetCount()>0 then
		g:KeepAlive()
		e:SetLabelObject(g)
	end
end
function c511015115.regop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():GetCardTarget():FilterCount(Card.IsLocation,nil,LOCATION_MZONE)<=0 then return end
	if e:GetHandler():IsDisabled() and e:GetHandler():GetFlagEffect(511015115)>0 then
		Duel.RaiseEvent(e:GetHandler(),511015116,e,REASON_EFFECT,tp,tp,0)
		e:GetHandler():ResetFlagEffect(511015115)
	end
end
function c511015115.destg2(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=e:GetLabelObject():GetLabelObject()
	if chk==0 then return g and g:FilterCount(Card.IsLocation,nil,LOCATION_MZONE)>0 end
	local sg=g:Filter(Card.IsLocation,nil,LOCATION_MZONE)
	e:GetLabelObject():SetLabelObject(nil)
	local spg=Group.CreateGroup()
	local tc=sg:GetFirst()
	while tc do
		local og=tc:GetOverlayGroup()
		if og:GetCount()>0 then spg:Merge(og) end
		tc=sg:GetNext()
	end
	Duel.SetTargetCard(sg)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,g:GetCount(),0,0)
end
function c511015115.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=e:GetHandler():GetCardTarget()
	if chk==0 then return g:GetCount() and g:FilterCount(Card.IsLocation,nil,LOCATION_MZONE)>0 end
	local sg=g:Filter(Card.IsLocation,nil,LOCATION_MZONE)
	local spg=Group.CreateGroup()
	local tc=sg:GetFirst()
	while tc do
		local og=tc:GetOverlayGroup()
		if og:GetCount()>0 then spg:Merge(og) end
		tc=sg:GetNext()
	end
	Duel.SetTargetCard(sg)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,g:GetCount(),0,0)
end
function c511015115.desop(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if tg:GetCount()>0 then
		local spg=Group.CreateGroup()
		local tc=tg:GetFirst()
		while tc do
			local og=tc:GetOverlayGroup()
			if og:GetCount()>0 then spg:Merge(og) end
			tc=tg:GetNext()
		end
		if Duel.Destroy(tg,REASON_EFFECT)>0 then
			Duel.SpecialSummon(spg,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
