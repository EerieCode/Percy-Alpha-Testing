--神鳥の烈戦
--Simorgh Storms Forth
--Scripted by AlphaKretin
local s,id=GetID()
function s.initial_effect(c)
	--Activate
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    c:RegisterEffect(e1)
    --Cannot target
    local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_FIELD)
    e2:SetRange(LOCATION_SZONE)
    e2:SetTargetRange(0,LOCATION_MZONE)
    e2:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
    e2:SetValue(s.atlimit)
    c:RegisterEffect(e1)
end
function s.atkval(tp)
	local g=Duel.GetMatchingGroup(aux.FilterFaceupFunction(Card.IsRace,RACE_WINDBEAST),tp,LOCATION_MZONE,0,nil)
	local _,val=g:GetMaxGroup(Card.GetAttack)
	return val
end
function s.atlimit(e,c)
    return c:IsFaceup() and c:IsRace(RACE_WINDBEAST) and c:GetAttack()<s.atkval(e:GetHandlerPlayer())
end