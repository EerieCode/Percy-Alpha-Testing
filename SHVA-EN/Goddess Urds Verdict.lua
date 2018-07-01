--Goddess Urd's Verdict
--scripted by AlphaKretin
--find replace the below values when revealed
local CARD;
local CODE;
local SET_VALKYRIE;
function CARD.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--remove
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(CODE,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTarget(CARD.rmtg)
	e2:SetOperation(CARD.rmop)
	c:RegisterEffect(e2)
	--indes
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e3:SetTarget(CARD.indtg)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetRange(LOCATION_SZONE)
	e3:SetValue(aux.indoval)
	c:RegisterEffect(e1)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e4:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e4:SetValue(aux.tgoval)
	c:RegisterEffect(e4)
end
function CARD.rmfilter(c)
	return c:IsFacedown() and c:IsAbleToRemove()
end
function CARD.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:GetControler()~=tp and chkc:IsLocation(LOCATION_ONFIELD) and CARD.rmfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(CARD.rmfilter,tp,0,LOCATION_ONFIELD,1,nil) end
	local g=Duel.SelectTarget(tp,CARD.rmfilter,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CODE)
	local ac=Duel.AnnounceCard(tp)
	Duel.SetTargetParam(ac)
	Duel.SetOperationInfo(0,CATEGORY_ANNOUNCE,nil,0,tp,ANNOUNCE_CARD)
end
function CARD.rmop(e,tp,eg,ep,ev,re,r,rp)
	local ac=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc and tc:IsRelateToEffect(e) and tc:IsCode(ac) then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end
function CARD.indtg(e,c)
	return c:IsFaceup() and c:IsSetCard(SET_VALKYRIE)
end