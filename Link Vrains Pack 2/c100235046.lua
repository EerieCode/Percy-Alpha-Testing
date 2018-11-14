--Great General of the Six Samurai
--Logical Nonsense

--Substitute ID
local s,id=GetID()

function s.initial_effect(c)
	c:EnableCounterPermit(0x3)
	--Add a card that can place a "Bushido" counter, optional trigger effect
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,id)
	e1:SetCost(s.thcost)
	e1:SetCondition(s.thcon)
	e1:SetTarget(s.thtg)
	e1:SetOperation(s.thop)
	c:RegisterEffect(e1)
	--Add counter if Six Samurai normal summoned to a zone, continuous effect
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(s.concon)
	e2:SetOperation(s.conop)
	c:RegisterEffect(e2)
	--Same as above, but if special summoned
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	--ATK gain for each "Bushido Counter" on your side of the field, continuous effect
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_UPDATE_ATTACK)
	e4:SetValue(s.atkval)
	c:RegisterEffect(e4)
end
	--If it was link summoned
function s.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_LINK)
end
	--Find a card that can place a "Bushido Counter"
function c94599451.thfilter(c,tp)
	return c:IsCanAddCounter(0x3,1,false,LOCATION_MZONE) and c:IsAbleToHand()
end
	--Discarding as a cost
function s.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil)
		and s.cost(e,tp,eg,ep,ev,re,r,rp,0) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
	s.cost(e,tp,eg,ep,ev,re,r,rp,1)
end
	--Activation legality
function s.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
	--Performing the effect of adding a "Bushido Counter" placing card to hand
function s.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,s.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
	--Check if "Six Samurai" was summoned to a zone this card points to
function s.cfilter(c,ec)
	if c:IsLocation(LOCATION_MZONE) then
		return c:IsSetCard(0x3d) and c:IsFaceup() and ec:GetLinkedGroup():IsContains(c)
	else
		return c:IsPreviousSetCard(0x3d) and c:IsPreviousPosition(POS_FACEUP)
			and bit.extract(ec:GetLinkedZone(c:GetPreviousControler()),c:GetPreviousSequence())~=0
	end
end
	--If it ever happened
function s.concon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(s.cfilter,1,nil,e:GetHandler())
end
	--Add "Bushido Counter" onto the card
function s.conop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():AddCounter(0x3,1)
end
	--Count the number of "Bushido Counter"
function s.atkfilter(e)
	return Duel.GetCounter(e:GetHandlerPlayer(),1,0,0x3)
end
	--Update ATK by the amount of "Bushido Counters" * 100
function s.atkval(e,c)
	return Duel.GetMatchingGroupCount(s.atkfilter,0,LOCATION_MZONE,0,nil)*100
end