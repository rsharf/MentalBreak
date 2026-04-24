-- Auto-generated Fabled Controller Script
-- a_crypt_spectre (105167) Spawns #The_Fabled_Crypt_Spectre (ID: 105286) exactly 15 seconds after death

function event_death_complete(e)
    -- ID 999999 is our invisible Fabled_Spawner controller
    local spawner = eq.spawn2(999999, 0, 0, e.self:GetX(), e.self:GetY(), e.self:GetZ(), e.self:GetHeading())
    if spawner and spawner.valid then
        spawner:CastToNPC():SetEntityVariable("fabled_id", "105286")
    end
end
