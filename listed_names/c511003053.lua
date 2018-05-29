--Nightmare Past Loop
function c511003053.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--tribute
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_RELEASE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c511003053.reltg)
	e2:SetOperation(c511003053.relop)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c511003053.spcon)
	e3:SetCost(c511003053.spcost)
	e3:SetTarget(c511003053.sptg)
	e3:SetOperation(c511003053.spop)
	c:RegisterEffect(e3)
end
c511003053.listed_names={511003050}
function c511003053.reltg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsReleasableByEffect,1,nil) end
	e:GetHandler():RegisterFlagEffect(511003053,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,0)
end
function c511003053.relop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.SelectReleaseGroup(tp,Card.IsReleasableByEffect,1,1,nil)
	Duel.Release(g,REASON_EFFECT)
end
function c511003053.spcon(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetTurnPlayer()~=tp or e:GetHandler():GetFlagEffect(511003053)==0 then return false end
	local ph=Duel.GetCurrentPhase()
	return ph==PHASE_MAIN1 or (ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE) or ph==PHASE_MAIN2
end
function c511003053.cfilter(c,ft,tp)
	local mg=c:GetMaterial()
	return mg and mg:IsExists(Card.IsCode,1,nil,511003050) and c:IsSummonType(SUMMON_TYPE_FUSION,SUMMON_TYPE_SYNCHRO,SUMMON_TYPE_XYZ) 
		 and (ft>0 or (c:IsControler(tp) and c:GetSequence()<5)) and (c:IsControler(tp) or c:IsFaceup())
end
function c511003053.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if chk==0 then return ft>-1 and Duel.CheckReleaseGroup(tp,c511003053.cfilter,1,nil,ft,tp) end
	local g=Duel.SelectReleaseGroup(tp,c511003053.cfilter,1,1,nil,ft,tp)
	Duel.Release(g,REASON_COST)
end
function c511003053.filter(c,e,tp)
	return c:IsCode(511003050) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511003053.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511003053.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c511003053.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511003053.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
