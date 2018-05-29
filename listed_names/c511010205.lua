--CNo.5 亡朧龍カオス・キマイラ・ドラゴン (Anime)
--fixed by MLD
function c511010205.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,6,3,nil,nil,99)
	c:EnableReviveLimit()
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c511010205.atkval)
	c:RegisterEffect(e1)
	--cannot attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_ATTACK)
	e2:SetCondition(c511010205.atcon)
	c:RegisterEffect(e2)
	--multiple attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_EXTRA_ATTACK)
	e3:SetValue(c511010205.atkct)
	c:RegisterEffect(e3)
	--banish
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_REMOVE)
	e4:SetDescription(aux.Stringid(612115,0))
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCost(c511010205.atkcost)
	e4:SetCondition(c511010205.atkcon)
	e4:SetTarget(c511010205.atktg)
	e4:SetOperation(c511010205.atkop)
	c:RegisterEffect(e4,false,1)
	--halve atk
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EVENT_ATTACK_ANNOUNCE)
	e5:SetCondition(c511010205.atkregcon)
	e5:SetOperation(c511010205.atkregop)
	c:RegisterEffect(e5)
	--back to deck
	local e6=Effect.CreateEffect(c)
	e6:SetCategory(CATEGORY_TODECK)
	e6:SetDescription(aux.Stringid(2772236,0))
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e6:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e6:SetCountLimit(1)
	e6:SetLabelObject(e4)
	e6:SetRange(LOCATION_MZONE)
	e6:SetTarget(c511010205.tdtg)
	e6:SetOperation(c511010205.tdop)
	c:RegisterEffect(e6)
	--reattach
	local e8=Effect.CreateEffect(c)
	e8:SetDescription(aux.Stringid(14005031,0))
	e8:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e8:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e8:SetRange(LOCATION_MZONE)
	e8:SetCondition(c511010205.matcon)
	e8:SetCost(c511010205.matcost)
	e8:SetTarget(c511010205.mattg)
	e8:SetOperation(c511010205.matop)
	c:RegisterEffect(e8)
	--Rank Up Check
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e9:SetCode(EVENT_SPSUMMON_SUCCESS)
	e9:SetCondition(c511010205.rankupregcon)
	e9:SetOperation(c511010205.rankupregop)
	c:RegisterEffect(e9)
	--battle indestructable
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_SINGLE)
	e10:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e10:SetValue(aux.NOT(aux.TargetBoolFunction(Card.IsSetCard,0x48)))
	c:RegisterEffect(e10)
	aux.CallToken(69757518)
end
c511010205.listed_names={90126061}
c511010205.xyz_number=5
function c511010205.atkval(e,c)
	return c:GetOverlayCount()*1000
end
function c511010205.atcon(e)
	return e:GetHandler():GetFlagEffect(511010205)==0
end
function c511010205.atkct(e,c)
	return e:GetHandler():GetFlagEffect(511010205)-1
end
function c511010205.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511010205.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<PHASE_BATTLE 
		and not e:GetHandler():IsStatus(STATUS_CHAINING)
end
function c511010205.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,0,LOCATION_DECK,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,tp,LOCATION_DECK)
end
function c511010205.atkop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,0,LOCATION_DECK,nil):RandomSelect(tp,1)
	if Duel.Remove(g,POS_FACEUP,REASON_EFFECT)>0 then
		g:GetFirst():RegisterFlagEffect(5110205,RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END,0,0)
		local c=e:GetHandler()
		if c:IsRelateToEffect(e) and c:IsFaceup() then
			c:RegisterFlagEffect(511010205,RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_BATTLE,0,0)
		end
	end
end
function c511010205.atkregcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()==nil
end
function c511010205.atkregop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL)
	e1:SetCondition(c511010205.halfcon)
	e1:SetValue(c511010205.halfval)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE)
	c:RegisterEffect(e1)
end
function c511010205.halfcon(e)
	return Duel.GetCurrentPhase()==PHASE_DAMAGE_CAL
end
function c511010205.halfval(e,c)
	return math.ceil(c:GetAttack()/2)
end
function c511010205.tdfilter(c,te)
	return c:IsAbleToDeck() and c:GetFlagEffect(5110205)~=0 and c:GetReasonEffect()==te
end
function c511010205.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local te=e:GetLabelObject()
	if chk==0 then return Duel.IsExistingMatchingCard(c511010205.tdfilter,tp,0,LOCATION_REMOVED,1,nil,te) end
	local g=Duel.GetMatchingGroup(c511010205.tdfilter,tp,0,LOCATION_REMOVED,nil,te)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
end
function c511010205.tdop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c511010205.tdfilter,tp,0,LOCATION_REMOVED,nil,e:GetLabelObject())
	local ct=Duel.SendtoDeck(g,nil,0,REASON_EFFECT)
	if ct>0 then
		Duel.SortDecktop(tp,1-tp,ct)
		g:ForEach(function(tc)
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_FORBIDDEN)
			tc:RegisterEffect(e1)
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_CANNOT_USE_AS_COST)
			tc:RegisterEffect(e2)
		end)
	end
end
function c511010205.matcon(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c511010205.matcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.PayLPCost(tp,math.floor(Duel.GetLP(tp)/2))
end
function c511010205.matfilter(c,tc,tid)
	return c:GetPreviousLocation()&LOCATION_OVERLAY~=0 and c:GetReasonEffect() and c:GetReasonEffect():GetHandler()==tc and c:GetTurnID()==tid-1
end
function c511010205.mattg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tid=Duel.GetTurnCount()
	if Duel.GetTurnPlayer()==tp then tid=tid-1 end
	if chk==0 then return Duel.IsExistingMatchingCard(c511010205.matfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil,e:GetHandler(),tid) end
	local g=Duel.GetMatchingGroup(c511010205.matfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,nil,e:GetHandler(),tid)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g,g:GetCount(),tp,0)
end
function c511010205.matop(e,tp,eg,ep,ev,re,r,rp)
	local tid=Duel.GetTurnCount()
	if Duel.GetTurnPlayer()==tp then tid=tid-1 end
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c511010205.matfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,nil,c,tid)
	if c:IsRelateToEffect(e) then
		Duel.Overlay(c,g)
	end
end
function c511010205.rumfilter(c)
	return c:IsCode(90126061) and not c:IsPreviousLocation(LOCATION_OVERLAY)
end
function c511010205.rankupregcon(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():GetFlagEffect(511015134)~=0 then return true end
	local rc=re:GetHandler()
	return e:GetHandler():IsSummonType(SUMMON_TYPE_XYZ) and re and (rc:IsSetCard(0x95) or rc:IsCode(100000581,111011002,511000580,511002068,511002164,93238626))
		and e:GetHandler():GetMaterial() and e:GetHandler():GetMaterial():IsExists(c511010205.rumfilter,1,nil)
end
function c511010205.rankupregop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--material
	local e9=Effect.CreateEffect(c)
	e9:SetDescription(aux.Stringid(12744567,0))
	e9:SetType(EFFECT_TYPE_IGNITION)
	e9:SetRange(LOCATION_MZONE)
	e9:SetCountLimit(1)
	e9:SetTarget(c511010205.ovtg)
	e9:SetOperation(c511010205.ovop)
	e9:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e9)
end
function c511010205.ovtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,LOCATION_HAND,0,1,nil) end
end
function c511010205.ovop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local g=Duel.SelectMatchingCard(tp,aux.TRUE,tp,LOCATION_HAND,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.Overlay(c,g)
	end
end
