function event_signal(e)
	if eq.get_zone_instance_version() == 100 then return end

	if (e.signal == 1) then

		local derakor = eq.get_entity_list():GetMobByNpcTypeID(113118);

		eq.follow(derakor:GetID());
	end
end
