--No.39 希望皇ホープ・ダブル
--Number 39: Utopia Double
--Logical Nonsense

--Substitute ID
local s,id=GetID()

function s.initial_effect(c)
	--Must be properly summoned
	c:EnableReviveLimit()
	--Xyz summon method
	aux.AddXyzProcedure(c,nil,4,2)
	--Search and Xyz
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1+id)
	e1:SetCost(s.cost)
	e1:SetTarget(s.target)
	e1:SetOperation(s.operation)
	c:RegisterEffect(e1)
end
	--Detach 1 material
function s.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
	--Look for "Double or Nothing!"
function s.thfilter(c)
	return c:IsCode(94770493) and c:IsAbleToHand()
end
	--Check for "Utopia" Xyz monster, excluding "Number 39: Utopia Double"
function s.spfilter(c,e,tp,mc)
	return c:IsSetCard(0x107f) and not c:IsCode(id) and mc:IsCanBeXyzMaterial(c)
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false)
end
	--Activation legality
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCountFromEx(tp,tp,e:GetHandler())>0
		and aux.MustMaterialCheck(e:GetHandler(),tp,EFFECT_MUST_BE_XMATERIAL)
		and Duel.IsExistingMatchingCard(s.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,e:GetHandler())
		and Duel.IsExistingMatchingCard(s.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
	--Performing the effect of adding "Double or Nothing!", then Xyz summon 1 "Utopia" monster
Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
function s.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,s.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if Duel.SendtoHand(g,nil,REASON_EFFECT)>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
		Duel.ShuffleHand(tp)
		Duel.BreakEffect()
		Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
		if Duel.GetLocationCountFromEx(tp,tp,c)>0 and aux.MustMaterialCheck(c,tp,EFFECT_MUST_BE_XMATERIAL) then
			if c:IsFaceup() and c:IsRelateToEffect(e) and c:IsControler(tp) and not c:IsImmuneToEffect(e) then
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
				local g=Duel.SelectMatchingCard(tp,s.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,c)
				local sc=g:GetFirst()
				if sc then
					local mg=c:GetOverlayGroup()
					if mg:GetCount()~=0 then
						Duel.Overlay(sc,mg)
					end
					sc:SetMaterial(Group.FromCards(c))
					Duel.Overlay(sc,Group.FromCards(c))
					Duel.SpecialSummon(sc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
					sc:CompleteProcedure()
				end
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			sc:RegisterEffect(e1)
			local e2=Effect.CreateEffect((e:GetHandler()))
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_SET_ATTACK_FINAL)
			e2:SetValue(tc:GetBaseAttack()*2)
			e2:SetReset(RESET_EVENT+RESETS_STANDARD)
			sc:RegisterEffect(e2)
			end
		end
	end
end
