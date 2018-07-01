--Ride of the Valkyries
--scripted by Naim
--find replace the below values when revealed
--scripted parts 1, 2 and 3, missing 4
local CARD;
local CODE;
local SET_VALKYRIE;
function CARD.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	--e1:SetCountLimit(1,14517422+EFFECT_COUNT_CODE_OATH)		--if it is once per turn or something
	e1:SetTarget(CARD.sptg)
	e1:SetOperation(CARD.spop)
	c:RegisterEffect(e1)
		--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(CODE,1))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	--e2:SetCondition(aux.exccon)		--except the turn this card was sent to the Graveyard
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(CARD.thtg)
	e2:SetOperation(CARD.thop)
	c:RegisterEffect(e2)
end
function CARD.filter(c,e,tp)
	return c:IsSetCard(SET_VALKYRIE) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function CARD.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(CARD.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function CARD.spop(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 then return end
	local c=e:GetHandler()
	if ft>5 then ft=5 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,CARD.filter,tp,LOCATION_HAND,0,1,ft,nil,e,tp)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
			while tc do
			Duel.SpecialSummonStep(tc,0,tp,tp,false,false)
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e2:SetCode(EVENT_PHASE+PHASE_END)
			e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
			e2:SetRange(LOCATION_MZONE)
			e2:SetCountLimit(1)
			e2:SetCondition(CARD.tdcon)
			e2:SetOperation(CARD.tdop)
			e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e2,true)
			tc=g:GetNext()
			end
		Duel.SpecialSummonComplete()
	end
end
function CARD.tdcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function CARD.tdop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoDeck(e:GetHandler(),nil,2,REASON_EFFECT)
end
function CARD.thfilter(c)
	return c:IsCode(MISCHIEF_CODE_HERE) and c:IsAbleToHand()
end
function CARD.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(CARD.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function CARD.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,CARD.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
