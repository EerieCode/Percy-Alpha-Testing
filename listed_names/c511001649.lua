--Dyna Base
function c511001649.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511001649,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c511001649.spcost)
	e1:SetTarget(c511001649.sptg)
	e1:SetOperation(c511001649.spop)
	c:RegisterEffect(e1)
end
c511001649.listed_names={511001648}
function c511001649.cfilter(c)
	return c:IsRace(RACE_DINOSAUR) and c:IsReleasable()
end
function c511001649.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() 
		and Duel.IsExistingMatchingCard(c511001649.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=Duel.SelectMatchingCard(tp,c511001649.cfilter,tp,LOCATION_HAND,0,1,1,nil)
	local tc=g:GetFirst()
	g:AddCard(e:GetHandler())
	Duel.Release(g,REASON_COST)
	e:SetLabelObject(tc)
end
function c511001649.filter(c,e,tp)
	return c:IsCode(511001648) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) and c:CheckFusionMaterial()
end
function c511001649.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCountFromEx(tp,tp,e:GetHandler())>0 
		and Duel.IsExistingMatchingCard(c511001649.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetTargetCard(e:GetLabelObject())
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511001649.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCountFromEx(tp)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,c511001649.filter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp):GetFirst()
	if tc and Duel.SpecialSummon(tc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)>0 then
		tc:CompleteProcedure()
		local tc2=Duel.GetFirstTarget()
		if tc2 then
			Duel.RaiseSingleEvent(tc,511001649,e,REASON_EFFECT,tp,tp,tc2:GetTextAttack())
		end
	end
end
