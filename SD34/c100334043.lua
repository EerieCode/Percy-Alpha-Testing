--トークバック・ランサー
--Talkback Lancer 
function c100334043.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,c100334043.matfilter,1,1)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(100334043,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c100334043.spcost)
	e1:SetTarget(c100334043.sptg)
	e1:SetOperation(c100334043.spop)
	c:RegisterEffect(e1)
end
function c100334043.matfilter(c,lc,sumtype,tp)
	return c:IsLevelBelow(2) and c:IsRace(RACE_CYBERSE,lc,sumtype,tp)
end
function c100334043.spcfilter(c,g,zone)
	return c:IsRace(RACE_CYBERSE) and (zone~=0 or g:IsContains(c))
	and Duel.IsExistingMatchingCard(c64514622.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp,zone,c:GetCode()) 
end
function c100334043.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local lg=c:GetLinkedGroup()
	local zone=c:GetFreeLinkedZone()&0x1f
	if chk==0 then return Duel.CheckReleaseGroupCost(tp,c100334043.spcfilter,1,false,nil,e:GetHandler(),lg,zone) end
	local tc=Duel.SelectReleaseGroupCost(tp,c100334043.spcfilter,1,1,false,nil,e:GetHandler(),lg,zone)
	Duel.Release(tc,REASON_COST)
	e:SetLabelObject(tc)
end
function c100334043.spfilter(c,e,tp,zone,code)
	if not zone then zone=0xff end
	return c:IsSetCard(0x101) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP,tp,zone) and not c:GetOriginalCode()~=code
end
function c100334043.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local cc=e:GetLabelObject()
	local zone=e:GetHandler():GetFreeLinkedZone()&0x1f
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and chkc~=cc
		and c100334043.spfilter(chkc,e,tp,zone) or c100334043.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c100334043.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp,zone,cc:GetOriginalCode())
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c100334043.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,zone,cc:GetOriginalCode())
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c100334043.spop(e,tp,eg,ep,ev,re,r,rp)
	local zone=e:GetHandler():GetFreeLinkedZone()&0x1f
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and zone~=0 then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP,zone)
	end
end