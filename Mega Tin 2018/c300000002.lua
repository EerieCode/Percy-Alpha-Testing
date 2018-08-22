--Junk Speeder
function c300000002.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x1017),1,1,aux.NonTuner(nil),1,99)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(300000002,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,300000002)
	e1:SetCost(c300000002.spcost)
	e1:SetCondition(c300000002.spcon)
	e1:SetTarget(c300000002.sptg)
	e1:SetOperation(c300000002.spop)
	c:RegisterEffect(e1)
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(300000102,0))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,300000102)
	e2:SetCondition(c300000002.atkcon)
	e2:SetOperation(c300000002.atkop)
	c:RegisterEffect(e2,false,1)
	--extra attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetCondition(c300000002.effcon)
	e3:SetOperation(c300000002.regop)
	c:RegisterEffect(e3)
	Duel.AddCustomActivityCounter(300000002,ACTIVITY_SPSUMMON,c300000002.counterfilter)
end
function c300000002.counterfilter(c)
	return c:GetSummonLocation()~=LOCATION_EXTRA or c:IsType(TYPE_SYNCHRO)
end
function c300000002.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCustomActivityCount(300000002,tp,ACTIVITY_SPSUMMON)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c300000002.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c300000002.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsType(TYPE_SYNCHRO) and c:IsLocation(LOCATION_EXTRA)
end
function c300000002.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO
end
function c300000002.filter(c,e,tp)
	return c:IsSetCard(0x1017) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c300000002.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local ct=Duel.GetLocationCount(tp,LOCATION_MZONE,tp,LOCATION_REASON_TOFIELD)
		return ct>0 and Duel.IsExistingMatchingCard(c300000002.filter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,nil,e,tp)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE)
end
function c300000002.spop(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetLocationCount(tp,LOCATION_MZONE,tp,LOCATION_REASON_TOFIELD)
	if ct<=0 then return end
	if Duel.IsPlayerAffectedByEffect(tp,CARD_BLUEEYES_SPIRIT) then ct=1 end
	local g=Duel.GetMatchingGroup(c300000002.filter,tp,LOCATION_DECK,0,nil,e,tp)
	if g:GetCount()>0 then
		local sg=Group.CreateGroup()
		repeat
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local sg2=g:Select(tp,1,1,nil)
			sg:AddCard(sg2:GetFirst())
			g:Remove(Card.IsLevel,nil,sg2:GetFirst():GetLevel())
			ct=ct-1
		until ct==0 or g:GetCount()==0 or not Duel.SelectYesNo(tp,aux.Stringid(300000002,0))
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP,zone)
	end
end
function c300000002.effcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SYNCHRO)
end
function c300000002.regop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(300000002,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end

function c300000002.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(300000002)~=0 and (e:GetHandler()==Duel.GetAttacker() and Duel.GetAttackTarget()~=nil) or e:GetHandler()==Duel.GetAttackTarget()
end
function c300000002.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(c:GetBaseAttack()*2)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
