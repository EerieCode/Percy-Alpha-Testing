--int Duel.GetZoneWithLinkedCount(int count, int tp)
function Duel.GetZoneWithLinkedCount(count, tp)
	local g = Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_MZONE,LOCATION_MZONE,nil,TYPE_LINK)
	local zones = {}
	local z = {0x1,0x2,0x4,0x8,0x10,0x20,0x40}
	for _,zone in ipairs(z) do
		local ct = 0
		for tc in aux.Next(g) do
			if (zone&tc:GetLinkedZone(tp))~= 0 then
				ct = ct + 1
			end
		end
		zones[zone] = ct
	end
	local rzone = 0
	for i,ct in pairs(zones) do
		if ct >= count then
			rzone = rzone | i
		end
	end
	return rzone
end
