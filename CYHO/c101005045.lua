--Mekkknight Bright Star 
function c101005045.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,nil,2,2,c101005045.lcheck)
	c:EnableReviveLimit()
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(24484270,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,24484270)
	e1:SetCost(c101005045.thcost)
	e1:SetCondition(c101005045.thcon)
	e1:SetTarget(c101005045.thtg)
	e1:SetOperation(c101005045.thop)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x10c))
	e2:SetValue(c101005045.indval)
	c:RegisterEffect(e2)
	local e4=e2:Clone()
	e4:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	c:RegisterEffect(e4)
end
function c101005045.lcheck(g,lc)
	return g:IsExists(Card.IsLinkSetCard,1,nil,0x10c)
end

function c101005045.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_LINK)
end
function c101005045.cfilter(c)
	return (c:IsSetCard(0x10c) or c:IsSetCard(0xfe)) and c:IsDiscardable()
end
function c101005045.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c101005045.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c101005045.cfilter,1,1,REASON_DISCARD+REASON_COST)
end
function c101005045.thfilter(c)
	return c:IsSetCard(0xfe) and c:IsAbleToHand()
end
function c101005045.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c101005045.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c101005045.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c101005045.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c101005045.indtg(e,c)
	e::SetLabelObject(c)
	return c:IsSetCard(0x10c)
end
function c101005045.indval(e,c)
	return not c:GetColumnGroup():IsContains(e:GetLabelObject())
end