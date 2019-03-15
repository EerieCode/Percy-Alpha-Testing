--utility function for a "non-effect monster"
function Card.IsNonEffectMon(c)
    return c:GetType()==TYPE_MONSTER and not c:GetType()==TYPE_EFFECT
end