if eq.get_zone_instance_version() == 100 then
    eq.load_encounter('instance_boss')
elseif eq.get_zone_instance_version() == 101 then
    eq.load_encounter('instance_boss_v2')
end
