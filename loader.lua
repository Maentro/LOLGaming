local version_info = {
    debug = false,
    version = "0.1",
}

-- Source for the imported modules (bypass/players/ui/etc).
local root_url = version_info.debug and "http://localhost:8000/" or "https://raw.githubusercontent.com/cyr0zn/Specter/main/"

local debug_print = version_info.debug and function(T, ...)
    return warn("debug: "..T:format(...))
end or function() end

local function import(file)
    debug_print("Importing File \"%s\"", file)

    if type(loadstring) ~= "function" then
        warn(string.format("failed to import %s\n\t--> loadstring is not available in this environment", file))
        return false
    end

    local okHttp, srcOrErr = pcall(function()
        return game:HttpGet(root_url .. file)
    end)
    if not okHttp then
        warn(string.format("failed to import %s\n\t--> %s", file, srcOrErr))
        return false
    end

    local fn, err = loadstring(srcOrErr)
    if not fn then
        warn(string.format("failed to import %s\n\t--> %s", file, err))
        return false
    end

    local okRun, result = pcall(fn)
    if not okRun then
        warn(string.format("failed to import %s\n\t--> %s", file, result))
        return false
    end

    return result
end

getgenv().import = import
getgenv().version_info = version_info
getgenv().debug_print = version_info and debug_print

import('main.lua')