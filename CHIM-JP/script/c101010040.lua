--海晶乙女クリスタルハート
--Marincess Crystal Heart
--Scripted by AlphaKretin
local s,id=GetID()
function s.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunctionEx(Card.IsAttribute,ATTRIBUTE_WATER),2,2)
	c:EnableReviveLimit()
	--immune
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(s.econ)
	e1:SetValue(s.efilter)
	c:RegisterEffect(e1)
	--other immune
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetCondition(s.imcon)
	e2:SetTarget(s.imtg)
	e2:SetValue(s.imval)
	c:RegisterEffect(e2)
	--protect battle
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BE_BATTLE_TARGET)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCondition(s.damcon)
	e2:SetOperation(s.damop)
	c:RegisterEffect(e2)
end
function s.econ(e)
	return e:GetHandler():GetSequence()>4
end
function s.efilter(e,te)
	return te:GetOwner()~=e:GetOwner()
end
function s.imcon(e)
	local ph=Duel.GetCurrentPhase()
	return (ph==PHASE_DAMAGE or ph==PHASE_DAMAGE_CAL)
end
function s.imtg(e,c)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	local tc=e:GetHandler()
	return a and d and (a==c and d==tc) or (a==tc and d==c)
end
function s.imval(e,te)
    return te:GetOwner()~=e:GetOwner()
end
function s.damfilter(c,tg)
	return tg:IsContains(c) and c:IsSetCard(0x12b)
end
function s.damcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return eg:IsContains(c) or eg:IsExists(s.damfilter,1,nil,c:GetLinkedGroup())
end
function s.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(s.cfilter,tp,LOCATION_HAND,0,1,nil) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
    local g=Duel.SelectMatchingCard(tp,s.cfilter,tp,LOCATION_HAND,0,1,1,nil)
    Duel.SendtoGrave(g,REASON_COST)
end
function s.damop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetAttackTarget()
	if tc and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
        e1:SetValue(1)
        e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE)
        tc:RegisterEffect(e1)
	end
	local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    e2:SetCode(EVENT_PRE_BATTLE_DAMAGE)
    e2:SetOperation(s.damop)
    e2:SetReset(RESET_PHASE+PHASE_DAMAGE)
    Duel.RegisterEffect(e2,tp)
end
function s.damop(e,tp,eg,ep,ev,re,r,rp)
    Duel.ChangeBattleDamage(tp,0)
end