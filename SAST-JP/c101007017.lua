--
--Shiranui Spectralsword Saga
--Scripted by AlphaKretin
function c101007017.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(101007017,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCountLimit(1,101007017)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c101007017.cost)
	e1:SetTarget(c101007017.target)
	e1:SetOperation(c101007017.operation)
	c:RegisterEffect(e1)
end
function c101007017.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c101007017.rescon(sg, e, tp, mg)
	return aux.ChkfMMZ(2)(sg, e, tp, mg) and sg:IsExists(Card.IsSetCard,1,nil,0xd9)
end
function c101007017.filter(c,e,tp)
	return c:IsRace(RACE_ZOMBIE) and not c:IsCode(101007017) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c101007017.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c101007017.filter,tp,LOCATION_REMOVED,0,nil,e,tp)
	if chk==0 then 
		return not Duel.IsAffectedByEffect(CARD_BLUEEYES_SPIRIT) 
			and aux.SelectUnselectGroup(g,1,tp,2,2,c101007017.rescon,chk) 
	end
	local tg = aux.SelectUnselectGroup(g,1,tp,2,2,c101007017.rescon,chk,tp) 
	Duel.SetTargetCard(tg)
    Duel.SetOperationInfo(0, CATEGORY_SPECIAL_SUMMON, tg, #tg, 0, 0)
end
function c101007017.operation(e,tp,eg,ep,ev,re,r,rp)
local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 then return end
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	if #sg>1 and Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	if #sg>ft then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		sg=sg:Select(tp,ft,ft,nil)
	end
	Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
end