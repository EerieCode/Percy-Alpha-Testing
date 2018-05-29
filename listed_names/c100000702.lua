--ダークネス・レインクロー
function c100000702.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPSUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c100000702.condition)
	e1:SetCost(c100000702.cost)
	e1:SetTarget(c100000702.target)
	e1:SetOperation(c100000702.activate)
	c:RegisterEffect(e1)
end
c100000702.listed_names={100000701,60417395}
function c100000702.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp)
end
function c100000702.cosfilter(c,ft)
	return c:IsCode(100000701) and c:IsAbleToGraveAsCost() and (ft>0 or (c:IsLocation(LOCATION_MZONE) and c:GetSequence()<5))
end
function c100000702.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if chk==0 then return ft>-1 and e:GetHandler():IsAbleToGraveAsCost() 
		and Duel.IsExistingMatchingCard(c100000702.cosfilter,tp,LOCATION_ONFIELD,0,1,nil,ft) end
	local g=Duel.SelectMatchingCard(tp,c100000702.cosfilter,tp,LOCATION_ONFIELD,0,1,1,nil,ft)
	g:AddCard(e:GetHandler())
	Duel.SendtoGrave(g,REASON_COST)
end
function c100000702.filter(c,e,tp)
	return c:IsCode(60417395) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c100000702.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c100000702.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c100000702.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c100000702.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)
	end
end
