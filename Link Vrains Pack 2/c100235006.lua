--japanese name goes here
--Harpie Conductor
--scripted by
local s,id=GetID()
function c100235006.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunctionEx(Card.IsAttribute,ATTRIBUTE_WIND),2,2)
	c:EnableReviveLimit()
	--change name
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e0:SetCode(EFFECT_CHANGE_CODE)
	e0:SetRange(LOCATION_MZONE+LOCATION_GRAVE)
	e0:SetValue(76812113)
	c:RegisterEffect(e0)
	--destroy replace
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DESTROY_REPLACE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,100235006)
	e1:SetTarget(c100235006.reptg)
	e1:SetValue(c100235006.repval)
	e1:SetOperation(c100235006.repop)
	c:RegisterEffect(e1)
end
function c100235006.repfilter(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:IsLocation(LOCATION_ONFIELD) and c:IsSetCard(0x64)
		and (c:IsReason(REASON_BATTLE) or c:IsReason(REASON_EFFECT)) and not c:IsReason(REASON_REPLACE)
end
function c100235006.desfilter(c,e,tp)
	return c:IsControler(tp) and c:IsType(TYPE_SPELL+TYPE_TRAP)
		and c:IsDestructable(e) and not c:IsStatus(STATUS_DESTROY_CONFIRMED+STATUS_BATTLE_DESTROYED)
end
function c100235006.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c100235006.repfilter,1,nil,tp)
		and Duel.IsExistingMatchingCard(c100235006.desfilter,tp,LOCATION_ONFIELD,0,1,nil,e,tp) end
	if Duel.SelectEffectYesNo(tp,e:GetHandler(),96) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESREPLACE)
		local g=Duel.SelectMatchingCard(tp,c100235006.desfilter,tp,LOCATION_ONFIELD,0,1,1,nil,e,tp)
		e:SetLabelObject(g:GetFirst())
		g:GetFirst():SetStatus(STATUS_DESTROY_CONFIRMED,true)
		return true
	end
	return false
end
function c100235006.repval(e,c)
	return c100235006.repfilter(c,e:GetHandlerPlayer())
end
function c100235006.repop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	tc:SetStatus(STATUS_DESTROY_CONFIRMED,false)
	Duel.Destroy(tc,REASON_EFFECT+REASON_REPLACE)
end
