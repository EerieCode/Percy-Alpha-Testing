--雷龍融合
--Thunder Dragon Fusion
--Scripted by AlphaKretin
local s,id=GetID()
function s.initial_effect(c)
	--Activate
	local e1=aux.CreateFusionEffect(c,s.fusfilter,aux.FALSE,nil,s.matfilter,nil,s.fusop)
	c:RegisterEffect(e1)
	if not GhostBelleTable then GhostBelleTable={} end
	table.insert(GhostBelleTable,e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,0))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,id)
	e2:SetCondition(aux.exccon)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(s.thtg)
	e2:SetOperation(s.thop)
	c:RegisterEffect(e2)
end
function s.fusfilter(c,e,tp)
	return c:IsRace(RACE_THUNDER)
end
function s.matfilter(c)
	return c:IsType(TYPE_MONSTER) and (c:IsLocation(LOCATION_GRAVE) or (c:IsLocation(LOCATION_REMOVED) and c:IsFaceup())) and c:IsAbleToDeck()
end
function s.fusop(g,e,tp)
	Duel.SendtoDeck(g,nil,2,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
end
function s.thfilter(c)
	return c:IsRace(RACE_THUNDER) and c:IsAbleToHand()
end
function s.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function s.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,s.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end