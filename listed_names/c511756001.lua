--壺魔人
--fixed by MLD
function c511756001.initial_effect(c)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c511756001.tg)
	e2:SetOperation(c511756001.op)
	c:RegisterEffect(e2)
end
c511756001.listed_names={50045299,50045299}
function c511756001.filter(c)
	return c:IsFaceup() and c:IsCode(50045299) and c:GetOverlayGroup():IsExists(Card.IsRace,1,nil,RACE_DRAGON)
end
function c511756001.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsExistingMatchingCard(c511756001.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
end
function c511756001.op(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVEXYZ)
	local g=Duel.SelectMatchingCard(tp,c511756001.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.HintSelection(g)
		local og=tc:GetOverlayGroup():Filter(Card.IsRace,nil,RACE_DRAGON)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
		local sc=og:Select(tp,1,1,nil):GetFirst()
		Duel.MoveToField(sc,tp,tp,LOCATION_MZONE,POS_FACEUP,true)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_IMMUNE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		e2:SetValue(c511756001.efilter)
		sc:RegisterEffect(e2)
	end
end
function c511756001.efilter(e,te)
	return te:GetHandler():IsCode(50045299)
end
