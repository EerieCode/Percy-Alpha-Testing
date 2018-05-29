--Elemental HERO Terra Firma
--fixed by MLD
function c511023013.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcMix(c,true,true,37195861,75434695)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511023013,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c511023013.atkcost)
	e1:SetOperation(c511023013.atkop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(aux.FALSE)
	c:RegisterEffect(e2)
	e1:SetLabelObject(e2)
end
c511023013.listed_names={74711057}
c511023013.material_setcode={0x8,0x3008}
function c511023013.cfilter(c,tp)
	return c:IsSetCard(0x3008) and Duel.IsExistingMatchingCard(c511023013.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,c)
end
function c511023013.filter(c)
	return c:IsFaceup() and c:IsCode(74711057)
end
function c511023013.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroupCost(tp,c511023013.cfilter,1,false,nil,nil,tp) end
	local g=Duel.SelectReleaseGroupCost(tp,c511023013.cfilter,1,1,false,nil,nil,tp)
	e:SetLabel(g:GetFirst():GetAttack())
	e:GetLabelObject():SetLabel(g:GetFirst():GetDefense())
	Duel.Release(g,REASON_COST)
end
function c511023013.atkop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511023013.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(e:GetLabel())
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		e2:SetValue(e:GetLabelObject():GetLabel())
		tc:RegisterEffect(e2)
		tc=g:GetNext()
	end
end
