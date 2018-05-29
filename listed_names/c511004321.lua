--Skull Skull Servant (DOR)
--scripted by GameMaster (GM)
function c511004321.initial_effect(c)
--atk/def up 300 skullServant
local e2=Effect.CreateEffect(c)
e2:SetDescription(aux.Stringid(511004321,0))
e2:SetCategory(CATEGORY_ATKCHANGE)
e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
e2:SetOperation(c511004321.operation)
c:RegisterEffect(e2)
end
c511004321.listed_names={32274490}
function c511004321.atktg(e,c)
return Duel.GetMatchingGroup(c511004321.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
end
function c511004321.filter(c)
return c:IsType(TYPE_MONSTER) and (c:IsFaceup() and c:IsCode(32274490) )
end
function c511004321.operation(e,tp,eg,ep,ev,re,r,rp)
local g=Duel.GetMatchingGroup(c511004321.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
local tc=g:GetFirst()
while tc do
local e1=Effect.CreateEffect(e:GetHandler())
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_UPDATE_ATTACK)
e1:SetTarget(c511004321.atktg)
e1:SetValue(300)
e1:SetReset(RESET_EVENT+0x1ff0000)
tc:RegisterEffect(e1)
local e2=e1:Clone()
e2:SetCode(EFFECT_UPDATE_DEFENSE)
tc:RegisterEffect(e2)
tc=g:GetNext()
end
end