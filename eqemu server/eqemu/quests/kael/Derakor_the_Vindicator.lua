function event_death_complete(e)
	if eq.get_zone_instance_version() == 100 then return end
	e.self:Shout("Your kind will not defile the temple of Rallos Zek!");
end

function event_combat(e)
	if eq.get_zone_instance_version() == 100 then return end

	if (e.joined) then
		eq.signal(113120, 1); -- NPC: a_temple_guardian
	end
end
