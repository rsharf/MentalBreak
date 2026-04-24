-- Origin Spell Custom Logic (Two-Way Recall)
function event_spell_effect(e)
    local client = eq.get_entity_list():GetClientByID(e.caster_id)
    if not client or not client.valid then return 1 end
    
    local current_zone = eq.get_zone_short_name()
    
    if current_zone == "poknowledge" then
        -- Inside PoK: Attempt to Recall
        local ret_zone_id = tonumber(client:GetBucket("OriginReturnZoneID")) or 0
        
        if ret_zone_id > 0 then
            local ret_x = tonumber(client:GetBucket("OriginReturnX")) or 0
            local ret_y = tonumber(client:GetBucket("OriginReturnY")) or 0
            local ret_z = tonumber(client:GetBucket("OriginReturnZ")) or 0
            local ret_h = tonumber(client:GetBucket("OriginReturnH")) or 0
            
            client:Message(15, "Recalling to your previous location...")
            
            -- Consume the ticket
            client:DeleteBucket("OriginReturnZoneID")
            client:DeleteBucket("OriginReturnX")
            client:DeleteBucket("OriginReturnY")
            client:DeleteBucket("OriginReturnZ")
            client:DeleteBucket("OriginReturnH")
            
            client:MovePC(ret_zone_id, ret_x, ret_y, ret_z, ret_h)
        else
            client:Message(13, "You have no saved return location. Cast Origin from another zone first!")
        end
    else
        -- Outside PoK: Save location and port to PoK
        client:SetBucket("OriginReturnZoneID", tostring(eq.get_zone_id()))
        client:SetBucket("OriginReturnX", tostring(client:GetX()))
        client:SetBucket("OriginReturnY", tostring(client:GetY()))
        client:SetBucket("OriginReturnZ", tostring(client:GetZ()))
        client:SetBucket("OriginReturnH", tostring(client:GetHeading()))
        
        client:Message(15, "Your return location has been saved. Cast Origin again in PoKnowledge to return here.")
        
        -- Port to PoK: X=-59.27, Y=-127.70, Z=-157.25, Heading=0
        client:MovePC(202, -59.27, -127.70, -157.25, 0)
    end
    
    return 1 -- Overrides default spell effect
end
