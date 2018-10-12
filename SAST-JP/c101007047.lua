--クロック・リザード
--Clock Lizard
--scripted by Larry126
local s,id=GetID()
function s.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunctionEx(Card.IsRace,RACE_CYBERSE),2,2)
	c:EnableReviveLimit()
	--fusion summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON+CATEGORY_TODECK)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(s.spcost)
	e1:SetTarget(s.sptg)
	e1:SetOperation(s.spop)
	c:RegisterEffect(e1)
	--atk down
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_REMOVE)
	e2:SetCondition(s.atkcon)
	e2:SetTarget(s.atktg)
	e2:SetOperation(s.atkop)
	c:RegisterEffect(e2)
end
function s.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function s.mfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsCanBeFusionMaterial() and c:IsAbleToRemove() and aux.SpElimFilter(c)
end
function s.tdfilter(c,e,tp,mg,f,mgc,mf)
	return c:IsType(TYPE_FUSION) and c:IsAbleToExtra()
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false)
		and (c:CheckFusionMaterial(mg,nil,tp) and (not f or f(c))
		or c:CheckFusionMaterial(mgc,nil,tp) and (not mf or mf(c)))
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local mg=Duel.GetMatchingGroup(s.mfilter,tp,LOCATION_GRAVE+LOCATION_ONFIELD,0,nil)
	local ce=Duel.GetChainMaterial(tp)
	local mgc=Group.CreateGroup()
	local mf=nil
	if ce~=nil then
		mgc=ce:GetTarget()(ce,e,tp)
		mf=ce:GetValue()
	end
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and s.tdfilter(chkc,e,tp,mg,nil,mgc,mf) end
	if chk==0 then return Duel.IsExistingTarget(s.tdfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp,mg,nil,mgc,mf) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,s.tdfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,mg,nil,mgc,mf)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,tp,LOCATION_GRAVE)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
	Duel.SetOperationInfo(0,CATEGORY_FUSION_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SendtoDeck(tc,nil,0,REASON_EFFECT)~=0 then
		local mg=Duel.GetMatchingGroup(s.mfilter,tp,LOCATION_GRAVE+LOCATION_ONFIELD,0,nil)
		local mgc=Group.CreateGroup()
		local mf=nil
		local ce=Duel.GetChainMaterial(tp)
		if ce~=nil then
			mgc=ce:GetTarget()(ce,e,tp)
			mf=ce:GetValue()
		end
		local nf=tc:CheckFusionMaterial(mg,nil,tp) and (not f or f(tc))
		local cef=tc:CheckFusionMaterial(mgc,nil,tp) and (not mf or mf(tc))
		if tc:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false)
			and (nf or cef) then
			Duel.BreakEffect()
			if nf and (not cef or not Duel.SelectYesNo(tp,ce:GetDescription())) then
				local mat1=Duel.SelectFusionMaterial(tp,tc,mg,nil,tp)
				tc:SetMaterial(mat1)
				Duel.Remove(mat1,POS_FACEUP,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
				Duel.BreakEffect()
				Duel.SpecialSummon(tc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
			else
				local mat2=Duel.SelectFusionMaterial(tp,tc,mgc,nil,tp)
				local fop=ce:GetOperation()
				fop(ce,e,tp,tc,mat2)
			end
			tc:CompleteProcedure()
		end
	end
end
function s.filter(c,p)
	return c:IsControler(p) and c:IsFaceup()
end
function s.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_GRAVE)
end
function s.atkfilter(c)
	return c:IsFaceup() and c:IsSummonType(SUMMON_TYPE_SPECIAL)
end
function s.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsRace,tp,LOCATION_GRAVE,0,1,nil,RACE_CYBERSE)
	and Duel.IsExistingMatchingCard(s.atkfilter,tp,0,LOCATION_MZONE,1,nil) end
end
function s.atkop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(s.atkfilter,tp,0,LOCATION_MZONE,nil)
	if g:GetCount()==0 then return end
	local atk=Duel.GetMatchingGroupCount(Card.IsRace,tp,LOCATION_GRAVE,0,nil)*400
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-atk)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end