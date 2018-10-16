--大天使ゼラート
--Archlord Zerato
function c18378582.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c18378582.spcon)
	e2:SetOperation(c18378582.spop)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(18378582,0))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCost(c18378582.descost)
	e3:SetTarget(c18378582.destg)
	e3:SetOperation(c18378582.desop)
	c:RegisterEffect(e3)
end
c18378582.listed_names={CARD_SANCTUARY_SKY,66073051}
function c18378582.rfilter(c,ft)
	return c:IsFaceup() and c:IsCode(66073051) and (ft>0 or c:GetSequence()<5)
end
function c18378582.envfilter(c)
	return c:IsFaceup() and c:IsCode(CARD_SANCTUARY_SKY)
end
function c18378582.spcon(e,c)
	if c==nil then return Duel.IsExistingMatchingCard(c18378582.envfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) or Duel.IsEnvironment(CARD_SANCTUARY_SKY) end
	local tp=c:GetControler()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	return ft>-1 and Duel.CheckReleaseGroup(tp,c18378582.rfilter,1,nil,ft)
end
function c18378582.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.SelectReleaseGroup(tp,c18378582.rfilter,1,1,nil,Duel.GetLocationCount(tp,LOCATION_MZONE))
	Duel.Release(g,REASON_COST)
end
function c18378582.cfilter(c)
	return c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsDiscardable() and c:IsAbleToGraveAsCost()
end
function c18378582.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c18378582.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c18378582.cfilter,1,1,REASON_COST+REASON_DISCARD)
end
function c18378582.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,#g,0,0)
end
function c18378582.desop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsExistingMatchingCard(c18378582.envfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) or Duel.IsEnvironment(CARD_SANCTUARY_SKY) then
		local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
		Duel.Destroy(g,REASON_EFFECT)
	end
end
