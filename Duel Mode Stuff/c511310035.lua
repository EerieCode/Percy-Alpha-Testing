--Pegasus Ultimate Challenge
--Scripted by AlphaKretin
local scard, s_id = GetID()
local ADJUST_COUNT_MEAN = 75 --average number of adjusts between challenges
local ADJUST_COUNT_VAR = 25 --number of adjusts between challenges can be mean +- this
local EVENT_PEGASUS_SPEAKS = EVENT_CUSTOM + s_id

function scard.initial_effect(c)
    --enable REVERSE_DECK function
    Duel.EnableGlobalFlag(GLOBALFLAG_DECK_REVERSE_CHECK)
    --Add Extra Rule procedure
    aux.EnableExtraRule(c, scard)
    if not scard.global_check then
        scard.global_check = true
        scard[0] = false
        scard[1] = false
        scard.adjustCount = scard.getAdjustCount()
        --check for destroyed card this turn
        local ge1 = Effect.CreateEffect(c)
        ge1:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_CONTINUOUS)
        ge1:SetCode(EVENT_DESTROYED)
        ge1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
        ge1:SetOperation(scard.checkop)
        Duel.RegisterEffect(ge1, 0)
        local ge2 = Effect.CreateEffect(c)
        ge2:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_CONTINUOUS)
        ge2:SetCode(EVENT_TURN_END)
        ge2:SetCountLimit(1)
        ge2:SetCondition(scard.clear)
        Duel.RegisterEffect(ge2, 0)
        --Apply challenges
        local e3 = Effect.CreateEffect(c)
        e3:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_CONTINUOUS)
        e3:SetCode(EVENT_PEGASUS_SPEAKS)
        e3:SetCondition(scard.chalcon)
        e3:SetOperation(scard.chalop)
        Duel.RegisterEffect(e3, 0)
        local e4 = Effect.CreateEffect(c)
        e4:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_CONTINUOUS)
        e4:SetCode(EVENT_ADJUST)
        e4:SetLabelObject(e3)
        e4:SetCondition(scard.chalcon)
        e4:SetOperation(scard.eventop)
        Duel.RegisterEffect(e4, 0)
    end
end

scard.illegal = true --enables announcing illegal card names. Crucially this includes the "Yu-Gi-Oh!" token
scard.challenges = {} --table of functions that apply the challenges
scard.activeChallenges = {} --table of effects for lingering challenges to be reset for the challenge that does so

function scard.getAdjustCount()
    return ADJUST_COUNT_MEAN + Duel.GetRandomNumber(-ADJUST_COUNT_VAR, ADJUST_COUNT_VAR)
end

function scard.eventop(e, tp)
    --if challenge already queued
    if e:GetLabelObject():GetLabel() > 0 then
        --raise the event again without changing the challenge until the challenge happenes
        Duel.RaiseEvent(Group.CreateGroup(), EVENT_PEGASUS_SPEAKS, e, 0, 0, 0, 0)
    else
        --decrement "timer" until next challenge
        scard.adjustCount = scard.adjustCount - 1
        --if next challenge is due
        if scard.adjustCount <= 0 then
            --select a random challenge
            local challenge = Duel.GetRandomNumber(1, #scard.challenges)
            --announce the challenge
            Duel.SelectOption(0, aux.Stringid(5000, challenge - 1)) --if over 15 wraps to next token
            Duel.SelectOption(1, aux.Stringid(5000, challenge - 1))
            --queue the challenge
            e:GetLabelObject():SetLabel(challenge)
            --raise the event for the challenge to happen
            Duel.RaiseEvent(Group.CreateGroup(), EVENT_PEGASUS_SPEAKS, e, 0, 0, 0, 0)
            --reset timer
            scard.adjustCount = scard.getAdjustCount()
        end
    end
end

function scard.chalcon(e, tp)
    --set by extra rule
    return scard.global_active_check
end

function scard.chalop(e, tp)
    --if the game state is open or a chain is building (but not resolving)
    if Duel.GetCurrentChain() == 0 or Duel.CheckEvent(EVENT_CHAINING) then
        local challenge = e:GetLabel()
        --clear the queue before challenge to avoid recursion in challenges that raise adjusts
        e:SetLabel(0)
        --apply the queued challenge
        scard.challenges[challenge](e, tp)
    end
end

--helper function to apply custom reset to challenges
function scard.applyNewChallengeReset(e)
    local e1 = Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_CONTINUOUS + EFFECT_TYPE_FIELD)
    e1:SetCode(EVENT_PEGASUS_SPEAKS)
    e1:SetLabelObject(e)
    e1:SetOperation(scard.resetop)
    Duel.RegisterEffect(e1, e:GetHandlerPlayer())
end

function scard.resetop(e)
    e:GetLabelObject():Reset()
    e:Reset()
end

--helper function to "play" a card
function scard.playCard(c, p)
    if c and not c:IsForbidden() then
        local canSummon = Duel.GetLocationCount(p, LOCATION_MZONE) > 0
        local canPendActivate =
            c:IsType(TYPE_PENDULUM) and
            (Duel.CheckLocation(p, LOCATION_PZONE, 0) or Duel.CheckLocation(p, LOCATION_PZONE, 1))
        if c:IsType(TYPE_MONSTER) then
            --check for monster seperately so skips next block if is monster
            if (canSummon or canPendActivate) then
                --TODO: This could be made more efficient surely
                if canSummon and not canPendActivate and Duel.SelectYesNo(p, 1152) then --Special Summon
                    --play monster to the field (skill summon!)
                    return Duel.MoveToField(c, p, p, LOCATION_MZONE, POS_FACEUP, true, 0x1f)
                elseif canPendActivate and not canSummon and Duel.SelectYesNo(p, 1160) then --Activate in PZONE
                    return Duel.MoveToField(c, p, p, LOCATION_PZONE, POS_FACEUP, true)
                elseif canSummon and canPendActivate then
                    local opt = Duel.SelectOption(p, 1203, 1152, 1160) --N/A, SS, PZone
                    if opt == 1 then
                        return Duel.MoveToField(c, p, p, LOCATION_MZONE, POS_FACEUP, true, 0x1f)
                    elseif opt == 2 then
                        return Duel.MoveToField(c, p, p, LOCATION_PZONE, POS_FACEUP, true)
                    end
                end
            end
        else
            --activate backrow
            local ae = c:GetActivateEffect()
            if ae and ae:IsActivatable(p) and Duel.SelectYesNo(p, 94) then
                --not just for show, actually helps it not crash! go figure
                if Duel.MoveToField(c, p, p, LOCATION_SZONE, POS_FACEDOWN, true, 0x1f) then
                    Duel.Activate(ae)
                    return true
                end
            end
        end
    end
    return false
end

--helper function do destroy all cards that fit a filter
function scard.destroyFilter(func, loc)
    local dg = Duel.GetMatchingGroup(func, 0, loc, loc, nil) --which player doesn't matter because we get both sides
    if #dg > 0 then
        Duel.Destroy(dg, REASON_RULE)
    end
end

--All players reveal the top card of their deck. You may play that card immediately, starting with the turn player.
function scard.playTopCard(e, tp)
    local p = Duel.GetTurnPlayer()
    Duel.ConfirmDecktop(p, 1)
    local turnPlayersCard = Duel.GetDecktopGroup(p, 1):GetFirst()
    Duel.ConfirmDecktop(1 - p, 1)
    local nonTurnPlayersCard = Duel.GetDecktopGroup(1 - p, 1):GetFirst()
    scard.playCard(turnPlayersCard, p)
    scard.playCard(nonTurnPlayersCard, 1 - p)
end
table.insert(scard.challenges, scard.playTopCard)

--Both players play with their hands revealed.
function scard.revealHands(e, tp)
    local e1 = Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetCode(EFFECT_PUBLIC)
    e1:SetTargetRange(LOCATION_HAND, LOCATION_HAND)
    Duel.RegisterEffect(e1, tp)
    scard.applyNewChallengeReset(e1)
end
table.insert(scard.challenges, scard.revealHands)

--Destroy all monsters with five or more stars.
function scard.destroyFivePlusStar(e, tp)
    scard.destroyFilter(
        function(c)
            return c:IsLevelAbove(5) or c:IsRankAbove(5)
        end,
        LOCATION_MZONE
    )
end
table.insert(scard.challenges, scard.destroyFivePlusStar)

--Everyone discard a random card from their hand.
function scard.discardRandom(e, tp)
    local g = Duel.GetFieldGroup(tp, LOCATION_HAND, 0)
    local sg = g:RandomSelect(tp, 1)
    Duel.SendtoGrave(sg, REASON_RULE + REASON_DISCARD)
    local g2 = Duel.GetFieldGroup(1 - tp, LOCATION_HAND, 0)
    local sg2 = g2:RandomSelect(1 - tp, 1)
    Duel.SendtoGrave(sg2, REASON_RULE + REASON_DISCARD)
end
table.insert(scard.challenges, scard.discardRandom)

--Everyone stop and introduce yourself to the person sitting on your right.
function scard.introduce(e, tp)
    --only displays a message, as handled by chalop
end
table.insert(scard.challenges, scard.introduce)

--Lose 500 LP for each Spell and Trap Card you control.
function scard.loseLPForBackrow(e, tp)
    local tpLoss = Duel.GetFieldGroupCount(tp, LOCATION_SZONE, 0) * 500
    local ntpLoss = Duel.GetFieldGroupCount(tp, 0, LOCATION_SZONE) * 500
    --Happens at same time and causes draw if appropriate
    Duel.SetLP(tp, Duel.GetLP(tp) - tpLoss)
    Duel.SetLP(1 - tp, Duel.GetLP(1 - tp) - ntpLoss)
end
table.insert(scard.challenges, scard.loseLPForBackrow)

--Shuffle your hand into your deck and then draw that many cards.
function scard.mulligan(e, tp)
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
table.insert(scard.challenges, scard.mulligan)

--Swap LP with your opponent.
function scard.swapLP(e, tp)
    local temp = Duel.GetLP(tp)
    Duel.SetLP(tp, Duel.GetLP(1 - tp))
    Duel.SetLP(1 - tp, temp)
end
table.insert(scard.challenges, scard.swapLP)

--Destroy all monsters with 1500 or less ATK.
function scard.destroy1500LessATK(e, tp)
    scard.destroyFilter(
        function(c)
            return c:IsAttackBelow(1500)
        end,
        LOCATION_MZONE
    )
end
table.insert(scard.challenges, scard.destroy1500LessATK)

--If you had a card destroyed this turn, you may destroy one of your opponent's cards.
function scard.paybackDestroy(e, tp)
    if scard[tp] then
        local dc = Duel.SelectMatchingCard(tp, aux.TRUE, tp, 0, LOCATION_ONFIELD, 0, 1, nil)
        if #dc > 0 then
            Duel.Destroy(dc, REASON_RULE)
        end
    end
    if scard[1 - tp] then
        local dc = Duel.SelectMatchingCard(1 - tp, aux.TRUE, 1 - tp, 0, LOCATION_ONFIELD, 0, 1, nil)
        if #dc > 0 then
            Duel.Destroy(dc, REASON_RULE)
        end
    end
end
table.insert(scard.challenges, scard.paybackDestroy)

function scard.checkop(e, tp, eg)
    for tc in aux.Next(eg) do
        scard[tc:GetPreviousControler()] = true
    end
end

function scard.clear(e, tp)
    scard[0] = false
    scard[1] = false
    return false
end

--Players cannot activate Spell Cards. (They could activate their effects.)
function scard.noActSpell(e, tp)
    local e1 = Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e1:SetCode(EFFECT_CANNOT_ACTIVATE)
    e1:SetTargetRange(1, 1)
    e1:SetValue(scard.aclimit)
    Duel.RegisterEffect(e1, tp)
    scard.applyNewChallengeReset(e1)
end
table.insert(scard.challenges, scard.noActSpell)

function scard.aclimit(e, re, tp)
    return re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_SPELL)
end

--Remove all cards in all graveyard from the game.
function scard.vanishGrave(e, tp)
    local rg = Duel.GetFieldGroup(tp, LOCATION_GRAVE, LOCATION_GRAVE)
    Duel.DisableShuffleCheck()
    Duel.SendtoDeck(rg, nil, -2, REASON_RULE)
end
table.insert(scard.challenges, scard.vanishGrave)

--Switch the ATK and DEF of all monsters on the field.
function scard.switchATKDEF(e, tp)
    local g = Duel.GetFieldGroup(tp, LOCATION_MZONE, LOCATION_MZONE)
    local c = e:GetHandler()
    for tc in aux.Next(g) do
        local e1 = Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_SWAP_AD)
        e1:SetReset(RESET_EVENT + RESETS_STANDARD)
        tc:RegisterEffect(e1)
        scard.applyNewChallengeReset(e1)
    end
end
table.insert(scard.challenges, scard.switchATKDEF)

--Turn your deck over and then draw from the new top of the deck.
function scard.reverseDeck(e, tp)
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
    e2:SetOperation(scard.drop)
    Duel.RegisterEffect(e2, tp)
    scard.applyNewChallengeReset(e1)
end
table.insert(scard.challenges, scard.reverseDeck)

function scard.drop(e, tp)
    Duel.Draw(tp, 1, REASON_RULE)
    Duel.Draw(1 - tp, 1, REASON_RULE)
    e:Reset()
end

--You cannot attack unless you say "Yu-Gi-Oh!"
function scard.attackCost(e, tp)
    --attack cost
    local e1 = Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetCode(EFFECT_ATTACK_COST)
    e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e1:SetTargetRange(1, 1)
    e1:SetOperation(scard.atop)
    Duel.RegisterEffect(e1, tp)
    scard.applyNewChallengeReset(e1)
end
table.insert(scard.challenges, scard.attackCost)

function scard.atop(e, tp)
    if Duel.IsAttackCostPaid() ~= 2 then
        local CARD_YUGIOH = 5000
        scard.announce_filter = {CARD_YUGIOH, OPCODE_ISCODE}
        Duel.AnnounceCardFilter(tp, table.unpack(scard.announce_filter))
        Duel.AttackCostPaid()
    end
end

--All monsters become Normal Monsters with no effects.
function scard.becomeNormal(e, tp)
    local c = e:GetHandler()
    --disable
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetTargetRange(LOCATION_MZONE, LOCATION_MZONE)
    e1:SetCode(EFFECT_DISABLE)
    Duel.RegisterEffect(e1, tp)
    scard.applyNewChallengeReset(e1)
    --type
    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_FIELD)
    e2:SetTargetRange(LOCATION_MZONE, LOCATION_MZONE)
    e2:SetCode(EFFECT_CHANGE_TYPE)
    e2:SetValue(TYPE_NORMAL)
    Duel.RegisterEffect(e2, tp)
    scard.applyNewChallengeReset(e2)
end
table.insert(scard.challenges, scard.becomeNormal)

--Destroy all cards on the field.
function scard.destroyAll(e, tp)
    scard.destroyFilter(aux.TRUE, LOCATION_ONFIELD)
end
table.insert(scard.challenges, scard.destroyAll)

--Destroy all monsters.
function scard.destroyMonster(e, tp)
    scard.destroyFilter(aux.TRUE, LOCATION_MZONE)
end
table.insert(scard.challenges, scard.destroyMonster)

--Destroy all Spell and Trap Cards.
function scard.destroyBackrow(e, tp)
    scard.destroyFilter(aux.TRUE, LOCATION_SZONE)
end
table.insert(scard.challenges, scard.destroyBackrow)

--Destroy all face-up Xyz Monsters.
function scard.destroyXyz(e, tp)
    scard.destroyFilter(
        function(c)
            return c:IsFaceup() and c:IsType(TYPE_XYZ)
        end,
        LOCATION_MZONE
    )
end
table.insert(scard.challenges, scard.destroyXyz)

--Discard your hand and then draw that many cards.
function scard.discardMulligan(e, tp)
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
table.insert(scard.challenges, scard.discardMulligan)

--Everyone draw the bottom card of their Deck.
function scard.drawBottom(e, tp)
    local tc = Duel.GetFieldGroup(tp, LOCATION_DECK, 0):GetFirst() --first card in deck is bottom
    if tc then
        Duel.SendtoHand(tc, nil, REASON_RULE + REASON_DRAW)
    end
    local tc2 = Duel.GetFieldGroup(tp, 0, LOCATION_DECK):GetFirst()
    if tc2 then
        Duel.SendtoHand(tc2, nil, REASON_RULE + REASON_DRAW)
    end
end
table.insert(scard.challenges, scard.drawBottom)

--If you have less LP than your opponent, Special Summon one monster from your hand to the field, ignore all Summoning conditions.
function scard.loserSpecial(e, tp)
    local p = nil
    if Duel.GetLP(tp) < Duel.GetLP(1 - tp) then
        p = tp
    elseif Duel.GetLP(1 - tp) < Duel.GetLP(tp) then
        p = 1 - tp
    end
    if not p or Duel.GetLocationCount(p, LOCATION_MZONE) <= 0 then
        return
    end
    Duel.Hint(HINT_SELECTMSG, p, HINTMSG_SPSUMMON)
    local g = Duel.SelectMatchingCard(p, scard.spfilter, p, LOCATION_HAND, 0, 1, 1, nil, e, p)
    if #g > 0 then
        Duel.SpecialSummon(g, 0, p, p, true, false, POS_FACEUP)
    end
end
table.insert(scard.challenges, scard.loserSpecial)

function scard.spfilter(c, e, tp)
    return c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e, 0, tp, true, false)
end

--Players cannot activate Trap Cards. (They could activate their effects.)
function scard.noActTrap(e, tp)
    local e1 = Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e1:SetCode(EFFECT_CANNOT_ACTIVATE)
    e1:SetTargetRange(1, 1)
    e1:SetValue(scard.aclimit2)
    Duel.RegisterEffect(e1, tp)
    scard.applyNewChallengeReset(e1)
end
table.insert(scard.challenges, scard.noActTrap)

function scard.aclimit2(e, re, tp)
    return re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_TRAP)
end

--Shuffle your Graveyard into your Deck and then put the top 15 cards of your Deck into the Graveyard.
function scard.shuffleGrave(e, tp)
    local g = Duel.GetFieldGroup(tp, LOCATION_GRAVE, LOCATION_GRAVE)
    Duel.SendtoDeck(g, nil, 2, REASON_EFFECT)
    Duel.ShuffleDeck(tp)
    Duel.ShuffleDeck(1 - tp)
    Duel.DiscardDeck(tp, 15, REASON_RULE)
    Duel.DiscardDeck(1 - tp, 15, REASON_RULE)
end
table.insert(scard.challenges, scard.shuffleGrave)

--You must sing your Battle Phase.
--UNIMPLEMENTABLE

--Destroy all Continuous Spell and Trap Cards.
function scard.destroyCont(e, tp)
    scard.destroyFilter(
        function(c)
            return c:IsType(TYPE_CONTINUOUS)
        end,
        LOCATION_SZONE
    )
end
table.insert(scard.challenges, scard.destroyCont)

--Destroy all monsters with 1500 or more ATK.
function scard.destroy1500MoreATK(e, tp)
    scard.destroyFilter(
        function(c)
            return c:IsAttackAbove(1500)
        end,
        LOCATION_MZONE
    )
end
table.insert(scard.challenges, scard.destroy1500MoreATK)

--Destroy all monsters with 4 or less Levels.
function scard.destroyFourLessStar(e, tp)
    scard.destroyFilter(
        function(c)
            return c:IsLevelBelow(4)
        end,
        LOCATION_MZONE
    )
end
table.insert(scard.challenges, scard.destroyFourLessStar)

--No monsters can be face-down, flip all face-down monsters to face up and their flip effects are negated.
--TODO: Is there a practical difference between "flip effects negated" and "don't activate flip effects when flipped"?
function scard.goFaceUp(e, tp)
    local c = e:GetHandler()
    --cannot mset
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetCode(EFFECT_CANNOT_MSET)
    e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e1:SetTargetRange(1, 1)
    Duel.RegisterEffect(e1, tp)
    scard.applyNewChallengeReset(e1)
    --cannot turn set
    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_FIELD)
    e2:SetCode(EFFECT_CANNOT_TURN_SET)
    e2:SetTargetRange(LOCATION_MZONE, LOCATION_MZONE)
    Duel.RegisterEffect(e2, tp)
    scard.applyNewChallengeReset(e2)
    local sg = Duel.GetMatchingGroup(scard.IsFacedown, tp, LOCATION_MZONE, LOCATION_MZONE, nil)
    if #sg > 0 then
        Duel.ChangePosition(sg, POS_FACEUP_ATTACK, POS_FACEUP_ATTACK, POS_FACEUP_DEFENSE, POS_FACEUP_DEFENSE, true)
    end
end
table.insert(scard.challenges, scard.goFaceUp)

--Shuffle your Side Deck and then draw from that instead of your Main Deck.
--UNIMPLEMENTABLE

--Swap monsters with your opponent. All of them.
function scard.swapControl(e, tp)
    local g1 = Duel.GetFieldGroup(tp, LOCATION_MZONE, 0)
    local g2 = Duel.GetFieldGroup(tp, 0, LOCATION_MZONE)
    if #g1 == #g2 then
        Duel.SwapControl(g1, g2)
        return
    end
    --workaround for groups of different sizes
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
table.insert(scard.challenges, scard.swapControl)

--Turn all monsters face-down. They cannot be flipped up this turn.
function scard.goFaceDown(e, tp)
    local g = Duel.GetMatchingGroup(scard.IsCanTurnSet, tp, LOCATION_MZONE, LOCATION_MZONE, nil)
    if #g > 0 then
        Duel.ChangePosition(g, POS_FACEDOWN_DEFENSE)
        --pos limit
        local e1 = Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_FIELD)
        e1:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
        e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
        e1:SetTargetRange(LOCATION_MZONE, LOCATION_MZONE)
        e1:SetTarget(aux.TargetBoolFunction(scard.IsFacedown))
        e1:SetReset(RESET_PHASE + PHASE_END)
        Duel.RegisterEffect(e1, tp)
    end
end
table.insert(scard.challenges, scard.goFaceDown)

--You can only activate cards on your turn.
function scard.noActOppTurn(e, tp)
    local e1 = Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e1:SetCode(EFFECT_CANNOT_ACTIVATE)
    e1:SetTargetRange(1, 1)
    e1:SetValue(scard.aclimit3)
    Duel.RegisterEffect(e1, tp)
    scard.applyNewChallengeReset(e1)
end
table.insert(scard.challenges, scard.noActTrap)

function scard.aclimit3(e, re, tp)
    return re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.GetTurnPlayer() ~= tp
end

--All duelists must discard a card at random.
function scard.discardRandomMarik(e, tp)
    local g = Duel.GetFieldGroup(tp, LOCATION_HAND, 0)
    local sg = g:RandomSelect(tp, 1)
    Duel.SendtoGrave(sg, REASON_RULE + REASON_DISCARD)
    local g2 = Duel.GetFieldGroup(1 - tp, LOCATION_HAND, 0)
    local sg2 = g2:RandomSelect(1 - tp, 1)
    Duel.SendtoGrave(sg2, REASON_RULE + REASON_DISCARD)
end
table.insert(scard.challenges, scard.discardRandomMarik)

--For three turns, all monsters have "Jam" added to the ends of their names.
--When a "Jam" monster is destroyed, you can Special Summon it back to the field in Defense Position.
function scard.allJam(e, tp)
    local c = e:GetHandler()
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetTargetRange(LOCATION_MZONE, LOCATION_MZONE)
    e1:SetCode(EFFECT_ADD_SETCODE)
    e1:SetValue(0x54b)
    e1:SetReset(RESET_PHASE + PHASE_END, 3)
    Duel.RegisterEffect(e1, tp)
    table.insert(scard.activeChallenges, e1)
    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_CONTINUOUS)
    e2:SetCode(EVENT_DESTROYED)
    e2:SetOperation(scard.jamspop)
    e2:SetReset(RESET_PHASE + PHASE_END, 3)
    Duel.RegisterEffect(e2, tp)
    table.insert(scard.activeChallenges, e2)
end
table.insert(scard.challenges, scard.allJam)

function scard.jamspfilter(c, e)
    local p = c:GetControler()
    return c:IsPreviousSetCard(0x54b) and c:IsCanBeSpecialSummoned(e, nil, p, false, false)
end

function scard.jamspop(e, tp, eg)
    for tc in aux.Next(eg) do
        local p = tc:GetControler()
        if
            scard.jamspfilter(tc, e) and
                (not tc:IsLocation(LOCATION_EXTRA) and Duel.GetLocationCount(p, LOCATION_MZONE) > 0) or
                (tc:IsLocation(LOCATION_EXTRA) and Duel.GetLocationCountFromEx(p) > 0) and Duel.SelectYesNo(p, 1075)
         then
            Duel.SpecialSummon(tc, 0, p, p, false, false, POS_FACEUP_DEFENSE)
        end
    end
end

--For three turns, duelists can activate trap cards from their hands.
function scard.handTrap(e, tp)
    local c = e:GetHandler()
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetCode(EFFECT_TRAP_ACT_IN_HAND)
    e1:SetTargetRange(LOCATION_HAND, LOCATION_HAND)
    e1:SetReset(RESET_PHASE + PHASE_END, 3)
    Duel.RegisterEffect(e1, tp)
    table.insert(scard.activeChallenges, e1)
end
table.insert(scard.challenges, scard.handTrap)

--By paying 1000 Life Points per monster, players may smite any number of their opponent's monsters
--and send them to the Graveyard.
function scard.smite(e, tp)
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
table.insert(scard.challenges, scard.smite)

--Necrovalley is in effect for three turns. Cards cannot leave the Graveyard for 3 turns.
function scard.necrovalley(e, tp)
    local c = e:GetHandler()
    --field
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetCode(EFFECT_CHANGE_ENVIRONMENT)
    e1:SetValue(CARD_NECROVALLEY)
    Duel.RegisterEffect(e1, tp)
    table.insert(scard.activeChallenges, e1)
    --cannot remove
    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_FIELD)
    e2:SetCode(EFFECT_CANNOT_REMOVE)
    e2:SetTargetRange(LOCATION_GRAVE, LOCATION_GRAVE)
    Duel.RegisterEffect(e2, tp)
    table.insert(scard.activeChallenges, e2)
    --necro valley
    local e3 = Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_FIELD)
    e3:SetCode(EFFECT_NECRO_VALLEY)
    e3:SetTargetRange(LOCATION_GRAVE, LOCATION_GRAVE)
    Duel.RegisterEffect(e3, tp)
    table.insert(scard.activeChallenges, e3)
    local e4 = Effect.CreateEffect(c)
    e4:SetType(EFFECT_TYPE_FIELD)
    e4:SetCode(EFFECT_NECRO_VALLEY)
    e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e4:SetTargetRange(1, 1)
    Duel.RegisterEffect(e4, tp)
    table.insert(scard.activeChallenges, e4)
end
table.insert(scard.challenges, scard.necrovalley)

--Choose a monster, a spell, and a trap card from your Graveyard and set them all onto your field.
--Credit to andré for SelectUnselectLoop that handles Fields and Spell/Traps
function scard.mimicat(e, tp)
    local mzc = Duel.GetLocationCount(tp, LOCATION_MZONE)
    local szc = Duel.GetLocationCount(tp, LOCATION_SZONE)
    local g = Duel.GetMatchingGroup(scard.graveSetFilter, tp, LOCATION_GRAVE, 0, nil, e, tp)
    if #g > 0 and aux.SelectUnselectGroup(g, e, tp, 1, 3, scard.rescon(mzc, szc, g), 0) then
        local sg =
            aux.SelectUnselectGroup(
            g,
            e,
            tp,
            1,
            3,
            scard.rescon(mzc, szc, g),
            1,
            tp,
            HINTMSG_SET,
            scard.rescon(mzc, szc, g)
        )
        local sg1 = sg:Filter(scard.IsType, nil, TYPE_MONSTER)
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
    g = Duel.GetMatchingGroup(scard.graveSetFilter, 1 - tp, LOCATION_GRAVE, 0, nil, e, 1 - tp)
    if #g > 0 and aux.SelectUnselectGroup(g, e, 1 - tp, 1, 3, scard.rescon(mzc, szc, g), 0) then
        local sg =
            aux.SelectUnselectGroup(
            g,
            e,
            1 - tp,
            1,
            3,
            scard.rescon(mzc, szc, g),
            1,
            1 - tp,
            HINTMSG_SET,
            scard.rescon(mzc, szc, g)
        )
        local sg1 = sg:Filter(scard.IsType, nil, TYPE_MONSTER)
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
table.insert(scard.challenges, scard.mimicat)

function scard.graveSetFilter(c, e, tp)
    return (c:IsType(TYPE_SPELL + TYPE_TRAP) and c:IsSSetable()) or
        (c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e, 0, tp, true, true, POS_FACEDOWN_DEFENSE))
end

function scard.rescon(mzc, szc, g)
    return function(sg, e, tp, mg)
        if
            mzc > 0 and g:IsExists(scard.IsType, 1, nil, TYPE_MONSTER) and
                sg:FilterCount(scard.IsType, nil, TYPE_MONSTER) ~= 1
         then
            return false
        elseif mzc == 0 and sg:FilterCount(scard.IsType, nil, TYPE_MONSTER) ~= 0 then
            return false
        end
        local bg = sg:Filter(aux.NOT(scard.IsType), nil, TYPE_MONSTER)
        if szc == 0 then
            if g:IsExists(scard.IsType, 1, nil, TYPE_FIELD) then
                return #bg == 1 and bg:GetFirst():IsType(TYPE_FIELD)
            else
                return #bg == 0
            end
        elseif szc == 1 then
            if #bg > 2 then
                return false
            end
            if g:IsExists(scard.IsType, 1, nil, TYPE_SPELL | TYPE_TRAP) then
                return bg:IsExists(scard.raux1, 1, nil, bg, g, true)
            end
        else
            if #bg > 2 then
                return false
            end
            if g:IsExists(scard.IsType, 1, nil, TYPE_SPELL | TYPE_TRAP) then
                return bg:IsExists(scard.raux1, 1, nil, bg, g, false) and
                    bg:FilterCount(scard.IsType, nil, TYPE_FIELD) <= 1
            end
        end
        return true
    end
end
function scard.raux1(c, bg, g, mfield)
    local bool =
        g:IsExists(scard.raux2, 1, c, (TYPE_SPELL | TYPE_TRAP) & (~c:GetType()), not c:IsType(TYPE_FIELD), mfield)
    return (bool and
        bg:IsExists(scard.raux2, 1, c, (TYPE_SPELL | TYPE_TRAP) & (~c:GetType()), not c:IsType(TYPE_FIELD), mfield)) or
        (not bool and bg:FilterCount(aux.TRUE, c) == 0)
end
function scard.raux2(c, type, field, mfield)
    if type == 0 then
        type = TYPE_SPELL | TYPE_TRAP
    end
    if mfield then
        return c:IsType(type) and ((field and c:IsType(TYPE_FIELD)) or (not field and not c:IsType(TYPE_FIELD)))
    else
        return c:IsType(type)
    end
end

--Each duelist must search his or her deck for any card, add it to their hand, and shuffle their deck afterward.
function scard.search(e, tp)
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
table.insert(scard.challenges, scard.search)

--All old rules become no longer in effect, and all players reveal their hands and face-down cards to their opponents.
function scard.reset(e, tp)
    for _, e in ipairs(scard.activeChallenges) do
        e:Reset()
    end
    scard.activeChallenges = {}
    local g = Duel.GetFieldGroup(tp, LOCATION_HAND + LOCATION_MZONE + LOCATION_SZONE, 0):Filter(scard.IsFacedown, nil)
    Duel.ConfirmCards(1 - tp, g)
    local g2 = Duel.GetFieldGroup(tp, 0, LOCATION_HAND + LOCATION_MZONE + LOCATION_SZONE):Filter(scard.IsFacedown, nil)
    Duel.ConfirmCards(tp, g2)
end
table.insert(scard.challenges, scard.reset)

--Choose a card in your opponent's graveyard and set it to your side of the field.
function scard.graveSteal(e, tp)
    local tc = Duel.SelectMatchingCard(tp, scard.graveStealFilter, tp, 0, LOCATION_GRAVE, 1, 1, nil, e, tp):GetFirst()
    if tc then
        if tc:IsType(TYPE_MONSTER) then
            Duel.SpecialSummon(tc, 0, tp, tp, true, true, POS_FACEDOWN_DEFENSE)
        else
            Duel.SSet(tp, tc)
        end
        Duel.ConfirmCards(1 - tp, tc)
    end
    local tc2 =
        Duel.SelectMatchingCard(1 - tp, scard.graveStealFilter, 1 - tp, 0, LOCATION_GRAVE, 1, 1, nil, e, 1 - tp):GetFirst(

    )
    if tc2 then
        if tc2:IsType(TYPE_MONSTER) then
            Duel.SpecialSummon(tc2, 0, 1 - tp, 1 - tp, true, true, POS_FACEDOWN_DEFENSE)
        else
            Duel.SSet(1 - tp, tc2)
        end
        Duel.ConfirmCards(tp, tc2)
    end
end
table.insert(scard.challenges, scard.graveSteal)

function scard.graveStealFilter(c, e, tp)
    return (c:IsType(TYPE_SPELL + TYPE_TRAP) and c:IsSSetable() and
        (Duel.GetLocationCount(tp, LOCATION_SZONE) > 0 or c:IsType(TYPE_FIELD))) or
        (c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e, 0, tp, true, true, POS_FACEDOWN_DEFENSE) and
            Duel.GetLocationCount(tp, LOCATION_MZONE) > 0)
end

--Each duelist may draw up to two cards, but loses 1000 Life Points for each card he or she chooses to draw.
--The turn player decides how many cards to draw first.
function scard.costDraw(e, tp)
    local p = Duel.GetTurnPlayer()
    local ct = Duel.AnnounceLevel(p, 0, math.min(2, Duel.GetFieldGroupCount(p, LOCATION_DECK)))
    Duel.Draw(p, ct, REASON_RULE)
    Duel.SetLP(p, Duel.GetLP(p) - 1000 * ct)
    local ct = Duel.AnnounceLevel(1 - p, 0, math.min(2, Duel.GetFieldGroupCount(1 - p, LOCATION_DECK)))
    Duel.Draw(1 - p, ct, REASON_RULE)
    Duel.SetLP(1 - p, Duel.GetLP(1 - p) - 1000 * ct)
end
table.insert(scard.challenges, scard.costDraw)

--You can only play monsters with an ATK of 1600 or higher.
function scard.noSummonLowATK(e, tp)
    local e1 = Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetCode(EFFECT_CANNOT_SUMMON)
    e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e1:SetTargetRange(1, 1)
    e1:SetTarget(scard.splimit)
    Duel.RegisterEffect(e1, tp)
    scard.applyNewChallengeReset(e1)
    local e2 = e1:Clone()
    e2:SetCode(EFFECT_CANNOT_FLIP_SUMMON)
    Duel.RegisterEffect(e2, tp)
    scard.applyNewChallengeReset(e2)
    local e3 = e1:Clone()
    e3:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
    Duel.RegisterEffect(e3, tp)
    scard.applyNewChallengeReset(e3)
end
table.insert(scard.challenges, scard.noSummonLowATK)

function scard.splimit(e, c, sump, sumtype, sumpos, targetp, se)
    return not c:IsAttackAbove(1600)
end
