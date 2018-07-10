--クマモール
--Bearrier
function c101006029.initial_effect(c)
	--cannot destroy s/t
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c101006029.condition)
	e1:SetTargetRange(LOCATION_SZONE,0)
	e1:SetTarget(c101006029.target1)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--rage buff
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetDescription(aux.Stringid(101006029,0))
	e2:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetCondition(c101006029.atkcon)
	e2:SetOperation(c101006029.atkop)
	c:RegisterEffect(e2)
end
function c101006029.condition(e,tp)
	return Duel.GetTurnPlayer()~=e:GetHandlerPlayer()
end
function c101006029.target1(e,c)
	return c:IsFacedown()
end
function c101006029.filter(c,tp)
	return c:IsPreviousLocation(LOCATION_SZONE) and c:IsPreviousPosition(POS_FACEDOWN) and c:GetPreviousControler()==tp
end
function c101006029.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c101006029.filter,1,nil,tp) and rp~=tp
end
function c101006029.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		e1:SetValue(800)
		c:RegisterEffect(e1)
	end
end
