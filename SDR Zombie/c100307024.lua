--Zombie Struggle
--Logical Nonsense
function c100307024.initial_effect(c)
	--Activate effect to modify ATK
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetDescription(aux.Stringid(100307024,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCondition(c100307024.condition)
	e1:SetTarget(c100307024.target)
	e1:SetOperation(c100307024.activate)
	c:RegisterEffect(e1)
end
	--Shuffle to set from GY
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TODECK)
	e2:SetDescription(aux.Stringid(100307024,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,100307024)
	e2:SetTarget(c100307024.settg)
	e2:SetOperation(c100307024.setop)
	c:RegisterEffect(e2)
end
	--When it can be activated
function c100307024.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()~=PHASE_DAMAGE or not Duel.IsDamageCalculated()
end
	--Check target card is Zombie type
function c100307024.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_ZOMBIE)
end
	--Check for any valid targets on the field
function c100307024.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc,race)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c100307024.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c100307024.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(c100307024.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
	--Actually doing the first effect
function c100307024.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and c100307024.filter(tc) then --Checks if the target is valid
		local atk=1000
		if Duel.SelectYesNo(tp,aux.Stringid(100307024,2)) then atk=atk*-1 end --ask the player, and if they say yes (to "lose atk?"), turn the ATK gain into loss
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK) --Tells which stat will be changed
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END) --When the effect resets
		e1:SetValue(atk) --How much the ATK changes
		tc:RegisterEffect(e1)
	end
end
	--Check if there's any zombie to shuffle into deck
function c100307024.setfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_ZOMBIE) and c:IsAbleToDeck()
end
	--Set-up to allow the card to set it, and banish itself if it leaves
function c100307024.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsSSetable()
		and Duel.IsExistingMatchingCard(c100307024.setfilter,tp,LOCATION_REMOVED,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,e:GetHandler(),1,0,0)
end
	--Actually doing the second effect
function c100307024.setop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c100307024.setfilter,tp,LOCATION_REMOVED,0,1,1,nil)
	if #g>0 and Duel.SendtoDeck(g,nil,2,REASON_EFFECT)>0
		and c:IsRelateToEffect(e) and c:IsSSetable() then
		Duel.SSet(tp,c)
		Duel.ConfirmCards(1-tp,c)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x47e0000)
		e1:SetValue(LOCATION_REMOVED)
		c:RegisterEffect(e1)
	end
end