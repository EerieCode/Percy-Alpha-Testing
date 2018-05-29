--Mushroom Man(DOR)
--scripted by GameMaster (GM)
function c511005717.initial_effect(c)
--atk/def up 500 mushroom man #2
local e1=Effect.CreateEffect(c)
e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
e1:SetOperation(c511005717.operation)
c:RegisterEffect(e1)
end
c511005717.listed_names={93900406}
function c511005717.atktg(e,c)
return Duel.GetMatchingGroup(c511005717.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
end
function c511005717.filter(c)
return c:IsType(TYPE_MONSTER) and (c:IsFaceup() and c:IsCode(93900406) )
end
function c511005717.operation(e,tp,eg,ep,ev,re,r,rp)
local g=Duel.GetMatchingGroup(c511005717.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
local tc=g:GetFirst()
while tc do
local e1=Effect.CreateEffect(e:GetHandler())
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_UPDATE_ATTACK)
e1:SetTarget(c511005717.atktg)
e1:SetValue(500)
e1:SetReset(RESET_EVENT+0x1ff0000)
tc:RegisterEffect(e1)
local e2=e1:Clone()
e2:SetCode(EFFECT_UPDATE_DEFENSE)
tc:RegisterEffect(e2)
tc=g:GetNext()
end
end
