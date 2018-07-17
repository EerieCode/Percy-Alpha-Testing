--麗の魔妖-妖狐
--Beautiful Mayakashi – Youko
function c100410035.initial_effect(c)
	c:SetUniqueOnField(1,0,100410035)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,1,1,aux.NonTuner(nil),1,99)
	c:EnableReviveLimit()
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(100410035,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCountLimit(1,100410035)
	e1:SetCondition(c100410035.condition)
	e1:SetTarget(c100410035.target)
	e1:SetOperation(c100410035.operation)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(100410035,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,100410135)
	e2:SetCondition(c100410035.spcon)
	e2:SetTarget(c100410035.sptg)
	e2:SetOperation(c100410035.spop)
	c:RegisterEffect(e2)
end
function c100410035.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetPreviousLocation()==LOCATION_GRAVE and e:GetHandler():GetPreviousControler()==tp
end
function c100410035.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c100410035.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,Card.IsDestructable,tp,0,LOCATION_MZONE,1,1,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.Destroy(g,REASON_EFFECT)
	end
end
function c100410035.thcfilter(c,tp)
	return c:IsAbleToRemoveAsCost() and c:IsRace(RACE_ZOMBIE) and aux.SpElimFilter(c,true)
end
function c100410035.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100410035.thcfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,e:GetHandler(),tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c100410035.thcfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,1,e:GetHandler(),tp)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c100410035.spfilter(c,tp,rp)
	return c:IsPreviousPosition(POS_FACEUP) and c:GetPreviousControler()==tp and c:GetPreviousTypeOnField()&TYPE_SYNCHRO~=0
		and c:GetOriginalLevel()==11
end
function c100410035.spcon(e,tp,eg,ep,ev,re,r,rp)
	return not eg:IsContains(e:GetHandler()) and eg:IsExists(c100410035.spfilter,1,nil)
end
function c100410035.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c100410035.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end

