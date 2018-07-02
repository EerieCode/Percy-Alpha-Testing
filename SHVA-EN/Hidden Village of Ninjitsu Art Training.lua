--Hidden Village of Ninjitsu Art Training
--scripted by AlphaKretin
--find replace the below values when revealed
local CARD;
local CODE;
function CARD.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,CODE)
	e2:SetCondition(CARD.thcon)
	e2:SetTarget(CARD.thtg)
	e2:SetOperation(CARD.thop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e4)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,CODE+100)
	e2:SetTarget(CARD.reptg)
	e2:SetValue(CARD.repval)
	e2:SetOperation(CARD.repop)
	c:RegisterEffect(e2)
end
function CARD.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x2b)
end
function CARD.thcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(CARD.cfilter,1,nil)
end
function CARD.thfilter(c)
	return (c:IsSetCard(0x2b) or c:IsSetCard(0x61)) and c:IsAbleToHand()
end
function CARD.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and CARD.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(CARD.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,CARD.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function CARD.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
function CARD.repfilter(c,tp)
	return c:IsFaceup() and ((c:IsSetCard(0x2b) and c:IsType(TYPE_MONSTER)) or c:IsSetCard(0x61))
		and c:IsControler(tp) and c:IsReason(REASON_EFFECT+REASON_BATTLE) and not c:IsReason(REASON_REPLACE)
end
function CARD.rmfilter(c)
	return c:IsAbleToRemove() and (c:IsSetCard(0x2b) or c:IsSetCard(0x61)) and aux.SpElimFilter(c,true)
end
function CARD.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,91646304)==0 and eg:IsExists(c91646304.repfilter,1,nil,tp) and Duel.IsExistingMatchingCard(CARD.rmfilter,tp,LOCATION_GRAVE,0,1,nil) end
	if Duel.SelectEffectYesNo(tp,e:GetHandler(),96) then
		Duel.RegisterFlagEffect(tp,91646304,RESET_PHASE+PHASE_END,0,1)
		return true
	else
		return false
	end
end
function CARD.repval(e,c)
	return CARD.repfilter(c,e:GetHandlerPlayer())
end
function CARD.repop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.SelectMatchingCard(tp,CARD.rmfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_EFFECT)
end