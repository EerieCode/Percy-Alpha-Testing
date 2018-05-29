--アポピスの化神
--fixed by MLD
function c511777009.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511777009.condition)
	e1:SetTarget(c511777009.target)
	e1:SetOperation(c511777009.activate)
	c:RegisterEffect(e1)
end
c511777009.listed_names={38033121}
function c511777009.cfilter(c)
	return c:IsFaceup() and c:IsCode(38033121)
end
function c511777009.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511777009.cfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
end
function c511777009.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
end
function c511777009.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.MoveToField(c,tp,tp,LOCATION_MZONE,POS_FACEUP,true) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_RACE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(RACE_SPELLCASTER)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e1,true)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_CHANGE_ATTRIBUTE)
		e2:SetValue(ATTRIBUTE_DARK)
		c:RegisterEffect(e2,true)
		local e3=e1:Clone()
		e3:SetCode(EFFECT_CHANGE_LEVEL)
		e3:SetValue(7)
		c:RegisterEffect(e3,true)
		local e4=e1:Clone()
		e4:SetCode(EFFECT_SET_ATTACK)
		e4:SetValue(2500)
		c:RegisterEffect(e4,true)
		local e5=e1:Clone()
		e5:SetCode(EFFECT_SET_DEFENSE)
		e5:SetValue(2100)
		c:RegisterEffect(e5,true)
		local e6=e1:Clone()
		e6:SetCode(EFFECT_CHANGE_CODE)
		e6:SetValue(46986414)
		c:RegisterEffect(e6,true)
		local e7=e1:Clone()
		e7:SetCode(EFFECT_ADD_TYPE)
		e7:SetValue(TYPE_MONSTER)
		c:RegisterEffect(e7,true)
		local fid=c:GetFieldID()
		c:RegisterFlagEffect(51177709,RESET_EVENT+0x1fe0000,0,1,fid)
		local e8=Effect.CreateEffect(c)
		e8:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e8:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e8:SetCode(EVENT_PHASE+PHASE_END)
		e8:SetCountLimit(1)
		e8:SetLabel(fid)
		e8:SetLabelObject(c)
		e8:SetCondition(c511777009.tgcon)
		e8:SetOperation(c511777009.tgop)
		e8:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e8,tp)
		c:SetStatus(STATUS_FORM_CHANGED,true)
	end
end
function c511777009.tgcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:GetFlagEffectLabel(51177709)==e:GetLabel() then
		return true
	else
		e:Reset()
		return false
	end
end
function c511777009.tgop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	Duel.SendtoGrave(tc,REASON_EFFECT)
end
