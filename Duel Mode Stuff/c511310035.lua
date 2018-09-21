--Pegasus Ultimate Challenge
--Scripted by AlphaKretin
local card, code = GetID()
local CHALLENGE_CHANCE = 15 --chance of a challenge applying each phase, out of 100.
function card.initial_effect(c)
	--enable REVERSE_DECK function
	Duel.EnableGlobalFlag(GLOBALFLAG_DECK_REVERSE_CHECK)
	--Apply at start of duel (Duel mode)
	local e1 = Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE + EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetRange(0xff)
	e1:SetCountLimit(1)
	e1:SetCondition(card.actcon)
	e1:SetOperation(card.actop)
	c:RegisterEffect(e1)
	if not card.global_check then
		card.global_check = true
		card[0] = false
		card[1] = false
		--check for destroyed card this turn
		local ge1 = Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_DESTROYED)
		ge1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
		ge1:SetOperation(card.checkop)
		Duel.RegisterEffect(ge1, 0)
		local ge2 = Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_TURN_END)
		ge2:SetCountLimit(1)
		ge2:SetCondition(card.clear)
		Duel.RegisterEffect(ge2, 0)
	end
end
card.illegal = true --enables announcing illegal card names. Crucially this includes the "Yu-Gi-Oh!" token
card.challenges = {} --table of functions that apply the challenges
card.activeChallenges = {} --table of effects for lingering challenges to be reset for the challenge that does so

function card.actcon(e, tp, eg, ep, ev, re, r, rp)
	return Duel.GetTurnCount() == 1
end

function card.actop(e, tp, eg, ep, ev, re, r, rp)
	local c = e:GetHandler()
	Duel.DisableShuffleCheck()
	local flag = c:IsLocation(LOCATION_HAND)
	Duel.SendtoDeck(c, nil, -2, REASON_RULE)
	local ct = Duel.GetMatchingGroupCount(nil, tp, LOCATION_HAND + LOCATION_DECK, 0, c)
	local chk = (Duel.GetFlagEffect(tp, 511004001) or Duel.IsDuelType(SPEED_DUEL)) and ct < 20 or ct < 40
	if chk and Duel.SelectYesNo(1 - tp, aux.Stringid(5002, 15)) then
		Duel.Win(1 - tp, 0x60)
	end
	if flag then
		Duel.Draw(tp, 1, REASON_RULE)
	end
	if not card.global_act_check then
		Duel.ConfirmCards(tp, c)
		Duel.ConfirmCards(1 - tp, c)
		Duel.Hint(HINT_CARD, 0, code)
		Duel.Hint(HINT_CARD, 1, code)
		card.global_act_check = true
		--Apply challenges
		local e1 = Effect.CreateEffect(c)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE + EFFECT_FLAG_UNCOPYABLE)
		e1:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE_START + PHASE_DRAW)
		e1:SetTargetRange(1, 1)
		e1:SetOperation(card.chalop)
		Duel.RegisterEffect(e1, tp)
		local e2 = e1:Clone()
		e2:SetCode(EVENT_PHASE_START + PHASE_STANDBY)
		Duel.RegisterEffect(e2, tp)
		local e3 = e1:Clone()
		e3:SetCode(EVENT_PHASE_START + PHASE_MAIN1)
		Duel.RegisterEffect(e3, tp)
		local e4 = e1:Clone()
		e4:SetCode(EVENT_PHASE_START + PHASE_BATTLE_START)
		Duel.RegisterEffect(e4, tp)
		local e5 = e1:Clone()
		e5:SetCode(EVENT_PHASE_START + PHASE_MAIN2)
		Duel.RegisterEffect(e5, tp)
		local e6 = e1:Clone()
		e6:SetCode(EVENT_PHASE_START + PHASE_END)
		Duel.RegisterEffect(e6, tp)
	end
end

function card.chalop(e, tp, eg, ep, ev, re, r, rp)
	local rand = Duel.GetRandomNumber(1, 100)
	if (rand <= CHALLENGE_CHANCE) then
		local challenge = Duel.GetRandomNumber(1, #card.challenges)
		Duel.Hint(HINT_MESSAGE, 0, aux.Stringid(5000, challenge - 1)) --if over 15 wraps to next token
		Duel.Hint(HINT_MESSAGE, 1, aux.Stringid(5000, challenge - 1))
		card.challenges[challenge](e, tp, eg, ep, ev, re, r, rp)
	end
end

--helper function to "play" a card
function card.playCard(c, p, e, tp, eg, ep, ev, re, r, rp)
	if c then
		if c:IsType(TYPE_MONSTER) and Duel.GetLocationCount(p, LOCATION_MZONE) > 0 and Duel.SelectYesNo(p, 1075) then
			--play monster to the field (skill summon!)
			Duel.MoveToField(c, p, p, LOCATION_MZONE, POS_FACEUP, true, 0x1f)
		else
			--activate backrow
			local ae = c:GetActivateEffect()
			if ae and ae:IsActivatable(p) and Duel.SelectYesNo(p, 94) then
				Duel.MoveToField(c, p, p, LOCATION_SZONE, POS_FACEDOWN, true, 0x1f)
				Duel.Activate(ae)
			end
		end
	end
end

--helper function do destroy all cards that fit a filter
function card.destroyFilter(func, loc)
	local dg = Duel.GetMatchingGroup(func, 0, loc, loc, nil) --which player doesn't matter because we get both sides
	if #dg > 0 then
		Duel.Destroy(dg, REASON_RULE)
	end
end

--All players reveal the top card of their deck. You may play that card immediately, starting with the turn player.
function card.playTopCard(e, tp, eg, ep, ev, re, r, rp)
	local p = Duel.GetTurnPlayer()
	Duel.ConfirmDecktop(p, 1)
	local turnPlayersCard = Duel.GetDecktopGroup(p, 1):GetFirst()
	Duel.ConfirmDecktop(1 - p, 1)
	local nonTurnPlayersCard = Duel.GetDecktopGroup(1 - p, 1):GetFirst()
	card.playCard(turnPlayersCard, p)
	card.playCard(nonTurnPlayersCard, 1 - p)
end
table.insert(card.challenges, card.playTopCard)

--Both players play with their hands revealed.
function card.revealHands(e, tp, eg, ep, ev, re, r, rp)
	local e1 = Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_PUBLIC)
	e1:SetTargetRange(LOCATION_HAND, LOCATION_HAND)
	Duel.RegisterEffect(e1, tp)
	table.insert(card.activeChallenges, e1)
end
table.insert(card.challenges, card.revealHands)

--Destroy all monsters with five or more stars.
function card.destroyFivePlusStar(e, tp, eg, ep, ev, re, r, rp)
	card.destroyFilter(
		function(c)
			return c:IsLevelAbove(5) or c:IsRankAbove(5)
		end,
		LOCATION_MZONE
	)
end
table.insert(card.challenges, card.destroyFivePlusStar)

--Everyone discard a random card from their hand.
function card.discardRandom(e, tp, eg, ep, ev, re, r, rp)
	local g = Duel.GetFieldGroup(tp, LOCATION_HAND, 0)
	local sg = g:RandomSelect(tp, 1)
	Duel.SendtoGrave(sg, REASON_RULE + REASON_DISCARD)
	local g2 = Duel.GetFieldGroup(1 - tp, LOCATION_HAND, 0)
	local sg2 = g2:RandomSelect(1 - tp, 1)
	Duel.SendtoGrave(sg2, REASON_RULE + REASON_DISCARD)
end
table.insert(card.challenges, card.discardRandom)

--Everyone stop and introduce yourself to the person sitting on your right.
function card.introduce(e, tp, eg, ep, ev, re, r, rp)
	--only displays a message, as handled by chalop
end
table.insert(card.challenges, card.introduce)

--Lose 500 LP for each Spell and Trap Card you control.
function card.loseLPForBackrow(e, tp, eg, ep, ev, re, r, rp)
	local tpLoss = Duel.GetFieldGroupCount(tp, LOCATION_SZONE, 0) * 500
	local ntpLoss = Duel.GetFieldGroupCount(tp, 0, LOCATION_SZONE) * 500
	Duel.SetLP(tp, Duel.GetLP(tp) - tpLoss)
	Duel.SetLP(1 - tp, Duel.GetLP(1 - tp) - ntpLoss)
end
table.insert(card.challenges, card.loseLPForBackrow)

--Shuffle your hand into your deck and then draw that many cards.
function card.mulligan(e, tp, eg, ep, ev, re, r, rp)
	local g = Duel.GetFieldGroup(tp, LOCATION_HAND, 0)
	if #g > 0 then
		Duel.SendtoDeck(g, nil, 2, REASON_RULE)
		Duel.ShuffleDeck(tp)
		Duel.Draw(tp, #g, REASON_RULE)
	end
	local g2 = Duel.GetFieldGroup(tp, 0, LOCATION_HAND)
	if #g2 > 0 then
		Duel.SendtoDeck(g2, nil, 2, REASON_RULE)
		Duel.ShuffleDeck(1 - tp)
		Duel.Draw(1 - tp, #g2, REASON_RULE)
	end
end
table.insert(card.challenges, card.mulligan)

--Swap LP with your opponent.
function card.swapLP(e, tp, eg, ep, ev, re, r, rp)
	local temp = Duel.GetLP(tp)
	Duel.SetLP(tp, Duel.GetLP(1 - tp))
	Duel.SetLP(1 - tp, temp)
end
table.insert(card.challenges, card.swapLP)

--Destroy all monsters with 1500 or less ATK.
function card.destroy1500LessATK(e, tp, eg, ep, ev, re, r, rp)
	card.destroyFilter(
		function(c)
			return c:IsAttackBelow(1500)
		end,
		LOCATION_MZONE
	)
end
table.insert(card.challenges, card.destroy1500LessATK)

--If you had a card destroyed this turn, you may destroy one of your opponent's cards.
function card.paybackDestroy(e, tp, eg, ep, ev, re, r, rp)
	if card[tp] then
		local dc = Duel.SelectMatchingCard(tp, aux.TRUE, tp, 0, LOCATION_ONFIELD, 0, 1, nil)
		if #dc > 0 then
			Duel.Destroy(dc, REASON_RULE)
		end
	end
	if card[1 - tp] then
		local dc = Duel.SelectMatchingCard(1 - tp, aux.TRUE, 1 - tp, 0, LOCATION_ONFIELD, 0, 1, nil)
		if #dc > 0 then
			Duel.Destroy(dc, REASON_RULE)
		end
	end
end
table.insert(card.challenges, card.paybackDestroy)

function card.checkop(e, tp, eg, ep, ev, re, r, rp)
	for tc in aux.Next(eg) do
		card[tc:GetPreviousControler()] = true
	end
end

function card.clear(e, tp, eg, ep, ev, re, r, rp)
	card[0] = false
	card[1] = false
	return false
end

--Players cannot activate Spell Cards. (They could activate their effects.)
function card.noActSpell(e, tp, eg, ep, ev, re, r, rp)
	local e1 = Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(1, 1)
	e1:SetValue(card.aclimit)
	Duel.RegisterEffect(e1, tp)
	table.insert(card.activeChallenges, e1)
end
table.insert(card.challenges, card.noActSpell)

function card.aclimit(e, re, tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_SPELL)
end

--Remove all cards in all graveyard from the game.
function card.vanishGrave(e, tp, eg, ep, ev, re, r, rp)
	local rg = Duel.GetFieldGroup(tp, LOCATION_GRAVE, LOCATION_GRAVE)
	Duel.DisableShuffleCheck()
	Duel.SendtoDeck(rg, nil, -2, REASON_RULE)
end
table.insert(card.challenges, card.vanishGrave)

--Switch the ATK and DEF of all monsters on the field.
function card.switchATKDEF(e, tp, eg, ep, ev, re, r, rp)
	local g = Duel.GetFieldGroup(tp, LOCATION_MZONE, LOCATION_MZONE)
	local c = e:GetHandler()
	for tc in aux.Next(g) do
		local e1 = Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SWAP_AD)
		e1:SetReset(RESET_EVENT + RESETS_STANDARD)
		tc:RegisterEffect(e1)
		table.insert(card.activeChallenges, e1)
	end
end
table.insert(card.challenges, card.switchATKDEF)

--Turn your deck over and then draw from the new top of the deck.
function card.reverseDeck(e, tp, eg, ep, ev, re, r, rp)
	local e1 = Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_REVERSE_DECK)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1, 1)
	Duel.RegisterEffect(e1, tp)
	--workaround to delay draw until after deck flips, credit to larry
	local e2 = Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_ADJUST)
	e2:SetOperation(card.drop)
	Duel.RegisterEffect(e2, tp)
	table.insert(card.activeChallenges, e1)
end
table.insert(card.challenges, card.reverseDeck)

function card.drop(e, tp, eg, ep, ev, re, r, rp)
	Duel.Draw(tp, 1, REASON_RULE)
	Duel.Draw(tp, 1 - tp, REASON_RULE)
	e:Reset()
end

--You cannot attack unless you say "Yu-Gi-Oh!"
function card.attackCost(e, tp, eg, ep, ev, re, r, rp)
	--attack cost
	local e1 = Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_ATTACK_COST)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1, 1)
	e1:SetOperation(card.atop)
	Duel.RegisterEffect(e1, tp)
	table.insert(card.activeChallenges, e1)
end
table.insert(card.challenges, card.attackCost)

function card.atop(e, tp, eg, ep, ev, re, r, rp)
	if Duel.IsAttackCostPaid() ~= 2 then
		local CARD_YUGIOH = 5000
		card.announce_filter = {CARD_YUGIOH, OPCODE_ISCODE}
		Duel.AnnounceCardFilter(tp, table.unpack(card.announce_filter))
		Duel.AttackCostPaid()
	end
end

--All monsters become Normal Monsters with no effects.
function card.becomeNormal(e, tp, eg, ep, ev, re, r, rp)
	local c = e:GetHandler()
	--disable
	local e1 = Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetTargetRange(LOCATION_MZONE, LOCATION_MZONE)
	e1:SetCode(EFFECT_DISABLE)
	Duel.RegisterEffect(e1, tp)
	table.insert(card.activeChallenges, e1)
	--type
	local e2 = Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetTargetRange(LOCATION_MZONE, LOCATION_MZONE)
	e2:SetCode(EFFECT_CHANGE_TYPE)
	e2:SetValue(TYPE_NORMAL)
	Duel.RegisterEffect(e2, tp)
	table.insert(card.activeChallenges, e2)
end
table.insert(card.challenges, card.becomeNormal)

--Destroy all cards on the field.
function card.destroyAll(e, tp, eg, ep, ev, re, r, rp)
	card.destroyFilter(aux.TRUE, LOCATION_ONFIELD)
end
table.insert(card.challenges, card.destroyAll)

--Destroy all monsters.
function card.destroyMonster(e, tp, eg, ep, ev, re, r, rp)
	card.destroyFilter(aux.TRUE, LOCATION_MZONE)
end
table.insert(card.challenges, card.destroyMonster)

--Destroy all Spell and Trap Cards.
function card.destroyBackrow(e, tp, eg, ep, ev, re, r, rp)
	card.destroyFilter(aux.TRUE, LOCATION_SZONE)
end
table.insert(card.challenges, card.destroyBackrow)

--Destroy all face-up Xyz Monsters.
function card.destroyXyz(e, tp, eg, ep, ev, re, r, rp)
	card.destroyFilter(
		function(c)
			return c:IsFaceup() and c:IsType(TYPE_XYZ)
		end,
		LOCATION_MZONE
	)
end
table.insert(card.challenges, card.destroyXyz)

--Discard your hand and then draw that many cards.
function card.discardMulligan(e, tp, eg, ep, ev, re, r, rp)
	local g = Duel.GetFieldGroup(tp, LOCATION_HAND, 0)
	if #g > 0 then
		Duel.SendtoGrave(g, REASON_RULE + REASON_DISCARD)
		Duel.Draw(tp, #g, REASON_RULE)
	end
	local g2 = Duel.GetFieldGroup(tp, 0, LOCATION_HAND)
	if #g2 > 0 then
		Duel.SendtoGrave(g2, REASON_RULE + REASON_DISCARD)
		Duel.Draw(1 - tp, #g2, REASON_RULE)
	end
end
table.insert(card.challenges, card.discardMulligan)

--Everyone draw the bottom card of their Deck.
function card.drawBottom(e, tp, eg, ep, ev, re, r, rp)
	local tc = Duel.GetFieldGroup(tp, LOCATION_DECK, 0):GetFirst() --first card in deck is bottom
	if tc then
		Duel.SendtoHand(tc, nil, REASON_RULE + REASON_DRAW)
	end
	local tc2 = Duel.GetFieldGroup(tp, 0, LOCATION_DECK):GetFirst()
	if tc2 then
		Duel.SendtoHand(tc2, nil, REASON_RULE + REASON_DRAW)
	end
end
table.insert(card.challenges, card.drawBottom)

--If you have less LP than your opponent, Special Summon one monster from your hand to the field, ignore all Summoning conditions.
function card.loserSpecial(e, tp, eg, ep, ev, re, r, rp)
	local p = nil
	if Duel.GetLP(tp) < Duel.GetLP(1 - tp) then
		p = tp
	elseif Duel.GetLP(1 - tp) < Duel.GetLP(tp) then
		p = 1 - tp
	end
	if not p or Duel.GetLocationCount(tp, LOCATION_MZONE) <= 0 then
		return
	end
	Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_SPSUMMON)
	local g = Duel.SelectMatchingCard(p, card.spfilter, p, LOCATION_HAND, 0, 1, 1, nil, e, p)
	if #g > 0 then
		Duel.SpecialSummon(g, 0, p, p, true, false, POS_FACEUP)
	end
end
table.insert(card.challenges, card.loserSpecial)

function card.spfilter(c, e, tp)
	return c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e, 0, tp, true, false)
end

--Players cannot activate Trap Cards. (They could activate their effects.)
function card.noActTrap(e, tp, eg, ep, ev, re, r, rp)
	local e1 = Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(1, 1)
	e1:SetValue(card.aclimit2)
	Duel.RegisterEffect(e1, tp)
	table.insert(card.activeChallenges, e1)
end
table.insert(card.challenges, card.noActTrap)

function card.aclimit2(e, re, tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_TRAP)
end

--Shuffle your Graveyard into your Deck and then put the top 15 cards of your Deck into the Graveyard.
function card.shuffleGrave(e, tp, eg, ep, ev, re, r, rp)
	local g = Duel.GetFieldGroup(tp, LOCATION_GRAVE, LOCATION_GRAVE)
	Duel.SendtoDeck(g, nil, 2, REASON_EFFECT)
	Duel.ShuffleDeck(tp)
	Duel.ShuffleDeck(1 - tp)
	Duel.DiscardDeck(tp, 15, REASON_RULE)
	Duel.DiscardDeck(1 - tp, 15, REASON_RULE)
end
table.insert(card.challenges, card.shuffleGrave)

--You must sing your Battle Phase.
--UNIMPLEMENTABLE

--Destroy all Continuous Spell and Trap Cards.
function card.destroyCont(e, tp, eg, ep, ev, re, r, rp)
	card.destroyFilter(
		function(c)
			return c:IsType(TYPE_CONTINUOUS)
		end,
		LOCATION_SZONE
	)
end
table.insert(card.challenges, card.destroyCont)

--Destroy all monsters with 1500 or more ATK.
function card.destroy1500MoreATK(e, tp, eg, ep, ev, re, r, rp)
	card.destroyFilter(
		function(c)
			return c:IsAttackAbove(1500)
		end,
		LOCATION_MZONE
	)
end
table.insert(card.challenges, card.destroy1500MoreATK)

--Destroy all monsters with 4 or less Levels.
function card.destroyFourLessStar(e, tp, eg, ep, ev, re, r, rp)
	card.destroyFilter(
		function(c)
			return c:IsLevelBelow(4)
		end,
		LOCATION_MZONE
	)
end
table.insert(card.challenges, card.destroyFourLessStar)

--No monsters can be face-down, flip all face-down monsters to face up and their flip effects are negated.
function card.goFaceUp(e, tp, eg, ep, ev, re, r, rp)
	local c = e:GetHandler()
	--cannot mset
	local e1 = Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_MSET)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1, 1)
	Duel.RegisterEffect(e1, tp)
	table.insert(card.activeChallenges, e1)
	--cannot turn set
	local e2 = Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_TURN_SET)
	e2:SetTargetRange(LOCATION_MZONE, LOCATION_MZONE)
	Duel.RegisterEffect(e2, tp)
	table.insert(card.activeChallenges, e2)
	local sg = Duel.GetMatchingGroup(Card.IsFacedown, tp, LOCATION_MZONE, LOCATION_MZONE, nil)
	if #sg > 0 then
		Duel.ChangePosition(sg, POS_FACEUP_ATTACK, POS_FACEUP_ATTACK, POS_FACEUP_DEFENSE, POS_FACEUP_DEFENSE, true)
	end
end
table.insert(card.challenges, card.goFaceUp)

--Shuffle your Side Deck and then draw from that instead of your Main Deck.
--UNIMPLEMENTABLE

--Swap monsters with your opponent. All of them.
function card.swapControl(e, tp, eg, ep, ev, re, r, rp)
	local g1 = Duel.GetFieldGroup(tp, LOCATION_MZONE, 0)
	local g2 = Duel.GetFieldGroup(tp, 0, LOCATION_MZONE)
	if #g1 == #g2 then
		Duel.SwapControl(g1, g2)
		return
	end
	local p = 1 - tp
	if #g2 > #g1 then
		g1, g2 = g2, g1
		p = tp
	end
	--get a subset of group 1 equal to size of group 2
	local g3 = Group.CreateGroup()
	local tc = g1:GetFirst()
	while #g3 < #g2 do
		g3:AddCard(tc)
		tc = g1:GetNext()
	end
	g1 = g1 - g3
	Duel.SwapControl(g2, g3)
	Duel.GetControl(g1, p)
end
table.insert(card.challenges, card.swapControl)

--Turn all monsters face-down.
function card.goFaceDown(e, tp, eg, ep, ev, re, r, rp)
	local g = Duel.GetMatchingGroup(Card.IsCanTurnSet, tp, LOCATION_MZONE, LOCATION_MZONE, nil)
	if #g > 0 then
		Duel.ChangePosition(g, POS_FACEDOWN_DEFENSE)
	end
end

--You can only activate cards on your turn.
function card.noActOppTurn(e, tp, eg, ep, ev, re, r, rp)
	local e1 = Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(1, 1)
	e1:SetValue(card.aclimit3)
	Duel.RegisterEffect(e1, tp)
	table.insert(card.activeChallenges, e1)
end
table.insert(card.challenges, card.noActTrap)

function card.aclimit3(e, re, tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.GetTurnPlayer() ~= tp
end

--You can only play monsters with an ATK of 1600 or higher.
function card.noSummonLowATK()
	local e1 = Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1, 1)
	e1:SetTarget(card.splimit)
	Duel.RegisterEffect(e1, tp)
	table.insert(card.activeChallenges, e1)
	local e2 = e1:Clone()
	e2:SetCode(EFFECT_CANNOT_FLIP_SUMMON)
	Duel.RegisterEffect(e2, tp)
	table.insert(card.activeChallenges, e2)
	local e3 = e1:Clone()
	e3:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	Duel.RegisterEffect(e3, tp)
	table.insert(card.activeChallenges, e3)
end

function card.splimit(e, c, sump, sumtype, sumpos, targetp, se)
	return not c:IsAttackAbove(1600)
end

--All duelists must discard a card at random.
function card.discardRandomMarik(e, tp, eg, ep, ev, re, r, rp)
	local g = Duel.GetFieldGroup(tp, LOCATION_HAND, 0)
	local sg = g:RandomSelect(tp, 1)
	Duel.SendtoGrave(sg, REASON_RULE + REASON_DISCARD)
	local g2 = Duel.GetFieldGroup(1 - tp, LOCATION_HAND, 0)
	local sg2 = g2:RandomSelect(1 - tp, 1)
	Duel.SendtoGrave(sg2, REASON_RULE + REASON_DISCARD)
end
table.insert(card.challenges, card.discardRandomMarik)

--For three turns, all monsters have "Jam" added to the ends of their names.
--When a "Jam" monster is destroyed, you can Special Summon it back to the field in Defense Position.
function card.allJam(e, tp, eg, ep, ev, re, r, rp)
	local c = e:GetHandler()
	local e1 = Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetTargetRange(LOCATION_MZONE, LOCATION_MZONE)
	e1:SetCode(EFFECT_ADD_SETCODE)
	e1:SetValue(0x54b)
	e1:SetReset(RESET_PHASE + PHASE_END, 3)
	Duel.RegisterEffect(e1, tp)
	table.insert(card.activeChallenges, e1)
	local e2 = Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetOperation(card.jamspop)
	e2:SetReset(RESET_PHASE + PHASE_END, 3)
	Duel.RegisterEffect(e2, tp)
	table.insert(card.activeChallenges, e2)
end
table.insert(card.challenges, card.allJam)

function card.jamspfilter(c, e)
	local p = c:GetControler()
	return c:IsPreviousSetCard(0x54b) and c:IsCanBeSpecialSummoned(e, nil, p, false, false)
end

function card.jamspop(e, tp, eg, ep, ev, re, r, rp)
	for tc in aux.Next(eg) do
		local p = tc:GetControler()
		if card.jamspfilter(tc, e) and Duel.GetLocationCount(p, LOCATION_MZONE) > 0 and Duel.SelectYesNo(p, 1075) then
			Duel.SpecialSummon(tc, 0, p, p, false, false, POS_FACEUP_DEFENSE)
		end
	end
end

--For three turns, duelists can activate trap cards from their hands.
function card.handTrap(e, tp, eg, ep, ev, re, r, rp)
	local c = e:GetHandler()
	local e1 = Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	e1:SetTargetRange(LOCATION_HAND, LOCATION_HAND)
	e1:SetReset(RESET_PHASE + PHASE_END, 3)
	Duel.RegisterEffect(e1, tp)
	table.insert(card.activeChallenges, e1)
end
table.insert(card.challenges, card.handTrap)

--By paying 1000 Life Points per monster, players may smite any number of their opponent's monsters
--and send them to the Graveyard.
function card.smite(e, tp, eg, ep, ev, re, r, rp)
	local p = Duel.GetTurnPlayer()
	local max1 = Duel.GetLP(p) // 1000
	local dg1 = Duel.SelectMatchingCard(p, aux.TRUE, p, 0, LOCATION_MZONE, 0, max1, nil)
	if #dg1 > 0 then
		Duel.PayLPCost(p, #dg1 * 1000)
		Duel.SendtoGrave(dg1, REASON_RULE)
	end
	local max2 = Duel.GetLP(1 - p) // 1000
	local dg2 = Duel.SelectMatchingCard(1 - p, aux.TRUE, 1 - p, 0, LOCATION_MZONE, 0, max1, nil)
	if #dg2 > 0 then
		Duel.PayLPCost(1 - p, #dg2 * 1000)
		Duel.SendtoGrave(dg2, REASON_RULE)
	end
end
table.insert(card.challenges, card.smite)

--Necrovalley is in effect for three turns. Cards cannot leave the Graveyard for 3 turns.
function card.necrovalley(e, tp, eg, ep, ev, re, r, rp)
	local c = e:GetHandler()
	--field
	local e1 = Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_ENVIRONMENT)
	e1:SetValue(CARD_NECROVALLEY)
	Duel.RegisterEffect(e1, tp)
	table.insert(card.activeChallenges, e1)
	--cannot remove
	local e2 = Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_REMOVE)
	e2:SetTargetRange(LOCATION_GRAVE, LOCATION_GRAVE)
	Duel.RegisterEffect(e2, tp)
	table.insert(card.activeChallenges, e2)
	--necro valley
	local e3 = Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_NECRO_VALLEY)
	e3:SetTargetRange(LOCATION_GRAVE, LOCATION_GRAVE)
	Duel.RegisterEffect(e3, tp)
	table.insert(card.activeChallenges, e3)
	local e4 = Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_NECRO_VALLEY)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetTargetRange(1, 1)
	Duel.RegisterEffect(e4, tp)
	table.insert(card.activeChallenges, e4)
end
table.insert(card.challenges, card.necrovalley)

--Choose a monster, a spell, and a trap card from your Graveyard and set them all onto your field.
function card.mimicat(e, tp, eg, ep, ev, re, r, rp)
	local mzc = Duel.GetLocationCount(tp, LOCATION_MZONE)
	local szc = Duel.GetLocationCount(tp, LOCATION_SZONE)
	local g = Duel.GetMatchingGroup(card.graveSetFilter, tp, LOCATION_GRAVE, 0, nil, e, tp)
	if #g>0 and aux.SelectUnselectGroup(g, e, tp, 1, 3, card.rescon(mzc, szc, g), 0) then
		local sg = aux.SelectUnselectGroup(g, e, tp, 1, 3, card.rescon(mzc, szc, g), 1, tp, HINTMSG_SET, card.rescon(mzc, szc, g))
		local sg1 = sg:Filter(Card.IsType, nil, TYPE_MONSTER)
		local sg2 = sg - sg1
		if #sg1 > 0 then
			Duel.SpecialSummon(sg1, 0, tp, tp, true, true, POS_FACEDOWN_DEFENSE)
		end
		if #sg2 > 0 then
			Duel.SSet(tp, sg2)
		end
		Duel.ConfirmCards(1 - tp, sg)
	end
	mzc = Duel.GetLocationCount(1 - tp, LOCATION_MZONE)
	szc = Duel.GetLocationCount(1 - tp, LOCATION_SZONE)
	g = Duel.GetMatchingGroup(card.graveSetFilter, 1 - tp, LOCATION_GRAVE, 0, nil, e, 1 - tp)
	if #g>0 and aux.SelectUnselectGroup(g, e, 1 - tp, 1, 3, card.rescon(mzc, szc, g), 0) then
		local sg = aux.SelectUnselectGroup(g, e, 1 - tp, 1, 3, card.rescon(mzc, szc, g), 1, 1 - tp, HINTMSG_SET, card.rescon(mzc, szc, g))
		local sg1 = sg:Filter(Card.IsType, nil, TYPE_MONSTER)
		local sg2 = sg - sg1
		if #sg1 > 0 then
			Duel.SpecialSummon(sg1, 0, 1 - tp, 1 - tp, true, true, POS_FACEDOWN_DEFENSE)
		end
		if #sg2 > 0 then
			Duel.SSet(1 - tp, sg2)
		end
		Duel.ConfirmCards(tp, sg)
	end
end
table.insert(card.challenges, card.mimicat)

function card.graveSetFilter(c, e, tp)
	return (c:IsType(TYPE_SPELL + TYPE_TRAP) and c:IsSSetable()) or
		(c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e, 0, tp, true, true, POS_FACEDOWN_DEFENSE))
end

function card.rescon(mzc, szc, g)
	return function (sg, e, tp, mg)
			if mzc > 0 and g:IsExists(Card.IsType, 1, nil, TYPE_MONSTER) and sg:FilterCount(Card.IsType, nil, TYPE_MONSTER) ~= 1 then
				return false
			elseif mzc == 0 and sg:FilterCount(Card.IsType, nil, TYPE_MONSTER) ~= 0 then
				return false
			end
			local bg = sg:Filter(aux.NOT(Card.IsType), nil, TYPE_MONSTER)
			if szc == 0 then
				if g:IsExists(Card.IsType, 1, nil, TYPE_FIELD) then
					return #bg == 1 and bg:GetFirst():IsType(TYPE_FIELD)
				else
					return #bg == 0
				end
			elseif szc == 1 then
				if #bg > 2 then return false end
				if g:IsExists(Card.IsType, 1, nil, TYPE_SPELL | TYPE_TRAP) then
					return bg:IsExists(card.raux1, 1, nil, bg, g, true)
				end
			else
				if #bg > 2 then return false end
				if g:IsExists(Card.IsType, 1, nil, TYPE_SPELL | TYPE_TRAP) then
					return bg:IsExists(card.raux1, 1, nil, bg, g, false) and bg:FilterCount(Card.IsType, nil, TYPE_FIELD) <= 1
				end
			end
			return true
		end
end
function card.raux1(c, bg, g, mfield)
	local bool = g:IsExists(card.raux2, 1, c, (TYPE_SPELL | TYPE_TRAP)&(~c:GetType()), not c:IsType(TYPE_FIELD), mfield)
	return (bool and bg:IsExists(card.raux2, 1, c, (TYPE_SPELL | TYPE_TRAP)&(~c:GetType()), not c:IsType(TYPE_FIELD), mfield)) 
		or (not bool and bg:FilterCount(aux.TRUE, c) == 0)
end
function card.raux2(c, type, field, mfield)
	if type == 0 then type = TYPE_SPELL | TYPE_TRAP end
	if mfield then
		return c:IsType(type) and ((field and c:IsType(TYPE_FIELD)) or (not field and not c:IsType(TYPE_FIELD)))
	else
		return c:IsType(type)
	end
end

--Each duelist must search his or her deck for any card, add it to their hand, and shuffle their deck afterward.
function card.search(e, tp, eg, ep, ev, re, r, rp)
	local g = Duel.SelectMatchingCard(tp, aux.TRUE, tp, LOCATION_DECK, 0, 1, 1, nil)
	if #g > 0 then
		Duel.SendtoHand(g, nil, REASON_RULE)
		Duel.ConfirmCards(1 - tp, g)
	end
	local g2 = Duel.SelectMatchingCard(1 - tp, aux.TRUE, 1 - tp, LOCATION_DECK, 0, 1, 1, nil)
	if #g2 > 0 then
		Duel.SendtoHand(g2, nil, REASON_RULE)
		Duel.ConfirmCards(tp, g2)
	end
end
table.insert(card.challenges, card.search)

--All old rules become no longer in effect, and all players reveal their hands and face-down cards to their opponents.
function card.reset(e, tp, eg, ep, ev, re, r, rp)
	for _, e in ipairs(card.activeChallenges) do
		e:Reset()
	end
	card.activeChallenges = {}
	local g = Duel.GetFieldGroup(tp, LOCATION_HAND + LOCATION_MZONE + LOCATION_SZONE, 0):Filter(Card.IsFacedown)
	Duel.ConfirmCards(1 - tp, g)
	local g2 = Duel.GetFieldGroup(tp, 0, LOCATION_HAND + LOCATION_MZONE + LOCATION_SZONE):Filter(Card.IsFacedown)
	Duel.ConfirmCards(tp, g2)
end
table.insert(card.challenges, card.reset)

--Choose a card in your opponent's graveyard and set it to your side of the field.
function card.graveSteal(e, tp, eg, ep, ev, re, r, rp)
	local tc = Duel.SelectMatchingCard(tp, card.graveStealFilter, tp, 0, LOCATION_GRAVE, 1, 1, nil, tp):GetFirst()
	if tc then
		if tc:IsType(TYPE_MONSTER) then
			Duel.SpecialSummon(tc, 0, tp, tp, true, true, POS_FACEDOWN_DEFENSE)
		else
			Duel.SSet(tp, tc)
		end
		Duel.ConfirmCards(1 - tp, tc)
	end
	local tc2 =
		Duel.SelectMatchingCard(1 - tp, card.graveStealFilter, 1 - tp, 0, LOCATION_GRAVE, 1, 1, nil, 1 - tp):GetFirst()
	if tc2 then
		if tc2:IsType(TYPE_MONSTER) then
			Duel.SpecialSummon(tc2, 0, 1 - tp, 1 - tp, true, true, POS_FACEDOWN_DEFENSE)
		else
			Duel.SSet(1 - tp, tc2)
		end
		Duel.ConfirmCards(tp, tc2)
	end
end
table.insert(card.challenges, card.graveSteal)

function card.graveStealFilter(c, tp)
	return (c:IsType(TYPE_SPELL + TYPE_TRAP) and c:IsSSetable() and Duel.GetLocationCount(tp, LOCATION_SZONE) > 0) or
		(c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e, 0, tp, true, true, POS_FACEDOWN_DEFENSE) and
			Duel.GetLocationCount(tp, LOCATION_MZONE) > 0)
end

--Each duelist may draw up to two cards, but loses 1000 Life Points for each card he or she chooses to draw.
--The turn player decides how many cards to draw first.
function card.costDraw(e, tp, eg, ep, ev, re, r, rp)
	local p = Duel.GetTurnPlayer()
	local ct = Duel.AnnounceLevel(p, 0, math.min(2, Duel.GetFieldGroupCount(p, LOCATION_DECK)))
	Duel.Draw(p, ct, REASON_RULE)
	Duel.SetLP(p, Duel.GetLP(p) - 1000 * ct)
	local ct = Duel.AnnounceLevel(1 - p, 0, math.min(2, Duel.GetFieldGroupCount(1 - p, LOCATION_DECK)))
	Duel.Draw(1 - p, ct, REASON_RULE)
	Duel.SetLP(1 - p, Duel.GetLP(1 - p) - 1000 * ct)
end
table.insert(card.challenges, card.costDraw)
