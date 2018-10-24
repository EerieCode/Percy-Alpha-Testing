--掃射特攻
--Blitzkrieg Bombardment
--Logical Nonsense - first effect by DyXel

--Substitute ID
local s,id=GetID()

function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Detach materials to destroy, fast effect
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCost(s.cost)
	e2:SetTarget(s.target)
	e2:SetOperation(s.activate)
	c:RegisterEffect(e2)
	--Inflict damage if machine Xyz is destroyed, optional trigger
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,0))
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCost(s.damcost)
	e3:SetCondition(s.damcon)
	e3:SetTarget(s.damtg)
	e3:SetOperation(s.damop)
	c:RegisterEffect(e3)
end
function s.XyzMachineFilter(c)
    return c:IsFaceup() and c:IsRace(RACE_MACHINE) and c:IsType(TYPE_XYZ) and c:GetOverlayCount()>=1
end
function s.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
    -- Check if there are valid Xyz Machines to pay cost (deatach monsters)
    local xyzMachineMonsters = Duel.GetMatchingGroup(s.XyzMachineFilter, tp, LOCATION_MZONE, 0, nil)
    if chk==0 then return #xyzMachineMonsters == 0 end
    -- Select Xyz monsters to deattach from and sum all deatached materials
    local selectedXyz = Group.Select(xyzMachineMonsters, tp, 1, #xyzMachineMonsters, nil)
    local totalTargets = 0
    local maxTargets = Duel.GetMatchingGroup(aux.TRUE, tp, LOCATION_ONFIELD, LOCATION_ONFIELD, e:GetHandler()):GetCount()
    for xyzCard in aux.Next(xyzMachineMonsters) do
        xyzCard:RemoveOverlayCard(tp,1,maxTargets - totalTargets, REASON_COST)
        totalTargets = totalTargets + Duel.GetOperatedGroup():GetCount()
    end
    e:SetLabel(totalTargets)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then
		if e:GetLabel()==1 then
			e:SetLabel(0)
			return Duel.IsExistingTarget(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) 
		end
	end
	e:SetLabel(0)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,ct,ct,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
	--Performing the effect of destroying cards
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	Duel.Destroy(sg,REASON_EFFECT)
end
	--If a machine Xyz monster was destroyed by battle or card effect
function s.desfilter(c,tp,rp)
	return c:IsReason(REASON_BATTLE+REASON_EFFECT) and c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsRace(RACE_MACHINE)
		and c:IsPreviousLocation(LOCATION_MZONE) and c:GetPreviousControler()==tp
		and (c:IsReason(REASON_BATTLE) or (rp==1-tp and c:IsReason(REASON_EFFECT)))
end
	--If it ever happened
function s.damcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(s.desfilter,1,nil,tp,rp)
end
	--Check for machine Xyz monster
function s.damfilter(c)
	return c:IsType(TYPE_XYZ) and c:IsRace(RACE_MACHINE) and c:IsAbleToRemoveAsCost() c:GetRank()>0
end
	--Cost
function s.damcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToRemoveAsCost()
		and Duel.IsExistingMatchingCard(s.damfilter,tp,LOCATION_GRAVE,0,1,c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,s.damfilter,tp,LOCATION_GRAVE,0,1,1,c)
	g:AddCard(c)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
	--Activation legality
function s.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(e:GetRank()*200)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,e:GetRank()*200)
end
	--Performing the effect of inflicting rank*200 damage
function s.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end