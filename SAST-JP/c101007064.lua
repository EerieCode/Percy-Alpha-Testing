--不知火流 伝承の陣
--Shiranui Style Succession
--scripted by Naim
function c101007064.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--cannot disable summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(101007064,0))
	e2:SetCode(EFFECT_CANNOT_DISABLE_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCountLimit(1,101007064)
	e2:SetCost(c101007064.ndisabcost)
	e2:SetTarget(c101007064.ndisabtg)
	e2:SetOperation(c101007064.ndisabop)
	c:RegisterEffect(e2)
	--banish and send
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(101007064,1))
	e3:SetCategory(CATEGORY_REMOVE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1,101007064)
	e3:SetTarget(c101007064.rmvtg)
	e3:SetOperation(c101007064.rmvop)
	c:RegisterEffect(e3)
end
function c101007064.rmvfilter1(c)
	return c:IsRace(RACE_ZOMBIE) and c:IsAbleToRemoveAsCost()
end
function c101007064.ndisabcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c101007064.rmvfilter1,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c101007064.rmvfilter1,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c101007064.ndisabtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
end
function c101007064.ndisabop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_DISABLE_SUMMON)
	e1:SetProperty(EFFECT_FLAG_IGNORE_RANGE+EFFECT_FLAG_SET_AVAILABLE)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_ZOMBIE))
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_DISABLE_SPSUMMON)
	Duel.RegisterEffect(e2,tp)
end
function c101007064.rmvfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_ZOMBIE) and c:IsAbleToRemove()
end
function c101007064.tgfilter(c,e,tp)
	return c:IsRace(RACE_ZOMBIE) and c:IsDefenseBelow(0) 
end
function c101007064.rmvtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c101007064.rmvfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c101007064.rmvfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c101007064.rmvfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c101007064.rmvop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsControler(tp) and tc:IsRelateToEffect(e) and Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)~=0 then
		if Duel.IsExistingMatchingCard(c101007064.tgfilter,tp,LOCATION_DECK,0,1,nil,e,tp) and Duel.SelectYesNo(tp,aux.Stringid(101007064,2)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local g=Duel.SelectMatchingCard(tp,c101007064.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
		if g:GetCount()>0 then
			Duel.SendtoGrave(g,REASON_EFFECT)
		end
	end
	end
end