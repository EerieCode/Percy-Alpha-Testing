--Utonomatopia
--Logical Nonsense

--Substitute ID
local s,id=GetID()

function s.initial_effect(c)
	--Special summon from multiple archetypes from hand, ignition effect
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1,id)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(s.sptg)
	e1:SetOperation(s.spop)
	c:RegisterEffect(e1)
end
	--Check for "Gagaga" monster
function s.spfilter1(c,e,tp)
	return c:IsType(TYPE_MONSTER) 
		and c:IsSetCard(0x54) 
		and not c:IsCode(id) 
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
	--Check for "Gogogo" monster
function s.spfilter2(c,e,tp)
	return c:IsType(TYPE_MONSTER) 
		and c:IsSetCard(0x59) 
		and not c:IsCode(id) 
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
	--Check for "Dododo" monster
function s.spfilter3(c,e,tp)
	return c:IsType(TYPE_MONSTER) 
		and c:IsSetCard(0x82)
		and not c:IsCode(id) 
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
	--Check for "Zubaba" monster
function s.spfilter4(c,e,tp)
	return c:IsType(TYPE_MONSTER) 
		and c:IsSetCard(0x8f)
		and not c:IsCode(id) 
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
	--Activation legality
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and (Duel.IsExistingMatchingCard(s.spfilter1,tp,LOCATION_HAND,0,1,nil,e,tp)
		or Duel.IsExistingMatchingCard(s.spfilter2,tp,LOCATION_HAND,0,1,nil,e,tp)
		or Duel.IsExistingMatchingCard(s.spfilter3,tp,LOCATION_HAND,0,1,nil,e,tp)
		or Duel.IsExistingMatchingCard(s.spfilter4,tp,LOCATION_HAND,0,1,nil,e,tp))
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
	--Performing the effect of special summoning "Gagaga", "Gogogo", "Dododo", and/or "Zubaba" monster(s) from hand
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft==0 then return end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	local g1=Duel.GetMatchingGroup(s.spfilter1,tp,LOCATION_HAND,nil,e,tp)
	local g2=Duel.GetMatchingGroup(s.spfilter2,tp,LOCATION_HAND,nil,e,tp)
	local g3=Duel.GetMatchingGroup(s.spfilter3,tp,LOCATION_HAND,nil,e,tp)
	local g4=Duel.GetMatchingGroup(s.spfilter4,tp,LOCATION_HAND,nil,e,tp)
	local sg=Group.CreateGroup()
	if g1:GetCount()>0 and ((g2:GetCount()==0 and g3:GetCount()==0) or Duel.SelectYesNo(tp,aux.Stringid(id,1))) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg1=g1:Select(tp,1,1,nil)
		sg:Merge(sg1)
		ft=ft-1
	end
	if g2:GetCount()>0 and ft>0 and ((sg:GetCount()==0 and g3:GetCount()==0) or Duel.SelectYesNo(tp,aux.Stringid(id,2))) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg2=g2:Select(tp,1,1,nil)
		sg:Merge(sg2)
		ft=ft-1
	end
	if g3:GetCount()>0 and ft>0 and (sg:GetCount()==0 or Duel.SelectYesNo(tp,aux.Stringid(id,3))) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg3=g3:Select(tp,1,1,nil)
		sg:Merge(sg3)
	end
	Duel.SpecialSummon(sg,0,tp,tp,true,false,POS_FACEUP)
	end
	local ge1=Effect.CreateEffect(c)
	ge1:SetType(EFFECT_TYPE_FIELD)
	ge1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	ge1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	ge1:SetTargetRange(1,0)
	ge1:SetTarget(s.splimit)
	ge1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(ge1,tp)
end
	--Extra deck restriction to Xyz monsters
function s.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsType(TYPE_XYZ) and c:IsLocation(LOCATION_EXTRA)
end