--力の代行者 マーズ
--The Agent of Force - Mars
function c91123920.initial_effect(c)
	--immune spell
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c91123920.efilter)
	c:RegisterEffect(e1)
	--update atk,def
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c91123920.val)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e3)
end
c91123920.listed_names={CARD_SANCTUARY_SKY}
function c91123920.efilter(e,te)
	return te:IsActiveType(TYPE_SPELL)
end
function c91123920.envfilter(c)
	return c:IsFaceup() and c:IsCode(CARD_SANCTUARY_SKY)
end
function c91123920.val(e,c)
	local tp=c:GetControler()
	if not (Duel.IsExistingMatchingCard(c91123920.envfilter,e:GetHandlerPlayer(),LOCATION_ONFIELD,0,1,nil) or Duel.IsEnvironment(CARD_SANCTUARY_SKY,tp)) then return 0 end
	local v=Duel.GetLP(tp)-Duel.GetLP(1-tp)
	if v>0 then return v else return 0 end
end
