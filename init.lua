-- tank gauge step sprites
local steps_x = 6
local steps_y = 20
for i=1,2 do
	local template, w, h = ModImageMakeEditable("mods/foolish_gauges/files/tank/full_" .. i .. ".png", 20, 34)
	local step_upto = 0
	for step_y=1,steps_y do
		for step_x=1,steps_x do
			local image =  ModImageMakeEditable("mods/foolish_gauges/files/tank/generated/" .. i .. "/" .. step_upto ..".png", 20, 34)
			local final_y = h - 5 - (step_y - 1)
			for y=h,final_y,-1 do
				local final_x = w - 1
				if y == final_y then
					final_x = w - 8 - 8 + step_x * (8 / steps_x)
				end
				for x=0,final_x do
					ModImageSetPixel(image, x, y, ModImageGetPixel(template, x, y))
				end
			end
			step_upto = step_upto + 1
		end
	end
	template, w, h = ModImageMakeEditable("mods/foolish_gauges/files/tank/full_" .. i .. "_hot.png", 20, 34)
	step_upto = 0
	for step_y=1,steps_y do
		for step_x=1,steps_x do
			local image =  ModImageMakeEditable("mods/foolish_gauges/files/tank/generated/" .. i .. "_hot/" .. step_upto ..".png", 20, 34)
			local final_y = h - 5 - (step_y - 1)
			for y=h,final_y,-1 do
				local final_x = w - 1
				if y == final_y then
					final_x = w - 8 - 8 + step_x * (8 / steps_x)
				end
				for x=0,final_x do
					ModImageSetPixel(image, x, y, ModImageGetPixel(template, x, y))
				end
			end
			step_upto = step_upto + 1
		end
	end
end

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
	if ModIsEnabled("foolish_flame") then
		ModLuaFileAppend("mods/foolish_flame/files/scripts/gauges.lua", "mods/foolish_gauges/files/gauges.lua")
	end
end