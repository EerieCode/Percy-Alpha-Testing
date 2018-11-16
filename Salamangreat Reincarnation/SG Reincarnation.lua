CARD_SALAMANGREAT_SANCTUARY =1295111
function Card.IsReincarnationSummoned(c)
	return c:GetFlagEffect(CARD_SALAMANGREAT_SANCTUARY)~=0
end
function Auxiliary.EnableCheckReincarnation(c)
	if not c1295111.global_check then
		c1295111.global_check=true
        local e1=Effect.GlobalEffect()
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_MATERIAL_CHECK)
        e1:SetValue(Auxiliary.ReincarnationCheckValue)
        local ge1=Effect.GlobalEffect()
        ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
        ge1:SetLabelObject(e1)
        ge1:SetTargetRange(0xff,0xff)
        ge1:SetTarget(Auxiliary.ReincarnationCheckTarget)
        Duel.RegisterEffect(ge1,0)
	end
end
function Auxiliary.ReincarnationCheckTarget(e,c)
	return c:IsType(TYPE_FUSION+TYPE_RITUAL+TYPE_LINK)
end
function Auxiliary.ReincarnationRitualFilter(c,id,tp)
	return c:IsCode(id) and c:IsControler(tp) and c:IsLocation(LOCATION_MZONE)
end
function Auxiliary.ReincarnationCheckValue(e,c)
	local g=c:GetMaterial()
	local id=c:GetID()
	local rc=false
	if c:IsType(TYPE_LINK) then
		rc=g:IsExists(Card.IsLinkCode,1,nil,id)
	elseif c:IsType(TYPE_FUSION) then
		rc=g:IsExists(Card.IsFusionCode,1,nil,id)
	elseif c:IsType(TYPE_RITUAL) then
		rc=g:IsExists(Aux.ReincarnationRitualFilter,1,nil,id,c:GetControler())
	end
	if rc then
		c:RegisterFlagEffect(CARD_SALAMANGREAT_SANCTUARY,RESET_EVENT+RESETS_STANDARD-RESET_TOFIELD-RESET_LEAVE-RESET_TEMP_REMOVE,0,1)
	end
end
