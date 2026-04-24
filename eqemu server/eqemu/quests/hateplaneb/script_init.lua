if eq.get_zone_instance_version() == 100 then
    eq.load_encounter('instance_boss');
else
    eq.load_encounter('rogue_1_5');
    eq.load_encounter('maestro');
    eq.load_encounter('inny');
end
