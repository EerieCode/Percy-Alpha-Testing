--int Duel.GetZoneWithLinkedCount(int count, int tp)
function Duel.GetZoneWithLinkedCount(count, tp)
	local g = Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_MZONE,LOCATION_MZONE,nil,TYPE_LINK)
	local zones = {}
	local zone = 1
	while zone <= 0x7f do
		local ct = 0
		for tc in aux.Next(g) do
			if (zone&tc:GetLinkedZone(tp))~= 0 then
				ct = ct + 1
			end
		end
		zones[zone] = ct
		zone = zone * 2
	end
	local rzone = 0
	for i,ct in ipairs(zones) do
		if ct >= count then
			rzone = rzone | i
		end
	end
	return rzone
end