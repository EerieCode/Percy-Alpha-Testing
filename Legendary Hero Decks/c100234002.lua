--[[Phantom Knight of Rusty Bardiche
During your Main Phase: you can send 1 "The Phantom Knights" card from your Deck to the GY
then set 1 "Phantom Knights" Spell/Trap card from your Deck to the Spell & Trap Zone.
If a DARK Xyz Monster is Special Summoned to a zone(s) this card points to,
while this monster is on the field except during the Damage Step:
You can target 1 card on the field; destroy it.
You can only use each effect of "The Phantom Knights of Rusty Bardiche" once per turn.
Cannot be used to Link Summon.--]]
function c100234001.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunctionEx(Card.IsAttribute,ATTRIBUTE_DARK),2)
	c:EnableReviveLimit()
	--to grave
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,100234002)
	e1:SetTarget(c100234002.tgtg)
	e1:SetOperation(c100234002.tgop)
	c:RegisterEffect(e1)	
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetDescription(aux.Stringid(100234102,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,100234102+100)
	e2:SetCondition(c100234002.descon)
	e2:SetTarget(c100234002.destg)
	e2:SetOperation(c100234002.desop)
	c:RegisterEffect(e2)
	--cannot link material
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetCode(EFFECT_CANNOT_BE_LINK_MATERIAL)
	e3:SetValue(1)
	c:RegisterEffect(e3)
end

function c100234002.tgfilter(c)
	return  c:IsSetCard(0x10d9) and c c:IsAbleToGrave()
	and Duel.IsExistingMatchingCard(c100234002.setfilter,tp,LOCATION_DECK,0,1,nil)
end
function c100234002.setfilter(c)
	return c:IsSetCard(0xd9)  and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsSSetable()
end
function c100234002.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100234002.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c100234002.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c100234002.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		if Duel.SendtoGrave(g,REASON_EFFECT)~=0 and Duel.IsExistingMatchingCard(c100234002.setfilter,tp,LOCATION_DECK,0,1,nil) then
		local g=Duel.SelectMatchingCard(tp,c100234002.setfilter,tp,LOCATION_DECK,0,1,1,nil)
		local tc=g:GetFirst()
			if tc then
			Duel.SSet(tp,tc)
			Duel.ConfirmCards(1-tp,tc)
			end
		end
	end
end
function c100234002.descfilter(c,lg)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsAttribute(ATTRIBUTE_DARK) and lg:IsContains(c)
end
function c100234002.descon(e,tp,eg,ep,ev,re,r,rp)
	local lg=e:GetHandler():GetLinkedGroup()
	return eg:IsExists(c100234002.descfilter,1,nil,lg)
end
function c100234002.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c100234002.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
