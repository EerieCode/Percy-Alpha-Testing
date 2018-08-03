--Mischief of the Time Goddess
--scripted by AlphaKretin and Larry126
local CARD
local CODE
local SET_VALKYRIE
function CARD.initial_effect(c)
    --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e1:SetCondition(CARD.condition)
	e1:SetTarget(CARD.target)
	e1:SetOperation(CARD.activate)
	c:RegisterEffect(e1)
end
function CARD.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(SET_VALKYRIE)
end
function CARD.condition(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_MZONE,0)
	return Duel.GetCurrentChain()>1 and Duel.GetTurnPlayer()==tp and #g>0 and g:FilterCount(CARD.cfilter,nil)==#g
end
function CARD.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	if e:IsHasType(EFFECT_TYPE_ACTIVATE) then
		Duel.SetChainLimit(aux.FALSE)
	end
end
function CARD.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.SendtoGrave(c,REASON_EFFECT)
	local ph=Duel.GetCurrentPhase()
	local tid=Duel.GetTurnCount()
	local p=Duel.GetTurnPlayer()
	if p==tp then
		local e1=Effect.GlobalEffect()
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCode(EFFECT_SKIP_TURN)
		e1:SetTargetRange(0,1)
		e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
		Duel.RegisterEffect(e1,tp)
		Duel.SkipPhase(tp,PHASE_DRAW,RESET_PHASE+PHASE_END,2)
		Duel.SkipPhase(tp,PHASE_STANDBY,RESET_PHASE+PHASE_END,2)
		Duel.SkipPhase(tp,PHASE_MAIN1,RESET_PHASE+PHASE_END,2)
	else
		Duel.SkipPhase(tp,PHASE_DRAW,RESET_PHASE+PHASE_END,1)
		Duel.SkipPhase(tp,PHASE_STANDBY,RESET_PHASE+PHASE_END,1)
		Duel.SkipPhase(tp,PHASE_MAIN1,RESET_PHASE+PHASE_END,1)
	end
	Duel.SkipPhase(p,PHASE_DRAW,RESET_PHASE+PHASE_END,1)
	Duel.SkipPhase(p,PHASE_STANDBY,RESET_PHASE+PHASE_END,1)
	Duel.SkipPhase(p,PHASE_MAIN1,RESET_PHASE+PHASE_END,1)
	if ph<PHASE_BATTLE_START then
		local e1=Effect.GlobalEffect()
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCode(EFFECT_CANNOT_BP)
		e1:SetLabel(tid)
		e1:SetTargetRange(1,0)
		e1:SetCondition(CARD.skipcon)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,p)
	else
		Duel.SkipPhase(p,PHASE_BATTLE,RESET_PHASE+PHASE_END,1,2)
	end
	Duel.SkipPhase(p,PHASE_MAIN2,RESET_PHASE+PHASE_END,1)
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_EP)
	e1:SetLabel(tid)
	e1:SetTargetRange(1,0)
	e1:SetCondition(CARD.skipcon)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,p)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(1,0)
	e1:SetValue(CARD.aclimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function CARD.skipcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnCount()==e:GetLabel()
end
function CARD.aclimit(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsCode(CODE)
end