-- Auto-generated Fabled Controller Script
-- Grizzleknot (14142) Spawns #The_Fabled_Grizzleknot (ID: 14168) exactly 15 seconds after death

function event_death_complete(e)
    -- ID 999999 is our invisible Fabled_Spawner controller
    local spawner = eq.spawn2(999999, 0, 0, e.self:GetX(), e.self:GetY(), e.self:GetZ(), e.self:GetHeading())
    if spawner and spawner.valid then
        spawner:CastToNPC():SetEntityVariable("fabled_id", "14168")
    end
end
