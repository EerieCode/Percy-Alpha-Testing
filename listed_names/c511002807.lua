--スターダスト・シャオロン
function c511002807.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_SPSUM_PARAM+EFFECT_FLAG_UNCOPYABLE)
	e1:SetTargetRange(POS_FACEUP_ATTACK,0)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(c511002807.spcon)
	c:RegisterEffect(e1)
end
c511002807.listed_names={44508094}
function c511002807.filter(c)
	return c:IsFaceup() and c:IsCode(44508094)
end
function c511002807.spcon(e,c)
	if c==nil then return true end
	local eff={c:GetCardEffect(EFFECT_NECRO_VALLEY)}
	for _,te in ipairs(eff) do
		local op=te:GetOperation()
		if not op or op(e,c) then return false end
	end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0 and
		Duel.IsExistingMatchingCard(c511002807.filter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
