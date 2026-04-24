function event_signal(e)
	if eq.get_zone_instance_version() == 100 then return end

	if (e.signal == 1) then

		local statue = eq.get_entity_list():GetMobByNpcTypeID(113071);

		eq.follow(statue:GetID());
	end
end
