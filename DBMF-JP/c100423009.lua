--塊斬機ラプラシア
--Cluster Zan-Ki Laplacian
--Scripted by AlphaKretin
local s,id=GetID()
function s.initial_effect(c)
    --xyz summon
    aux.AddXyzProcedure(c,nil,4,3)
    c:EnableReviveLimit()
    --atk
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(s.con)
	e1:SetCost(s.cost)
	e1:SetTarget(s.tg)
	e1:SetOperation(s.op)
	c:RegisterEffect(e1,false,REGISTER_FLAG_DETACH_XMAT)
end
function s.con(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_XYZ)
end
function s.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local ct=0
	if s.handtg(e,tp,eg,ep,ev,re,r,rp,0) then ct=ct+1 end
	if s.montg(e,tp,eg,ep,ev,re,r,rp,0) then ct=ct+1 end
	if s.sttg(e,tp,eg,ep,ev,re,r,rp,0) then ct=ct+1 end
	if chk==0 then return ct>0 and c:CheckRemoveOverlayCard(tp,1,REASON_COST) end
	c:RemoveOverlayCard(tp,1,ct,REASON_COST)
	local num=Duel.GetOperatedGroup():GetCount()
	e:SetLabel(num)
end
function s.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	
end
function s.handtg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetFieldGroupCount(1-tp,LOCATION_HAND,0)~=0 end
    Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,1-tp,LOCATION_HAND)
end
function s.handop(e,tp,eg,ep,ev,re,r,rp)
    local g=Duel.GetFieldGroup(1-tp,LOCATION_HAND,0)
    if #g==0 then return end
    local sg=g:RandomSelect(1-tp,1)
    Duel.SendtoGrave(sg,REASON_EFFECT)
end
function s.montg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToGrave,tp,0,LOCATION_MZONE,1,nil) end
	e:SetCategory(CATEGORY_TOGRAVE)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,0,0)
end
function s.monop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToGrave,tp,0,LOCATION_MZONE,1,1,nil)
	if #g>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
function s.stfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToGrave()
end
function s.sttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.stfilter,tp,0,LOCATION_MZONE,1,nil) end
	e:SetCategory(CATEGORY_TOGRAVE)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,0,0)
end
function s.monop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.SelectMatchingCard(tp,s.stftiler,tp,0,LOCATION_MZONE,1,1,nil)
	if #g>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end