--Cyber Roar
function c511002287.initial_effect(c)
	aux.AddEquipProcedure(c,nil,aux.FilterBoolFunction(Card.IsSetCard,0x93),nil,nil,c511002287.tg,c511002287.op)
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(300)
	c:RegisterEffect(e2)
end
c511002287.listed_names={70095154,70095154}
function c511002287.tg(e,tp,eg,ep,ev,re,r,rp,tc)
	e:SetCategory(CATEGORY_EQUIP+CATEGORY_DRAW)
	if tc:IsCode(70095154) then
		Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
	end
end
function c511002287.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc and tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsCode(70095154) then
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
