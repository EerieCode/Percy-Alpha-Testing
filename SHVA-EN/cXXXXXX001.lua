--Valkyrie Dritte
--scripted by AlphaKretin
--find replace the below values when revealed
local CARD;
local CODE;
local SET_VALKYRIE;
function CARD.initial_effect(c)
	--tohand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(CODE,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,CODE)
	e1:SetTarget(CARD.thtg)
	e1:SetOperation(CARD.thop)
	c:RegisterEffect(e1)
	local e3=e1:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	--atk/def
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_UPDATE_ATTACK)
	e4:SetValue(CARD.atkvalue)
	c:RegisterEffect(e4)
end
function CARD.thfilter(c)
	return c:IsSetCard(SET_VALKYRIE) and c:IsAbleToHand() and not c:IsCode(CODE)
end
function CARD.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(CARD.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function CARD.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,CARD.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if #g>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function CARD.rmfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER)
end
function CARD.atkvalue(e,c)
	return Duel.GetMatchingGroupCount(CARD.rmfilter,c:GetControler(),0,LOCATION_REMOVED,nil)*200
end