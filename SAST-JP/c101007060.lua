--ネオス・フュージョン
--Neos Fusion
--Scripted by Eerie Code
function c101007060.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c101007060.target)
	e1:SetOperation(c101007060.activate)
	c:RegisterEffect(e1)
	if not AshBlossomTable then AshBlossomTable={} end
	table.insert(AshBlossomTable,e1)
end
c101007060.listed_names={CARD_NEOS}
function c101007060.filter0(c)
	return c:IsType(TYPE_MONSTER) and c:IsCanBeFusionMaterial() and c:IsAbleToGrave()
end
function c101007060.filter1(c,e)
	return not c:IsImmuneToEffect(e)
end
function c101007060.filter2(c,e,tp,m,chkf)
	return aux.IsMaterialListCode(c,CARD_NEOS)
		and c:IsCanBeSpecialSummoned(e,0,tp,true,false) and c:CheckFusionMaterial(m,nil,chkf+65536)
end
function c101007060.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local chkf=tp
		Auxiliary.FCheckExact=2
		local mg1=Duel.GetFusionMaterial(tp)
		local mg2=Duel.GetMatchingGroup(c101007060.filter0,tp,LOCATION_DECK,0,nil)
		mg1:Merge(mg2)
		local res=Duel.IsExistingMatchingCard(c101007060.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg1,chkf)
		Auxiliary.FCheckExact=nil
		return res
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c101007060.activate(e,tp,eg,ep,ev,re,r,rp)
	local mg1=Duel.GetFusionMaterial(tp):Filter(c101007060.filter1,nil,e)
	local mg2=Duel.GetMatchingGroup(c101007060.filter0,tp,LOCATION_DECK,0,nil)
	mg1:Merge(mg2)
	Auxiliary.FCheckExact=2
	local sg1=Duel.GetMatchingGroup(c101007060.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg1,nil)
	if #sg1>0 then
		local sg=sg1:Clone()
		if sg2 then sg:Merge(sg2) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tg=sg:Select(tp,1,1,nil)
		local tc=tg:GetFirst()
		local mat1=Duel.SelectFusionMaterial(tp,tc,mg1,nil,tp)
		tc:SetMaterial(mat1)
		Duel.SendtoGrave(mat1,REASON_EFFECT)
		Duel.BreakEffect()
		Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)
		tc:CompleteProcedure()
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	Auxiliary.FCheckExact=nil
end
