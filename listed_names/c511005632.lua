--M-Warrior#1 (DOR)
--scripted by GameMaster (GM)
function c511005632.initial_effect(c)
--atk/def up 500 m-Warrior #2
local e1=Effect.CreateEffect(c)
e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
e1:SetOperation(c511005632.operation)
c:RegisterEffect(e1)
end
c511005632.listed_names={92731455}
function c511005632.atktg(e,c)
return Duel.GetMatchingGroup(c511005632.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
end
function c511005632.filter(c)
return c:IsType(TYPE_MONSTER) and (c:IsFaceup() and c:IsCode(92731455) )
end
function c511005632.operation(e,tp,eg,ep,ev,re,r,rp)
local g=Duel.GetMatchingGroup(c511005632.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
local tc=g:GetFirst()
while tc do
local e1=Effect.CreateEffect(e:GetHandler())
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_UPDATE_ATTACK)
e1:SetTarget(c511005632.atktg)
e1:SetValue(500)
e1:SetReset(RESET_EVENT+0x1ff0000)
tc:RegisterEffect(e1)
local e2=e1:Clone()
e2:SetCode(EFFECT_UPDATE_DEFENSE)
tc:RegisterEffect(e2)
tc=g:GetNext()
end
end