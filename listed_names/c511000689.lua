--Rose Whip
function c511000689.initial_effect(c)
	aux.AddEquipProcedure(c,nil,aux.FilterBoolFunction(Card.IsCode,76812113))
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(c511000689.atkval)
	c:RegisterEffect(e2)
	--def up
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	e3:SetValue(c511000689.atkval)
	c:RegisterEffect(e3)
end
c511000689.listed_names={76812113}
function c511000689.filter(c)
	return c:IsFaceup() and c:IsCode(76812113) 
end
function c511000689.atkval(e,c)
	return Duel.GetMatchingGroupCount(c511000689.filter,c:GetControler(),LOCATION_MZONE,LOCATION_MZONE,nil)*300
end
