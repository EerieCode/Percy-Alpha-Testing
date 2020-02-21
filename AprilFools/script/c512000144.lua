--
--I Don't Have It
--Scripted by AlphaKretin
local s,id=GetID()
function s.initial_effect(c)
	--Banish
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(1041,0))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(s.condition)
	e1:SetTarget(s.rmtg)
	e1:SetOperation(s.rmop)
	c:RegisterEffect(e1)
	--Add to hand
	local e2=e1:Clone()
	e2:SetDescription(aux.Stringid(1041,1))
	e2:SetCategory(0)
	e2:SetTarget(s.regtg)
	e2:SetOperation(s.regop)
	c:RegisterEffect(e2)
end
local LOCATION_POSSESS=LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE+LOCATION_ONFIELD+LOCATION_EXTRA+LOCATION_REMOVED
function s.condition(e,tp,eg,ep,ev,re,r,rp)
	local ex,cg,ct,cp,cv=Duel.GetOperationInfo(ev,CATEGORY_ANNOUNCE)
	return rp~=tp and ex and bit.band(cv,ANNOUNCE_CARD+ANNOUNCE_CARD_FILTER)~=0
end
function s.rmfilter(c,code)
	return c:IsCode(code) and c:IsAbleToRemove()
end
function s.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local code=Duel.GetChainInfo(ev,CHAININFO_TARGET_PARAM)
	if chk==0 then return Duel.IsExistingMatchingCard(s.rmfilter,tp,LOCATION_POSSESS,0,1,nil,code) end
	local g=Duel.GetMatchingGroup(s.rmfilter,tp,LOCATION_POSSESS,0,nil,code)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,#g,0,0)
end
function s.rmop(e,tp,eg,ep,ev,re,r,rp)
	local code=Duel.GetChainInfo(ev,CHAININFO_TARGET_PARAM)
	local g=Duel.GetMatchingGroup(s.rmfilter,tp,LOCATION_POSSESS,0,nil,code)
	if #g>0 then
		Duel.Remove(g,POS_FACEDOWN,REASON_EFFECT)
		local og=Duel.GetOperatedGroup()
		for tc in aux.Next(og) do
			tc:RegisterFlagEffect(id,RESET_EVENT+RESETS_STANDARD,0,0)
		end
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_CHAIN_END)
		e1:SetOperation(s.thop)
		Duel.RegisterEffect(e1,tp)
	end
end
function s.thfilter(c)
	return c:GetFlagEffect(id)~=0
end
function s.thop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(s.thfilter,tp,LOCATION_REMOVED,0,nil)
	if #g>0 then
		Duel.SendtoHand(g,tp,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
		for tc in aux.Next(g) do
			tc:ResetFlagEffect(id)
		end
	end
	e:Reset()
end
function s.regtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local code=Duel.GetChainInfo(ev,CHAININFO_TARGET_PARAM)
	if chk==0 then return not Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_POSSESS,0,1,nil,code) end
end
function s.regop(e,tp,eg,ep,ev,re,r,rp)
	local code=Duel.GetChainInfo(ev,CHAININFO_TARGET_PARAM)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAIN_END)
	e1:SetOperation(s.thop2)
	e1:SetLabel(code)
	Duel.RegisterEffect(e1,tp)
end
function s.thop2(e,tp,eg,ep,ev,re,r,rp)
	local code=e:GetLabel()
	local tc=Duel.CreateToken(tp,code)
	Duel.SendtoHand(tc,tp,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,tc)
	e:Reset()
end