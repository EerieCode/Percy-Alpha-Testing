--Supreme King Servant Dragon Dark Rebellion
--fixed by MLD
function c511009508.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunctionEx(Card.IsAttribute,ATTRIBUTE_DARK),4,2)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(c511009508.spcon)
	e1:SetOperation(c511009508.spop)
	c:RegisterEffect(e1)
	--atk limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e2:SetValue(c511009508.atlimit)
	c:RegisterEffect(e2)
	--atk change
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(67547370,1))
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e3:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e3:SetCondition(c511009508.atkcon)
	e3:SetCost(c511009508.atkcost)
	e3:SetTarget(c511009508.atktg)
	e3:SetOperation(c511009508.atkop)
	c:RegisterEffect(e3)
	--spsummon
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(95923441,0))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetHintTiming(0,TIMING_END_PHASE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCost(c511009508.spcost)
	e4:SetTarget(c511009508.sptg)
	e4:SetOperation(c511009508.spop2)
	c:RegisterEffect(e4)
end
c511009508.listed_names={13331639}
function c511009508.spfilter(c,tp)
	return c:IsControler(1-tp) and c:IsType(TYPE_XYZ) and c:IsSummonType(SUMMON_TYPE_XYZ)
end
function c511009508.cfilter(c)
	return c:IsFaceup() and c:IsCode(13331639)
end
function c511009508.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511009508.spfilter,1,nil,tp) and Duel.IsExistingMatchingCard(c511009508.cfilter,tp,LOCATION_MZONE,0,1,nil)
		and e:GetHandler():IsXyzSummonable(nil)
end
function c511009508.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsXyzSummonable(nil) and Duel.SelectYesNo(tp,aux.Stringid(4003,7)) then
		Duel.XyzSummon(tp,c,nil)
	end
end
function c511009508.atlimit(e,c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c~=e:GetHandler()
end
function c511009508.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetBattleTarget() and e:GetHandler():GetBattleTarget():IsControler(1-tp)
end
function c511009508.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511009508.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if chkc then return chkc==bc end
	if chk==0 then
		if c:IsHasEffect(511009518) then return bc and bc:IsOnField() and bc:IsCanBeEffectTarget(e)
		else return bc end
	end
	if c:IsHasEffect(511009518) then
		e:SetProperty(0)
	else
		e:SetProperty(EFFECT_FLAG_CARD_TARGET)
		Duel.SetTargetCard(bc)
	end
end
function c511009508.atkfilter(c)
	return c:IsFaceup() and c:GetAttack()>0
end
function c511009508.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local sum=0
	if c:IsHasEffect(511009518) then
		local g=Duel.GetMatchingGroup(c511009508.atkfilter,tp,0,LOCATION_MZONE,nil)
		local tc=g:GetFirst()
		while tc do
			local atk=tc:GetAttack()
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_SET_ATTACK_FINAL)
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			e1:SetValue(0)
			tc:RegisterEffect(e1)
			sum=sum+atk
			tc=g:GetNext()
		end
	else
		local tc=Duel.GetFirstTarget()
		if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) and not tc:IsImmuneToEffect(e) then
			local atk=tc:GetAttack()
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_SET_ATTACK_FINAL)
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			e1:SetValue(0)
			if tc:RegisterEffect(e1)~=0 and atk and atk>0 then
				sum=atk
			end
		end
	end
	if c:IsRelateToEffect(e) and c:IsFaceup() and sum>0 then
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_UPDATE_ATTACK)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e2:SetValue(sum)
		c:RegisterEffect(e2)
	end
	e:SetProperty(EFFECT_FLAG_CARD_TARGET)
end
function c511009508.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToExtraAsCost() end
	Duel.SendtoDeck(e:GetHandler(),nil,0,REASON_COST)
end
function c511009508.spfilter2(c,e,tp)
	return c:IsFaceup() and c:IsSetCard(0x20f8) and c:IsType(TYPE_PENDULUM) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511009508.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.GetLocationCountFromEx(tp,tp,e:GetHandler())>1 and e:GetHandler():GetFlagEffect(511009508)==0
		and Duel.IsExistingMatchingCard(c511009508.spfilter2,tp,LOCATION_GRAVE,0,2,nil,e,tp) end
	e:GetHandler():RegisterFlagEffect(511009508,RESET_CHAIN,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_GRAVE)
end
function c511009508.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
end
function c511009508.spop2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) or Duel.GetLocationCountFromEx(tp)<2 then return end
	local g=Duel.GetMatchingGroup(aux.NecroValleyFilter(c511009508.spfilter2),tp,LOCATION_GRAVE,0,nil,e,tp)
	if g:GetCount()>=2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,2,2,nil)
		Duel.HintSelection(sg)
		if Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)==0 then return end
		local ag=Duel.GetMatchingGroup(c511009508.filter,tp,0,LOCATION_MZONE,nil)
		local tc=ag:GetFirst()
		while tc do
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_SET_ATTACK_FINAL)
			e2:SetValue(0)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e2)
			tc=ag:GetNext()
		end
	end
end
