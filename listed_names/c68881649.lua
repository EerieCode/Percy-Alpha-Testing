--憑依装着－エリア
function c68881649.initial_effect(c)
	--spsummon proc
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND+LOCATION_DECK)
	e1:SetCondition(c68881649.spcon)
	e1:SetOperation(c68881649.spop)
	c:RegisterEffect(e1)
end
c68881649.listed_names={74364659,74364659}
function c68881649.spfilter1(c,tp)
	return c:IsFaceup() and c:IsCode(74364659) and c:IsAbleToGraveAsCost()
end
function c68881649.spfilter2(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WATER) and c:IsAbleToGraveAsCost()
end
function c68881649.rescon(sg,e,tp,mg)
	return aux.ChkfMMZ(1)(sg,e,tp,mg) and sg:IsExists(c68881649.chk,1,nil,sg)
end
function c68881649.chk(c,sg)
	return c:IsCode(74364659) and sg:IsExists(Card.IsAttribute,1,c,ATTRIBUTE_WATER)
end
function c68881649.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local g1=Duel.GetMatchingGroup(c68881649.spfilter1,tp,LOCATION_MZONE,0,nil)
	local g2=Duel.GetMatchingGroup(c68881649.spfilter2,tp,LOCATION_MZONE,0,nil)
	local g=g1:Clone()
	g:Merge(g2)
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-2 and g1:GetCount()>0 and g2:GetCount()>0 
		and aux.SelectUnselectGroup(g,e,tp,2,2,c68881649.rescon,0)
end
function c68881649.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g1=Duel.GetMatchingGroup(c68881649.spfilter1,tp,LOCATION_MZONE,0,nil)
	local g2=Duel.GetMatchingGroup(c68881649.spfilter2,tp,LOCATION_MZONE,0,nil)
	g1:Merge(g2)
	local sg=aux.SelectUnselectGroup(g1,e,tp,2,2,c68881649.rescon,1,tp,HINTMSG_TOGRAVE)
	Duel.SendtoGrave(sg,REASON_COST)
	Duel.ShuffleDeck(tp)
	--pierce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_PIERCE)
	e1:SetReset(RESET_EVENT+0xff0000)
	c:RegisterEffect(e1)
end
