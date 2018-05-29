--チェンジ！ ジェット・アイアン号
function c100000220.initial_effect(c)
	--Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCost(c100000220.cost)
	e1:SetTarget(c100000220.target)
	e1:SetOperation(c100000220.operation)
	c:RegisterEffect(e1)
end
c100000220.listed_names={15574615}
function c100000220.spcheck(sg,tp)
	return aux.ReleaseCheckMMZ(sg,tp) and sg:IsExists(c100000220.chk,1,nil,sg,Group.CreateGroup(),80208158,16796157,43791861,79185500)
end
function c100000220.chk(c,sg,g,code,...)
	if not c:IsCode(code) then return false end
	local res
	if ... then
		g:AddCard(c)
		res=sg:IsExists(c100000220.chk,1,g,sg,g,...)
		g:RemoveCard(c)
	else
		res=true
	end
	return res
end
function c100000220.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return Duel.CheckReleaseGroupCost(tp,Card.IsCode,4,nil,c100000220.spcheck,nil,80208158,16796157,43791861,79185500) end
	local sg=Duel.SelectReleaseGroupCost(tp,Card.IsCode,4,4,nil,c100000220.spcheck,nil,80208158,16796157,43791861,79185500)
	Duel.Release(sg,REASON_COST)
end
function c100000220.filter(c,e,tp)
	return c:IsCode(15574615) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c100000220.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()==0 and Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return false end
		e:SetLabel(0)
		return Duel.IsExistingMatchingCard(c100000220.filter,tp,0x13,0,1,nil,e,tp)
	end
	e:SetLabel(0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0x13)
end
function c100000220.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c100000220.filter),tp,0x13,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,true,POS_FACEUP)
	end
end
