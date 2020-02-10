--ヴィクトリー・システム・ＦＯＯＬ
--Final Order Of Legacy
--Scripted by AlphaKretin
local s,id=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(s.regop)
	c:RegisterEffect(e1)
end
function s.regop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetRange(LOCATION_REMOVED) 
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetCountLimit(1)
	e1:SetCondition(s.wincon)
	e1:SetOperation(s.winop)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN)
	Duel.RegisterEffect(e1,tp)
end
function s.wincon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function s.winop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(1040,15))
	Duel.Hint(HINT_MESSAGE,1-tp,aux.Stringid(1040,15))
end