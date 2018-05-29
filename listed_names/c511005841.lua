--Flame Ghost (DOR)
--scripted by GameMaster (GM)
function c511005841.initial_effect(c)	
--destroy all monsters if umi is faceup on field
local e1=Effect.CreateEffect(c)
e1:SetCategory(CATEGORY_DESTROY)
e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
e1:SetTarget(c511005841.target)
e1:SetCondition(c511005841.condition)
e1:SetOperation(c511005841.operation)
c:RegisterEffect(e1)
end
c511005841.listed_names={22702055}
function c511005841.target(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return true end
local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c511005841.operation(e,tp,eg,ep,ev,re,r,rp)
local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
Duel.Destroy(g,REASON_EFFECT)
end
function c511005841.cfilter(c)
return c:IsFaceup() and c:IsCode(22702055)
end
function c511005841.condition(e,tp,eg,ep,ev,re,r,rp)
return Duel.IsExistingMatchingCard(c511005841.cfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) 
end
