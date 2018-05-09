--氷獄龍 トリシューラ
--Trishula, the Ice Prison Dragon
--Scripted by Eerie Code
function c100228001.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcMixN(c,true,true,c100228001.ffilter,3)
	aux.AddContactFusion(c,c100228001.contactfil,c100228001.contactop,c100228001.splimit)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(100228001,0))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,100228001)
	e1:SetCondition(c100228001.spcon)
	e1:SetTarget(c100228001.sptg)
	e1:SetOperation(c100228001.spop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_MATERIAL_CHECK)
	e2:SetValue(c100228001.valcheck)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
end
function c100228001.ffilter(c,fc,sumtype,tp,sub,mg,sg)
	return (not sg or not sg:IsExists(c100228001.fusfilter,1,c,c:GetCode(fc,sumtype,tp),fc,sumtype,tp))
end
function c100228001.fusfilter(c,cd,fc,sumtype,tp)
	return c:IsCode(cd,fc,sumtype,tp) and not c:IsHasEffect(511002961)
end
function c100228001.filteraux(c)
	return c:IsAbleToRemoveAsCost() and c:IsType(TYPE_MONSTER)
end
function c100228001.contactfil(tp)
	return Duel.GetMatchingGroup(c100228001.filteraux,tp,LOCATION_ONFIELD,0,nil)
end
function c100228001.contactop(g)
	Duel.Remove(g,POS_FACEUP,REASON_COST+REASON_MATERIAL)
end
function c100228001.splimit(e,se,sp,st)
	return e:GetHandler():GetLocation()~=LOCATION_EXTRA
end
function c100228001.valfilter(c)
	return c:GetOriginalRace()~=RACE_DRAGON
end
function c100228001.valcheck(e,c)
	local g=c:GetMaterial()
	local lbl=1
	if g:IsExists(c100228001.valfilter,1,nil) then lbl=0 end
	e:GetLabelObject():SetLabel(lbl)
end
function c100228001.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetLabel()~=0
end
function c100228001.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,LOCATION_DECK,0,1,nil)
		and Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,0,LOCATION_DECK,1,nil)
		and Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,0,LOCATION_EXTRA,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,tp,LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,2,1-tp,LOCATION_DECK+LOCATION_EXTRA)
end
function c100228001.spop(e,tp,eg,ep,ev,re,r,rp)
	local g=Group.CreateGroup()
	local g1=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,LOCATION_DECK,0,nil)
	local g2=Duel.GetDecktopGroup(1-tp,1)
	local g3=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,0,LOCATION_EXTRA,nil)
	if #g1>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local sg1=g1:Select(tp,1,1,nil)
		g=g+sg1
	end
	if #g2>0 and g2:GetFirst():IsAbleToRemove() then g=g+g2 end
	if #g3>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local sg3=g3:Select(tp,1,1,nil)
		g=g+sg3
	end
	if #g>0 then
		Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	end
end
