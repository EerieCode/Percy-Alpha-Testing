--Generic Witchcraft Monster
local s,id=GetID()
function s.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCost(s.cost)
	c:RegisterEffect(e1)
end
function s.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return aux.WitchcraftDiscardCost(aux.FilterBoolFunction(Card.IsType,TYPE_SPELL))(e,tp,eg,ep,ev,re,r,rp,0) end
	aux.WitchcraftDiscardCost(aux.FilterBoolFunction(Card.IsType,TYPE_SPELL))(e,tp,eg,ep,ev,re,r,rp,1)
end
