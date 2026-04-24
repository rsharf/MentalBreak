-- Auto-generated Fabled Controller Script
-- an_undead_knight_of_Unrest (63003) Spawns The_Fabled_Undead_Knight_Of_Unrest (ID: 63091) exactly 15 seconds after death

function event_death_complete(e)
    -- ID 999999 is our invisible Fabled_Spawner controller
    local spawner = eq.spawn2(999999, 0, 0, e.self:GetX(), e.self:GetY(), e.self:GetZ(), e.self:GetHeading())
    if spawner and spawner.valid then
        spawner:CastToNPC():SetEntityVariable("fabled_id", "63091")
    end
end
