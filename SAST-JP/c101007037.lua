--ヴァレルロード・S・ドラゴン
--Borreload Savage Dragon
--Scripted by AlphaKretin
function c101007037.initial_effect(c)
	c:EnableCounterPermit(0x147)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,1,1,aux.NonTuner(nil),1,99)
	c:EnableReviveLimit()
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetDescription(aux.Stringid(101007037,0))
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCondition(c101007037.eqcon)
	e1:SetTarget(c101007037.eqtg)
	e1:SetOperation(c101007037.eqop)
	c:RegisterEffect(e1)
	aux.AddEREquipLimit(c,nil,c101007037.eqval,c101007037.equipop,e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_SET_ATTACK)
	e2:SetCondition(c101007037.atkcon)
	e2:SetValue(c101007037.atkval)
	c:RegisterEffect(e2)
end
function c101007037.eqval(ec,c,tp)
	return ec:IsControler(tp) and (ec:GetOriginalType()&TYPE_LINK==TYPE_LINK)
end
function c101007037.filter(c)
	return c:IsType(TYPE_LINK) and not c:IsForbidden()
end
function c101007037.eqcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SYNCHRO)
end
function c101007037.eqtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingMatchingCard(c101007037.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,nil,1,tp,LOCATION_GRAVE)
end
function c101007037.equipop(c,e,tp,tc)
	return aux.EquipByEffectAndLimitRegister(c,e,tp,tc,101007037,true)
end
function c101007037.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	if c:IsFacedown() or not c:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c101007037.filter),tp,LOCATION_GRAVE,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		local link=tc:GetLink() --workaround for no GetOriginalLink
		if c101007037.equipop(c,e,tp,tc) then
			c:AddCounter(0x147,link)
		end
	end
end
function c101007037.eqfilter(c)
	return c:GetFlagEffect(101007037)~=0 
end
function c101007037.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=c:GetEquipGroup():Filter(c101007037.eqfilter,nil)
	return g:GetCount()>0
end
function c101007037.atkval(e,c)
	local c=e:GetHandler()
	local g=c:GetEquipGroup():Filter(c101007037.eqfilter,nil)
	local atk=0
	for tc in aux.Next(g) do
		if tc:IsFaceup() and tc:GetOriginalType()&TYPE_MONSTER==TYPE_MONSTER and tc:GetTextAttack()>0 then
			atk+=Math.floor(tc:GetTextAttack()/2)
		end
	end
	return atk
end
