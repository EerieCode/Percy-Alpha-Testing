--Astrograph Sorcerer (Anime)
--アストログラフ・マジシャン
--fixed by MLD
function c511010507.initial_effect(c)
	--Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511010507,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_HAND)
	e1:SetTarget(c511010507.sptg)
	e1:SetOperation(c511010507.spop)
	c:RegisterEffect(e1)
	--special summon Zarc
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511010507,2))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c511010507.zarccost)
	e2:SetTarget(c511010507.zarctg)
	e2:SetOperation(c511010507.zarcop)
	c:RegisterEffect(e2)
end
c511010507.listed_names={13331639}
function c511010507.spcfilter(c,e,tp)
	return c:GetPreviousControler()==tp and c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsCanBeEffectTarget(e) 
		and (c:IsLocation(LOCATION_SZONE+LOCATION_EXTRA+LOCATION_GRAVE+LOCATION_HAND) or (c:IsLocation(LOCATION_REMOVED) and c:IsFaceup()))
end
function c511010507.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return eg:IsExists(c511010507.spcfilter,1,nil,e,tp) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and c:IsCanBeSpecialSummoned(e,1,tp,false,false) end
	local g=eg:Filter(c511010507.spcfilter,nil,e,tp)
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c511010507.spcfilterchk(c,e,tp)
	return c:GetPreviousControler()==tp and c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsRelateToEffect(e) 
		and (c:IsLocation(LOCATION_SZONE+LOCATION_EXTRA+LOCATION_GRAVE+LOCATION_HAND) or (c:IsLocation(LOCATION_REMOVED) and c:IsFaceup()))
		and not Duel.GetFieldCard(tp,c:GetPreviousLocation(),c:GetPreviousSequence())
end
function c511010507.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(c511010507.spcfilterchk,nil,e,tp)
	if Duel.SpecialSummon(c,1,tp,tp,false,false,POS_FACEUP)~=0 and g:GetCount()>0 and Duel.SelectEffectYesNo(tp,c) then
		g:KeepAlive()
		--spsummon
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
		e1:SetCode(EVENT_CUSTOM+511010507)
		e1:SetLabelObject(g)
		e1:SetTarget(c511010507.rettg)
		e1:SetOperation(c511010507.retop)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e1)
		Duel.RaiseSingleEvent(c,EVENT_CUSTOM+511010507,e,r,tp,tp,0)
	end
end
function c511010507.rettg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=e:GetLabelObject()
	g:DeleteGroup()
	Duel.SetTargetCard(g)
end
function c511010507.retop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(c511010507.spcfilterchk,nil,e,tp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_BECOME_LINKED_ZONE)
	e1:SetValue(0xffffff)
	Duel.RegisterEffect(e1,tp)
	for tc in aux.Next(g) do
		if tc:IsPreviousLocation(LOCATION_PZONE) then
			local seq=0
			if tc:GetPreviousSequence()==7 or tc:GetPreviousSequence()==4 then seq=1 end
			Duel.MoveToField(tc,tp,tp,LOCATION_PZONE,tc:GetPreviousPosition(),true,bit.lshift(1,seq))
		else
			Duel.MoveToField(tc,tp,tp,tc:GetPreviousLocation(),tc:GetPreviousPosition(),true,bit.lshift(1,tc:GetPreviousSequence()))
		end
	end
	e1:Reset()
end
function c511010507.zarccost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c511010507.zarcspfilter(c,e,tp)
	return c:IsCode(13331639) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511010507.zarcremfilter(c)
	return c:IsCode(41209827,82044279,16195942,16178681) and c:IsAbleToRemove() and (c:IsLocation(0x49) or aux.SpElimFilter(c,true,true))
end
function c511010507.fcheck(c,sg,g,code,...)
	if not c:IsCode(code) then return false end
	if ... then
		g:AddCard(c)
		local res=sg:IsExists(c511010507.fcheck,1,g,sg,g,...)
		g:RemoveCard(c)
		return res
	else return true end
end
function c511010507.fselect(c,tp,mg,sg,...)
	sg:AddCard(c)
	local res=false
	if sg:GetCount()<4 then
		res=mg:IsExists(c511010507.fselect,1,sg,tp,mg,sg,...)
	elseif Duel.GetLocationCountFromEx(tp,tp,sg)>0 then
		local g=Group.CreateGroup()
		res=sg:IsExists(c511010507.fcheck,1,g,sg,g,...)
	end
	sg:RemoveCard(c)
	return res
end
function c511010507.zarctg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c511010507.zarcremfilter,tp,0x5d,0,nil)
	if chk==0 then return g:IsExists(c511010507.fselect,1,nil,tp,g,Group.CreateGroup(),41209827,82044279,16195942,16178681) 
		and Duel.IsExistingMatchingCard(c511010507.zarcspfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511010507.zarcop(e,tp,eg,ep,ev,re,r,rp)
	local mg=Duel.GetMatchingGroup(aux.NecroValleyFilter(c511010507.zarcremfilter),tp,0x5d,0,nil)
	local sg=Group.CreateGroup()
	while sg:GetCount()<4 do
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local g=mg:FilterSelect(tp,c511010507.fselect,1,1,sg,tp,mg,sg,41209827,82044279,16195942,16178681)
		if not g or g:GetCount()<=0 then return false end
		sg:Merge(g)
	end
	if Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)>3 and Duel.GetLocationCountFromEx(tp)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tc=Duel.SelectMatchingCard(tp,c511010507.zarcspfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp):GetFirst()
		if tc and Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)>0 then
			tc:CompleteProcedure()
		end
	end
end