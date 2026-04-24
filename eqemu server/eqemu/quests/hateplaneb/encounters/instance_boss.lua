-- Instance Boss Encounter (version 100)
-- Named NPCs spawn via database spawn2 entries (version=100).
-- This encounter handles boss events and player zone-in positioning.

function Boss_Spawn(e)
    eq.zone_emote(15, "The air crackles with malice as Innoruuk materializes before you!");
end

function Boss_Death(e)
    -- Set 24-hour lockout for the killer (character-scoped)
    eq.set_global("inst_hpb_lockout", tostring(os.time()), 2, "H24");

    local client_list = eq.get_entity_list():GetClientList();
    for client in client_list.entries do
        if client.valid then
            client:Message(15, "You have defeated Innoruuk! You may challenge him again in 24 hours.");
        end
    end
end

function Boss_Combat(e)
    if e.joined then
        e.self:Shout("You dare challenge ME in my own domain?!");
    end
end

function Zone_Entry(e)
    if eq.get_zone_instance_version() == 100 then
        -- Move player to zone safe point (away from boss)
        e.self:GMMove(-393, 656, 3, 0);
    end
end

function event_encounter_load(e)
    eq.register_npc_event('instance_boss', Event.spawn, 203001, Boss_Spawn);
    eq.register_npc_event('instance_boss', Event.death_complete, 203001, Boss_Death);
    eq.register_npc_event('instance_boss', Event.combat, 203001, Boss_Combat);
    eq.register_player_event('instance_boss', Event.enter_zone, Zone_Entry);
end
