--新生代化石竜 スカルガー
function c100000621.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcMix(c,true,true,c100000621.ffilter1,c100000621.ffilter2)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c100000621.splimit)
	c:RegisterEffect(e1)
end
c100000621.listed_names={100000025}
function c100000621.splimit(e,se,sp,st)
	return se:GetHandler():IsCode(100000025)
end
function c100000621.ffilter1(c,fc,sumtype,tp)
	return c:IsRace(RACE_ROCK,fc,sumtype,tp) and c:IsLocation(LOCATION_GRAVE) and c:IsControler(tp)
end
function c100000621.ffilter2(c,fc,sumtype,tp)
	return c:IsLevelBelow(4) and c:IsRace(RACE_DINOSAUR,fc,sumtype,tp) and c:IsLocation(LOCATION_GRAVE) and c:IsControler(1-tp)
end
