--シールド・ハンドラ
--Shield Handler
--scripted by Larry126
function c101005068.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c101005068.condition)
	e1:SetTarget(c101005068.target)
	e1:SetOperation(c101005068.activate)
	c:RegisterEffect(e1)
end
function c101005068.filter(c)
	return c:IsOnField() and c:IsType(TYPE_MONSTER)
end
function c101005068.condition(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsChainNegatable(ev) then return false end
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_DESTROY)
	return ex and tg~=nil and tc+tg:FilterCount(c101005068.filter,nil)-tg:GetCount()>0
end
function c101005068.cfilter(c,sf)
	return c:IsType(TYPE_LINK) and c:IsFaceup() and (sf or aux.disfilter1(c))
end
function c101005068.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c101005068.cfilter,tp,0,LOCATION_MZONE,1,nil,false)
		and Duel.IsExistingTarget(c101005068.cfilter,tp,LOCATION_MZONE,0,1,nil,true) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_OPPO)
	local g=Duel.SelectTarget(tp,c101005068.cfilter,tp,0,LOCATION_MZONE,1,1,nil,false)
	e:SetLabelObject(g:GetFirst())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SELF)
	Duel.SelectTarget(tp,c101005068.cfilter,tp,LOCATION_MZONE,0,1,1,nil,true)
end
function c101005068.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local hc=e:GetLabelObject()
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tc=g:GetFirst()
	if tc==hc then tc=g:GetNext() end
	if hc:IsFaceup() and hc:IsRelateToEffect(e) and not hc:IsDisabled() then
		Duel.NegateRelatedChain(hc,RESET_TURN_SET)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		hc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		hc:RegisterEffect(e2)
		if hc:IsType(TYPE_TRAPMONSTER) then
			local e3=e1:Clone()
			e3:SetCode(EFFECT_DISABLE_TRAPMONSTER)
			hc:RegisterEffect(e3)
		end
		if not hc:IsImmuneToEffect(e1) and not hc:IsImmuneToEffect(e2) and (not e3 or not hc:IsImmuneToEffect(e3))
			and tc:IsRelateToEffect(e) and tc:IsFaceup() and c:IsRelateToEffect(e) then
			Duel.Equip(tp,c,tc)
			c:CancelToGrave()
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_EQUIP)
			e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			e1:SetValue(1)
			c:RegisterEffect(e1)
			--Equip limit
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_EQUIP_LIMIT)
			e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e2:SetValue(c101005068.eqlimit)
			e2:SetLabelObject(tc)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			c:RegisterEffect(e2)
		end
	end
end
function c101005068.eqlimit(e,c)
	return c==e:GetLabelObject()
end