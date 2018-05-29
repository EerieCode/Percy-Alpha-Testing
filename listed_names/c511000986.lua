--Chaos Bringer
function c511000986.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c511000986.condition)
	e1:SetTarget(c511000986.target)
	e1:SetOperation(c511000986.activate)
	c:RegisterEffect(e1)
	if not c511000986.global_check then
		c511000986.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511000986.archchk)
		Duel.RegisterEffect(ge2,0)
	end
end
c511000986.listed_names={111011002}
function c511000986.archchk(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(0,420)==0 then 
		Duel.CreateToken(tp,420)
		Duel.CreateToken(1-tp,420)
		Duel.RegisterFlagEffect(0,420,0,0,0)
	end
end
function c511000986.cfilter(c)
	return c:IsType(TYPE_XYZ) and c:IsC() and c:GetOverlayCount()>0
end
function c511000986.condition(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c511000986.cfilter,nil)
	return g:GetCount()==1 and ep~=tp
end
function c511000986.filter(c)
	return c:IsCode(111011002) and c:IsAbleToHand()
end
function c511000986.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000986.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c511000986.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c511000986.cfilter,nil):GetFirst()
	g:RemoveOverlayCard(tp,g:GetOverlayCount(),g:GetOverlayCount(),REASON_EFFECT)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c511000986.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_CANNOT_ATTACK)
		e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
		e1:SetTarget(aux.TargetBoolFunction(Card.IsC))
		e1:SetReset(RESET_PHASE+PHASE_END)
		e1:SetValue(1)
		Duel.RegisterEffect(e1,tp)	
	end
end
