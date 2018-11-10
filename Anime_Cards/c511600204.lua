--クロック・リザード
--Clock Lizard
--scripted by Larry126
local s,id,alias=GetID()
function s.initial_effect(c)
	alias=c:GetOriginalCodeRule()
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunctionEx(Card.IsRace,RACE_CYBERSE),2,2)
	c:EnableReviveLimit()
	--fusion summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(alias,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON+CATEGORY_TODECK)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(s.spcost)
	e1:SetTarget(s.sptg)
	e1:SetOperation(s.spop)
	c:RegisterEffect(e1)
	--atk down
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(alias,1))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetRange(LOCATION_REMOVED)
	e2:SetCondition(s.atkcon)
	e2:SetTarget(s.atktg)
	e2:SetOperation(s.atkop)
	c:RegisterEffect(e2)
	if not ClockLizardSubstitute then
		ClockLizardSubstitute = {}
		ClockLizardSubstituteGroup = Group.CreateGroup()
		ClockLizardSubstituteGroup:KeepAlive()
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge1:SetCountLimit(1)
		ge1:SetCode(EVENT_ADJUST)
		ge1:SetOperation(s.subop)
		Duel.RegisterEffect(ge1,0)
	end
	local isexist=Duel.IsExistingMatchingCard
		Duel.IsExistingMatchingCard=function(f,tp,int_s,int_o,count,ex,...)
		local arg={...}
		if arg~=nil then
			return isexist(f,tp,int_s,int_o,count,ex and ClockLizardSubstituteGroup+ex or ClockLizardSubstituteGroup,table.unpack(arg))
		else
			return isexist(f,tp,int_s,int_o,count,ex and ClockLizardSubstituteGroup+ex or ClockLizardSubstituteGroup)
		end
	end
	local isexisttg=Duel.IsExistingTarget
		Duel.IsExistingTarget=function(f,tp,int_s,int_o,count,ex,...)
		local arg={...}
		if arg~=nil then
			return isexisttg(f,tp,int_s,int_o,count,ex and ClockLizardSubstituteGroup+ex or ClockLizardSubstituteGroup,table.unpack(arg))
		else
			return isexisttg(f,tp,int_s,int_o,count,ex and ClockLizardSubstituteGroup+ex or ClockLizardSubstituteGroup)
		end
	end
	local getmatchg=Duel.GetMatchingGroup
		Duel.GetMatchingGroup=function(f,tp,int_s,int_o,ex,...)
		local arg={...}
		if arg~=nil then
			return getmatchg(f,tp,int_s,int_o,ex and ClockLizardSubstituteGroup+ex or ClockLizardSubstituteGroup,table.unpack(arg))
		else
			return getmatchg(f,tp,int_s,int_o,ex and ClockLizardSubstituteGroup+ex or ClockLizardSubstituteGroup)
		end
	end
	local getfg=Duel.GetFieldGroup
		Duel.GetFieldGroup=function(tp,int_s,int_o)
		return getfg(tp,int_s,int_o)-ClockLizardSubstituteGroup
	end
	local getfgc=Duel.GetFieldGroupCount
		Duel.GetFieldGroupCount=function(tp,int_s,int_o)
		return #Duel.GetFieldGroup(tp,int_s,int_o)
	end
	local getmatchgc=Duel.GetMatchingGroupCount
		Duel.GetMatchingGroupCount=function(f,tp,int_s,int_o,ex,...)
		local arg={...}
		return #Duel.GetMatchingGroup(f,tp,int_s,int_o,ex,arg)
	end
	local getfmatch=Duel.GetFirstMatchingCard
		Duel.GetFirstMatchingCard=function(f,tp,int_s,int_o,ex,...)
		local arg={...}
		return Duel.GetMatchingGroup(f,tp,int_s,int_o,ex,arg):GetFirst()
	end
	local selmatchc=Duel.SelectMatchingCard
		Duel.SelectMatchingCard=function(sp,f,tp,int_s,int_o,min,max,ex, ...)
		local arg={...}
		if arg~=nil then
			return selmatchc(sp,f,tp,int_s,int_o,min,max,ex and ClockLizardSubstituteGroup+ex or ClockLizardSubstituteGroup,table.unpack(arg))
		else
			return selmatchc(sp,f,tp,int_s,int_o,min,max,ex and ClockLizardSubstituteGroup+ex or ClockLizardSubstituteGroup)
		end
	end
	local gettgc=Duel.GetTargetCount
		Duel.GetTargetCount=function(f,tp,int_s,int_o,ex,...)
		local arg={...}
		return #Duel.GetTarget(f,tp,int_s,int_o,ex and ClockLizardSubstituteGroup+ex or ClockLizardSubstituteGroup,arg)
	end
	local seltg=Duel.SelectTarget
		Duel.SelectTarget=function(sp,f,tp,int_s,int_o,min,max,ex, ...)
		local arg={...}
		if arg~=nil then
			local sel=selmatchc(sp,f,tp,int_s,int_o,min,max,ex and ClockLizardSubstituteGroup+ex or ClockLizardSubstituteGroup,table.unpack(arg))
			Duel.SetTargetCard(sel)
			return sel
		else
			local sel=selmatchc(sp,f,tp,int_s,int_o,min,max,ex and ClockLizardSubstituteGroup+ex or ClockLizardSubstituteGroup)
			Duel.SetTargetCard(sel)
			return sel
		end
	end
end
function s.subop(e,tp,eg,ep,ev,re,r,rp,chk)
	for i=0,1 do
		local sub=Duel.CreateToken(i,511610204)
		ClockLizardSubstitute[i] = sub
		ClockLizardSubstituteGroup:AddCard(sub)
		Duel.SendtoDeck(sub,nil,1,REASON_RULE)
	end
end
function s.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function s.mfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsCanBeFusionMaterial() and c:IsAbleToRemove() and aux.SpElimFilter(c)
end
function s.tdfilter(c,e,tp,mg,f,mgc,mf)
	if not c:IsType(TYPE_FUSION) or not c:IsAbleToExtra()
		or not (c:CheckFusionMaterial(mg,nil,tp) and (not f or f(c))
		or c:CheckFusionMaterial(mgc,nil,tp) and (not mf or mf(c))) then return false end
	local fc=ClockLizardSubstitute[tp]
	if Duel.GetLocationCountFromEx(tp,tp,e:GetHandler(),fc)<=0 then return false end
	fc:AssumeProperty(ASSUME_CODE,c:GetOriginalCodeRule())
	fc:AssumeProperty(ASSUME_TYPE,c:GetOriginalType())
	fc:AssumeProperty(ASSUME_LEVEL,c:GetOriginalLevel())
	fc:AssumeProperty(ASSUME_RACE,c:GetOriginalRace())
	fc:AssumeProperty(ASSUME_ATTRIBUTE,c:GetOriginalAttribute())
	fc:AssumeProperty(ASSUME_ATTACK,c:GetTextAttack())
	fc:AssumeProperty(ASSUME_DEFENSE,c:GetTextDefense())
	local fceffs={}
	local sum=false
	for _,eff in ipairs({c:GetCardEffect(EFFECT_SPSUMMON_CONDITION)}) do
		local e=eff:Clone()
		fc:RegisterEffect(e,true)
		table.insert(fceffs,e)
	end
	if fc:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) then sum=true end
	for _,eff in ipairs(fceffs) do
		eff:Reset()
	end
	return sum
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local mg=Duel.GetMatchingGroup(s.mfilter,tp,LOCATION_GRAVE+LOCATION_ONFIELD,0,nil)
	local ce=Duel.GetChainMaterial(tp)
	local mgc=Group.CreateGroup()
	local mf=nil
	if ce~=nil then
		mgc=ce:GetTarget()(ce,e,tp)
		mf=ce:GetValue()
	end
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and s.tdfilter(chkc,e,tp,mg,nil,mgc,mf) end
	if chk==0 then return Duel.IsExistingTarget(s.tdfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp,mg,nil,mgc,mf) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,s.tdfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,mg,nil,mgc,mf)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,tp,LOCATION_GRAVE)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
	Duel.SetOperationInfo(0,CATEGORY_FUSION_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local mg=Duel.GetMatchingGroup(s.mfilter,tp,LOCATION_GRAVE+LOCATION_ONFIELD,0,nil)
	local ce=Duel.GetChainMaterial(tp)
	local mgc=Group.CreateGroup()
	local mf=nil
	if ce~=nil then
		mgc=ce:GetTarget()(ce,e,tp)
		mf=ce:GetValue()
	end
	if tc:IsRelateToEffect(e) and s.tdfilter(tc,e,tp,mg,nil,mgc,mf) and Duel.SendtoDeck(tc,nil,0,REASON_EFFECT)~=0 then
		local nf=tc:CheckFusionMaterial(mg,nil,tp) and (not f or f(tc))
		local cef=tc:CheckFusionMaterial(mgc,nil,tp) and (not mf or mf(tc))
		if tc:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false)
			and (nf or cef) then
			Duel.BreakEffect()
			if nf and (not cef or not Duel.SelectYesNo(tp,ce:GetDescription())) then
				local mat1=Duel.SelectFusionMaterial(tp,tc,mg,nil,tp)
				tc:SetMaterial(mat1)
				Duel.Remove(mat1,POS_FACEUP,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
				Duel.BreakEffect()
				Duel.SpecialSummon(tc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
			else
				local mat2=Duel.SelectFusionMaterial(tp,tc,mgc,nil,tp)
				local fop=ce:GetOperation()
				fop(ce,e,tp,tc,mat2)
			end
			tc:CompleteProcedure()
		end
	end
end
function s.filter(c,p)
	return c:IsControler(p) and c:IsFaceup()
end
function s.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetTurnID()==Duel.GetTurnCount()
end
function s.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(s.filter,1,nil,1-tp) end
	local g=eg:Filter(s.filter,nil,1-tp)
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_ATKCHANGE,g,#g,1-tp,-Duel.GetMatchingGroupCount(Card.IsRace,e:GetOwnerPlayer(),LOCATION_GRAVE,0,nil,RACE_CYBERSE)*400)
end
function s.atkop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	for tc in aux.Next(g) do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(s.val)
		e1:SetReset(RESET_PHASE+PHASE_END+RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
end
function s.val(e,c)
	return Duel.GetMatchingGroupCount(Card.IsRace,e:GetOwnerPlayer(),LOCATION_GRAVE,0,nil,RACE_CYBERSE)*-400
end
