--The function generates a default Fusion Summon effect. By default it's usable for Spells/Traps, usage in monsters requires changing type and code afterwards.
--c				card that uses the effect
--ffilter		filter for the monster to be Fusion Summoned
--matfilter		restriction on the default materials returned by GetFusionMaterial
--xcon			condition for the additional materials (if not used, the materials will always be used)
--xfilter		filter on additional materials (if used, must include location and controller)
--gc			mandatory card to be used (for effects like Soprano)
--matop			operation to be performed on the materials (by default they're sent to the GY)
function Auxiliary.CreateFusionEffect(c,ffilter,matfilter,xcon,xfilter,gc,matop)
	if not matop then matop=Auxiliary.FEDefaultMatOperation end
	local e=Effect.CreateEffect(c)
	e:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON)
	e:SetType(EFFECT_TYPE_ACTIVATE)
	e:SetCode(EVENT_FREE_CHAIN)
	e:SetTarget(Auxiliary.FETarget(ffilter,matfilter,xcon,xfilter,gc))
	e:SetOperation(Auxiliary.FEOperation(ffilter,matfilter,xcon,xfilter,gc,matop))
	return e
end
function Auxiliary.FEDefaultMatOperation(g,e,tp)
	Duel.SendtoGrave(g,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
end
function Auxiliary.FEFilter1(c,f,tp)
	return c:IsCanBeFusionMaterial() and f(c,tp)
end
function Auxiliary.FEFilter2(c,e,tp,m,gc,ffilter,f,chkf)
	return c:IsType(TYPE_FUSION) and (not ffilter or ffilter(c)) and (not f or f(c))
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) and c:CheckFusionMaterial(m,gc,chkf)
end
function Auxiliary.FETarget(ffilter,matfilter,xcon,xfilter,gc)
	return function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then
			local chkf=tp
			local mg1=Duel.GetFusionMaterial(tp)
			if matfilter then mg1=mg1:Filter(matfilter,nil,tp) end
			if (not xcon or xcon(e,tp,eg,ep,ev,re,r,rp)) and xfilter then
				local mg2=Duel.GetMatchingGroup(Auxiliary.FEFilter1,tp,0x7f,0x7f,nil,xfilter,tp)
				mg1:Merge(mg2)
			end
			local res=Duel.IsExistingMatchingCard(Auxiliary.FEFilter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg1,gc,ffilter,nil,chkf)
			if not res then
				local ce=Duel.GetChainMaterial(tp)
				if ce~=nil then
					local fgroup=ce:GetTarget()
					local mg2=fgroup(ce,e,tp)
					local mf=ce:GetValue()
					res=Duel.IsExistingMatchingCard(Auxiliary.FEFilter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg2,gc,ffilter,mf,chkf)
				end
			end
			return res
		end
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
	end
end
function Auxiliary.FEOperation(ffilter,matfilter,xcon,xfilter,gc,matop)
	return function(e,tp,eg,ep,ev,re,r,rp)
		local chkf=tp
		local mg1=Duel.GetFusionMaterial(tp):Filter(aux.NOT(Card.IsImmuneToEffect),nil,e)
		if matfilter then mg1=mg1:Filter(matfilter,nil,tp) end
		if (not xcon or xcon(e,tp,eg,ep,ev,re,r,rp)) and xfilter then
			local mg2=Duel.GetMatchingGroup(Auxiliary.FEFilter1,tp,0x7f,0x7f,nil,xfilter,tp)
			mg1:Merge(mg2:Filter(aux.NOT(Card.IsImmuneToEffect),nil,e))
		end
		local sg1=Duel.GetMatchingGroup(Auxiliary.FEFilter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg1,gc,ffilter,nil,chkf)
		local mg2=nil
		local sg2=nil
		local ce=Duel.GetChainMaterial(tp)
		if ce~=nil then
			local fgroup=ce:GetTarget()
			mg2=fgroup(ce,e,tp)
			local mf=ce:GetValue()
			sg2=Duel.GetMatchingGroup(Auxiliary.FEFilter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg2,gc,ffilter,mf,chkf)
		end
		if #sg1>0 or (sg2~=nil and #sg2>0) then
			local sg=sg1:Clone()
			if sg2 then sg:Merge(sg2) end
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local tg=sg:Select(tp,1,1,nil)
			local tc=tg:GetFirst()
			if sg1:IsContains(tc) and (sg2==nil or not sg2:IsContains(tc) or not Duel.SelectYesNo(tp,ce:GetDescription())) then
				local mat1=Duel.SelectFusionMaterial(tp,tc,mg1,gc,chkf)
				tc:SetMaterial(mat1)
				matop(mat1,e,tp)
				Duel.BreakEffect()
				Duel.SpecialSummon(tc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
			else
				local mat2=Duel.SelectFusionMaterial(tp,tc,mg2,gc,chkf)
				local fop=ce:GetOperation()
				fop(ce,e,tp,tc,mat2)
			end
			tc:CompleteProcedure()
		end
	end
end
