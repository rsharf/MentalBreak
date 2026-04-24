function event_spawn(e)
  e.self:SetRunning(true);
end
-- Auto-generated Fabled Controller Script
-- Spawns The_Fabled_Fippy_Darkpaw (ID: 2148) 15 seconds after death

function event_death_complete(e)
    -- ID 999999 is our invisible Fabled_Spawner controller
    local spawner = eq.spawn2(999999, 0, 0, e.self:GetX(), e.self:GetY(), e.self:GetZ(), e.self:GetHeading())
    if spawner and spawner.valid then
        spawner:CastToNPC():SetEntityVariable("fabled_id", "2148")
    end
end
