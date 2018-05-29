--Glass Slippers
function c511000433.initial_effect(c)
	aux.AddEquipProcedure(c,nil,c511000433.filter)
	--change equip
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511000433,0))
	e3:SetCategory(CATEGORY_EQUIP)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLE_DAMAGE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c511000433.eqcon)
	e3:SetTarget(c511000433.eqtg)
	e3:SetOperation(c511000433.eqop)
	c:RegisterEffect(e3)
	--Atk up
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_EQUIP)
	e4:SetCode(EFFECT_UPDATE_ATTACK)
	e4:SetValue(-1000)
	e4:SetCondition(c511000433.atkcon)
	c:RegisterEffect(e4)
	--at limit
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_EQUIP)
	e5:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e5:SetCondition(c511000433.atkcon)
	e5:SetValue(aux.TargetBoolFunction(Card.IsCode,511000431))
	c:RegisterEffect(e5)
	--reequip to Cinderella
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(511000433,2))
	e6:SetCategory(CATEGORY_EQUIP)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e6:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e6:SetCode(EVENT_TO_GRAVE)
	e6:SetCondition(c511000433.eqcon2)
	e6:SetTarget(c511000433.eqtg2)
	e6:SetOperation(c511000433.eqop)
	c:RegisterEffect(e6)
end
c511000433.listed_names={511000431,511000431}
function c511000433.filter(c,e,tp)
	return c:IsCode(511000431) or c:GetControler()~=tp
end
function c511000433.eqcon(e,tp,eg,ep,ev,re,r,rp)
	local eq=e:GetHandler():GetEquipTarget()
	return ep~=tp and eq and eq:IsCode(511000431) and eg:GetFirst()==eq
end
function c511000433.atkcon(e)
	local ec=e:GetHandler():GetEquipTarget()
	return ec and ec:IsControler(1-e:GetHandlerPlayer())
end
function c511000433.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(511000433,1))
	Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c511000433.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.Equip(tp,c,tc)
	else
		Duel.SendtoGrave(c,REASON_EFFECT) 
	end
end
function c511000433.eqcon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_LOST_TARGET) and e:GetHandler():GetPreviousEquipTarget():IsReason(REASON_DESTROY)
		and e:GetHandler():GetPreviousEquipTarget():GetPreviousControler()~=tp
end
function c511000433.eqtg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511000433.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511000433.filter,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(511000433,1))
	Duel.SelectTarget(tp,c511000433.filter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
