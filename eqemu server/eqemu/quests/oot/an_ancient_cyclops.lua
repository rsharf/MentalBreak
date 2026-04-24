-- Auto-generated Fabled Controller Script
-- an_ancient_cyclops (69150) Spawns The_Fabled_Ancient_Cyclops (ID: 35163) exactly 15 seconds after death

function event_death_complete(e)
    -- ID 999999 is our invisible Fabled_Spawner controller
    local spawner = eq.spawn2(999999, 0, 0, e.self:GetX(), e.self:GetY(), e.self:GetZ(), e.self:GetHeading())
    if spawner and spawner.valid then
        spawner:CastToNPC():SetEntityVariable("fabled_id", "35163")
    end
end
