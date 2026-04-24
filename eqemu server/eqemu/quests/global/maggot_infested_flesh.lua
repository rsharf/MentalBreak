-- Auto-generated Fabled Controller Script
-- #maggot_infested_flesh (111160) Spawns #The_Fabled_maggot_infested_flesh (ID: 111181) exactly 15 seconds after death

function event_death_complete(e)
    -- ID 999999 is our invisible Fabled_Spawner controller
    local spawner = eq.spawn2(999999, 0, 0, e.self:GetX(), e.self:GetY(), e.self:GetZ(), e.self:GetHeading())
    if spawner and spawner.valid then
        spawner:CastToNPC():SetEntityVariable("fabled_id", "111181")
    end
end
