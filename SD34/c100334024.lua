--サイバネット・コーデック
--Cynet Codec
--Scripted by Eerie Code
function c100334024.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_CUSTOM+100334024)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTarget(c100334024.thtg)
	e2:SetOperation(c100334024.thop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetRange(LOCATION_SZONE)
	e3:SetLabelObject(e2)
	e3:SetCondition(c100334024.regcon)
	e3:SetOperation(c100334024.regop)
	c:RegisterEffect(e3)
	--register attributes
	if not c100334024.global_flag then
		c100334024.global_flag=true
		c100334024.attr_list={}
		c100334024.attr_list[0]=0
		c100334024.attr_list[1]=0
		c100334024.summon_group={}
		c100334024.summon_group[0]=nil
		c100334024.summon_group[1]=nil
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_PHASE+PHASE_END)
		ge1:SetOperation(c100334024.resetop)
		Duel.RegisterEffect(ge1,0)
	end
end
function c100334024.resetop(e,tp,eg,ep,ev,re,r,rp)
	c100334024.attr_list[0]=0
	c100334024.attr_list[1]=0
end
function c100334024.regfilter(c,e,tp)
	local attr=c:GetAttribute()
	return c:IsSetCard(0x101) and c:IsControler(tp) 
		and c:IsLocation(LOCATION_MZONE) and c:IsPreviousLocation(LOCATION_EXTRA)
		and c100334024.attr_list[tp]&attr==0
		and c:IsCanBeEffectTarget(e)		
		and Duel.IsExistingMatchingCard(c100334024.thfilter,tp,LOCATION_DECK,0,1,nil,attr)
end
function c100334024.thfilter(c,attr)
	return c:IsRace(RACE_CYBERSE) and c:IsAttribute(attr) and c:IsAbleToHand()
end
function c100334024.regcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.CheckChainUniqueness() and eg:IsExists(c100334024.regfilter,1,nil,e:GetLabelObject(),tp)
end
function c100334024.filter(c)
	return c:IsFaceup() and c:IsCode(100334024) and not c:IsDisabled()
end
function c100334024.regop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(tp,100334024)==0 and Duel.SelectYesNo(tp,aux.Stringid(100334024,0)) then
		Duel.RegisterFlagEffect(tp,100334024,RESET_CHAIN,0,1)
		Debug.Message("Effect to be activated.")
		local g=Duel.GetMatchingGroup(c100334024.filter,tp,LOCATION_SZONE,0,nil)
		local c=nil
		Debug.Message("Checking other Cynet Codecs.")
		if #g==1 then
			c=g:GetFirst()
			Debug.Message("No other Cynet Codecs.")
		else
			Debug.Message("Other Cynet Codecs on field, must choose.")
			c=g:Select(tp,1,1,nil):GetFirst()
		end
		local sg=eg:Filter(c100334024.regfilter,nil,e:GetLabelObject(),tp)
		Debug.Message("#sg="..#sg)
		sg:KeepAlive()
		c100334024.summon_group[tp]=sg
		if c100334024.summon_group[tp] then Debug.Message("#var="..c100334024.summon_group[tp]:GetCount()) else Debug.Message("Global variable not set.") end
		Duel.RaiseSingleEvent(c,EVENT_CUSTOM+100334024,re,r,rp,0,0)
	end
end
function c100334024.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local g=c100334024.summon_group[tp]
	if chkc then return g:IsContains(chkc) and c100334024.regfilter(chkc,e,tp) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local sg=g:FilterSelect(tp,c100334024.regfilter,1,1,nil,e,tp)
	Duel.SetTargetCard(sg)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c100334024.thop(e,tp,eg,ep,ev,re,r,rp)
	c100334024.summon_group[tp]=nil
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not c:IsRelateToEffect(e) then return end
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,c100334024.thfilter,tp,LOCATION_DECK,0,1,1,nil,tc:GetAttribute())
		if #g>0 then
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
			c100334024.attr_list[tp]=c100334024.attr_list[tp]|tc:GetAttribute()
		end
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c100334024.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c100334024.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsRace(RACE_CYBERSE) and c:IsLocation(LOCATION_EXTRA)
end
