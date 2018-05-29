--Giant's Training
function c511001413.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511001413.cost)
	e1:SetTarget(c511001413.target)
	e1:SetOperation(c511001413.activate)
	c:RegisterEffect(e1)
end
c511001413.listed_names={511001412,511001414}
function c511001413.cfilter(c,tid,ft,tp)
	return c:IsFaceup() and c:IsCode(511001412) and c:GetTurnID()<tid and (ft>0 or (c:IsControler(tp) and c:GetSequence()<5)) 
		and (c:IsControler(tp) or c:IsFaceup())
end
function c511001413.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	local tid=Duel.GetTurnCount()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if chk==0 then return ft>-1 and Duel.CheckReleaseGroupCost(tp,c511001413.cfilter,1,false,nil,nil,tid,ft,tp) end
	local g=Duel.SelectReleaseGroupCost(tp,c511001413.cfilter,1,1,false,nil,nil,tid,ft,tp)
	Duel.Release(g,REASON_COST)
end
function c511001413.filter(c,e,tp)
	return c:IsCode(511001414) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c511001413.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()==0 and Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return false end
		e:SetLabel(0)
		return Duel.IsExistingMatchingCard(c511001413.filter,tp,0x13,0,1,nil,e,tp)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0x13)
end
function c511001413.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c511001413.filter),tp,0x13,0,1,1,nil,e,tp):GetFirst()
	if tc and Duel.SpecialSummon(tc,0,tp,tp,true,true,POS_FACEUP)>0 then
		tc:CompleteProcedure()
	end
end
