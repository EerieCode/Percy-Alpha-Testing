function aux.IsCounterAdded(c,counter)
	if not c.counter_add_list then return false end
		for _,ccounter in ipairs(c.counter_add_list) do
			if counter==ccounter then return true end
		end
	return false
end