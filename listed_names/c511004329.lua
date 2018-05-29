--Mystic Lamp
--scripted by andré
--fixed by GameMaster
function c511004329.initial_effect(c)
--Increase lord of the lamps by 700 atk/def
local e1=Effect.CreateEffect(c)
e1:SetCategory(CATEGORY_ATKCHANGE)
e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
e1:SetOperation(c511004329.operation)
c:RegisterEffect(e1)
end
c511004329.listed_names={99510761}
function c511004329.atktg(e,c)
return Duel.GetMatchingGroup(c511004329.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
end
function c511004329.filter(c)
return c:IsType(TYPE_MONSTER) and (c:IsFaceup() and c:IsCode(99510761) )
end
function c511004329.operation(e,tp,eg,ep,ev,re,r,rp)
local g=Duel.GetMatchingGroup(c511004329.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
local tc=g:GetFirst()
while tc do
local e1=Effect.CreateEffect(e:GetHandler())
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_UPDATE_ATTACK)
e1:SetTarget(c511004329.atktg)
e1:SetValue(700)
e1:SetReset(RESET_EVENT+0x1ff0000)
tc:RegisterEffect(e1)
local e2=e1:Clone()
e2:SetCode(EFFECT_UPDATE_DEFENSE)
tc:RegisterEffect(e2)
tc=g:GetNext()
end
end