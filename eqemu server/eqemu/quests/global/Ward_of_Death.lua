-- Auto-generated Fabled Controller Script
-- #Ward_of_Death (154155) Spawns #The_Fabled_Ward_of_Death (ID: 154163) exactly 15 seconds after death

function event_death_complete(e)
    -- ID 999999 is our invisible Fabled_Spawner controller
    local spawner = eq.spawn2(999999, 0, 0, e.self:GetX(), e.self:GetY(), e.self:GetZ(), e.self:GetHeading())
    if spawner and spawner.valid then
        spawner:CastToNPC():SetEntityVariable("fabled_id", "154163")
    end
end
