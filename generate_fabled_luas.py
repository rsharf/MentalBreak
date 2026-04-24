import json
import os

pairs_file = 'fabled_pairs.json'
quests_dir = r'd:\app ideas\MentalBreak\eqemu server\eqemu\quests'

with open(pairs_file, 'r') as f:
    pairs = json.load(f)

for pair in pairs:
    zone = pair['zone']
    fabled_id = pair['fabled']['id']
    fabled_name = pair['fabled']['name']
    
    # Ensure zone directory exists
    zone_dir = os.path.join(quests_dir, zone)
    os.makedirs(zone_dir, exist_ok=True)
    
    for base in pair['base']:
        base_id = base['id']
        base_name = base['name'].replace('#', '')
        
        # We write <Base_Name>.lua, because EQEmu prioritizes <npc_name>.lua or <npcid>.lua
        # Let's write both name.lua and id.lua to be perfectly safe, or just id.lua since names can collision?
        # Standard PEQ is usually Name.lua
        script_content = f"""-- Auto-generated Fabled Controller Script
-- Spawns {fabled_name} (ID: {fabled_id}) 15 seconds after death

function event_death_complete(e)
    -- ID 999999 is our invisible Fabled_Spawner controller
    local spawner = eq.spawn2(999999, 0, 0, e.self:GetX(), e.self:GetY(), e.self:GetZ(), e.self:GetHeading())
    if spawner and spawner.valid then
        spawner:CastToNPC():SetEntityVariable("fabled_id", "{fabled_id}")
    end
end
"""
        # Save as name.lua (EQEmu standard is capitalization as in DB)
        lua_path = os.path.join(zone_dir, f"{base_name}.lua")
        
        # If it exists, append to it but avoid duplicates
        if os.path.exists(lua_path):
            with open(lua_path, 'r') as lf:
                content = lf.read()
            if "event_death_complete" in content:
                # Need to modify properly if it exists, for now append if it doesn't have it
                if "999999" not in content:
                    with open(lua_path, 'a') as lf:
                        lf.write("\n-- Fabled Spawner hook appended automatically\n")
                        lf.write(script_content)
            else:
                with open(lua_path, 'a') as lf:
                    lf.write("\n" + script_content)
        else:
            with open(lua_path, 'w') as lf:
                lf.write(script_content)
        
        print(f"Created/Updated {lua_path} for base ID {base_id} (Fabled {fabled_id})")
