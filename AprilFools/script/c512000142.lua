--シャッフル・システム・ＡＰＲＩＬ
--Admin Perfect RNG - Impeccable Luck
--Scripted by AlphaKretin
local s,id=GetID()
function s.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ADJUST)
	e1:SetCountLimit(1)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_NO_TURN_RESET)
	e1:SetRange(0xff)
	e1:SetOperation(s.regop)
	c:RegisterEffect(e1)
end
s.garnet_list={
	91731841, --Gem-Knight Garnet
	61677004, --Predaplant Darlingtonia Cobra
	94770493, --Double or Nothing!
	54537489, --Mare Mare
}
s.global_active_check={}
function s.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.DisableShuffleCheck()
	Duel.SendtoDeck(c,nil,-2,REASON_RULE)
	if c:IsPreviousLocation(LOCATION_HAND) then Duel.Draw(tp, 1, REASON_RULE) end
	if not s.global_active_check[tp] then
		Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(1040,14))
		local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
		local ct=#g
		Duel.SendtoDeck(g,nil,-2,REASON_RULE)
		local i=0
		while i<ct do
			local garnet=s.garnet_list[Duel.GetRandomNumber(1,#s.garnet_list)]
			local gc=Duel.CreateToken(tp,garnet)
			Duel.SendtoHand(gc,tp,REASON_RULE)
			i=i+1
		end
		s.global_active_check[tp] = true
	end
end