--花札衛－牡丹に蝶－
function c57261568.initial_effect(c)
	c:EnableReviveLimit()
	--special summon rule
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetCondition(c57261568.hspcon)
	e1:SetOperation(c57261568.hspop)
	c:RegisterEffect(e1,false,2)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(57261568,0))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetTarget(c57261568.target)
	e2:SetOperation(c57261568.operation)
	c:RegisterEffect(e2)
	--synchro
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_SYNCHRO_MATERIAL_CUSTOM)
	e3:SetOperation(c57261568.synop)
	c:RegisterEffect(e3)
end
c57261568.listed_names={57261568}
function c57261568.hspfilter(c)
	return c:IsSetCard(0xe6) and not c:IsCode(57261568)
end
function c57261568.hspcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-1
		and Duel.CheckReleaseGroup(c:GetControler(),c57261568.hspfilter,1,nil)
end
function c57261568.hspop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.SelectReleaseGroup(c:GetControler(),c57261568.hspfilter,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c57261568.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c57261568.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	if Duel.Draw(p,d,REASON_EFFECT)~=0 then
		local tc=Duel.GetOperatedGroup():GetFirst()
		Duel.ConfirmCards(1-tp,tc)
		if tc:IsType(TYPE_MONSTER) and tc:IsSetCard(0xe6) then
			local ct=Duel.GetFieldGroupCount(1-tp,LOCATION_DECK,0)
			if ct<3 then return end
			Duel.BreakEffect()
			local g=Duel.GetDecktopGroup(1-tp,3)
			Duel.ConfirmCards(tp,g)
			local opt=Duel.SelectOption(tp,aux.Stringid(57261568,1),aux.Stringid(57261568,2))
			Duel.SortDecktop(tp,1-tp,3)
			if opt==0 then
				for i=1,3 do
					local mg=Duel.GetDecktopGroup(1-tp,1)
					Duel.MoveSequence(mg:GetFirst(),1)
				end
			end
		else
			Duel.BreakEffect()
			Duel.SendtoGrave(tc,REASON_EFFECT)
		end
		Duel.ShuffleHand(tp)
	end
end
function c57261568.synop(e,tg,ntg,sg,lv,sc,tp)
	local res=sg:CheckWithSumEqual(Card.GetSynchroLevel,lv,sg:GetCount(),sg:GetCount(),sc) 
		or sg:CheckWithSumEqual(function() return 2 end,lv,sg:GetCount(),sg:GetCount())
	return res,true
end
