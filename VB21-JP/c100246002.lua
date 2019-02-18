--Salamangreat Coyote
function s.initial_effect(c)
	--to grave
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EVENT_BE_MATERIAL)
	e1:SetOperation(s.regop)
	c:RegisterEffect(e1)
end
function s.regcon(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_LINK
end
function s.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsReason(REASON_LINK) then
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(id,0))
		e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SPECIAL_SUMMON)
		e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetRange(LOCATION_GRAVE)
		e1:SetTarget(s.target)
		e1:SetOperation(s.operation)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
function s.spfilter(c,e,tp)
	return c:IsSetCard(0x119) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
end
function s.thfilter(c)
	return c:IsSetCard(0x119) and c:IsAbleToHand()
end

function s.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and s.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c64245689.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) 
		or Duel.IsExistingTarget(s.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	local op=0
	if Duel.IsExistingTarget(c64245689.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) 
		and Duel.IsExistingTarget(s.thfilter,tp,LOCATION_GRAVE,0,1,nil) then
		op=Duel.SelectOption(tp,aux.Stringid(id,1),aux.Stringid(id,2))
	elseif Duel.IsExistingTarget(c64245689.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp)  then
		Duel.SelectOption(tp,aux.Stringid(id,2))
		op=1
	else
		Duel.SelectOption(tp,aux.Stringid(id,1))
		op=0
	end
	e:SetLabel(op)
	if op==0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectTarget(tp,s.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectTarget(tp,c64245689.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
	end
end
function s.operation(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabel()==0 then
		local tc=Duel.GetFirstTarget()
		if tc and tc:IsRelateToEffect(e) then
			Duel.SendtoHand(tc,nil,REASON_EFFECT)
		end
	else
		local tc=Duel.GetFirstTarget()
		if tc:IsRelateToEffect(e) then
			Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
		end
	end
end
