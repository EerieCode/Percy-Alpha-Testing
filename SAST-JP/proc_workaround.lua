local nt=Card.IsNotTuner
Card.IsNotTuner=function (c,sc,tp)
    local nte = c:GetCardEffect(EFFECT_NONTUNER)
    local val = nte and nte:GetValue() or nil
    if not val or type(val) == 'number' then
        return nt(c,sc,tp)
    else
        return val(c,sc,tp) or not c:IsType(TYPE_TUNER,sc,SUMMON_TYPE_SYNCHRO,tp)
    end
end