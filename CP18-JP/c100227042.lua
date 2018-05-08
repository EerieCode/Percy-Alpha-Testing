--トリガー・ヴルム 
--Triggering Wurm
function c100227042.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(100227042,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCode(EVENT_BE_MATERIAL)
	e1:SetCountLimit(1,100227042)
	e1:SetCondition(c100227042.spcon)
	e1:SetTarget(c100227042.sptg)
	e1:SetOperation(c100227042.spop)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(100227042,0))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCountLimit(1,100227142)
	e2:SetCondition(c100227042.drcon)
	e2:SetTarget(c100227042.drtg)
	e2:SetOperation(c100227042.drop)
	c:RegisterEffect(e2)
end

function c100227042.spcon(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_LINK and re:GetHandler():IsAttribute(ATTRIBUTE_DARK)
end
function c100227042.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	local zone=re:GetHandler():GetLinkedZone(tp)
	if chk==0 then return zone~=0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_ATTACK,tp,zone) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,tp,LOCATION_GRAVE)
end
function c100227042.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local zone=0
	zone=re:GetHandler():GetLinkedZone(tp)
	if c:IsRelateToEffect(e) and zone~=0 and Duel.SpecialSummonStep(c,0,tp,tp,false,false,POS_FACEUP,zone) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_CANNOT_BE_LINK_MATERIAL)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e1,true)
		Duel.SpecialSummonComplete()
	end
end
function c100227042.drcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,0x41)==0x41 and re:GetHandler():IsType(TYPE_LINK) and re:IsActivated()
end
function c100227042.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c100227042.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end