--Anit the Ray
--Scripted by Keddy
function c513000133.initial_effect(c)
	--Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(4004,2))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c513000133.target)
	e1:SetOperation(c513000133.operation)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(1131)
	e2:SetCategory(CATEGORY_DISABLE+CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e2:SetType(EFFECT_TYPE_QUICK_O+EFFECT_TYPE_XMATERIAL)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c513000133.dcondition)
	e2:SetCost(c513000133.dcost)
	e2:SetTarget(c513000133.dtarget)
	e2:SetOperation(c513000133.doperation)
	c:RegisterEffect(e2)
	aux.CallToken(420)
end
c513000133.listed_names={513000133}
function c513000133.filter(c,e,tp)
	return c:IsType(TYPE_MONSTER) and c:IsAnti() and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c513000133.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_DECK) and c513000133.filter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c513000133.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c513000133.cfilter(c,tc)
	return c:IsFaceup() and c:IsAnti() and c~=tc
end
function c513000133.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c513000133.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if g:GetCount()>0 and Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)~=0 then
		local xg=Group.FromCards(c)
		local xge=Duel.SelectMatchingCard(tp,c513000133.cfilter,tp,LOCATION_MZONE,0,0,99,tc,c)
		local sg
		xg:Merge(xge)
		for tc in aux.Next(xg) do
			local ov=tc:GetOverlayGroup()
			if not sg then
				sg=ov
			else
				sg=sg+ov
			end
		end
		Duel.SendtoGrave(sg,REASON_RULE)
		Duel.Overlay(tc,xg)
	end
end
function c513000133.dcondition(e,tp,eg,ep,ev,re,r,rp)
	local m0=Duel.GetFieldGroupCount(0,LOCATION_MZONE,0)
	local m1=Duel.GetFieldGroupCount(1,LOCATION_MZONE,0)
	return m0==m1
end
function c513000133.dcfilter(c)
	return c:IsCode(513000133)
end
function c513000133.dcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local ov=c:GetOverlayGroup()
	if chk==0 then return ov:IsExists(c513000133.dcfilter,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVEXYZ)
	local tov=ov:FilterSelect(tp,c513000133.dcfilter,1,1,nil)
	Duel.SendtoGrave(tov,REASON_COST)
end
function c513000133.dfilter(c)
	return (c:GetAttack()~=c:GetBaseAttack() and c:GetDefense()~=c:GetBaseDefense()) or aux.disfilter1(c)
end
function c513000133.dtarget(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
	if chk==0 then return #g:Filter(c513000133.dfilter,nil)>0 end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,g,#g,0,0)
	Duel.SetOperationInfo(0,CATEGORY_ATKCHANGE,g,#g,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DEFCHANGE,g,#g,0,0)
end
function c513000133.doperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
	for tc in aux.Next(g) do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		tc:RegisterEffect(e2)		 
	end
	for tc in aux.Next(g) do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(tc:GetBaseAttack())
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_SET_DEFENSE_FINAL)
		e2:SetValue(tc:GetBaseDefense())
		tc:RegisterEffect(e2)		 
	end	   
end
