--Scripted by Eerie Code
--Ancient Gear Chaos Fusion
--fixed by MLD
function c700000034.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON)
	e1:SetCost(c700000034.cost)
	e1:SetTarget(c700000034.target)
	e1:SetOperation(c700000034.activate)
	c:RegisterEffect(e1)
end
c700000034.listed_names={24094653}
function c700000034.cfilter(c)
	return c:IsCode(24094653) and c:IsAbleToGraveAsCost()
end
function c700000034.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c700000034.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c700000034.cfilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c700000034.matfilter(c,e,tp,fc,se)
	return c:IsType(TYPE_MONSTER) and c:IsCanBeFusionMaterial(fc) and (not se or not c:IsImmuneToEffect(se)) and c:IsCanBeSpecialSummoned(e,0,tp,true,false) 
end
function c700000034.spfilter(c,e,tp,rg,se)
	if not c:IsType(TYPE_FUSION) or not c:IsSetCard(0x7) or not c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) then return false end
	local minc=c.min_material_count
	local maxc=c.max_material_count
	if not minc then return false end
	local mg2=Duel.GetMatchingGroup(c700000034.matfilter,tp,LOCATION_DECK+LOCATION_EXTRA+LOCATION_GRAVE,0,nil,e,tp,c,se)
	if Duel.IsPlayerAffectedByEffect(tp,69832741) then
		local maxc2=math.min(rg:GetCount(),maxc)
		local mft=Duel.GetLocationCount(tp,LOCATION_MZONE)
		if Duel.IsPlayerAffectedByEffect(tp,59822133) then maxc2=math.min(ft,1) mft=math.min(mft,1) end
		return minc>0 and maxc2>=minc and aux.SelectUnselectGroup(rg,e,tp,minc,maxc2,c700000034.resconse1(c,mft,mg2,se),0)
	else
		local ft=Duel.GetUsableMZoneCount(tp)
		local mft=Duel.GetLocationCount(tp,LOCATION_MZONE)
		local exft=Duel.GetLocationCountFromEx(tp)
		local ect=c29724053 and Duel.IsPlayerAffectedByEffect(tp,29724053) and (c29724053[tp]-1)
		if ect then exft=math.min(exft,ect) end
		maxc=math.min(maxc,ft)
		if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=math.min(ft,1) mft=math.min(mft,1) exft=math.min(exft,1) end
		return minc>0 and maxc>=minc and aux.SelectUnselectGroup(rg,e,tp,minc,maxc,c700000034.rescon1(c,mft,exft,ft,mg2,se),0)
	end
end
function c700000034.rescon1(fc,mft,exft,ft,mg2,se)
	return	function(sg,e,tp,mg)
				local mg3=mg2:Filter(aux.TRUE,sg)
				return ft>=sg:GetCount() and aux.SelectUnselectGroup(mg3,e,tp,sg:GetCount(),sg:GetCount(),c700000034.rescon2(fc,mft,exft),0)
			end
end
function c700000034.rescon2(fc,mft,exft)
	return	function(sg,e,tp,mg)
				Auxiliary.FCheckExact=sg:GetCount()
				local res=exft>=sg:FilterCount(Card.IsLocation,nil,LOCATION_EXTRA) and mft>=sg:FilterCount(aux.NOT(Card.IsLocation),nil,LOCATION_EXTRA)
					and fc:CheckFusionMaterial(sg,nil,tp)
				Auxiliary.FCheckExact=nil
				return res
			end
end
function c700000034.resconse1(fc,mft,mg2,se)
	return	function(sg,e,tp,mg)
				local mg3=mg2:Filter(aux.TRUE,sg)
				return aux.SelectUnselectGroup(mg3,e,tp,sg:GetCount(),sg:GetCount(),c700000034.resconse2(fc,sg,mft),0)
			end
end
function c700000034.resconse2(fc,rg,mft)
	return	function(sg,e,tp,mg)
				local ect=c29724053 and Duel.IsPlayerAffectedByEffect(tp,29724053) and (c29724053[tp]-1)
				local exct=sg:FilterCount(Card.IsLocation,nil,LOCATION_EXTRA) 
				Auxiliary.FCheckExact=sg:GetCount()
				local res=Duel.GetLocationCountFromEx(tp,tp,rg)>=exct and (not ect or exct<ect) 
					and rg:FilterCount(aux.MZFilter,nil,tp)+mft>=sg:FilterCount(aux.NOT(Card.IsLocation),nil,LOCATION_EXTRA)
					and fc:CheckFusionMaterial(sg,nil,tp)
				Auxiliary.FCheckExact=nil
				return res
			end
end
function c700000034.rmfilter(c)
	return c:GetSummonLocation()==LOCATION_EXTRA and c:IsPreviousLocation(LOCATION_MZONE) and c:IsAbleToRemove() and aux.SpElimFilter(c,true)
end
function c700000034.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local rg=Duel.GetMatchingGroup(c700000034.rmfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,nil)
	if chk==0 then return Duel.GetUsableMZoneCount(tp)>-1 and Duel.IsPlayerCanSpecialSummonCount(tp,2) 
		and Duel.IsExistingMatchingCard(c700000034.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,rg) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local fg=Duel.SelectMatchingCard(tp,c700000034.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,rg)
	Duel.ConfirmCards(1-tp,fg:GetFirst())
	Duel.SetTargetCard(fg)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c700000034.activate(e,tp,eg,ep,ev,re,r,rp)
	local fc=Duel.GetFirstTarget()
	local rg=Duel.GetMatchingGroup(aux.NecroValleyFilter(c700000034.rmfilter),tp,LOCATION_MZONE+LOCATION_GRAVE,0,nil)
	if not fc or not fc:IsRelateToEffect(e) or not c700000034.spfilter(fc,e,tp,rg,e) then return end
	local minc=fc.min_material_count
	local maxc=fc.max_material_count
	local rsg
	local mg=Duel.GetMatchingGroup(aux.NecroValleyFilter(c700000034.matfilter),tp,LOCATION_DECK+LOCATION_EXTRA+LOCATION_GRAVE,0,nil,e,tp,fc,e)
	if Duel.IsPlayerAffectedByEffect(tp,69832741) then
		local maxc2=math.min(rg:GetCount(),maxc)
		local mft=Duel.GetLocationCount(tp,LOCATION_MZONE)
		if Duel.IsPlayerAffectedByEffect(tp,59822133) then maxc2=math.min(ft,1) mft=math.min(mft,1) end
		if minc<=0 or maxc2<minc then return end
		rsg=aux.SelectUnselectGroup(rg,e,tp,minc,maxc2,c700000034.resconse1(c,mft,mg,e),1,tp,HINTMSG_REMOVE,c700000034.resconse1(c,mft,mg,e))
		if rsg:GetCount()<=0 then return end
	else
		local ft=Duel.GetUsableMZoneCount(tp)
		local mft=Duel.GetLocationCount(tp,LOCATION_MZONE)
		local exft=Duel.GetLocationCountFromEx(tp)
		local ect=c29724053 and Duel.IsPlayerAffectedByEffect(tp,29724053) and (c29724053[tp]-1)
		if ect then exft=math.min(exft,ect) end
		maxc=math.min(maxc,ft)
		if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=math.min(ft,1) mft=math.min(mft,1) exft=math.min(exft,1) end
		if minc<=0 or maxc<minc then return end
		rsg=aux.SelectUnselectGroup(rg,e,tp,minc,maxc,c700000034.rescon1(fc,mft,exft,ft,mg,e),1,tp,HINTMSG_REMOVE,c700000034.rescon1(fc,mft,exft,ft,mg,e))
		if rsg:GetCount()<=0 then return end
	end
	local ct=Duel.Remove(rsg,POS_FACEUP,REASON_EFFECT)
	if ct<rsg:GetCount() then return end
	local mft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local exft=Duel.GetLocationCountFromEx(tp)
	local ect=c29724053 and Duel.IsPlayerAffectedByEffect(tp,29724053) and (c29724053[tp]-1)
	if ect then exft=math.min(exft,ect) end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then mft=math.min(mft,1) exft=math.min(exft,1) end
	mg:Sub(rsg)
	local matg=aux.SelectUnselectGroup(mg,e,tp,ct,ct,c700000034.rescon2(fc,mft,exft),1,tp,HINTMSG_SPSUMMON)
	if not aux.MainAndExtraSpSummonLoop(c700000034.disop,0,0,0,true,false)(e,tp,eg,ep,ev,re,r,rp,matg) then return end
	Duel.BreakEffect()
	fc:SetMaterial(matg)
	Duel.SendtoGrave(matg,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
	Duel.BreakEffect()
	Duel.SpecialSummon(fc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
end
function c700000034.disop(e,tp,eg,ep,ev,re,r,rp,tc)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	tc:RegisterEffect(e1)
	local e3=Effect.CreateEffect(e:GetHandler())
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_DISABLE_EFFECT)
	e3:SetReset(RESET_EVENT+0x1fe0000)
	tc:RegisterEffect(e3)
end
