--ギャラクシーアイズ ＦＡ・フォトン・ドラゴン (Manga)
--Galaxy Eyes Full Armor Photon Dragon (Manga)
--fixed by MLD
function c511009480.initial_effect(c)
	aux.AddXyzProcedure(c,nil,8,3)
	c:EnableReviveLimit()
	--xyz summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(c511009480.xyzcon)
	e1:SetOperation(c511009480.xyzop)
	e1:SetValue(SUMMON_TYPE_XYZ)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(39030163,2))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetCondition(c511009480.descon)
	e2:SetCost(c511009480.descost)
	e2:SetTarget(c511009480.destg)
	e2:SetOperation(c511009480.desop)
	c:RegisterEffect(e2,false,1)
	--material
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(39030163,1))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e3:SetRange(LOCATION_MZONE)
	-- e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCountLimit(1)
	e3:SetCondition(c511009480.mtcon)
	e3:SetTarget(c511009480.mttg)
	e3:SetOperation(c511009480.mtop)
	c:RegisterEffect(e3)
	--banish
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511000183,1))
	e3:SetCategory(CATEGORY_DISABLE)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_CHAINING)
	e3:SetCondition(c511009480.rmcon)
	e3:SetCost(c511009480.rmcost)
	e3:SetTarget(c511009480.rmtg)
	e3:SetOperation(c511009480.rmop)
	c:RegisterEffect(e3)
	Duel.EnableGlobalFlag(GLOBALFLAG_DETACH_EVENT)
	if not c511009480.global_check then
		c511009480.global_check=true
		local ge=Effect.CreateEffect(c)
		ge:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge:SetCode(EVENT_DETACH_MATERIAL)
		ge:SetOperation(c511009480.checkop)
		Duel.RegisterEffect(ge,0)
	end
end
c511009480.listed_names={93717133}
function c511009480.ovfilter(c,tp,xyz)
	return c:IsFaceup() and c:IsCode(93717133) and c:GetEquipCount()==2 and Duel.GetLocationCountFromEx(tp,tp,c,xyz)>0
end
function c511009480.xyzcon(e,c,og)
	if c==nil then return true end
	local tp=c:GetControler()
	if og then return false end
	local mg=Duel.GetFieldGroup(tp,LOCATION_MZONE,0)
	local mustg=aux.GetMustBeMaterialGroup(tp,Group.CreateGroup(),tp,c,mg,REASON_XYZ)
	if mustg:GetCount()>0 or (min and min>1) then return false end
	return mg:IsExists(c511009480.ovfilter,1,nil,tp,c)
end
function c511009480.xyzop(e,tp,eg,ep,ev,re,r,rp,c,og)
	local mg=Duel.GetFieldGroup(tp,LOCATION_MZONE,0)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local g=mg:FilterSelect(tp,c511009480.ovfilter,1,1,nil,tp,c)
	local eqg=g:GetFirst():GetEquipGroup()
	c:SetMaterial(eqg)
	Duel.Overlay(c,eqg)
	Duel.Release(g,REASON_COST)
end
function c511009480.descon(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(aux.TRUE,tp,LOCATION_MZONE,0,1,e:GetHandler())
end
function c511009480.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function c511009480.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp)  end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c511009480.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c511009480.mtcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetBattledGroupCount()>0 and e:GetHandler():GetFlagEffect(511009480)~=0
end
function c511009480.mttg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local g=e:GetHandler():GetEquipGroup()
	if chkc then return g:IsContains(chkc) and chkc:IsCanBeEffectTarget(e) end
	if chk==0 then return g:IsExists(Card.IsCanBeEffectTarget,1,nil,e) end
	local sg=g:Select(tp,1,g:GetCount(),nil)
	Duel.SetTargetCard(sg)
end
function c511009480.mtfilter(c,e)
	return c:IsRelateToEffect(e) and not c:IsImmuneToEffect(e)
end
function c511009480.mtop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(c511009480.mtfilter,nil,e)
	if g:GetCount()>0 then
		Duel.Overlay(c,g)
	end
end
function c511009480.rmcon(e,tp,eg,ep,ev,re,r,rp,chk)
	local loc=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and ep~=tp
end
function c511009480.rmcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,e:GetHandler():GetOverlayGroup():GetCount(),e:GetHandler():GetOverlayGroup():GetCount(),REASON_COST)
end
function c511009480.rmfilter(c)
	return c:IsAbleToRemove()
end
function c511009480.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c511009480.filter(chkc) end
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingTarget(c511009480.rmfilter,tp,0,LOCATION_MZONE,1,nil) and c:IsAbleToRemove() end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c511009480.rmfilter,tp,0,LOCATION_MZONE,1,1,nil)
	local g2=Group.FromCards(c,g)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g2,2,0,0)
end
function c511009480.rmop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not c:IsRelateToEffect(e) or not tc:IsRelateToEffect(e) then return end
	local g=Group.FromCards(c,tc)
	local mcount=0
	if tc:IsFaceup() then mcount=tc:GetOverlayCount() end
	if Duel.Remove(g,0,REASON_EFFECT+REASON_TEMPORARY)~=0 then
		local og=Duel.GetOperatedGroup()
		if not og:IsContains(tc) then mcount=0 end
		local oc=og:GetFirst()
		while oc do
			oc:RegisterFlagEffect(93717133,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
			oc=og:GetNext()
		end
		og:KeepAlive()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetReset(RESET_PHASE+PHASE_END)
		e1:SetLabel(mcount)
		e1:SetCountLimit(1)
		e1:SetLabelObject(og)
		e1:SetOperation(c511009480.retop)
		Duel.RegisterEffect(e1,tp)
	end
end
function c511009480.retfilter(c)
	return c:GetFlagEffect(93717133)~=0
end
function c511009480.retop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	local sg=g:Filter(c511009480.retfilter,nil)
	g:DeleteGroup()
	local tc=sg:GetFirst()
	while tc do
		 Duel.ReturnToField(tc) 
		tc=sg:GetNext()
	end
end
function c511009480.checkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	
	while tc do
		if tc:IsFaceup() and bit.band(r,0x80)==0x80 then
			tc:RegisterFlagEffect(511009480,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
		end
		tc=eg:GetNext()
	end
end