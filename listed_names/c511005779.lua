--Dark Magician GIrl (DOR)
--scripted by GameMaster(GM)
function c511005779.initial_effect(c)
--atk/def +500 # drkMgcians
local e1=Effect.CreateEffect(c)
e1:SetDescription(aux.Stringid(511005779,1))
e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
e1:SetOperation(c511005779.op)
c:RegisterEffect(e1)
end
c511005779.listed_names={46986414}
function c511005779.filter(c)
return c:IsCode(46986414)
end
function c511005779.op(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
local ct,g=Duel.GetMatchingGroupCount(c511005779.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,nil)*500
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_UPDATE_ATTACK)
e1:SetReset(RESET_EVENT+0x1fe0000)
e1:SetValue(ct)
c:RegisterEffect(e1) 
local e2=e1:Clone()
e2:SetCode(EFFECT_UPDATE_DEFENSE)
c:RegisterEffect(e2)
end
