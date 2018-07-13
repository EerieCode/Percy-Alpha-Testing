--Parallel Panzer
function c101006066.initial_effect(c)
	aux.AddEquipProcedure(c,nil,aux.FilterBoolFunction(Card.IsType,TYPE_LINK))
	--move to a zone it point
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c101006066.mtarget)
	e1:SetOperation(c101006066.moperation)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCountLimit(1,101006066)
	e2:SetCondition(c101006066.dcondition)
	e2:SetTarget(c101006066.dtarget)
	e2:SetOperation(c101006066.doperation)
	c:RegisterEffect(e2)
end
function c101006066.mtarget(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local ec=c:GetEquipTarget()
	if chk==0 then
		if not ec then return false end
		local p=ec:GetControler()
		local zone=ec:GetLinkedZone()&0x1f
		return Duel.GetLocationCount(p,LOCATION_MZONE,p,LOCATION_REASON_CONTROL,zone)>0
	end
end
function c101006066.moperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ec=c:GetEquipTarget()
	if not ec then return end
	local p=ec:GetControler()
	local zone=ec:GetLinkedZone()&0x1f
	if Duel.GetLocationCount(p,LOCATION_MZONE,p,LOCATION_REASON_CONTROL,zone)>0 then
		local i=0
		if not ec:IsControler(tp) then i=16 end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOZONE)
		local nseq=math.log(Duel.SelectDisableField(tp,1,LOCATION_MZONE,LOCATION_MZONE,~(zone<<i)),2) - i
		Duel.MoveSequence(ec,nseq)
	end
end
function c101006066.dcondition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:GetPreviousLocation()==LOCATION_SZONE and not c:IsReason(REASON_LOST_TARGET)
end
function c101006066.filter(c,g)
	return g:IsContains(c)
end
function c101006066.dtarget(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local ec=c:GetPreviousEquipTarget()
	if chk==0 then
		if not ec then return false end
		e:SetLabelObject(ec)
		return Duel.IsExistingMatchingCard(c101006066.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil,ec:GetColumnGroup())
	end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,ec:GetColumnGroup(),1,0,0)
end
function c101006066.doperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ec=e:GetLabelObject()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local dg=Duel.SelectMatchingCard(tp,c101006066.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil,ec:GetColumnGroup())
	Duel.Destroy(dg,REASON_EFFECT)
end
