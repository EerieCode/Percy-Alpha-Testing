function Auxiliary.EnableExtraRule(c,card,init)
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    e1:SetCode(EVENT_ADJUST)
    e1:SetCountLimit(1)
    e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_NO_TURN_RESET)
    e1:SetRange(0xff)
    e1:SetOperation(Auxiliary.EnableExtraRuleOperation(c,card,init))
    c:RegisterEffect(e1)
end

function Auxiliary.EnableExtraRuleOperation(c,card,init)
    return function(e,tp,eg,ep,ev,re,r,rp)
        local c = e:GetHandler()
        local tp = c:GetControler()
        Duel.DisableShuffleCheck()
        Duel.SendtoDeck(c, nil, -2, REASON_RULE)
        local ct = Duel.GetMatchingGroupCount(nil, tp, LOCATION_HAND + LOCATION_DECK, 0, c)
        if ((card.global_active_check or Duel.IsDuelType(SPEED_DUEL)) and ct < 20 or ct < 40)
            and Duel.SelectYesNo(1 - tp, aux.Stringid(4014, 4)) then
            Duel.Win(1 - tp, 0x60)
        end
        if c:IsPreviousLocation(LOCATION_HAND) then Duel.Draw(tp, 1, REASON_RULE) end
        if not card.global_active_check then
            Duel.ConfirmCards(1-tp, c)
            if Duel.SelectYesNo(tp,aux.Stringid(4014,5)) and Duel.SelectYesNo(1-tp,aux.Stringid(4014,5)) then
            	init(c)
            end
            card.global_active_check = true
        end
    end
end

--aux.Stringid(4014, 4):
--Your opponent has an illegal number of cards in their deck after removing the Duel Mode. Do you want to take the win (Yes) or allow this (No)?

--aux.Stringid(4014, 5):
--Do you agree to play this special Duel Mode?

--Duel.Win(1 - tp, 0x60)
-- "Victory by entering the Duel with invalid Deck" (provisional)