-- Infected Paw Instance Encounter (version 101)
-- Named NPCs spawn via database spawn2 (version=101)
-- Lockout set on #Overlord_Flargor (ID 18112) death

function Boss_Death(e)
    eq.set_global("inst_paw2_lockout", tostring(os.time()), 2, "H24")
    local cl = eq.get_entity_list():GetClientList()
    for c in cl.entries do
        if c.valid then
            c:Message(15, "Infected Paw instance complete! You may return in 24 hours.")
        end
    end
end

function Zone_Entry(e)
    if eq.get_zone_instance_version() == 101 then
        e.self:GMMove(63.0, -122.0, 4.38, 0) -- Safely inside entrance tunnel
    end
end

function event_encounter_load(e)
    eq.register_npc_event('instance_boss_v2', Event.death_complete, 18112, Boss_Death)
    eq.register_player_event('instance_boss_v2', Event.enter_zone, Zone_Entry)
end
