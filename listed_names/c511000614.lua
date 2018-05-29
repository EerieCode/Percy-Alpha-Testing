--D－HERO Bloo－D (Anime)
--Destiny HERO - Plasma (Anime)
--fixed by Larry126
function c511000614.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(83965310,0))
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c511000614.spcon)
	e2:SetOperation(c511000614.spop)
	c:RegisterEffect(e2)
	--equip
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(83965310,1))
	e3:SetCategory(CATEGORY_EQUIP)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c511000614.eqcon)
	e3:SetTarget(c511000614.eqtg)
	e3:SetOperation(c511000614.eqop)
	c:RegisterEffect(e3)
	aux.AddEREquipLimit(c,c511000614.eqcon,function(ec,_,tp) return ec:IsControler(1-tp) end,c511000614.equipop,e3)
	--disable
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(0,LOCATION_MZONE)
	e4:SetCode(EFFECT_DISABLE)
	e4:SetCondition(c511000614.econ)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EVENT_CHAINING)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCondition(c511000614.discon)
	e5:SetOperation(c511000614.disop)
	c:RegisterEffect(e5)
end
c511000614.listed_names={100000270,100000270}
function c511000614.mzfilter(c,tp)
	return c:IsControler(tp) and c:GetSequence()<5
end
function c511000614.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local rg=Duel.GetReleaseGroup(tp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local ct=-ft+1
	return ft>-3 and rg:GetCount()>2 and (ft>0 or rg:IsExists(c511000614.mzfilter,ct,nil,tp))
end
function c511000614.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local rg=Duel.GetReleaseGroup(tp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local g=nil
	if ft>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
		g=rg:Select(tp,3,3,nil)
	elseif ft>-2 then
		local ct=-ft+1
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
		g=rg:FilterSelect(tp,c511000614.mzfilter,ct,ct,nil,tp)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
		local g2=rg:Select(tp,3-ct,3-ct,g)
		g:Merge(g2)
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
		g=rg:FilterSelect(tp,c511000614.mzfilter,3,3,nil,tp)
	end
	Duel.Release(g,REASON_COST)
end
function c511000614.eqfilter(c)
	return c:GetFlagEffect(83965310)~=0 
end
function c511000614.eqcon(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetHandler():GetEquipGroup():Filter(c511000614.eqfilter,nil)
	return g:GetCount()==0
end
function c511000614.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsAbleToChangeControler() end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(Card.IsAbleToChangeControler,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,Card.IsAbleToChangeControler,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,g,1,0,0)
end
function c511000614.equipop(c,e,tp,tc)
	local atk=tc:GetTextAttack()/2
	if tc:IsFacedown() then atk=0 end
	if atk<0 then atk=0 end
	if not aux.EquipByEffectAndLimitRegister(c,e,tp,tc,511000614) then return end
	if atk>0 then
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_EQUIP)
		e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_OWNER_RELATE)
		e2:SetCode(EFFECT_UPDATE_ATTACK)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		e2:SetValue(atk)
		tc:RegisterEffect(e2)
	end
	if tc:IsFaceup() then
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e3:SetCode(EVENT_ADJUST)
		e3:SetRange(0x7f)
		e3:SetOperation(c511000614.op)
		tc:RegisterEffect(e3)
	end
end
function c511000614.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		if c:IsFaceup() and c:IsRelateToEffect(e) then
			c511000614.equipop(c,e,tp,tc)
		else Duel.SendtoGrave(tc,REASON_EFFECT) end
	end
end
function c511000614.econ(e)
	local g=Duel.GetDecktopGroup(e:GetHandlerPlayer(),1)
	return g:GetCount()>0 and g:GetFirst():IsCode(100000270) and g:GetFirst():IsFaceup()
end
function c511000614.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local eq=c:GetEquipTarget()
	local o=e:GetOwner()
	local code=c:GetOriginalCode()
	if eq==o and eq:IsFaceup() and eq:GetFlagEffect(code)==0 and not eq:IsDisabled() then
		local cid=eq:CopyEffect(code,RESET_EVENT+0x1fe0000,1)
		eq:RegisterFlagEffect(code,RESET_EVENT+0x1fe0000,0,1)
		e:SetLabel(cid)
	end 
	if not eq or o~=eq or eq:IsDisabled() then
		local cid=e:GetLabel()
		o:ResetEffect(cid,RESET_COPY)
	end
	if not eq or o~=eq then
		e:Reset()
	end
end
function c511000614.dfilter(c,tp)
	return c:IsControler(tp) and c:IsLocation(LOCATION_ONFIELD)
end
function c511000614.discon(e,tp,eg,ep,ev,re,r,rp)
	local dc=Duel.GetDecktopGroup(tp,1):GetFirst()
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)	
	return dc and dc:IsCode(100000270) and dc:IsFaceup()
		and re:IsActiveType(TYPE_SPELL+TYPE_TRAP) and rp~=tp
		and re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) and g and g:IsExists(c511000614.dfilter,1,nil,tp)
end
function c511000614.disop(e,tp,eg,ep,ev,re,r,rp)
	local rc=re:GetHandler()
	if ((re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.NegateActivation(ev))
		or (not re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.NegateEffect(ev)))
		and rc:IsRelateToEffect(re) then
		Duel.Destroy(rc,REASON_EFFECT)
	end
end