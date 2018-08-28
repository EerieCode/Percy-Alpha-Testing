--マズルフラッシュ・ドラゴン
--Flash Charge Dragon
--scripted by Larry126
function c95372220.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(95372220)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(1,0)
	e1:SetValue(c95372220.filter)
	c:RegisterEffect(e1)

	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_ADJUST)
	e2:SetRange(LOCATION_MZONE)
	e2:SetOperation(c95372220.spcon)
	c:RegisterEffect(e2)
	local locCount=Duel.GetLocationCount
	Duel.GetLocationCount=function(tp,loc,p,r,zone)
		if not p then p=tp end
		if not r then r=LOCATION_REASON_TOFIELD end
		local freeZone=Duel.GetFreeZone(tp,loc,p)
		if zone then freeZone=freeZone&zone end
		return locCount(tp,loc,p,r,freeZone)
	end
	local spchk=Card.IsCanBeSpecialSummoned
	Card.IsCanBeSpecialSummoned=function(c,e,tpe,tp,con,conr,sump,smp,zone)
		if not sump then sump=POS_FACEUP end
		if not smp then smp=tp end
		if not zone then zone=0xff end
		local freeZone=Duel.GetFreeZone(tp,LOCATION_MZONE,smp)
		return spchk(c,e,tpe,tp,con,conr,sump,smp,freeZone&zone)
	end
	local sp=Duel.SpecialSummon
	Duel.SpecialSummon=function(g,tpe,sump,tp,check,limit,pos,zone)
		if not pos then pos=POS_FACEUP end
		if not zone then zone=0xff end
		local freeZone=Duel.GetFreeZone(tp,LOCATION_MZONE,sump)
		local tc=g
		if userdatatype(g)=="Group" then tc=g:GetFirst() end
		return sp(g,tpe,sump,tp,check,limit,pos,freeZone&zone)
	end
	local spst=Duel.SpecialSummonStep
	Duel.SpecialSummonStep=function(tc,tpe,sump,tp,check,limit,pos,zone)
		if not pos then pos=POS_FACEUP end
		if not zone then zone=0xff end
		local freeZone=Duel.GetFreeZone(tp,LOCATION_MZONE,sump)
		return spst(tc,tpe,sump,tp,check,limit,pos,freeZone&zone)
	end
	local rtf=Duel.ReturnToField
	Duel.ReturnToField=function(c,pos,zone,tp)
		if not pos then pos=c:GetPreviousPosition() end
		if not zone then zone=0xff end
		if not tp then tp=c:GetPreviousControler() end
		local freeZone=Duel.GetFreeZone(tp,c:GetPreviousLocation(),tp)
		return rtf(c,pos,freeZone&zone)
	end
end
function c95372220.filter(e,c)
	return c:GetLinkedZone()
end
function c95372220.spcon(e,tp,eg,ep,ev,re,r,rp)
	Debug.Message(Duel.GetMasterRule())
--  local zone=Duel.SelectFieldZone(tp,1,LOCATION_SZONE,0,0,true)
--  Debug.Message(zone>>8)
--  Debug.Message("Own zone")
--  Debug.Message(Duel.GetFreeZone(tp,LOCATION_MZONE,tp))
--  Debug.Message(Duel.GetLocationCount(tp,LOCATION_MZONE))
--  Debug.Message("Oppo's zone")
--  Debug.Message(Duel.GetFreeZone(1-tp,LOCATION_MZONE,tp))
--  Debug.Message(Duel.GetLocationCount(1-tp,LOCATION_MZONE,tp))
end
--target player, location, using player, whether check special mzone or szone
function Duel.GetFreeZone(tp,loc,p,exchk)
	if loc~=LOCATION_MZONE and loc~=LOCATION_SZONE then return 0 end
	if not p then p=tp end
	local zone=0
	local forbid=0
	local stshift=0
	if loc==LOCATION_SZONE then stshift=4 end
	local effs={Duel.GetPlayerEffect(p,95372220)}
	for _,eff in ipairs(effs) do
		local val=type(eff:GetValue())=='function' and eff:GetValue()(eff,eff:GetHandler()) or eff:GetValue()
		if eff:GetHandlerPlayer()==p and tp~=p then
			forbid=val>>(16+stshift)&0x1ff
		else
			forbid=val>>stshift&0x1ff
		end
	end
	local upper=not exchk and 4 or loc==LOCATION_MZONE and 6 or Duel.GetMasterRule()==3 and 7 or 5
	for i=0,upper do
		if Duel.CheckLocation(tp,loc,i) then
			zone=zone|2^i
		end
	end
	return zone&~forbid
end