--リミットレギュレーションの予想
--Banlist Predictions
--Scripted by AlphaKretin
local s,id=GetID()
function s.initial_effect(c)
    --Activate
    local e1=Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_RECOVER)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetTarget(s.target)
    c:RegisterEffect(e1)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then
        if not Duel.IsPlayerCanDiscardDeck(tp,3) then return false end
        local g=Duel.GetDecktopGroup(tp,3)
        return g:FilterCount(Card.IsAbleToHand,nil)>0
    end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CODE)
    local ac=Duel.AnnounceCard(tp)
    local codes={ac}
    while (#codes<=5 and Duel.SelectYesNo(tp,aux.Stringid(512,2))) do
        local filter={}
        for _,code in ipairs(codes) do
            table.insert(filter,code)
            table.insert(filter,OPCODE_OR)
        end
        table.remove(filter)
        table.insert(filter,OPCODE_ISCODE)
        table.insert(filter,OPCODE_NOT)
        s.announce_filter=filter
        Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CODE)
        local ac2=Duel.AnnounceCardFilter(tp,table.unpack(s.announce_filter))
        table.insert(codes,ac2)
    end
    e:SetOperation(s.operation(codes))
end
function s.operation(codes)
    return function(e,tp,eg,ep,ev,re,r,rp)
        local g=Duel.GetMatchingGroup(Card.IsCode,tp,0x7f,0x7f,nil,table.unpack(codes))
        if #g>0 then
            Duel.ConfirmCards(tp,g)
            Duel.Recover(tp,#g,REASON_EFFECT)
            --forbidden
            local e1=Effect.CreateEffect(e:GetHandler())
            e1:SetType(EFFECT_TYPE_FIELD)
            e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
            e1:SetCode(EFFECT_FORBIDDEN)
            e1:SetTargetRange(0x7f,0x7f)
            e1:SetTarget(s.bantg(codes))
            Duel.RegisterEffect(e1,tp)
        end
    end
end
function s.bantg(codes)
    return function(e,c)
        return c:IsCode(table.unpack(codes))
    end
end