--7 Completed (DOR)
--scripted by GameMaster (GM)
function c511005827.initial_effect(c)
--+700 atk/def slot machine
local e1=Effect.CreateEffect(c)
e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetTarget(c511005827.target)
e1:SetOperation(c511005827.activate)
c:RegisterEffect(e1)
end
c511005827.listed_names={3797883}
function c511005827.filter(c)
return c:IsCode(3797883) and c:IsFaceup()
end
function c511005827.target(e,tp,eg,ep,ev,re,r,rp,chk)
local tc=Duel.GetFirstTarget()
if chk==0 then return Duel.IsExistingTarget(c511005827.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,tc) end
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
Duel.SelectTarget(tp,c511005827.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,tc)
end
function c511005827.activate(e,tp,eg,ep,ev,re,r,rp)
local tc=Duel.GetFirstTarget()
if tc:IsRelateToEffect(e)  then
local e1=Effect.CreateEffect(e:GetHandler())
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_UPDATE_ATTACK)
e1:SetValue(700)
e1:SetReset(RESET_EVENT+0x1fe0000)
tc:RegisterEffect(e1)
local e2=e1:Clone()
e2:SetCode(EFFECT_UPDATE_DEFENSE)
tc:RegisterEffect(e2)
end
end
