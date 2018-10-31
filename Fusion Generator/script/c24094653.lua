--融合
--Polymerization
local s,id=GetID()
function s.initial_effect(c)
	--Activate
	c:RegisterEffect(aux.CreateFusionEffect(c))
end