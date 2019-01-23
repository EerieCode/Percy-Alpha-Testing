--Additional params: code of the mosnter to be banished, location from where it must be banished
function Auxiliary.AddMaleficSummonProc(c,code,loc)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(Auxiliary.MaleficSummonCondition(code,loc))
	e1:SetOperation(Auxiliary.MaleficSummonOperation(code,loc))
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCode(EFFECT_SPSUMMON_CONDITION)
	e2:SetValue(aux.FALSE)
	c:RegisterEffect(e2)
end
function Auxiliary.MaleficSummonFilter(c,cd)
	return c:IsCode(cd) and c:IsAbleToRemoveAsCost()
end
function Auxiliary.MaleficSummonSubstitute(c,cd)
	return c:IsHasEffect(100236115) and c:IsAbleToRemoveAsCost()
end
function Auxiliary.MaleficSummonCondition(cd,loc)
	return 	function(e,c)
				if c==nil then return true end
				return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
					and (Duel.IsExistingMatchingCard(Auxiliary.MaleficSummonFilter,c:GetControler(),loc,0,1,nil,cd)
					or Duel.IsExistingMatchingCard(Auxiliary.MaleficSummonSubstitute,c:GetControler(),LOCATION_ONFIELD+LOCATION_GRAVE,0,1,nil))
			end
end
function Auxiliary.MaleficSummonOperation(cd,loc)
	return	function(e,tp,eg,ep,ev,re,r,rp,c)
				local g=Duel.GetMatchingGroup(Auxiliary.MaleficSummonFilter,tp,loc,0,nil,cd)
				g:Merge(Duel.GetMatchingGroup(Auxiliary.MaleficSummonSubstitute,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,nil)
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
				local tc=g:Select(tp,1,1,nil):GetFirst()
				Duel.Remove(tc,POS_FACEUP,REASON_COST)
			end
end
