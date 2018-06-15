--マイクロ・コーダー
--Micro Coder
--extra matrial only by edo9300
function c100334004.lua.initial_effect(c)
	--Extra Material
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EFFECT_EXTRA_MATERIAL)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetOperation(c100334004.extracon)
	e1:SetValue(c100334004.extraval)
	c:RegisterEffect(e1)
end
function c100334004.extracon(c,e,tp,sg,mg,lc,og,chk)
	return (sg+mg):Filter(Card.IsLocation,nil,LOCATION_MZONE):IsExists(Card.IsRace,og,1,RACE_CYBERSE) and
	#(sg&sg:Filter(c100334004.flagcheck,nil))<2
end
function c100334004.flagcheck(c)
	return c:GetFlagEffect(100334004)>0
end
function c100334004.extraval(chk,summon_type,e,...)
	local c=e:GetHandler()
	if chk==0 then
		local tp,sc=...
		if not summon_type==SUMMON_TYPE_LINK or not sc:IsSetCard(0x101) or Duel.GetFlagEffect(tp,100334004)>0 then
			return Group.CreateGroup()
		else
			local feff=c:RegisterFlagEffect(100334004,0,0,1)
			local eff=Effect.CreateEffect(c)
			eff:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			eff:SetCode(EVENT_ADJUST)
			eff:SetOperation(function(e)feff:Reset() e:Reset() end)
			Duel.RegisterEffect(eff,0)
			return Group.FromCards(c)
		end
	else
		if summon_type==SUMMON_TYPE_LINK then
			local sg,sc,tp=...
			Duel.RegisterFlagEffect(tp,100334004,RESET_PHASE+PHASE_END,0,1)
		end
	end
end
