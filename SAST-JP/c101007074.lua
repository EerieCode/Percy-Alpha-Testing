--Shiranui Style Skill
--Logical Nonsense
function c101007074.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,101007074)
	e1:SetCondition(c101007074.condition)
	e1:SetTarget(c101007074.target)
	e1:SetOperation(c101007074.activate)
	c:RegisterEffect(e1)
	--Banish from the GY to target a zombie monster you control
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(101007074,0))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,101007074)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCondition(c101007074.atcon)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c101007074.sttg)
	e2:SetOperation(c101007074.sttc)
	c:RegisterEffect(e2)
end
	--Check for a zombie monster (for first effect)
function c101007074.spfilter(c,e,tp,race)
	return c:IsRace(RACE_ZOMBIE) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
	--Special summon a zombie from hand, but banish it if it leaves
function c101007074.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then 
		return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c101007074.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)	
end
function c101007074.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.SelectMatchingCard(c101007074.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if #g>0 and Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP_DEFENSE)~=0 then --Apply the following lingering to the monster
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x47e0000)
		e1:SetValue(LOCATION_REMOVED)
		g:GetFirst():RegisterEffect(e1,true)
	end
end
	--Preparation check if you do control a zombie monster
function c101007074.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_ZOMBIE)
end
	--Perform the action of targeting
function c101007074.sttg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c101007074.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c101007074.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c101007074.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
	--Apply immunity to the target
function c101007074.sstc(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_IMMUNE_EFFECT)
		e1:SetValue(c101007074.efilter)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
end