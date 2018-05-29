--ジャンク・ウォリアー
--fixed by MLD
function c511009416.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,c511009416.tfilter,1,1,aux.NonTuner(nil),1,99)
	c:EnableReviveLimit()
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetCondition(c511009416.con)
	e1:SetValue(c511009416.value)
	c:RegisterEffect(e1)
end
c511009416.listed_names={63977008}
c511009416.material_setcode=0x17
function c511009416.tfilter(c)
	return c:IsCode(63977008) or c:IsHasEffect(20932152)
end
function c511009416.con(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SYNCHRO)
end
function c511009416.filter(c)
	return c:IsFaceup() and c:IsLevelBelow(2)
end
function c511009416.value(e,c)
	local atk=0
	local g=Duel.GetMatchingGroup(c511009416.filter,c:GetControler(),LOCATION_MZONE,0,c)
	local tc=g:GetFirst()
	while tc do
		atk=atk+tc:GetAttack()
		tc=g:GetNext()
	end
	return atk
end
