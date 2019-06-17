--斬機超階乗
--Zanki Super Factorial
--Scripted by AlphaKretin
local s,id=GetID()
function s.initial_effect(c)
	--synchro summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(s.announcecost)
	e1:SetTarget(s.syntg)
	e1:SetOperation(s.synop)
	c:RegisterEffect(e1)
	--xyz summon
	local e2=e1:Clone()
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetTarget(s.xyztg)
	e2:SetOperation(s.xyzop)
	c:RegisterEffect(e2)
end
s.listed_series={0x231}
function s.announcecost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function s.matfilter(c,e,tp)
	return c:IsSetCard(0x231) and c:IsCanBeEffectTarget(e) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function s.relfilter(c,e,tp)
	return c:IsRelateToEffect(e) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function s.synfilter(c,tun,mg)
	return c:IsSetCard(0x231) and c:IsSynchroSummonable(tun,mg)
end
function s.smatfilter(c,e,tp,exg)
	return aux.SelectUnselectGroup(mg,e,tp,2,2,s.srescon(c,exg),0)
end
function s.srescon(c,exg)
	return function(sg,e,tp,mg)
		return exg:IsExists(Card.IsSynchroSummonable,1,nil,c,sg)
	end
end
function s.syntg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	local mg=Duel.GetMatchingGroup(s.matfilter,tp,LOCATION_GRAVE,0,nil,e,tp)
	local exg=Duel.GetMatchingGroup(s.synfilter,tp,LOCATION_EXTRA,0,nil,nil,mg)
	e:SetLabelObject(exg)
	if chk==0 then return Duel.IsPlayerCanSpecialSummonCount(tp,2)
		and not Duel.IsPlayerAffectedByEffect(tp,CARD_BLUEEYES_SPIRIT)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>2
		and Duel.GetLocationCountFromEx(tp)>0
		and mg:IsExists(s.smatfilter,1,nil,e,tp,exg) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg1=mg:FilterSelect(tp,s.smatfilter,1,1,nil)
	sg1:GetFirst():RegisterFlagEffect(id,RESET_CHAIN,0,0)
	local sg2=aux.SelectUnselectGroup(mg,e,tp,2,2,s.srescon(c,exg),chk,tp,HINTMSG_SPSUMMON)
	sg1:Merge(sg2)
	Duel.SetTargetCard(sg1)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,sg1,3,0,0)
end
function s.synop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerAffectedByEffect(tp,CARD_BLUEEYES_SPIRIT) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<3 then return end
	local g=Duel.GetTargetCards(e):Filter(s.relfilter,nil,e,tp)
	if #g<3 then return end
	for tc in aux.Next(g) do
		Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		tc:RegisterEffect(e2)
	end
	Duel.SpecialSummonComplete()
	if Duel.GetLocationCountFromEx(tp,tp,g)<=0 then return end
	Duel.BreakEffect()
	local tun=g:Filter(Card.GetFlagEffect,nil,id):GetFirst()
	g:RemoveCard(tun)
	local syng=Duel.GetMatchingGroup(s.synfilter,tp,LOCATION_EXTRA,0,tun,g)
	if #syng>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local syn=syng:Select(tp,1,1,nil):GetFirst()
		Duel.SynchroSummon(tp,syn,tun,g)
	end
end
function s.xyzfilter(c,mg)
	return c:IsSetCard(0x231) and c:IsXyzSummonable(mg,3,3)
end
function s.xrescon(exg)
	return function(sg,e,tp,mg)
		return exg:IsExists(Card.IsXyzSummonable,1,nil,sg,3,3)
	end
end
function s.xyztg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	local mg=Duel.GetMatchingGroup(s.matfilter,tp,LOCATION_GRAVE,0,nil,e,tp)
	local exg=Duel.GetMatchingGroup(s.xyzfilter,tp,LOCATION_EXTRA,0,nil,mg)
	if chk==0 then return Duel.IsPlayerCanSpecialSummonCount(tp,2)
		and not Duel.IsPlayerAffectedByEffect(tp,CARD_BLUEEYES_SPIRIT)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>2
		and Duel.GetLocationCountFromEx(tp)>0
		and aux.SelectUnselectGroup(mg,e,tp,3,3,s.xrescon(exg),0) end
	local sg=aux.SelectUnselectGroup(mg,e,tp,3,3,s.xrescon(exg),chk,tp,HINTMSG_SPSUMMON)
	Duel.SetTargetCard(sg)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,sg,3,0,0)
end
function s.xyzop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerAffectedByEffect(tp,CARD_BLUEEYES_SPIRIT) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<3 then return end
	local g=Duel.GetTargetCards(e):Filter(s.relfilter,nil,e,tp)
	if #g<3 then return end
	for tc in aux.Next(g) do
		Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		tc:RegisterEffect(e2)
	end
	Duel.SpecialSummonComplete()
	if Duel.GetLocationCountFromEx(tp,tp,g)<=0 then return end
	Duel.BreakEffect()
	local xyzg=Duel.GetMatchingGroup(s.xyzfilter,tp,LOCATION_EXTRA,0,nil,g)
	if #xyzg>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local xyz=xyzg:Select(tp,1,1,nil):GetFirst()
		Duel.XyzSummon(tp,xyz,g)
	end
end