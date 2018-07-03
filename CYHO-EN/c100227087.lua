--Danger! Zone
--Scripted by AlphaKretin
function c100227087.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW+CATEGORY_HANDES)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c100227087.target)
	e1:SetOperation(c100227087.activate)
	c:RegisterEffect(e1)
end
function c100227087.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,3) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(3)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,3)
end
function c100227087.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	if Duel.Draw(p,d,REASON_EFFECT)==3 then
		Duel.ShuffleHand(p)
		Duel.BreakEffect()
		if Duel.IsExistingMatchingCard(Card.IsSetCard,p,LOCATION_HAND,0,1,nil,0x223) then
			Duel.DiscardHand(p,nil,2,2,REASON_EFFECT+REASON_DISCARD)
		else
			local sg=Duel.GetFieldGroup(p,LOCATION_HAND,0)
			Duel.ConfirmCards(1-p,sg)
			Duel.SendtoDeck(sg,nil,2,REASON_EFFECT)
		end
	end
end