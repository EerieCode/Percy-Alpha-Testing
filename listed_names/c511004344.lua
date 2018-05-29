--マグネッツ２号 a.k.a M-Warrior 2 (DOR)
--by Pratama
--fixed by GameMaster
function c511004344.initial_effect(c)
	--flip effect, atk & def update of all "M-Warrior 1" currently on the field by 500 points.
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e2:SetOperation(c511004344.operation)
	c:RegisterEffect(e2)
end
c511004344.listed_names={56342351}
function c511004344.atktg(e,c)
return Duel.GetMatchingGroup(c511004344.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
end
function c511004344.filter(c)
return c:IsType(TYPE_MONSTER) and (c:IsFaceup() and c:IsCode(56342351) )
end
function c511004344.operation(e,tp,eg,ep,ev,re,r,rp)
local g=Duel.GetMatchingGroup(c511004344.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
local tc=g:GetFirst()
while tc do
local e1=Effect.CreateEffect(e:GetHandler())
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_UPDATE_ATTACK)
e1:SetTarget(c511004344.atktg)
e1:SetValue(500)
e1:SetReset(RESET_EVENT+0x1ff0000)
tc:RegisterEffect(e1)
local e2=e1:Clone()
e2:SetCode(EFFECT_UPDATE_DEFENSE)
tc:RegisterEffect(e2)
tc=g:GetNext()
end
end