if not ModIsEnabled("foolish_flame") then
	print("where is foolish flame?")
	return
end

dofile_once("mods/foolish_flame/files/scripts/gaugemaker.lua")

-- tank gauge step sprites
GenerateGaugeSteps("tank_1", "mods/foolish_gauges/files/tank/generated/1", "mods/foolish_gauges/files/tank/full_1.png")
GenerateGaugeSteps("tank_2", "mods/foolish_gauges/files/tank/generated/2", "mods/foolish_gauges/files/tank/full_2.png")
GenerateGaugeSteps("tank_1_hot", "mods/foolish_gauges/files/tank/generated/1_hot", "mods/foolish_gauges/files/tank/full_1_hot.png")
GenerateGaugeSteps("tank_2_hot", "mods/foolish_gauges/files/tank/generated/2_hot", "mods/foolish_gauges/files/tank/full_2_hot.png")

-- market gauge step sprites
GenerateGaugeSteps("market", "mods/foolish_gauges/files/market/generated", "mods/foolish_gauges/files/market/full.png")

-- relic gauge step sprites
GenerateGaugeSteps("relic", "mods/foolish_gauges/files/relic/generated", "mods/foolish_gauges/files/relic/full.png")

-- translations
local translations = ModTextFileGetContent("data/translations/common.csv")
if translations ~= nil then
    while translations:find("\r\n\r\n") do
        translations = translations:gsub("\r\n\r\n","\r\n")
    end
    local new_translations = ModTextFileGetContent(table.concat({"mods/foolish_gauges/files/translations.csv"}))
    translations = translations .. new_translations
    ModTextFileSetContent("data/translations/common.csv", translations)
end

function OnModPostInit()
	ModLuaFileAppend("mods/foolish_flame/files/scripts/gauges.lua", "mods/foolish_gauges/files/gauges.lua")
end