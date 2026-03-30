-- global tables
getgenv().Interface = {}
getgenv().Hooks = {}
getgenv().ModulesLoaded = false

import('bypass.lua')
local start_time = os.clock()
repeat
    task.wait()
until getgenv().ModulesLoaded or (os.clock() - start_time) > 5

if not getgenv().ModulesLoaded then
    warn("[Modules] bypass.lua did not enable ModulesLoaded; continuing without it")
    getgenv().ModulesLoaded = true
end
print("Modules loaded. Injecting")

import('players.lua')

--esp
import('esp/lines.lua')
import('esp/playerchams.lua')
import('esp/objectchams.lua')

--aim
import('aim/aimbot.lua')
import('aim/rcs.lua')

--character
import('character/speedhack.lua')
import('character/nofall.lua')

--ui
import('ui/interface.lua')
