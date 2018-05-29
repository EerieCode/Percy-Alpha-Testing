--Mountain Warrior (DOR)
--scripted by GameMaster (GM)
function c511005809.initial_effect(c)	
--+300 atk/def if mountian is on field
local e1=Effect.CreateEffect(c)
e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
e1:SetCondition(c511005809.condition)
e1:SetOperation(c511005809.operation)
c:RegisterEffect(e1)
end
c511005809.listed_names={50913601}
function c511005809.atktg(e,c)
return Duel.GetMatchingGroup(c511005809.filter2,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
end
function c511005809.filter2(c)
return c:IsType(TYPE_MONSTER) and c:IsFaceup()
end
function c511005809.filter(c)
return c:IsFaceup() and c:IsCode(50913601)
end
function c511005809.condition(e,tp,eg,ep,ev,re,r,rp)
return Duel.IsExistingMatchingCard(c511005809.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) 
end
function c511005809.operation(e,tp,eg,ep,ev,re,r,rp)
local g=Duel.GetMatchingGroup(c511005809.filter2,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
local tc=g:GetFirst()
while tc do
local e1=Effect.CreateEffect(e:GetHandler())
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_UPDATE_ATTACK)
e1:SetTarget(c511005809.atktg)
e1:SetValue(300)
e1:SetReset(RESET_EVENT+0x1ff0000)
tc:RegisterEffect(e1) 
local e2=e1:Clone()
e2:SetCode(EFFECT_UPDATE_DEFENSE)
tc:RegisterEffect(e2) 
tc=g:GetNext()
end
end
