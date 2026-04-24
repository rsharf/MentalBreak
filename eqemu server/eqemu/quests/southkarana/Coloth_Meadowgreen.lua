-- Auto-generated Fabled Controller Script
-- Coloth_Meadowgreen (14123) Spawns #The_Fabled_Coloth_Meadowgreen (ID: 14167) exactly 15 seconds after death

function event_death_complete(e)
    -- ID 999999 is our invisible Fabled_Spawner controller
    local spawner = eq.spawn2(999999, 0, 0, e.self:GetX(), e.self:GetY(), e.self:GetZ(), e.self:GetHeading())
    if spawner and spawner.valid then
        spawner:CastToNPC():SetEntityVariable("fabled_id", "14167")
    end
end
