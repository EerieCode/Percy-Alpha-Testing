--Gladiator Beast Assault Fort
function c511002973.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c511002973.condition)
	c:RegisterEffect(e1)
	--adjust
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_ADJUST)
	e2:SetRange(LOCATION_SZONE)
	e2:SetOperation(c511002973.desop)
	c:RegisterEffect(e2)
	--name
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CHANGE_CODE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_SZONE,0)
	e3:SetTarget(c511002973.gbtg)
	e3:SetValue(511002974)
	--c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_CHANGE_TYPE)
	e4:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
	--c:RegisterEffect(e4)
	--negate
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EVENT_CHAINING)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCondition(c511002973.discon)
	e5:SetOperation(c511002973.disop)
	c:RegisterEffect(e5)
	--activate
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e6:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e6:SetCode(EVENT_DESTROYED)
	e6:SetTarget(c511002973.actg)
	e6:SetOperation(c511002973.acop)
	c:RegisterEffect(e6)
	--
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e7:SetRange(LOCATION_SZONE)
	e7:SetCode(511002974)
	c:RegisterEffect(e7)
end
c511002973.listed_names={511002974,511002973,511002974,511002974,511002975}
function c511002973.condition(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return ep==tp and (a:IsSetCard(0x19) or (d and d:IsSetCard(0x19)))
end
function c511002973.desfilter(c)
	return not c:IsSetCard(0x19) or c:IsFacedown()
end
function c511002973.filter(c,tid)
	--if not c:IsCode(511002974) or c:GetFlagEffect(511002973)>0 then return false end
	if c:GetFlagEffect(511002973)>0 then return false end
	if c:IsHasEffect(511002974) and c:GetFieldID()<=tid then return false end
	--return not c:IsHasEffect(511002974) or c:GetFieldID()>tid
	return c:IsFaceup() and c:IsSetCard(0x19)
end
function c511002973.ovfilter(c)
	return c:IsSetCard(0x19) and c:IsType(TYPE_MONSTER)
end
function c511002973.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511002973.desfilter,tp,LOCATION_ONFIELD,0,nil)
	if g then
		Duel.Destroy(g,REASON_EFFECT)
	end
	local sg=Duel.GetMatchingGroup(c511002973.filter,tp,LOCATION_SZONE,0,e:GetHandler(),e:GetHandler():GetFieldID())
	if not sg or sg:GetCount()<=0 then return end
	local tc=sg:GetFirst()
	while tc do
		local cid=tc:ReplaceEffect(511002974,RESET_EVENT+RESETS_STANDARD)
		--reset
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EVENT_ADJUST)
		e1:SetRange(LOCATION_SZONE)
		e1:SetLabel(cid)
		e1:SetOperation(c511002973.resetop)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		local og=Duel.SelectMatchingCard(tp,c511002973.ovfilter,tp,LOCATION_DECK,0,1,1,nil)
		if og:GetCount()>0 then
			Duel.Overlay(tc,og)
		end
		tc:RegisterFlagEffect(511002973,RESET_EVENT+RESETS_STANDARD,0,0)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_CODE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetCondition(c511002973.effcon)
		e1:SetValue(511002974)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_CHANGE_TYPE)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)
		e2:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
		e2:SetCondition(c511002973.effcon)
		tc:RegisterEffect(e2)
		tc=sg:GetNext()
	end
end
function c511002973.effcon(e)
	if e:GetHandler():GetFlagEffect(511002973)>0 and e:GetHandler():GetSequence()<5 then
		return true
	else
		e:Reset()
		return false
	end
end
function c511002973.gbtg(e,c)
	if not c:IsSetCard(0x19) or c==e:GetHandler() or c:GetSequence()>=5 then return false end
	return not c:IsHasEffect(511002974) or c:GetFieldID()>e:GetHandler():GetFieldID()
end
function c511002973.cfilter(c)
	return c:IsFaceup() and c:IsCode(511002973) and not c:IsDisabled()
end
function c511002973.resetop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not Duel.IsExistingMatchingCard(c511002973.cfilter,tp,LOCATION_SZONE,0,1,nil) then
		c:ResetEffect(e:GetLabel(),RESET_COPY)
		c:ResetFlagEffect(511002973)
		e:Reset()
		if c:GetType()&TYPE_CONTINUOUS+TYPE_FIELD==0 then
			Duel.SendtoGrave(c,REASON_RULE)
		elseif not c:IsCode(511002974) then
			local og=c:GetOverlayGroup()
			if og:GetCount()>0 then
				Duel.SendtoGrave(og,REASON_RULE)
			end
		end
	end
end
function c511002973.discon(e,tp,eg,ep,ev,re,r,rp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:GetHandler():IsControler(tp) and re:GetHandler():IsCode(511002974)
end
function c511002973.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
	re:GetHandler():CancelToGrave()
end
function c511002973.acfilter(c,tp)
	local te=c:GetActivateEffect()
	return c:IsCode(511002975) and te:IsActivatable(tp)
end
function c511002973.actg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_ONFIELD,0,nil)
	if chk==0 then return g:GetCount()>0 and (Duel.GetLocationCount(tp,LOCATION_SZONE)>0 or g:FilterCount(Card.IsLocation,nil,LOCATION_SZONE)>0) 
		and Duel.IsExistingMatchingCard(c511002973.acfilter,tp,0x13,0,1,nil,tp) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c511002973.acop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_ONFIELD,0,nil)
	if Duel.Destroy(g,REASON_EFFECT)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EFFECT)
		local tc=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c511002973.acfilter),tp,0x13,0,1,1,nil,tp):GetFirst()
		if tc then
			local tpe=tc:GetType()
			local te=tc:GetActivateEffect()
			local tg=te:GetTarget()
			local co=te:GetCost()
			local op=te:GetOperation()
			e:SetCategory(te:GetCategory())
			e:SetProperty(te:GetProperty())
			Duel.ClearTargetCard()
			if bit.band(tpe,TYPE_FIELD)~=0 then
				local fc=Duel.GetFieldCard(1-tp,LOCATION_SZONE,5)
				if Duel.IsDuelType(DUEL_OBSOLETE_RULING) then
					if fc then Duel.Destroy(fc,REASON_RULE) end
					fc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
					if fc and Duel.Destroy(fc,REASON_RULE)==0 then Duel.SendtoGrave(tc,REASON_RULE) end
				else
					Duel.GetFieldCard(tp,LOCATION_SZONE,5)
					if fc and Duel.SendtoGrave(fc,REASON_RULE)==0 then Duel.SendtoGrave(tc,REASON_RULE) end
				end
			end
			Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
			Duel.Hint(HINT_CARD,0,tc:GetCode())
			tc:CreateEffectRelation(te)
			if bit.band(tpe,TYPE_EQUIP+TYPE_CONTINUOUS+TYPE_FIELD)==0 then
				tc:CancelToGrave(false)
			end
			if co then co(te,tp,eg,ep,ev,re,r,rp,1) end
			if tg then tg(te,tp,eg,ep,ev,re,r,rp,1) end
			Duel.BreakEffect()
			local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
			if g then
				local etc=g:GetFirst()
				while etc do
					etc:CreateEffectRelation(te)
					etc=g:GetNext()
				end
			end
			if op then op(te,tp,eg,ep,ev,re,r,rp) end
			tc:ReleaseEffectRelation(te)
			if etc then	
				etc=g:GetFirst()
				while etc do
					etc:ReleaseEffectRelation(te)
					etc=g:GetNext()
				end
			end
		end
	end
end
