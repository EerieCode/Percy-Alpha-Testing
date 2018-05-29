--Dogking
function c511000038.initial_effect(c)
	aux.AddEquipProcedure(c)
	--Increase ATK
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(c511000038.value)
	c:RegisterEffect(e2)
	--Search Deck
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(511000038,0))
	e4:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_TO_GRAVE)
	e4:SetProperty(EFFECT_FLAG_DELAY)
	e4:SetTarget(c511000038.stg)
	e4:SetOperation(c511000038.sop)
	c:RegisterEffect(e4)
end
c511000038.listed_names={100000540}
function c511000038.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_BEAST)
end
function c511000038.value(e,c)
	return Duel.GetMatchingGroupCount(c511000038.filter,e:GetHandlerPlayer(),LOCATION_MZONE,0,nil)*500
end
function c511000038.sfilter(c)
	return c:IsCode(100000540) and c:IsAbleToHand()
end
function c511000038.stg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000038.sfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c511000038.sop(e,tp,eg,ep,ev,re,r,rp,chk)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c511000038.sfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
