--呪眼の女王 ゴルゴーネ
--Gorgone, Queen of the Evil Eyed
--Scripted by Eerie Code
local s,id=GetID()
function s.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,nil,2,2,s.matcheck)
	--atk up
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(s.atkval)
	c:RegisterEffect(e1)
	--negate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,0))
	e2:SetCategory(CATEGORY_DISABLE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetHintTiming(0,0x1c0)
	e2:SetCountLimit(1,id)
	e2:SetCondition(s.condition)
	e2:SetTarget(s.target)
	e2:SetOperation(s.operation)
	c:RegisterEffect(e2)
end
s.listed_names={CARD_EVIL_EYE_SELENE}
s.listed_series={0x129}
function s.matcheck(g,lc,tp)
    return g:IsExists(Card.IsLinkSetCard,1,nil,0x129)
end
function s.atkval(e,c)
	local g=Duel.GetMatchingGroup(Card.IsSetCard,e:GetHandlerPlayer(),LOCATION_GRAVE,0,nil,0x129)
	return g:GetClassCount(Card.GetCode)*100
end
function s.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetEquipGroup():IsExists(Card.IsCode,1,nil,CARD_EVIL_EYE_SELENE)
end
function s.filter(c)
	return c:IsType(TYPE_EFFECT) and aux.disfilter1(c)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and s.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(s.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,s.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,g,1,0,0)
end
function s.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc and ((tc:IsFaceup() and not tc:IsDisabled()) or tc:IsType(TYPE_TRAPMONSTER)) and tc:IsRelateToEffect(e) then
		Duel.NegateRelatedChain(tc,RESET_TURN_SET)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
		if tc:IsType(TYPE_TRAPMONSTER) then
			local e3=Effect.CreateEffect(c)
			e3:SetType(EFFECT_TYPE_SINGLE)
			e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e3:SetCode(EFFECT_DISABLE_TRAPMONSTER)
			e3:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e3)
		end
	end
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e0=Effect.CreateEffect(c)
		e0:SetCategory(CATEGORY_DESTROY)
		e0:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
		e0:SetCode(EVENT_PHASE+PHASE_STANDBY)
		e0:SetRange(LOCATION_MZONE)
		e0:SetCountLimit(1)
		if Duel.GetCurrentPhase()==PHASE_STANDBY then
			e0:SetLabel(Duel.GetTurnCount())
			e0:SetReset(RESET_PHASE+PHASE_STANDBY,2)
		else
			e0:SetLabel(0)
			e0:SetReset(RESET_PHASE+PHASE_STANDBY)			
		end
		e0:SetCondition(s.descon)
		e0:SetOperation(s.desop)
		c:RegisterEffect(e0)
	end
end
function s.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetLabel()~=Duel.GetTurnCount()
end
function s.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local g=c:GetLinkedGroup()
	if #g>0 then
		if #g>1 then 
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
			g=g:Select(tp,1,1,nil)
		end
		Duel.Destroy(g,REASON_EFFECT)
	end
end
