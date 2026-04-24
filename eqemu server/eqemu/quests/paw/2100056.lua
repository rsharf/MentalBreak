-- Instance Portal for Lair of the Splitpaw
local INST_VERSION = 100
local INST_DURATION = 86400
local ZONE_SHORT = "paw"
local ZONE_ID = 18
local LOCKOUT = "inst_paw_lockout"
local SAFE_X, SAFE_Y, SAFE_Z = 63.0, -122.0, 3.0

function event_say(e)
    local text = string.lower(e.message)
    if string.find(text, "hail") then
        e.self:Say("I can send you to a private instance of Lair of the Splitpaw where all named creatures are waiting. Say 'enter' when you are ready.")
    elseif string.find(text, "enter") then
        enter_instance(e)
    end
end

function enter_instance(e)
    local qglobals = eq.get_qglobals(e.other)
    if qglobals[LOCKOUT] then
        local lockout_set = tonumber(qglobals[LOCKOUT])
        if lockout_set then
            local remaining = INST_DURATION - (os.time() - lockout_set)
            if remaining > 0 then
                local h = math.floor(remaining / 3600)
                local m = math.floor((remaining % 3600) / 60)
                e.self:Say("You must wait " .. h .. "h " .. m .. "m before entering again.")
                return
            end
        end
    end
    local inst_id = eq.get_instance_id(ZONE_SHORT, INST_VERSION)
    if inst_id > 0 and eq.get_instance_timer_by_id(inst_id) > 0 then
        e.self:Say("Returning you to your existing instance...")
        eq.assign_to_instance(inst_id)
        e.other:MovePCInstance(ZONE_ID, inst_id, SAFE_X, SAFE_Y, SAFE_Z, 0)
        return
    end
    inst_id = eq.create_instance(ZONE_SHORT, INST_VERSION, INST_DURATION)
    if inst_id == 0 then
        e.self:Say("Instance creation failed. Try again.")
        return
    end
    eq.assign_to_instance(inst_id)
    e.self:Say("Transporting you now...")
    e.other:MovePCInstance(ZONE_ID, inst_id, SAFE_X, SAFE_Y, SAFE_Z, 0)
end
