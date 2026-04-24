-- Auto-generated Fabled Controller Script
-- #Blackguard_Thabis (107159) Spawns #The_Fabled_Blackguard_Thabis (ID: 107157) exactly 15 seconds after death

function event_death_complete(e)
    -- ID 999999 is our invisible Fabled_Spawner controller
    local spawner = eq.spawn2(999999, 0, 0, e.self:GetX(), e.self:GetY(), e.self:GetZ(), e.self:GetHeading())
    if spawner and spawner.valid then
        spawner:CastToNPC():SetEntityVariable("fabled_id", "107157")
    end
end
