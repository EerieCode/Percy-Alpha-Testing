--ソウル・レヴィ
--Soul Levy
--Logical Nonsense

--Substitute ID
local s,id=GetID()

function s.initial_effect(c)
	--Only control 1
	c:SetUniqueOnField(1,0,id)
	--Send 3 cards from opponent's deck to GY
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(s.condition)
	e1:SetOperation(s.operation)
	c:RegisterEffect(e1)
end
	--Who summoned
function s.filter(c,tp)
	return c:GetSummonPlayer()==tp
end
	--If it ever happened
function s.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(s.filter,1,nil,1-tp)
end
	--Send 3 cards from opponent's deck to GY
function s.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,id)
	Duel.DiscardDeck(1-tp,3,REASON_EFFECT)
end
