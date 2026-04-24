-- Auto-generated Fabled Controller Script
-- Priest_Majes_Medory (111031) Spawns #The_Fabled_Priest_Majes_Medory (ID: 111184) exactly 15 seconds after death

function event_death_complete(e)
    -- ID 999999 is our invisible Fabled_Spawner controller
    local spawner = eq.spawn2(999999, 0, 0, e.self:GetX(), e.self:GetY(), e.self:GetZ(), e.self:GetHeading())
    if spawner and spawner.valid then
        spawner:CastToNPC():SetEntityVariable("fabled_id", "111184")
    end
end
