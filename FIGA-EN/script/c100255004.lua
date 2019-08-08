--Start-up Order - Gear Force
--Scripted by Hel
local s,id=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(s.condition)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
function s.condition(e,tp,eg,ep,ev,re,r,rp)
	local fc=Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)
	return tp~=Duel.GetTurnPlayer() and fc>0 and Duel.GetMatchingGroupCount(aux.FilterFaceupFunction(Card.IsRace,RACE_MACHINE),tp,LOCATION_MZONE,0,nil)==fc
end
function s.filter(c)
	return c:IsAttackPos()
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.filter,tp,0,LOCATION_MZONE,1,nil) end
	local ct=Duel.GetMatchingGroupCount(aux.FilterFaceupFunction(Card.IsRace,RACE_MACHINE),tp,LOCATION_MZONE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,ct,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if g:GetCount()>0 then
		Duel.Destroy(g,REASON_EFFECT)
	end
end
