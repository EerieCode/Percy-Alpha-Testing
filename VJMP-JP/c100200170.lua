--塊斬機ダランベルシアン
--Batch Processlayer d'Alembertian
--Scripted by AlphaKretin
local s,id=GetID()
function s.initial_effect(c)
    --xyz summon
    aux.AddXyzProcedure(c,nil,4,2,nil,nil,99)
    c:EnableReviveLimit()
    --search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,id)
	e1:SetCondition(s.thcon)
	e1:SetCost(s.thcost)
	e1:SetTarget(s.thtg)
	e1:SetOperation(s.thop)
	c:RegisterEffect(e1,false,REGISTER_FLAG_DETACH_XMAT)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,4))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1,id+100)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(s.spcost)
	e2:SetTarget(s.sptg)
	e2:SetOperation(s.spop)
	c:RegisterEffect(e2)
end
s.listed_series={0x231}
function s.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_XYZ)
end
function s.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local mm=s.mmtg(e,tp,eg,ep,ev,re,r,rp,0) --"Mathmech" target
	local l4=s.l4tg(e,tp,eg,ep,ev,re,r,rp,0) --"Level 4" target
	local st=s.sttg(e,tp,eg,ep,ev,re,r,rp,0) --"Spell/Trap" target
	local ct
	if st then ct = 4 end
	if l4 then ct = 3 end
	if mm then ct = 2 end
	if chk==0 then return (hand or mon or st) and c:CheckRemoveOverlayCard(tp,ct,REASON_COST) end
		local selections={}
		if st and c:CheckRemoveOverlayCard(tp,4,REASON_COST) then
			table.insert(selections,4)
		end
		if l4 and c:CheckRemoveOverlayCard(tp,3,REASON_COST) then
			table.insert(selections,3)
		end
		if mm and c:CheckRemoveOverlayCard(tp,2,REASON_COST) then
			table.insert(selections,2)
		end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVEXYZ)
		local a,b=Duel.AnnounceNumber(tp,table.unpack(selections))
		Debug.Message(sel)
		Debug.Message(b)
		c:RemoveOverlayCard(tp,sel,sel,REASON_COST)
		if sel==2 then
			Duel.Hint(HINT_OPSELECTED,1-tp,aux.Stringid(id,1))
		else if sel==3 then
			Duel.Hint(HINT_OPSELECTED,1-tp,aux.Stringid(id,2))
		else 
			Duel.Hint(HINT_OPSELECTED,1-tp,aux.Stringid(id,3))
		end
		e:SetLabel(sel)
	end
end
function s.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end --legality handled in cost by necessity
		local sel=e:GetLabel()
		if sel==2 then
			s.mmtg(e,tp,eg,ep,ev,re,r,rp,chk)
		else if sel==3 then
			s.l4tg(e,tp,eg,ep,ev,re,r,rp,chk)
		else 
			s.sttg(e,tp,eg,ep,ev,re,r,rp,chk)
		end
	end
end
function s.thop(e,tp,eg,ep,ev,re,r,rp)
	local sel=e:GetLabel()
		if sel==2 then
			s.mmop(e,tp,eg,ep,ev,re,r,rp)
		else if sel==3 then
			s.l4op(e,tp,eg,ep,ev,re,r,rp)
		else 
			s.stop(e,tp,eg,ep,ev,re,r,rp)
		end
	end
end
function s.tg(filter)
	return function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return Duel.IsExistingMatchingCard(filter,tp,LOCATION_DECK,0,1,nil) end
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
	end
end
function s.op(filter)
	return function(e,tp,eg,ep,ev,re,r,rp)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,filter,tp,LOCATION_DECK,0,1,1,nil)
		if #g>0 then
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		end
	end
end
function s.mmfilter(c)
	return c:IsSetCard(0x231) and c:IsAbleToHand()
end
s.mmtg=s.tg(s.mmfilter)
s.mmop=s.op(s.mmfilter)
function s.l4filter(c)
	return c:IsLevel(4) and c:IsAbleToHand()
end
s.l4tg=s.tg(s.l4filter)
s.l4op=s.op(s.l4filter)
function s.stfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand()
end
s.sttg=s.tg(s.stfilter)
s.stop=s.op(s.stfilter)
function s.spfilter(c,e,tp)
	return c:IsSetCard(0x231) and c:IsLevel(4) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function s.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroupCost(tp,nil,1,false,nil,nil) end
	local sg=Duel.SelectReleaseGroupCost(tp,nil,1,1,false,nil,nil)
	Duel.Release(sg,REASON_COST)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(s.spfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(s.spfilter),tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if #g>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
