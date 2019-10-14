--フェイバリット・ヒーロー
--Favorite Hero
--Scripted by Randuin and AlphaKretin
local s,id=GetID()
function s.initial_effect(c)
	--equip only to lvl 5+ hero
	aux.AddEquipProcedure(c,nil,s.filter)
	--gain atk equal to def
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_EQUIP)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_SZONE)
	e1:SetValue(s.atkval)
	c:RegisterEffect(e1)
	--untargetable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP+EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetCondition(s.tgocon)
	e2:SetValue(aux.tgoval)
	c:RegisterEffect(e2)
	--Activate field
    local e3=Effect.CreateEffect(c)
    e3:SetDescription(aux.Stringid(id,0))
    e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
    e3:SetCode(EVENT_PHASE+PHASE_BATTLE_START)
    e3:SetRange(LOCATION_SZONE)
    e3:SetCountLimit(1,id)
    e3:SetTarget(s.acttg)
    e3:SetOperation(s.actop)
    c:RegisterEffect(e3)
    --destroy
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(id,1))
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_BATTLE_DESTROYING)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCondition(s.atkcon)
	e4:SetCost(s.atkcost)
	e4:SetOperation(s.atkop)
	c:RegisterEffect(e4)
end
function s.filter(c)
	return c:IsLevelAbove(5) and c:IsSetCard(0x8)
end
function s.atkval(e,c)
	local tp=c:GetControler()
	if Duel.GetFieldCard(tp,LOCATION_SZONE,5) then return e:GetHandler():GetBaseDefense() else return 0 end
end
function s.tgocon(e,tp)
	return Duel.GetFieldCard(tp,LOCATION_SZONE,5)
end
function s.actfilter(c,tp)
	return c:IsType(TYPE_FIELD) and c:GetActivateEffect():IsActivatable(tp,true,true)
end
function s.acttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.actfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,tp) end
end
function s.actop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local sc=Duel.SelectMatchingCard(tp,s.actfilter,tp,LOCATION_HAND+LOCATION_DECK,0,nil,tp):GetFirst()			
	if sc then
		local fc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
    	if fc then
        	Duel.SendtoGrave(fc,REASON_RULE)
        	Duel.BreakEffect()
    	end
		Duel.MoveToField(sc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		local te=sc:GetActivateEffect()
		local tep=sc:GetControler()
		local cost=te:GetCost()
		if cost then cost(te,tep,eg,ep,ev,re,r,rp,1) end
		Duel.RaiseEvent(sc,4179255,te,0,tp,tp,Duel.GetCurrentChain())
	end
end
function s.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetEquipTarget()==eg:GetFirst() and Duel.GetTurnPlayer()==tp
end
function s.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
    Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function s.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChainAttack()
end