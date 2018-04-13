--星遺物の醒存
--World Legacy Survival
--Scripted by AlphaKretin
function c101005060.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,101005060+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c101005060.target)
	e1:SetOperation(c101005060.activate)
	c:RegisterEffect(e1)
end
function c101005060.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,5) end
end
function c101005060.filter(c)
	return c:IsAbleToHand() and (c:IsType(TYPE_MONSTER) and c:IsSetCard(0x104)) or c:IsSetCard(0xfe)
end
function c101005060.operation(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsPlayerCanDiscardDeck(tp,5) then return end
	Duel.ConfirmDecktop(tp,5)
	local g=Duel.GetDecktopGroup(tp,5)
	if g:GetCount()>0 then
		Duel.DisableShuffleCheck()
		if g:IsExists(c101005060.filter,1,nil) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local sg=g:FilterSelect(tp,c101005060.filter,1,1,nil)
			Duel.SendtoHand(sg,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,sg)
			Duel.ShuffleHand(tp)
			g:Sub(sg)
			Duel.SendtoGrave(g,REASON_EFFECT+REASON_REVEAL)
		else
			Duel.SendtoDeck(g,nil,2,REASON_EFFECT+REASON_REVEAL) 
		end
	end
end