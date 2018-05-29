--ＷＲＵＭ－ホープ・フォース
function c511000685.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511000685.target)
	e1:SetOperation(c511000685.activate)
	c:RegisterEffect(e1)
end
c511000685.listed_names={84013237}
function c511000685.filter1(c,e,tp)
	local rk=c:GetRank()
	return c:IsFaceup() and c:IsCode(84013237) and c:GetOverlayGroup():GetCount()>=2 and (rk>0 or c:IsStatus(STATUS_NO_LEVEL)) 
		and Duel.GetLocationCountFromEx(tp,tp,c)>1
		and Duel.IsExistingMatchingCard(c511000685.filter2,tp,LOCATION_EXTRA,0,2,nil,rk,e,tp,c)
end
function c511000685.filter2(c,rk,e,tp,mc)
	if c.rum_limit and not c.rum_limit(mc,e) then return false end
	return c:IsType(TYPE_XYZ) and (c:IsRank(rk+1) or c:IsRank(rk+2)) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false)
end
function c511000685.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c511000685.filter1(chkc,e,tp) end
	local ect=c29724053 and Duel.IsPlayerAffectedByEffect(tp,29724053) and c29724053[tp]
	if chk==0 then
		local pg=aux.GetMustBeMaterialGroup(tp,Group.CreateGroup(),tp,nil,nil,REASON_XYZ)
		return pg:GetCount()<=0 and not Duel.IsPlayerAffectedByEffect(tp,59822133) and (not ect or ect>=2)
			and Duel.IsExistingTarget(c511000685.filter1,tp,LOCATION_MZONE,0,1,nil,e,tp)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c511000685.filter1,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_EXTRA)
end
function c511000685.activate(e,tp,eg,ep,ev,re,r,rp)
	local pg=aux.GetMustBeMaterialGroup(tp,Group.CreateGroup(),tp,nil,nil,REASON_XYZ)
	if pg:GetCount()>0 or Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	local ect=c29724053 and Duel.IsPlayerAffectedByEffect(tp,29724053) and c29724053[tp]
	if ect~=nil and ect<2 then return end
	local tc=Duel.GetFirstTarget()
	if not tc or tc:IsFacedown() or not tc:IsRelateToEffect(e) or tc:IsControler(1-tp) or tc:IsImmuneToEffect(e) 
		or Duel.GetLocationCountFromEx(tp,tp,tc)<=1 then return end
	local ov=tc:GetOverlayGroup()
	if ov:GetCount()<2 then return end
	local g=Duel.GetMatchingGroup(c511000685.filter2,tp,LOCATION_EXTRA,0,nil,tc:GetRank(),e,tp,tc)
	if g:GetCount()>=2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,2,2,nil)
		local ct=Duel.SpecialSummon(sg,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
		local spc=sg:GetFirst()
		while spc do
			spc:CompleteProcedure()
			spc=sg:GetNext()
		end
		if ct>1 then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
			local ovg=ov:Select(tp,2,2,nil)
			Duel.SendtoGrave(ovg,REASON_EFFECT)
			for i=1,2 do
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
				local ovsg=ovg:Select(tp,1,1,nil)
				local osg=sg:Select(tp,1,1,nil)
				Duel.HintSelection(osg)
				Duel.Overlay(osg:GetFirst(),ovsg)
				ovg:Sub(ovsg)
				sg:Sub(osg)
			end
		end
	end
end
