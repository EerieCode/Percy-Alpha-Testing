function s.spfilter(c,e,tp)
	return c:IsCanBeSpecialSummoned(c,e,0,tp,false,false)
end
function s.rescon(sg,e,tp,mg)
	return aux.ChkfMMZ(#sg)(sg,e,tp,mg)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(s.spfilter,tp,LOCATION_HAND,0,nil,e,tp)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and aux.SelectUnselectGroup(g,e,tp,1,2,s.rescon,chk) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(s.spfilter,tp,LOCATION_HAND,0,nil,e,tp)
	--if you're actually special summoning, the count might need a Blue-Eyes Spirit Dragon check
	--but this is a bare-bones example
	local sg=aux.SelectUnselectGroup(g,e,tp,1,2,s.rescon,1,tp,HINTMSG_SPSUMMON)
	if #sg>0 then
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
	end
end
