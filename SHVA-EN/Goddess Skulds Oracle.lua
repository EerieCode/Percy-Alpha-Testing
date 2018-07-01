--Goddess Skuld's Oracle
--scripted by AlphaKretin
--find replace the below values when revealed
local CARD;
local CODE;
local CARD_VERDANDE_GUIDANCE;
function CARD.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(CODE,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTarget(CARD.thtg)
	e2:SetOperation(CARD.thop)
	c:RegisterEffect(e2)
	--sort
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(CODE,1))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetCountLimit(1)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTarget(CARD.sttg)
	e3:SetOperation(CARD.stop)
	c:RegisterEffect(e3)
end
function CARD.thfilter(c)
	return c:IsCode(CARD_VERDANDE_GUIDANCE) and c:IsAbleToHand()
end
function CARD.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(CARD.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function CARD.thop(e,tp,eg,ep,ev,re,r,rp,chk)
	local tg=Duel.GetFirstMatchingCard(CARD.thfilter,tp,LOCATION_DECK,0,nil)
	if tg then
		Duel.SendtoHand(tg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tg)
	end
end
function CARD.sttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)>2 end
end
function CARD.stop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SortDecktop(tp,1-tp,3)
end
