--Trickstar Live Stage
--Logical Nonsense

--Substitute ID
local s,id=GetID()

function c2819435.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
	--Special summon a "Trickstar" token if you control a "Trickstar" link, ignition effect
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCountLimit(1,id)
	e2:SetCondition(s.spcon1)
	e2:SetTarget(s.sptg)
	e2:SetOperation(s.spop)
	c:RegisterEffect(e2)
	--Special summon a "Trickstar" if opponent controls S/T, ignition effect
	local e3=e2.Clone(c)
	e3:SetCondition(s.spcon2)
	e3:SetCountLimit(1,id+100)
	c:RegisterEffect(e3)
	Duel.AddCustomActivityCounter(id,ACTIVITY_SPSUMMON,s.counterfilter)
end
	--Check for anything but "Trickstar" monsters
function s.counterfilter(c)
	return not c:IsSetCard(0xfb)
end
	--Check for "Trickstar" monster
function s.thfilter(c)
	return c:IsSetCard(0xfb) and c:IsAbleToHand()
end
	--Performing the recycle effect
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(s.thfilter,tp,LOCATION_GRAVE,0,nil)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(id,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
end
	--Check for "Trickstar" link monster
function s.spcon1(c)
	return c:IsSetCard(0xfb)) and c:IsType(TYPE_LINK)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,id+100,0xfb,0x4011,0,0,1,RACE_FAIRY,ATTRIBUTE_LIGHT) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
	 --Performing the effect of special summoning token
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e)
		or Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,id+100,0xfb,0x4011,0,0,1,RACE_FAIRY,ATTRIBUTE_LIGHT) then return end
	local token=Duel.CreateToken(tp,id+100)
	Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
end
	--Defining what zones to look in
function s.filter(c)
	return c:GetSequence()<5
end
	--Checking if opponent cntrols S/T
function s.spcon2(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.IsExistingMatchingCard(s.filter,tp,0,LOCATION_SZONE,2,nil)
end