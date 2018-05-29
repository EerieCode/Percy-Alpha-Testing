--中生代化石マシン スカルワゴン
function c100000622.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcMix(c,true,true,c100000622.ffilter1,c100000622.ffilter2)
	--cannot spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCode(EFFECT_SPSUMMON_CONDITION)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetValue(c100000622.splimit)
	c:RegisterEffect(e2)
end
c100000622.listed_names={100000025}
function c100000622.ffilter1(c,fc,sumtype,tp)
	return c:IsRace(RACE_ROCK,fc,sumtype,tp) and c:IsLocation(LOCATION_GRAVE) and c:IsControler(tp)
end
function c100000622.ffilter2(c,fc,sumtype,tp)
	return (c:IsLevel(5) or c:IsLevel(6)) and c:IsRace(RACE_MACHINE,fc,sumtype,tp) and c:IsLocation(LOCATION_GRAVE) and c:IsControler(1-tp)
end
function c100000622.splimit(e,se,sp,st)
	return not e:GetHandler():IsLocation(LOCATION_EXTRA) or se:GetHandler():IsCode(100000025)
end
