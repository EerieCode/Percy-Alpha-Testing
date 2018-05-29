--Geira Guile the Cubic King (movie)
function c511004441.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1)
	e1:SetTarget(c511004441.target)
	e1:SetOperation(c511004441.operation)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetTarget(c511004441.target0)
	e2:SetOperation(c511004441.operation0)
	c:RegisterEffect(e2)
	--atk update
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_SET_BASE_ATTACK)
	e3:SetValue(function (e) return 800*e:GetHandler():GetOverlayGroup():FilterCount(Card.IsType,nil,TYPE_MONSTER) end)
	c:RegisterEffect(e3)
	--add effect
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_BATTLED)
	e4:SetTarget(c511004441.target1)
	e4:SetOperation(c511004441.operation1)
	c:RegisterEffect(e4)
	if not c511004441.global_check then
		c511004441.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511004441.archchk)
		Duel.RegisterEffect(ge2,0)
	end
end
c511004441.listed_names={77387463}
function c511004441.archchk(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(0,420)==0 then 
		Duel.CreateToken(tp,420)
		Duel.CreateToken(1-tp,420)
		Duel.RegisterFlagEffect(0,420,0,0,0)
	end
end
function c511004441.filter(c,sc)
	return c:IsType(TYPE_MONSTER) and c:IsCubicSeed() and c:IsFaceup()
end
function c511004441.target(e,tp,eg,ev,ep,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511004441.filter,tp,LOCATION_MZONE,0,1,nil,e:GetHandler()) and e:GetHandler():IsCanBeSpecialSummoned(e,SUMMON_TYPE_SPECIAL,tp,true,false) end
	local tg=Duel.SelectMatchingCard(tp,c511004441.filter,tp,LOCATION_MZONE,0,1,1,nil,e:GetHandler())
	Duel.SetTargetCard(tg)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c511004441.operation(e,tp,eg,ev,ep,re,r,rp)
	local c=e:GetHandler()
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_SPECIAL,tp,true,false) and tg and tg:GetCount()>0 then
		local mg=tg:Clone()
		local tc=tg:GetFirst()
		while tc do
			if tc:GetOverlayCount()~=0 then Duel.SendtoGrave(tc:GetOverlayGroup(),REASON_RULE) end
			tc=tg:GetNext()
		end
		c:SetMaterial(mg)
		Duel.Overlay(c,mg)
		Duel.SpecialSummon(c,SUMMON_TYPE_SPECIAL,tp,tp,true,false,POS_FACEUP)
	end
end
function c511004441.target0(e,tp,eg,ev,ep,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,0,0,1-tp,800)
end
function c511004441.operation0(e,tp,eg,ev,ep,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.Damage(1-tp,800,REASON_EFFECT)
	end
end
function c511004441.filter1(c)
	return c:IsAbleToHand() and c:IsCode(77387463)
end
function c511004441.target1(e,tp,eg,ev,ep,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToDeck() and Duel.IsExistingMatchingCard(c511004441.filter1,tp,LOCATION_DECK,0,1,nil) end
	local tg=Duel.SelectTarget(tp,c511004441.filter1,tp,LOCATION_DECK,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,tg:AddCard(c),2,0,0)
end
function c511004441.spfilter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_SPECIAL,tp,true,false) and c:IsType(TYPE_MONSTER) and c:IsCubicSeed()
end
function c511004441.operation1(e,tp,eg,ev,ep,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local c=e:GetHandler()
	local mg=c:GetOverlayGroup()
	if tc and tc:IsRelateToEffect(e) and Duel.SendtoDeck(c,nil,0,REASON_EFFECT)~=0 then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		local count=mg:GetCount()
		mg=mg:Filter(c511004441.spfilter,nil,e,tp)
		if mg:GetCount()<count then return end
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<mg:GetCount() or (Duel.IsPlayerAffectedByEffect(tp,59822133) and mg:GetCount()>1) then return end
		Duel.SpecialSummon(mg,SUMMON_TYPE_SPECIAL,tp,tp,true,false,POS_FACEUP)
	end
end
