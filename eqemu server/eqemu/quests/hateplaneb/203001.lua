function event_spawn(e)
    -- Set initial hate radius behavior
    e.self:SetAppearance(0);
end

function event_death_complete(e)
    -- Handled by encounter script, but log for safety
end
