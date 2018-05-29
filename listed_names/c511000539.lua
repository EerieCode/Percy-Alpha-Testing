--Thousand Dragon (Anime)
function c511000539.initial_effect(c)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000539,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_HAND+LOCATION_DECK)
	e1:SetProperty(EFFECT_FLAG_CHAIN_UNIQUE)
	e1:SetCode(71625222)
	e1:SetCondition(c511000539.spcon)
	e1:SetCost(c511000539.spcost)
	e1:SetTarget(c511000539.sptg)
	e1:SetOperation(c511000539.spop)
	c:RegisterEffect(e1)
end
c511000539.listed_names={88819587}
function c511000539.spcon(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp
end
function c511000539.cfilter(c,ft,tp)
	return c:IsCode(88819587) and (ft>0 or (c:IsControler(tp) and c:GetSequence()<5)) and (c:IsControler(tp) or c:IsFaceup())
end
function c511000539.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if chk==0 then return ft>-1 and Duel.CheckReleaseGroup(tp,c511000539.cfilter,1,nil,ft,tp) end
	local g=Duel.SelectReleaseGroup(tp,c511000539.cfilter,1,1,nil,ft,tp)
	Duel.Release(g,REASON_COST)
end
function c511000539.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,true,false) end
	if e:GetHandler():IsLocation(LOCATION_DECK) then
		Duel.ConfirmCards(1-tp,e:GetHandler())
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c511000539.spop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) and Duel.SpecialSummon(e:GetHandler(),0,tp,tp,true,false,POS_FACEUP)>0 then
		e:GetHandler():CompleteProcedure()
	end
end
