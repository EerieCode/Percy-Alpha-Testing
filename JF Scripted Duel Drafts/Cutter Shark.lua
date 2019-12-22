--
--Cutter Shark
--Scripted by Eerie Code and Edo9300
local s,id=GetID()
function s.initial_effect(c)
	--xyzlv
	local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_XYZ_LEVEL)
    e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e1:SetRange(LOCATION_MZONE)
    e1:SetValue(function(e)return e:GetHandler():GetLevel()<<16|3 end)
    c:RegisterEffect(e1)
    local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_SINGLE)
    e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e2:SetCode(511000189)
    e2:SetValue(5)
    e2:SetRange(LOCATION_MZONE)
    c:RegisterEffect(e2)
end
