--Multiplication of Ants (Manga)
function c511018004.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511018004.target)
	e1:SetOperation(c511018004.operation)
	c:RegisterEffect(e1)
end
c511018004.listed_names={511002428}
function c511018004.filter(c)
	return c:IsCode(511002428) and c:IsPosition(POS_ATTACK)
end
function c511018004.target(e,tp,eg,ev,ep,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(c511018004.filter,tp,LOCATION_MZONE,0,1,nil) end
	local tc=Duel.SelectMatchingCard(tp,c511018004.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetTargetCard(tc)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,0,Duel.GetLocationCount(tp,LOCATION_MZONE),0,0)
end
function c511018004.operation(e,tp,eg,ev,ep,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) or Duel.GetLocationCount(tp,LOCATION_MZONE)<=-1 then return end
	Duel.SendtoGrave(tc,REASON_RULE)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local g=Group.CreateGroup()
	g:KeepAlive()
	for i=1,ft do
		local tk=Duel.CreateToken(tp,511018005)
		if Duel.MoveToField(tk,tp,tp,LOCATION_MZONE,POS_FACEUP,true) then
			g:AddCard(tk)
		end
	end
	tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		tc:RegisterFlagEffect(511018004,RESET_EVENT+0x1fe0000,0,1)
		tc=g:GetNext()
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetLabelObject(g)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetCondition(c511018004.descon)
	e1:SetOperation(c511018004.desop)
	Duel.RegisterEffect(e1,tp)
end
function c511018004.descon(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	local c=g:GetFirst()
	local dg=Group.CreateGroup()
	while c do
		if c:GetFlagEffect(511018004)~=0 then dg:AddCard(c) end
		c=g:GetNext()
	end
	if dg:GetCount()>0 then
		return true
	else
		e:Reset()
		g:DeleteGroup()
		return false
	end
end
function c511018004.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	local c=g:GetFirst()
	local dg=Group.CreateGroup()
	while c do
		if c:GetFlagEffect(511018004)~=0 then dg:AddCard(c) end
		c=g:GetNext()
	end
	Duel.Destroy(dg,REASON_EFFECT)
end
--[[
	http://yugioh.wikia.com/wiki/Multiplication_of_Ants_(manga)
	Multiplication of Ants 22493811
	soldier ari 511002428
	army ant 22493812
	army ant (anime) 511018005
--]]
