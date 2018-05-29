--超天新龍オッドアイズ・レボリューション・ドラゴン (Manga)
--Odd-Eyes Revolution Dragon (Manga)
--Scripted by Larry126
function c511600090.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--revive limit
	c:EnableReviveLimit()
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--special summon rule
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c511600090.hspcon)
	e2:SetOperation(c511600090.hspop)
	c:RegisterEffect(e2)
	--atk/def
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_SET_ATTACK)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetValue(c511600090.atkval)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_SET_DEFENSE)
	c:RegisterEffect(e4)
	--todeck
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(16306932,2))
	e5:SetCategory(CATEGORY_TODECK)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCost(c511600090.tdcost)
	e5:SetTarget(c511600090.tdtg)
	e5:SetOperation(c511600090.tdop)
	c:RegisterEffect(e5)
end
c511600090.listed_names={41209827,82044279,16195942}
function c511600090.hspfilter1(c,g,ft)
	local rg=Group.FromCards(c)
	local ct=ft
	if c:IsLocation(LOCATION_MZONE) and c:GetSequence()<5 then ct=ct+1 end
	return c:IsCode(41209827) and g:IsExists(c511600090.hspfilter2,1,rg,g,rg,ft)
end
function c511600090.hspfilter2(c,g,rg,ft)
	local rg2=rg:Clone()
	rg2:AddCard(c)
	local ct=ft
	if c:IsLocation(LOCATION_MZONE) and c:GetSequence()<5 then ct=ct+1 end
	return c:IsCode(82044279) and g:IsExists(c511600090.hspfilter3,1,rg2,ft)
end
function c511600090.hspfilter3(c,ft)
	local ct=ft
	if c:IsLocation(LOCATION_MZONE) and c:GetSequence()<5 then ct=ct+1 end
	return c:IsCode(16195942) and ct>0
end
function c511600090.hspcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<-2 then return false end
	local g=Duel.GetReleaseGroup(tp):Filter(Card.IsRace,nil,RACE_DRAGON)
	return g:IsExists(c511600090.hspfilter1,1,nil,g,ft)
end
function c511600090.hspop(e,tp,eg,ep,ev,re,r,rp,c)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local g=Duel.GetReleaseGroup(tp):Filter(Card.IsRace,nil,RACE_DRAGON)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g1=g:FilterSelect(tp,c511600090.hspfilter1,1,1,nil,g,ft)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g2=g:FilterSelect(tp,c511600090.hspfilter2,1,1,g1,g,g1,ft)
	g1:Merge(g2)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g3=g:FilterSelect(tp,c511600090.hspfilter3,1,1,g1,ft)
	g1:Merge(g3)
	Duel.Release(g1,REASON_COST+REASON_MATERIAL)
end
function c511600090.atkval(e,c)
	return math.floor(Duel.GetLP(1-e:GetHandlerPlayer()))
end
function c511600090.tdcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.PayLPCost(tp,math.floor(Duel.GetLP(tp)/2))
end
function c511600090.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,LOCATION_ONFIELD+LOCATION_GRAVE,LOCATION_ONFIELD+LOCATION_GRAVE,e:GetHandler())
	if chk==0 then return g:GetCount()>0 end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
end
function c511600090.tdop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,LOCATION_ONFIELD+LOCATION_GRAVE,LOCATION_ONFIELD+LOCATION_GRAVE,e:GetHandler())
	if g:GetCount()>0 then
		Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
	end
end