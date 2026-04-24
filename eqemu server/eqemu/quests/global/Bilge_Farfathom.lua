-- Auto-generated Fabled Controller Script
-- #Bilge_Farfathom (70059) Spawns #The_Fabled_Bilge_Farfathom (ID: 70069) exactly 15 seconds after death

function event_death_complete(e)
    -- ID 999999 is our invisible Fabled_Spawner controller
    local spawner = eq.spawn2(999999, 0, 0, e.self:GetX(), e.self:GetY(), e.self:GetZ(), e.self:GetHeading())
    if spawner and spawner.valid then
        spawner:CastToNPC():SetEntityVariable("fabled_id", "70069")
    end
end
