--灼熱の火霊使いヒータ
--Hiita the Scorching Fire Charmer
--Scripted by ahtelel
function c101007056.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,nil,2,2,c101007056.lcheck)
	c:EnableReviveLimit()
	--add setcode
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_ADD_SETCODE)
	e0:SetValue(0xc0)
	c:RegisterEffect(e0)
	--sp summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(101007056,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,101007056)
	e1:SetTarget(c101007056.sptg)
	e1:SetOperation(c101007056.spop)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_DESTROYED)
	e1:SetCountLimit(1,101007156)
	e2:SetCondition(c101007056.thcon)
	e2:SetTarget(c101007056.thtg)
	e2:SetOperation(c101007056.thop)
	c:RegisterEffect(e2)
end
function c101007056.lcheck(g,lc)
	return g:IsExists(Card.IsAttribute,1,nil,ATTRIBUTE_FIRE)
end
function c101007056.spfilter(c,e,tp,zone)
	if zone==0 then zone=0xff end
	return c:IsAttribute(ATTRIBUTE_FIRE) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP,tp,zone)
end
function c101007056.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	local lg=c:GetLinkedGroup()
	local zone=c:GetFreeLinkedZone()&0x1f
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(1-tp) and c101007056.spfilter(chkc,e,tp,zone) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c101007056.spfilter,tp,0,LOCATION_GRAVE,1,1,nil,e,tp,c:GetFreeLinkedZone()&0x1f)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,tp,LOCATION_GRAVE)
end
function c101007056.spop(e,tp,eg,ep,ev,re,r,rp)
	local zone=e:GetHandler():GetFreeLinkedZone()&0x1f
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and zone~=0 then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP,zone)
	end
end
function c101007056.thcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_BATTLE+REASON_EFFECT) and c:GetReasonPlayer()~=tp and c:IsSummonType(SUMMON_TYPE_LINK)
end
function c101007056.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c101007056.thfilter(c)
	return c:IsDefenseBelow(1500) and c:IsType(TYPE_MONSTER) and c:IsAttribute(ATTRIBUTE_FIRE) and c:IsAbleToHand()
end
function c101007056.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c101007056.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
