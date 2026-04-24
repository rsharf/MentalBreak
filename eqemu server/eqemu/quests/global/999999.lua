function event_spawn(e)
    eq.set_timer("init", 1) -- 1 ms timer to allow parent script to set variables
    eq.set_timer("fabled_pop", 15000) -- 15 seconds
    e.self:SetInvisible(1) -- Make invisible to players
    e.self:SetBodyType(11, true) -- Make untargetable
end

function event_timer(e)
    if e.timer == "init" then
        eq.stop_timer(e.timer)
        eq.zone_emote(15, "A dark presence gathers its strength... a fabled creature is about to spawn!")
    elseif e.timer == "fabled_pop" then
        eq.stop_timer(e.timer)
        
        -- Get the assigned fabled ID from the entity variable set by the base NPC script
        local fabled_id_str = e.self:GetEntityVariable("fabled_id")
        
        if fabled_id_str ~= "" and fabled_id_str ~= nil then
            local fabled_id = tonumber(fabled_id_str)
            if fabled_id then
                eq.spawn2(fabled_id, 0, 0, e.self:GetX(), e.self:GetY(), e.self:GetZ(), e.self:GetHeading())
            end
        end
        
        -- Cleanup the spawner
        eq.depop()
    end
end
