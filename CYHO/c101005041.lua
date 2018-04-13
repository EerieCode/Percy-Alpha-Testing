--Voritcular Drumgon
function c101005041.initial_effect(c)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(101005041,1))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetTarget(c101005041.drtg)
	e2:SetOperation(c101005041.drop)
	c:RegisterEffect(e2)
	
	--disable field
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_DISABLE_FIELD)
	--thanks fluo for hardcoding our day
	e4:SetCondition(function(e)if not e:GetValue() then e:SetValue(c101005041.disop) end return true end)
	e4:SetValue(c101005041.disop)
	c:RegisterEffect(e4)
end

function c101005041.drcon(e,tp,eg,ep,ev,re,r,rp)
	return not eg:IsContains(e:GetHandler()) and eg:IsExists(c101005041.cfilter,1,nil,tp)
end
function c101005041.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c101005041.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
	e:GetHandler():ResetFlagEffect(34294855)
end

function c101005041.disop(e)
	local c=e:GetHandler()
	local flag=c:GetLinkedZone()
	return flag and c:GetFlagEffect(101005041)~=0
end
