--Parameters:
-- c: the card that will receive the effect
-- extrainfo: optional, eventual OperationInfo to be set in the target (see Nebula Neos)
-- extraop: optional, eventual operation to be performed if the card is returned to the ED (see Nebula Neos, NOT Magma Neos)
function Auxiliary.EnableNeosReturn(c,extrainfo,extraop)
	--return
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(Auxiliary.NeosReturnCondition1)
	e1:SetTarget(Auxiliary.NeosReturnTarget(c,extrainfo))
	e1:SetOperation(Auxiliary.NeosReturnOperation(c,extraop))
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(0)
	e2:SetCondition(Auxiliary.NeosReturnCondition2)
	c:RegisterEffect(e2)
end
function Auxiliary.NeosReturnCondition1(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsHasEffect(42015635)
end
function Auxiliary.NeosReturnCondition2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsHasEffect(42015635)
end
function Auxiliary.NeosReturnTarget(c,extrainfo)
	return function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return true end
		Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
		if extrainfo then extrainfo(e,tp,eg,ep,ev,re,r,rp,chk) end
	end
end
function Auxiliary.NeosReturnSubstituteFilter(c)
	return c:IsCode(101007060) and c:IsAbleToRemoveAsCost()
end
function Auxiliary.NeosReturnOperation(c,extraop)
	return function(e,tp,eg,ep,ev,re,r,rp)
		local c=e:GetHandler()
		if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
		local sc=Duel.GetFirstMatchingCard(Auxiliary.NecroValleyFilter(Auxiliary.NeosReturnSubstituteFilter),tp,LOCATION_GRAVE,0,nil)
		if sc and Duel.SelectYesNo(tp,aux.Stringid(101007060,0)) then
			Duel.Remove(sc,POS_FACEUP,REASON_COST)
		else
			Duel.SendtoDeck(c,nil,2,REASON_EFFECT)
		end
		if c:IsLocation(LOCATION_EXTRA) then
			local id=c:GetCode()
			Duel.RaiseSingleEvent(c,EVENT_CUSTOM+id,e,0,0,0,0)
			if extraop then
				extraop(e,tp,eg,ep,ev,re,r,rp)
			end
		end
	end
end
