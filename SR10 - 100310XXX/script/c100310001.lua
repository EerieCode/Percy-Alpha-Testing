--マシンナーズ・カーネル
--Machina Colonel
--Scripted by AlphaKretin
local s,id=GetID()
function s.initial_effect(c)
	c:EnableUnsummonable()
	--splimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(s.splimit)
	c:RegisterEffect(e1)
	--destroy
    local e2=Effect.CreateEffect(c)
    e2:SetCategory(CATEGORY_DESTROY)
    e2:SetType(EFFECT_TYPE_QUICK_O)
    e2:SetCode(EVENT_FREE_CHAIN)
    e2:SetRange(LOCATION_MZONE)
    e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e2:SetCountLimit(1,id)
    e2:SetTarget(s.destg)
    e2:SetOperation(s.desop)
    c:RegisterEffect(e2)
    --special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(s.spcon)
	e1:SetTarget(s.sptg)
	e1:SetOperation(s.spop)
	c:RegisterEffect(e1)
end
function s.splimit(e,se,sp,st)
	return se:IsHasType(EFFECT_TYPE_ACTIONS)
end
function s.tgfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_MACHINE) and Duel.IsExistingMatchingCard(s.desfilter,c:GetControler(),0,LOCATION_MZONE,1,nil,c:GetAttack())
end
function s.desfilter(c,atk)
    return c:IsFaceup() and c:IsAttackBelow(atk)
end
function s.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    local c=e:GetHandler()
    if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and s.tgfilter(chkc) end
    if chk==0 then return Duel.IsExistingTarget(s.tgfilter,tp,LOCATION_MZONE,0,1,nil) end
    local tc=Duel.SelectTarget(tp,s.tgfilter,tp,LOCATION_MZONE,0,1,nil):GetFirst()
    local dg=Duel.GetMatchingGroup(s.desfilter,tp,0,LOCATION_MZONE,c,tc:GetAttack())
    Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,#g,0,0)
end
function s.desop(e,tp,eg,ep,ev,re,r,rp)
    local tc=Duel.GetFirstTarget()
    if not tc:IsRelateToEffect(e) or not s.tgfilter(tc) then return end
    local g=Duel.GetMatchingGroup(s.desfilter,tp,0,LOCATION_MZONE,c,tc:GetAttack())
    if #g>0 then 
    	Duel.Destroy(g,REASON_EFFECT)
    end
end
function s.spcfilter(c,tp)
	return c:IsReason(REASON_BATTLE+REASON_EFFECT)
		and c:IsPreviousControler(tp) and c:IsPreviousLocation(LOCATION_ONFIELD)
		and c:IsPreviousPosition(POS_FACEUP) and (c:GetPreviousAttributeOnField&ATTRIBUTE_EARTH)==ATTRIBUTE_EARTH
		and (c:GetPreviousRaceOnField&RACE_MACHINE)==RACE_MACHINE
end
function s.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(s.spcfilter,1,nil,tp)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,LOCATION_GRAVE)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end