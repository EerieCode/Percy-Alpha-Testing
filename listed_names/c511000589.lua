--Coingnoma the Sibyl
function c511000589.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000589,0))
	e1:SetCategory(CATEGORY_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetTarget(c511000589.target)
	e1:SetOperation(c511000589.operation)
	c:RegisterEffect(e1)
end
c511000589.listed_names={32231618}
function c511000589.filter(c,tp)
	if not c:IsLevelBelow(4) or not c:IsType(TYPE_FLIP) or (c:IsCode(32231618) and c:IsLocation(LOCATION_GRAVE)) 
		or not c:IsSummonableCard() or c:IsStatus(STATUS_FORBIDDEN) then return false end
	local eff={Duel.GetPlayerEffect(tp,EFFECT_CANNOT_MSET)}
	for _,te in ipairs(eff) do
		local tg=te:GetTarget()
		if type(tg)=='function' then
			if tg(te,c,tp,SUMMON_TYPE_NORMAL) then return false end
		else return false end
	end
	return true
end
function c511000589.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511000589.filter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,nil,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SUMMON,nil,1,0,0)
end
function c511000589.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
	local tc=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c511000589.filter),tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,tp):GetFirst()
	if tc then
		Duel.MoveToField(tc,tp,tp,LOCATION_MZONE,POS_FACEDOWN_DEFENSE,true)
		tc:SetStatus(STATUS_SUMMON_TURN,true)
		Duel.RaiseEvent(tc,EVENT_MSET,e,REASON_EFFECT,tp,tp,0)
	end
end
