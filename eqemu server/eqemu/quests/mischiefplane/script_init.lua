if eq.get_zone_instance_version() == 100 then
    eq.load_encounter('instance_boss')
else
    eq.load_encounter("Bristlebane_the_King_of_Thieves"); -- 2.0 Version
end
