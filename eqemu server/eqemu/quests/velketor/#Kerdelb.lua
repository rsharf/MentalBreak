function event_death_complete(e)
  if eq.get_zone_instance_version() == 100 then return end
  eq.spawn2(112085, 0, 0, e.self:GetX(), e.self:GetY(),  e.self:GetZ(),  e.self:GetHeading()); --Kerd
end
