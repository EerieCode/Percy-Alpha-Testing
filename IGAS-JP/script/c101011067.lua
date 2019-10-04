--ライトニング・ストーム
--Raigeki Storm
--scripted by Hatter
local s,id=GetID()
function s.initial_effect(c)
	--rec or dam
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(s.condition)
	e1:SetTarget(s.target)
	e1:SetOperation(s.operation)
	c:RegisterEffect(e1)
end
function s.condition(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(Card.IsFaceup,tp,LOCATION_ONFIELD,0,1,nil)
end
function s.filter1(e,tp,eg,ep,ev,re,r,rp)
	return c:IsAttackPos()
end
function s.filter2(e,tp,eg,ep,ev,re,r,rp)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local g1=Duel.GetMatchingGroup(s.filter1,tp,0,LOCATION_MZONE,nil)
	local g2=Duel.GetMatchingGroup(s.filter2,tp,0,LOCATION_ONFIELD,c)
	if chk==0 then return #g1>0 or #g2>0 end
	if #g1>0 and not #g2>0 then
		e:SetLabel(0) 
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,g1,#g1,0,0)
	elseif #g2>0 and not #g1>0 then
		e:SetLabel(1)
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,g2,#g2,0,0)
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EFFECT)
		local op=Duel.SelectOption(tp,aux.Stringid(id,0),aux.Stringid(id,1))
		e:SetLabel(op)
		if op==0 then
			Duel.SetOperationInfo(0,CATEGORY_DESTROY,g1,#g1,0,0)
		else
			Duel.SetOperationInfo(0,CATEGORY_DESTROY,g2,#g2,0,0)
		end
	end
end
function s.operation(e,tp,eg,ep,ev,re,r,rp)
	local g
	if e:GetLabel()==0 then
		g=Duel.GetMatchingGroup(s.filter1,tp,0,LOCATION_MZONE,nil)
	else 
		g=Duel.GetMatchingGroup(s.filter2,tp,0,LOCATION_ONFIELD,aux.ExceptThisCard(e)) 
	end
	if #g>0 then
		Duel.Destroy(g,REASON_EFFECT)
	end
end