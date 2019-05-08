--デュエリスト・キングダム
--Duelist Kingdom
--Scripted by AlphaKretin
local s,id=GetID()
function s.initial_effect(c)
	aux.EnableExtraRule(c,s)
	if not s.global_check then
	s.global_check = true
	--no direct
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	Duel.RegisterEffect(e1,0)
	--summon face-up defense
	local EFFECT_LIGHT_INTERVENTION=EFFECT_DEVINE_LIGHT
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_LIGHT_INTERVENTION)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,1)
	Duel.RegisterEffect(e2,0)
	--summon any level
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,0))
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_SUMMON_PROC)
	e3:SetTargetRange(LOCATION_HAND,LOCATION_HAND)
	e3:SetCondition(s.ntcon)
	Duel.RegisterEffect(e3,0)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_SET_PROC)
	Duel.RegisterEffect(e4,0)
	--burn for destroy
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EVENT_DESTROYED)
	e5:SetOperation(s.damop)
	Duel.RegisterEffect(e5,0)
	end
end
function s.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function s.damfilter(c,p)
	return c:IsPreviousControler(p) and c:IsReason(REASON_EFFECT)
end
function s.damop(e,tp,eg,ep,ev,re,r,rp)
	for p=0,1 do
		local pg=eg:Filter(s.damfilter,nil,p)
		if #pg>0 then
			local sum=pg:GetSum(Card.GetPreviousAttackOnField)//2
			if sum>0 then
				Duel.Damage(p,sum,REASON_EFFECT)
			end
		end
	end
end
