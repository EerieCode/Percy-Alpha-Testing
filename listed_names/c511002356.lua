--Voltic Spear
function c511002356.initial_effect(c)
	aux.AddEquipProcedure(c,nil,aux.FilterBoolFunction(Card.IsRace,RACE_WARRIOR))
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(c511002356.value)
	c:RegisterEffect(e2)
end
c511002356.listed_names={9327502}
function c511002356.value(e,c)
	local ec=e:GetHandler():GetEquipTarget()
	if ec:IsCode(9327502) then
		return 1000
	else
		return 300
	end
end
