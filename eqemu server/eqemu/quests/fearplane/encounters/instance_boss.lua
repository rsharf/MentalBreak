-- Fearplane Instance Encounter (version 100)
-- Named NPCs spawn via database spawn2 entries (version=100).
-- CT 1.0 death → 15s warning → CT 2.0 spawns at original location.
-- Event_Control_Fear (203003) manages timers (persists after CT death).

local CT_1_ID = 72003;       -- Cazic_Thule (original)
local CT_2_ID = 203002;      -- Cazic_Thule 2.0 (harder clone)
local CONTROL_ID = 203003;   -- Hidden event controller
local CT_X = -163.2;
local CT_Y = 549.0;
local CT_Z = 18.9;
local CT_H = 235.0;

function CT1_Death(e)
    -- Zone-wide warning
    eq.zone_emote(15, "The ground shakes violently as Cazic Thule's essence reforms! A more powerful incarnation will appear in 15 seconds!");

    -- Signal the event controller to start the 15s timer
    eq.signal(CONTROL_ID, 1);
end

function CT1_Combat(e)
    if e.joined then
        e.self:Shout("You DARE set foot in MY domain?!");
    end
end

function Control_Signal(e)
    if e.signal == 1 then
        eq.set_timer("spawn_ct2", 15000);
    end
end

function Control_Timer(e)
    if e.timer == "spawn_ct2" then
        eq.stop_timer("spawn_ct2");
        eq.zone_emote(15, "Cazic Thule has returned -- stronger, angrier, and hungry for vengeance!");
        eq.spawn2(CT_2_ID, 0, 0, CT_X, CT_Y, CT_Z, CT_H);
    end
end

function CT2_Spawn(e)
    e.self:Shout("FOOLISH MORTAL! You thought you could destroy a GOD?!");
end

function CT2_Death(e)
    -- Set 24-hour lockout for the killer (character-scoped)
    eq.set_global("inst_fp_lockout", tostring(os.time()), 2, "H24");

    local client_list = eq.get_entity_list():GetClientList();
    for client in client_list.entries do
        if client.valid then
            client:Message(15, "You have defeated Cazic Thule! You may challenge him again in 24 hours.");
        end
    end
end

function CT2_Combat(e)
    if e.joined then
        e.self:Shout("This time there will be no mercy!");
    end
end

function Zone_Entry(e)
    if eq.get_zone_instance_version() == 100 then
        -- Move player to zone safe point (away from bosses)
        e.self:GMMove(1282, -1139, 5, 0);
    end
end

function event_encounter_load(e)
    -- Event controller (hidden NPC that manages timers)
    eq.register_npc_event('instance_boss', Event.signal, CONTROL_ID, Control_Signal);
    eq.register_npc_event('instance_boss', Event.timer, CONTROL_ID, Control_Timer);

    -- Cazic Thule 1.0 events
    eq.register_npc_event('instance_boss', Event.death_complete, CT_1_ID, CT1_Death);
    eq.register_npc_event('instance_boss', Event.combat, CT_1_ID, CT1_Combat);

    -- Cazic Thule 2.0 events
    eq.register_npc_event('instance_boss', Event.spawn, CT_2_ID, CT2_Spawn);
    eq.register_npc_event('instance_boss', Event.death_complete, CT_2_ID, CT2_Death);
    eq.register_npc_event('instance_boss', Event.combat, CT_2_ID, CT2_Combat);

    -- Player zone-in positioning
    eq.register_player_event('instance_boss', Event.enter_zone, Zone_Entry);
end
