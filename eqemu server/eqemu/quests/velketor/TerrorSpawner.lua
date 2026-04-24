function event_combat(e)
if eq.get_zone_instance_version() == 100 then return end
if e.joined then
eq.spawn2(112047, 0, 0, e.self:GetX(),e.self:GetY(),e.self:GetZ(),0); -- NPC: a_crystalline_shard
eq.depop_with_timer();
end
end
