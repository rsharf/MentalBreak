function event_spawn(e)
if eq.get_zone_instance_version() == 100 then return end
eq.set_proximity(e.self:GetX() - 30, e.self:GetX() + 30, e.self:GetY() - 30, e.self:GetY() + 30);
end

function event_enter(e)
if eq.get_zone_instance_version() == 100 then return end
e.self:Emote("at your feet erupts.");
eq.spawn2(103093, 0, 0, e.self:GetX(),e.self:GetY(),e.self:GetZ(),0); -- NPC: a_Reanimated_Berserker
eq.depop_with_timer();
end
