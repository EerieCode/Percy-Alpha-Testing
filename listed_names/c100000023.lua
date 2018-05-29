--古生代化石マシン スカルコンボイ
function c100000023.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcMix(c,true,true,c100000023.ffilter1,c100000023.ffilter2)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c100000023.splimit)
	c:RegisterEffect(e1)	
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(100000023,0))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EVENT_BATTLE_DESTROYING)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCondition(c100000023.damcon)
	e2:SetTarget(c100000023.damtg)
	e2:SetOperation(c100000023.damop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_EXTRA_ATTACK)	
	e3:SetCondition(c100000023.con)
	e3:SetValue(2)
	c:RegisterEffect(e3)
end
c100000023.listed_names={100000025}
function c100000023.splimit(e,se,sp,st)
	return se:GetHandler():IsCode(100000025)
end
function c100000023.ffilter1(c,fc,sumtype,tp)
	return c:IsRace(RACE_ROCK,fc,sumtype,tp) and c:IsLocation(LOCATION_GRAVE) and c:IsControler(tp)
end
function c100000023.ffilter2(c,fc,sumtype,tp)
	return c:IsLevelAbove(7) and c:IsRace(RACE_MACHINE,fc,sumtype,tp) and c:IsLocation(LOCATION_GRAVE) and c:IsControler(1-tp)
end
function c100000023.con(e)
	return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),0,LOCATION_MZONE)>0
end
function c100000023.damcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local d=Duel.GetAttacker()
	if d==c then d=Duel.GetAttackTarget() end
	return c:IsRelateToBattle() and d:IsLocation(LOCATION_GRAVE) and d:IsReason(REASON_BATTLE) and d:IsType(TYPE_MONSTER)
end
function c100000023.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(1000)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,1000)
end
function c100000023.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
