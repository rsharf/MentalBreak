-- Auto-generated Fabled Controller Script
-- Chancellor_of_Di`zok (85062) Spawns #The_Fabled_Chancellor_of_Di`zok (ID: 85230) exactly 15 seconds after death

function event_death_complete(e)
    -- ID 999999 is our invisible Fabled_Spawner controller
    local spawner = eq.spawn2(999999, 0, 0, e.self:GetX(), e.self:GetY(), e.self:GetZ(), e.self:GetHeading())
    if spawner and spawner.valid then
        spawner:CastToNPC():SetEntityVariable("fabled_id", "85230")
    end
end
