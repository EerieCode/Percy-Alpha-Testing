--マズルフラッシュ・ドラゴン
--Flash Charge Dragon
--scripted by Larry126
function c95372220.initial_effect(c)
	--force mzone
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_FORCE_MZONE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(1,0)
	e1:SetValue(c95372220.filter)
	c:RegisterEffect(e1)
end
function c95372220.filter(e,c)
	local zone = e:GetHandler():GetLinkedZone()
	return ~(((zone>>16)&0x1ff)<<16|zone&0x1ff)
end