-- Dagnor's Cauldron Instance Encounter (version 100)
-- Named NPCs spawn via database spawn2 (version=100)
-- Lockout set on Jinalis_Andir (ID 70028) death

function Boss_Death(e)
    eq.set_global("inst_cauldron_lockout", tostring(os.time()), 2, "H24")
    local cl = eq.get_entity_list():GetClientList()
    for c in cl.entries do
        if c.valid then
            c:Message(15, "Instance complete! You may return in 24 hours.")
        end
    end
end

function Boss_Combat(e)
    if e.joined then
        e.self:Shout("You dare challenge me alone?!")
    end
end

function Zone_Entry(e)
    if eq.get_zone_instance_version() == 100 then
        e.self:GMMove(320.0, 2815.0, 473.0, 0)
    end
end

function event_encounter_load(e)
    eq.register_npc_event('instance_boss', Event.death_complete, 70028, Boss_Death)
    eq.register_npc_event('instance_boss', Event.combat, 70028, Boss_Combat)
    eq.register_player_event('instance_boss', Event.enter_zone, Zone_Entry)
end
