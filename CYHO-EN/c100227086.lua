--Realm of Danger!
--Scripted by AlphaKretin
function c100227086.intial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--cannot be target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c100227086.target)
	e2:SetValue(aux.tgoval)
	c:RegisterEffect(e2)
end
function c100227086.target(e,c)
	return c:IsSetCard(0x233) and c:IsStatus(STATUS_SPSUMMON_TURN)
end