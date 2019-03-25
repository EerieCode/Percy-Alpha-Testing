--Card Destruction (DN)
--手札抹殺
function c512000122.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_HANDES+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c512000122.target)
	e1:SetOperation(c512000122.activate)
	c:RegisterEffect(e1)
	if not c512000122.global_check then
		c512000122.global_check=true
		c512000122[0]=0
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_CHAINING)
		ge1:SetOperation(c512000122.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c512000122.clear)
		Duel.RegisterEffect(ge2,0)
	end
end
function c512000122.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local h1=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
		if e:GetHandler():IsLocation(LOCATION_HAND) then h1=h1-1 end
		if c512000122[0]==0 then h1=h1+2 end
		local h2=Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)
		return (h1+h2>0) and (Duel.IsPlayerCanDraw(tp,h1) or h1==0) and (Duel.IsPlayerCanDraw(1-tp) or h2==0)
	end
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,PLAYER_ALL,1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,PLAYER_ALL,1)
end
function c512000122.activate(e,tp,eg,ep,ev,re,r,rp)
	local h1=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	local h2=Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,LOCATION_HAND)
	Duel.SendtoGrave(g,REASON_EFFECT+REASON_DISCARD)
	Duel.BreakEffect()
	if c512000122[0]==1 then h1=h1+2 end
	Duel.Draw(tp,h1,REASON_EFFECT)
	Duel.Draw(1-tp,h2,REASON_EFFECT)
end
function c512000122.checkop(e,tp,eg,ep,ev,re,r,rp)
	if re:GetHandler():IsCode(72892473) then
		c512000122[0]=c512000122[0]+1
	end
end
function c512000122.clear(e,tp,eg,ep,ev,re,r,rp)
	c512000122[0]=0
end