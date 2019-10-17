--ダークワイト＠イグニスター
--Darkwight @Ignister
--Scripted by Larry126
local s,id=GetID()
function s.initial_effect(c)
	--Link Summon
	c:EnableReviveLimit()
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetDescription(1076)
	e0:SetCode(EFFECT_SPSUMMON_PROC)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetRange(LOCATION_EXTRA)
	e0:SetCondition(aux.LinkCondition(s.matfilter,1,1,nil))
	e0:SetTarget(function(e,...)
		local res = aux.LinkTarget(s.matfilter,1,1,nil)(e,...)
		if res then
			s.LinkSummon=true
			local e1=Effect.GlobalEffect()
			e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
			e1:SetCode(EVENT_ADJUST)
			e1:SetOperation(function(e) s.LinkSummon=false e:Reset() end)
			Duel.RegisterEffect(e1,0)
		end
		return res
	end)
	e0:SetOperation(Auxiliary.LinkOperation(s.matfilter,1,1,nil))
	e0:SetValue(SUMMON_TYPE_LINK)
	c:RegisterEffect(e0)
	--cannot be targeted for attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(s.tgcon)
	e1:SetValue(aux.imval1)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_DESTROYED)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,id)
	e2:SetCondition(s.damcon)
	e2:SetTarget(s.damtg)
	e2:SetOperation(s.damop)
	c:RegisterEffect(e2)
	--forced EXMZONE Link Summon
	if not s.global_check then
		s.global_check=true
		--
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD)
		ge1:SetCode(EFFECT_FORCE_MZONE)
		ge1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		ge1:SetTargetRange(1,1)
		ge1:SetValue(s.fmval)
		Duel.RegisterEffect(ge1,tp)
		local lcex=Duel.GetLocationCountFromEx
		Duel.GetLocationCountFromEx=function(...)
			local _,_,_,c=table.unpack({...})
			if c and c:IsCode(id) then
				s.LinkSummon=true
			end
			local res = lcex(...)
			s.LinkSummon=false
			return res
		end
		--
		local iscan=Card.IsCanBeSpecialSummoned
		Card.IsCanBeSpecialSummoned=function(c,e,sumtype,tp,con,limit,sump,sumptp,zone,...)
			if not sump then sump=POS_FACEUP end
			if not sumptp then sumptp=tp end
			if not zone then zone=0xff end
			if not c:IsLocation(LOCATION_EXTRA) then zone=zone&0x1f end
			if c:IsCode(id) and sumtype&SUMMON_TYPE_LINK==SUMMON_TYPE_LINK then
				zone=zone&0x60
			end
			return iscan(c,e,sumtype,tp,con,limit,sump,sumptp,zone,...)
		end
		local spstep = Duel.SpecialSummonStep
		Duel.SpecialSummonStep = function(c,sumtype,tp,sumtp,con,check,sump,zone,...)
			if not zone then zone=0xff end
			if not c:IsLocation(LOCATION_EXTRA) then zone=zone&0x1f end
			if c:IsCode(id) and sumtype&SUMMON_TYPE_LINK==SUMMON_TYPE_LINK then
				zone=zone&0x60
			end
			return spstep(c,sumtype,tp,sumtp,con,check,sump,zone,...)
		end
	end
end
function s.fmval(e)
	if s.LinkSummon and Duel.GetMasterRule()>=4 then
		return 0x60
	else
		return 0xffffffff
	end
end
function s.matfilter(c,scard,sumtype,tp)
	return c:IsType(TYPE_NORMAL,scard,sumtype,tp)
end
function s.tgcon(e)
	return e:GetHandler():IsLinkState()
end
function s.damfilter(c,p)
	return c:GetPreviousControler()~=p
end
function s.damcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(s.damfilter,1,nil,tp)
end
function s.damtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(500)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,500)
end
function s.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
