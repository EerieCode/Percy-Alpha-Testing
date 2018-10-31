--影依融合
--Shaddoll Fusion
local s,id=GetID()
function s.initial_effect(c)
	--Activate
	local e1=aux.CreateFusionEffect(c,s.fusfilter,nil,s.xcon,s.matfilter)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	c:RegisterEffect(e1)
	if not AshBlossomTable then AshBlossomTable={} end
	table.insert(AshBlossomTable,e1)
end
function s.fusfilter(c,e,tp)
	return c:IsSetCard(0x9d)
end
function s.cfilter(c)
	return c:GetSummonLocation()==LOCATION_EXTRA
end
function s.xcon(e,tp)
	return Duel.IsExistingMatchingCard(s.cfilter,tp,0,LOCATION_MZONE,1,nil)
end
function s.matfilter(c)
	return c:IsLocation(LOCATION_DECK)
end