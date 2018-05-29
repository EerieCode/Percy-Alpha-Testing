--中生代化石騎士 スカルナイト
function c100000027.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcMix(c,true,true,c100000027.ffilter1,c100000027.ffilter2)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c100000027.splimit)
	c:RegisterEffect(e1)	
	--chain attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCountLimit(1)
	e2:SetCode(EVENT_DAMAGE_STEP_END)
	e2:SetCondition(c100000027.atcon)
	e2:SetOperation(c100000027.atop)
	c:RegisterEffect(e2)
end
c100000027.listed_names={100000025}
function c100000027.splimit(e,se,sp,st)
	return se:GetHandler():IsCode(100000025)
end
function c100000027.ffilter1(c,fc,sumtype,tp)
	return c:IsRace(RACE_ROCK,fc,sumtype,tp) and c:IsLocation(LOCATION_GRAVE) and c:IsControler(tp)
end
function c100000027.ffilter2(c,fc,sumtype,tp)
	return (c:IsLevel(5) or c:IsLevel(6)) and c:IsLocation(LOCATION_GRAVE) and c:IsControler(1-tp)
end
function c100000027.atcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler()==Duel.GetAttacker() and e:GetHandler():IsChainAttackable()
		and Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)~=0
end
function c100000027.atop(e,tp,eg,ep,ev,re,r,rp)	
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK)	
		e1:SetCondition(c100000027.con)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_BATTLE)
		c:RegisterEffect(e1)
	end
end
function c100000027.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(e:GetOwnerPlayer(),0,LOCATION_MZONE)>0
end
