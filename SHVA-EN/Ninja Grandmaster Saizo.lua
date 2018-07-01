--Ninja Grandmaster Saizo
--scripted by Naim
--find & replace the below values when revealed
local CARD;
local CODE;
function CARD.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkSetCard,0x2b),2,2)
							--scripted as if the materials were 2 "Ninja" monsters
	c:EnableReviveLimit()
	--set from deck
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(CARD.settg)
	e1:SetOperation(CARD.setop)
	c:RegisterEffect(e1)
	--cannot be battle target
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(CARD.limtg)
	e2:SetValue(aux.imval1)
	c:RegisterEffect(e2)
	--cannot be target
	local e3=e2:Clone()
	e3:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_SET_AVAILABLE)
	e3:SetValue(1)
	c:RegisterEffect(e3)
end
function CARD.setfilter(c)
	return c:IsSetCard(0x61) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsSSetable()
end
function CARD.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(CARD.setfilter,tp,LOCATION_DECK,0,1,nil) end
end
function CARD.setop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectMatchingCard(tp,CARD.setfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SSet(tp,g)
	end
end
function c45002991.limtg(e,c)
	return e:GetHandler():GetLinkedGroup():IsContains(c)
end