--超雷龍ーサンダー•ドラゴン
--Super Thunder Dragon - Thunder Dragon
--Scripted by AlphaKretin
function c101006036.initial_effect(c)
	--fusion summon
	c:EnableReviveLimit()
	aux.AddFusionProcMixRep(c,true,true,aux.FilterBoolFunctionEx(Card.IsRACE,RACE_THUNDER),1,1,31786629)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.fuslimit)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCondition(c101006036.hspcon)
	e2:SetOperation(c101006036.hspop)
	c:RegisterEffect(e2)
	--disable search
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_TO_HAND)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_DECK,LOCATION_DECK)
	c:RegisterEffect(e3)
	--destroy replace
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EFFECT_DESTROY_REPLACE)
	e4:SetTarget(c101006036.desreptg)
	e4:SetOperation(c101006036.desrepop)
	c:RegisterEffect(e4)
	if not c101006036.global_check then
		c101006036.global_check=true
		c101006036[0]=true
		c101006036[1]=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_CHAIN_SOLVED)
		ge1:SetOperation(c101006036.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c101006036.clear)
		Duel.RegisterEffect(ge2,0)
	end
end
function c101006036.hspfilter(c,tp,sc)
	return c:IsRace(RACE_THUNDER) and Duel.GetLocationCountFromEx(tp,tp,sc,c)>0 and c101006036[tp]
end
function c101006036.hspcon(e,c)
	if c==nil then return true end
	return Duel.CheckReleaseGroup(c:GetControler(),c101006036.hspfilter,1,nil,c:GetControler(),c)
end
function c101006036.hspop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.SelectReleaseGroup(tp,c101006036.hspfilter,1,1,nil,tp,c)
	Duel.Release(g,REASON_COST)
end
function c101006036.checkop(e,tp,eg,ep,ev,re,r,rp)
	if re:GetActiveType()==TYPE_MONSTER and re:GetActivateLocation()==LOCATION_HAND then
		c101006036[rp]=true
	end
end
function c101006036.clear(e,tp,eg,ep,ev,re,r,rp)
	c101006036[0]=false
	c101006036[1]=false
end
function c101006036.desreptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tg=c:GetEquipTarget()
	if chk==0 then return not c:IsStatus(STATUS_DESTROY_CONFIRMED)
		and tg and tg:IsReason(REASON_BATTLE+REASON_EFFECT)
		and Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,LOCATION_GRAVE,0,1,nil)
	return Duel.SelectEffectYesNo(tp,c,96)
end
function c101006036.desrepop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local tc=Duel.SelectMatchingCard(tp,Card.IsAbleToRemove,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
end