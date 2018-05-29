--Winged Kuriboh LV9 (Manga)
--fixed by MLD
function c511018000.initial_effect(c)
	--cannot be special summoned
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c511018000.splimit)
	c:RegisterEffect(e1)
	--atk & def decreased cause pochyena
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SET_ATTACK)
	e2:SetValue(c511018000.vatk)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_SET_DEFENSE)
	e3:SetValue(c511018000.vdef)
	c:RegisterEffect(e3)
	--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(511018000,1))
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_PHASE+PHASE_END)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetCondition(c511018000.descon)
	e4:SetTarget(c511018000.destg)
	e4:SetOperation(c511018000.desop)
	c:RegisterEffect(e4)
end
c511018000.listed_names={100000246,100000246}
function c511018000.splimit(e,se,sp,st)
	return se and se:GetHandler():IsCode(100000246)
end
function c511018000.filter(c)
	return c:GetReasonEffect() and c:GetReasonEffect():GetOwner():IsCode(100000246)
end
function c511018000.vatk(e,c)
	local g=Duel.GetMatchingGroup(c511018000.filter,0,LOCATION_REMOVED,LOCATION_REMOVED,nil)
	return rg:GetSum(Card.GetAttack)
end
function c511018000.vdef(e,c)
	local g=Duel.GetMatchingGroup(c511018000.filter,0,LOCATION_REMOVED,LOCATION_REMOVED,nil)
	return rg:GetSum(Card.GetDefense)
end
function c511018000.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsStatus(STATUS_SUMMON_TURN+STATUS_FLIP_SUMMON_TURN+STATUS_SPSUMMON_TURN)
end
function c511018000.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c511018000.desop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.Destroy(e:GetHandler(),REASON_EFFECT)
	end
end
