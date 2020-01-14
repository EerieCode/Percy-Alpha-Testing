--マシンナーズ・カーネル
--Machina Colonel
--Scripted by AlphaKretin
local s,id=GetID()
function s.initial_effect(c)
	c:EnableUnsummonable()
	--splimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(s.splimit)
	c:RegisterEffect(e1)
	 --destroy
    local e2=Effect.CreateEffect(c)
    e2:SetCategory(CATEGORY_DESTROY)
    e2:SetType(EFFECT_TYPE_QUICK_O)
    e2:SetCode(EVENT_FREE_CHAIN)
    e2:SetRange(LOCATION_MZONE)
    e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e2:SetCountLimit(1,id)
    e2:SetTarget(s.destg)
    e2:SetOperation(s.desop)
    c:RegisterEffect(e2)
end
function s.splimit(e,se,sp,st)
	return se:IsHasType(EFFECT_TYPE_ACTIONS)
end
function s.tgfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_MACHINE) and Duel.IsExistingMatchingCard(s.desfilter,c:GetControler(),0,LOCATION_MZONE,1,nil,c:GetAttack())
end
function s.desfilter(c,atk)
    return c:IsFaceup() and c:IsAttackBelow(atk)
end
function s.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    local c=e:GetHandler()
    if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp)
    if chk==0 then return Duel.IsExistingMatchingCard(c80666118.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,c,c:GetAttack()) end
    local g=Duel.GetMatchingGroup(c80666118.filter,tp,LOCATION_MZONE,LOCATION_MZONE,c,c:GetAttack())
    Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
    Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,g:GetCount()*500)
end
function s.desop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
    local g=Duel.GetMatchingGroup(c80666118.filter,tp,LOCATION_MZONE,LOCATION_MZONE,c,c:GetAttack())
    local ct=Duel.Destroy(g,REASON_EFFECT)
    if ct>0 then
        Duel.BreakEffect()
        Duel.Damage(1-tp,ct*500,REASON_EFFECT)
    end
end