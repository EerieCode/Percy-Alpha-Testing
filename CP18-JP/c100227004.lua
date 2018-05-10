--シンデレラ
--Cinderella
--Scripted by AlphaKretin
function c100227004.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(100227004,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(100227004,1)
	e1:SetTarget(c100227004.sptg)
	e1:SetOperation(c100227004.spop)
	c:RegisterEffect(e1)
	--equip
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(100227004,1))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCondition(c100227004.eqcon)
	e2:SetTarget(c100227004.eqtg)
	e2:SetOperation(c100227004.eqop)
	c:RegisterEffect(e2)
end
c100227004.listed_names={100227010}
function c100227004.filter(c,e,tp)
	return c:IsCode(100227005) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c100227004.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c100227004.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c100227004.eqfilter1(c,tc,tp)
	return c:IsCode(100227011) and c:CheckEquipTarget(tc) and c:CheckUniqueOnField(tp) and not c:IsForbidden()
end
function c100227004.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c100227004.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc then Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) end
	if Duel.GetLocationCount(tp,LOCATION_SZONE)>0 
		and Duel.IsExistingMatchingCard(c100227004.eqfilter,tp,LOCATION_DECK,0,1,nil,tp) 
		and c:IsRelateToEffect(e) and c:IsFaceup() and c:IsControler(tp) 
		and Duel.SelectYesNo(tp,aux.Stringid(100227004,2)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
		local g=Duel.SelectMatchingCard(tp,c100227004.eqfilter1,tp,LOCATION_DECK,0,1,1,nil,c,tp)
		if g:GetCount()>0 then
			Duel.Equip(tp,g:GetFirst(),c)
		end
	end
end
function c100227004.eqcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and Duel.GetAttackTarget()==nil
end
function c100227004.eqfilter2(c,tc)
	return c:IsCode(100227011) and tc:GetEquipGroup():IsContains(c) and Duel.IsExistingTarget(c100227004.eqfilter3,tp,LOCATION_MZONE,LOCATION_MZONE,1,tc,c) and c:CheckUniqueOnField(tp) and not c:IsForbidden()
end
function c100227004.eqfilter3(c,ec)
	return c:IsFaceup() and ec:CheckEquipTarget(c)
end
function c100227004.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c100227004.eqfilter2,tp,LOCATION_SZONE,0,1,nil,c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g1=Duel.SelectTarget(tp,c100227004.eqfilter2,tp,LOCATION_SZONE,0,1,1,nil,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	e:SetLabelObject(g1:GetFirst())
	local g2=Duel.SelectTarget(tp,c100227004.eqfilter3,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,c,g1:GetFirst())
	g1:Merge(g2)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g1,2,0,0)
end
function c100227004.equal(c,tc)
	return c==tc
end
function c100227004.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local ec=tg:Filter(c100227004.equal,nil,e:GetLabelObject()):GetFirst()
	local tc=tg:Filter(aux.NOT(c100227004.equal),nil,e:GetLabelObject()):GetFirst()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)>0 and ec:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,ec,tc)
	end
end