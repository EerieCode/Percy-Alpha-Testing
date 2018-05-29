--Electrode Beast Anion
--fixed by MLD
function c511008506.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511008506,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetRange(LOCATION_GRAVE+LOCATION_HAND+LOCATION_REMOVED+LOCATION_EXTRA)
	e1:SetCode(EVENT_LEAVE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCondition(c511008506.drcon)
	e1:SetTarget(c511008506.drtg)
	e1:SetOperation(c511008506.drop)
	c:RegisterEffect(e1)
end
c511008506.listed_names={511008507}
function c511008506.cfilter(c)
	return c:IsCode(511008507) and c:IsPreviousLocation(LOCATION_ONFIELD)
end
function c511008506.drcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD) and eg:IsExists(c511008506.cfilter,1,e:GetHandler())
end
function c511008506.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c511008506.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
