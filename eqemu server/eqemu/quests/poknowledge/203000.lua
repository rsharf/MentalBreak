-- Instance Portal NPC (203000) - Solo Raid Boss Instances
-- Located in Plane of Knowledge

local INST_VERSION = 100
local INST_DURATION = 86400  -- 24 hours in seconds

-- Zone configs: {short_name, zone_id, lockout_global, safe_x, safe_y, safe_z, safe_h, boss_name}
local ZONES = {
    hate = {
        short = "hateplaneb", id = 186,
        lockout = "inst_hpb_lockout",
        x = -393, y = 656, z = 3, h = 0,
        boss = "Innoruuk, Prince of Hate"
    },
    fear = {
        short = "fearplane", id = 72,
        lockout = "inst_fp_lockout",
        x = 1282, y = -1139, z = 5, h = 0,
        boss = "Cazic Thule, the Faceless"
    },
}

function event_spawn(e)
    e.self:SetAppearance(0)
end

function event_say(e)
    local text = string.lower(e.message)

    if string.find(text, "hail") then
        e.self:Say("Greetings, adventurer. I can transport you to face the mightiest foes of Norrath -- alone. "
            .. "Each challenge resets every 24 hours after you have claimed victory. "
            .. "Say 'Plane of Hate' to face Innoruuk, or 'Plane of Fear' to face Cazic Thule.")
        return
    end

    if string.find(text, "plane of hate") then
        enter_instance(e, ZONES.hate)
        return
    end

    if string.find(text, "plane of fear") then
        enter_instance(e, ZONES.fear)
        return
    end
end

function enter_instance(e, zone)
    -- Check lockout
    local qglobals = eq.get_qglobals(e.other)
    if qglobals[zone.lockout] then
        local lockout_set = tonumber(qglobals[zone.lockout])
        if lockout_set then
            local remaining = INST_DURATION - (os.time() - lockout_set)
            if remaining > 0 then
                local hours = math.floor(remaining / 3600)
                local minutes = math.floor((remaining % 3600) / 60)
                e.self:Say("You must wait " .. hours .. " hours and " .. minutes .. " minutes before challenging " .. zone.boss .. " again.")
                return
            end
        end
    end

    -- Check for existing instance
    local inst_id = eq.get_instance_id(zone.short, INST_VERSION)
    if inst_id > 0 and eq.get_instance_timer_by_id(inst_id) > 0 then
        e.self:Say("Returning you to your existing challenge...")
        eq.assign_to_instance(inst_id)
        e.other:MovePCInstance(zone.id, inst_id, zone.x, zone.y, zone.z, zone.h)
        return
    end

    -- Create new instance
    inst_id = eq.create_instance(zone.short, INST_VERSION, INST_DURATION)
    if inst_id == 0 then
        e.self:Say("The portal is unstable. Please try again.")
        return
    end

    eq.assign_to_instance(inst_id)
    e.self:Say("Prepare yourself! You are being transported to face " .. zone.boss .. "...")
    e.other:MovePCInstance(zone.id, inst_id, zone.x, zone.y, zone.z, zone.h)
end
