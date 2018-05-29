--ジャンク・ガードナー (Anime)
--Junk Gardna (Anime)
--scripted by Larry126
function c511600105.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,c511600105.tfilter,1,1,aux.NonTuner(nil),1,99)
	c:EnableReviveLimit()
	--pos
	local e1=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(37993923,0))
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c511600105.condition)
	e1:SetTarget(c511600105.target)
	e1:SetOperation(c511600105.operation)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(37993923,0))
	e2:SetCategory(CATEGORY_POSITION)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetTarget(c511600105.postg)
	e2:SetOperation(c511600105.posop)
	c:RegisterEffect(e2)
end
c511600105.listed_names={63977008}
c511600105.material_setcode=0x1017
function c511600105.tfilter(c)
	return c:IsCode(63977008) or c:IsHasEffect(20932152)
end
function c511600105.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp)
end
function c511600105.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local at=Duel.GetAttacker()
		return at:IsAttackPos() and at:IsCanChangePosition()
	end
	Duel.SetOperationInfo(0,CATEGORY_POSITION,at,1,1-tp,LOCATION_MZONE)
end
function c511600105.operation(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttacker()
	if at and at:IsAttackPos() and at:IsRelateToBattle() then
		Duel.ChangePosition(at,POS_FACEUP_DEFENSE,POS_FACEDOWN_DEFENSE)
	end
end
function c511600105.filter(c)
	return c:IsAttackPos() and c:IsCanChangePosition()
end
function c511600105.postg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c511600105.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_POSITION,nil,1,1-tp,LOCATION_MZONE)
end
function c511600105.posop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectMatchingCard(tp,c511600105.filter,tp,0,LOCATION_MZONE,1,1,nil)
	if #g>0 then
		Duel.ChangePosition(g,POS_FACEUP_DEFENSE,POS_FACEDOWN_DEFENSE)
	end
end