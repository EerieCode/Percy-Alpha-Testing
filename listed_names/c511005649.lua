--Cocoon of Evolution (DOR)
--scripted by GameMaster (GM)
function c511005649.initial_effect(c)
--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511005649.cost)
	e1:SetTarget(c511005649.tg)
	e1:SetOperation(c511005649.op)
	c:RegisterEffect(e1)
end
c511005649.listed_names={511005627}
c511005649.collection={ [87756343]=true; [58192742]=true; [81179446]=true; [81843628]=true; [77568553]=true; }
function c511005649.filter(c)
	return  c511005649.collection[c:GetCode()]
end
function c511005649.filter2(c,e,tp)
	return c:IsCode(511005627) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511005649.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c511005649.filter,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,c511005649.filter,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c511005649.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c511005649.filter2,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c511005649.op(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511005649.filter2,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc then
		Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP_ATTACK)
		tc:CompleteProcedure()
	end
end
