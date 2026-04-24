-- Auto-generated Fabled Controller Script
-- Foreman_Rixact (121062) Spawns #The_Fabled_Foreman_Rixact (ID: 121097) exactly 15 seconds after death

function event_death_complete(e)
    -- ID 999999 is our invisible Fabled_Spawner controller
    local spawner = eq.spawn2(999999, 0, 0, e.self:GetX(), e.self:GetY(), e.self:GetZ(), e.self:GetHeading())
    if spawner and spawner.valid then
        spawner:CastToNPC():SetEntityVariable("fabled_id", "121097")
    end
end
