--World Dino Wrestling
--anime version scripted by Larry196, updates by Naim
--missing the graveyard effect for now
function c101006054.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--attack limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetCondition(c101006054.atkcon1)
	e2:SetTarget(c101006054.atktg1)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetCode(EVENT_ATTACK_ANNOUNCE)
	e3:SetRange(LOCATION_FZONE)
	e3:SetOperation(c101006054.checkop)
	e3:SetLabelObject(e2)
	c:RegisterEffect(e3)
	--atk up
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_UPDATE_ATTACK)
	e4:SetRange(LOCATION_FZONE)
	e4:SetTargetRange(LOCATION_MZONE,0)
	e4:SetTarget(c101006054.atktg2)
	e4:SetCondition(c101006054.atkcon2)
	e4:SetValue(200)
	c:RegisterEffect(e4)
end
function c101006054.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x580)
end
function c101006054.atkcon1(e,tp)
	return e:GetHandler():GetFlagEffect(101006054)~=0 and Duel.IsExistingMatchingCard(c101006054.filter,tp,LOCATION_MZONE,0,1,nil)
end
function c101006054.atktg1(e,c)
	return c:GetFieldID()~=e:GetLabel()
end
function c101006054.checkop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():GetFlagEffect(101006054)~=0 then return end
	local fid=eg:GetFirst():GetFieldID()
	e:GetHandler():RegisterFlagEffect(101006054,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
	e:GetLabelObject():SetLabel(fid)
end
function c101006054.atktg2(e,c)
	return c:IsSetCard(0x580) and Duel.GetAttacker()==c
end
function c101006054.atkcon2(e)
	return Duel.GetCurrentPhase()==PHASE_DAMAGE_CAL and Duel.GetAttackTarget()~=nil
end
