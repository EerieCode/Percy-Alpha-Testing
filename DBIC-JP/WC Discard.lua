function Auxiliary.WitchcraftDiscardFilter(c)
	return c:IsHasEffect(100412024) and c:IsAbleToGraveAsCost()
end
function Auxiliary.WitchcraftDiscardGroup(minc)
	return	function(sg,e,tp,mg)
				if sg:IsExists(Card.IsHasEffect,1,nil,100412024) then
					return #sg==1
				else
					return #sg>=minc
				end
			end
end
function Auxiliary.WitchcraftDiscardCost(f,minc,maxc)
	if f then f=aux.AND(f,Card.IsDiscardable) else f=Card.IsDiscardable end
	if not minc then minc=1 end
	if not maxc then maxc=1 end
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				if chk==0 then return Duel.IsExistingMatchingCard(f,tp,LOCATION_HAND,0,minc,nil) or Duel.IsExistingMatchingCard(Auxiliary.WitchcraftDiscardFilter,tp,LOCATION_ONFIELD,0,1,nil) end
				local g=Duel.GetMatchingGroup(f,tp,LOCATION_HAND,0,nil)
				g:Merge(Duel.GetMatchingGroup(Auxiliary.WitchcraftDiscardFilter,tp,LOCATION_ONFIELD,0,nil))
				local sg=Auxiliary.SelectUnselectGroup(g,e,tp,1,maxc,Auxiliary.WitchcraftDiscardGroup(minc),1,tp,aux.Stringid(100412024,2))
				if sg:IsExists(Card.IsHasEffect,1,nil,100412024) then
					local id=sg:GetFirst():GetOriginalCode()
					Duel.SendtoGrave(sg,REASON_COST)
					Duel.RegisterFlagEffect(tp,id,RESET_PHASE+PHASE_END,0,1)
				else
					Duel.SendtoGrave(sg,REASON_COST+REASON_DISCARD)
				end
			end
end