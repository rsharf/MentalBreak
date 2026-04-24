import os

path = r"D:\app ideas\MentalBreak\eqemu server\eqemu\quests\paw\2100055.lua"
if os.path.exists(path):
    print("Found lua file:")
    with open(path, 'r') as f:
        print(f.read())
else:
    print("Lua file NOT found!")
