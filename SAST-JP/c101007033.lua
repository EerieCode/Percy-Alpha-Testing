--トリックスターバンド・ギタースイート
--Trickstar Band Sweet Guitar
--scripted by Larry126
function c101007033.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcMix(c,true,true,c101007033.matfilter,aux.FilterBoolFunction(Card.IsFusionSetCard,0xfb)) --aux.FilterBoolFunctionEx(Card.IsSetCard,0xfb)
	--avoid damage
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_DAMAGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_AVAILABLE_BD)
	e1:SetTargetRange(0,1)
	e1:SetValue(c101007033.damval)
	c:RegisterEffect(e1)
	--gain atk
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(101007033,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_DAMAGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c101007033.atkcon)
	e2:SetOperation(c101007033.atkop)
	c:RegisterEffect(e2)
	--recycle
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(101007033,1))
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_LEAVE_GRAVE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetLabelObject(e2)
	e3:SetCondition(c101007033.condition)
	e3:SetTarget(c101007033.target)
	e3:SetOperation(c101007033.operation)
	c:RegisterEffect(e3)
end
c101007033.material_setcode={0xfb}
function c101007033.matfilter(c,fc,sumtype,tp)
	return c:IsType(TYPE_LINK,fc,sumtype,tp) and c:IsFusionSetCard(0xfb) --c:IsSetCard(0xfb,fc,sumtype,tp)
end
function c101007033.damval(e,re,val,r,rp)
	if r&REASON_EFFECT==REASON_EFFECT and re and re:IsActiveType(TYPE_MONSTER) then
		local rc=re:GetHandler()
		if rc:IsFaceup() and rc:IsSetCard(0xfb) and rc:IsType(TYPE_LINK)
			and rc:GetLinkedGroup():IsContains(e:GetHandler()) then
			return val*2
		end
	end
	return val
end
function c101007033.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and r&REASON_EFFECT==REASON_EFFECT and re:IsActiveType(TYPE_MONSTER) and re:GetHandler():IsSetCard(0xfb)
end
function c101007033.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetLabelObject(e)
		e1:SetValue(ev)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD_DISABLE)
		c:RegisterEffect(e1)
	end
end
function c101007033.thfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0xfb) and c:IsAbleToHand()
end
function c101007033.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetAttackedCount()>0
end
function c101007033.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local effs={e:GetHandler():GetCardEffect(EFFECT_UPDATE_ATTACK)}
		for _,eff in ipairs(effs) do
			if eff:GetLabelObject()==e:GetLabelObject() then
				return true
			end
		end
		return false
	end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_GRAVE)
end
function c101007033.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local chk=false
		local effs={c:GetCardEffect(EFFECT_UPDATE_ATTACK)}
		for _,eff in ipairs(effs) do
			if eff:GetLabelObject()==e:GetLabelObject() then
				eff:Reset()
				chk=true
			end
		end
		local g=Duel.GetMatchingGroup(aux.NecroValleyFilter(c101007033.thfilter),tp,LOCATION_GRAVE,0,nil)
		if chk and #g>0 and Duel.SelectYesNo(tp,aux.Stringid(101007033,2)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local sg=g:Select(tp,1,1,nil)
			Duel.SendtoHand(sg,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,sg)
		end
	end
end
