--Stormrider Hippogriff
--Logical Nonsense

--Substitue ID
local s,id=GetID()

function s.initial_effect(c)
	--Special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(s.spcon)
	c:RegisterEffect(e1)
end
	--Defining what zones to look at
function s.filter(c)
	return c:GetSequence()<5
end
	--If you have a free monster zone and opponent controls a card in their S/T zone
function s.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(s.filter,tp,0,LOCATION_SZONE,1,nil)
end