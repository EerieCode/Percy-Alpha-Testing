--utility function for a "non-effect monster"
function Card.IsNonEffectMon(c)
    return c:IsType(TYPE_MONSTER) and not c:IsType(TYPE_EFFECT)
end
