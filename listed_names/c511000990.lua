--Yasushi the Skull Knight
function c511000990.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcMix(c,true,true,78010363,80604091)
	local e2=Effect.CreateEffect(c)
	e2:SetCode(EFFECT_ADD_TYPE)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_IGNORE_RANGE+EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(TYPE_NORMAL)
	c:RegisterEffect(e2)
	if not c511000990.global_check then
		c511000990.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD)
		ge2:SetCode(EFFECT_EXTRA_FUSION_MATERIAL)
		ge2:SetTargetRange(LOCATION_SZONE+LOCATION_HAND,LOCATION_SZONE+LOCATION_HAND)
		ge2:SetTarget(c511000990.mttg)
		ge2:SetValue(c511000990.mtval)
		Duel.RegisterEffect(ge2,0)
	end
end
c511000990.listed_names={80604091}
c511000990.illegal=true
function c511000990.mttg(e,c)
	return (c:IsCode(80604091) or c:GetOriginalCode()==80604091 or c:GetOriginalCode()==511003023)
end
function c511000990.mtval(e,c)
	if not c then return false end
	return c:GetOriginalCode()==511000990
end
