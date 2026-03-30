-- global tables
getgenv().Interface = {}
getgenv().Hooks = {}
getgenv().ModulesLoaded = false

import('bypass.lua')

-- Wait until bypass sets ModulesLoaded and shared.require becomes available.
repeat
    task.wait()
until getgenv().ModulesLoaded
print("Modules loaded. Injecting")

import('players.lua')

-- Ensure LocalPlayer exists before modules that reference it.
local start_localplayer = os.clock()
repeat
    task.wait()
until (getgenv().PlayerService and getgenv().PlayerService.LocalPlayer) or (os.clock() - start_localplayer) > 20

if not (getgenv().PlayerService and getgenv().PlayerService.LocalPlayer) then
    warn("[Players] LocalPlayer is nil; aborting further module injection")
    return
end

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
