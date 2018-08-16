--Extra Fusion
local s,id=GetID()
function s.initial_effect(c)
	--FS Dragon
	local e1=aux.CreateFusionEffect(c,aux.FilterBoolFunction(Card.IsRace,RACE_DRAGON),aux.FilterBoolFunction(Card.IsOnField))
	e1:SetDescription(aux.Stringid(id,0))
	c:RegisterEffect(e1)
	--FS Thunder
	local e2=aux.CreateFusionEffect(c,aux.FilterBoolFunction(Card.IsRace,RACE_THUNDER),aux.FilterBoolFunction(Card.IsLocation,LOCATION_HAND),nil,s.dkfilter)
	e2:SetDescription(aux.Stringid(id,1))
	c:RegisterEffect(e2)
	--FS Spellcaster
	local e3=aux.CreateFusionEffect(c,aux.FilterBoolFunction(Card.IsRace,RACE_SPELLCASTER),aux.FALSE,nil,s.gyfilter,nil,s.gyop)
	e3:SetDescription(aux.Stringid(id,2))
	c:RegisterEffect(e3)
	--FS Warrior
	local e4=aux.CreateFusionEffect(c,aux.FilterBoolFunction(Card.IsRace,RACE_WARRIOR),aux.FilterBoolFunction(Card.IsLocation,LOCATION_HAND),s.oppcon,s.oppfilter,nil,s.oppop)
	e4:SetDescription(aux.Stringid(id,3))
	c:RegisterEffect(e4)
end
function s.dkfilter(c,tp)
	return c:IsControler(tp) and c:IsType(TYPE_MONSTER) and c:IsLocation(LOCATION_DECK)
end
function s.gyfilter(c,tp)
	return c:IsControler(tp) and c:IsType(TYPE_MONSTER) and c:IsLocation(LOCATION_GRAVE) and c:IsAbleToDeck()
end
function s.gyop(g,e,tp)
	Duel.SendtoDeck(g,nil,2,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
end
function s.oppcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(Card.IsFacedown,tp,LOCATION_SZONE,0,1,e:GetHandler())
end
function s.oppfilter(c,tp)
	return c:IsControler(1-tp) and c:IsType(TYPE_MONSTER) and c:IsLocation(LOCATION_GRAVE) and c:IsAbleToRemove()
end
function s.oppop(g,e,tp)
	local rg=g:Filter(Card.IsControler,nil,1-tp)
	local gg=g:Filter(aux.TRUE,rg)
	Duel.Remove(rg,POS_FACEUP,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
	Duel.SendtoGrave(gg,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
end
