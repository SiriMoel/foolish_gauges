foolish_gauges = {
    {
        id = "tank",
        name = "$ff_display_tank",
        name_t = "Tank",
        sprite = "mods/foolish_gauges/files/tank/sprite.png",
        draw_order = {
            "SPRITE", "STEP", "OVERLAY"
        },
        func_unlocked = function() return true end,
        custom_logic = function(heat)
            local step_count = 115
            local step = math.min(math.floor((heat / 300) * step_count), step_count)
            local frame = GameGetFrameNum()
            local step_path = "mods/foolish_gauges/files/tank/generated/" .. (math.floor((frame / 12) % 2 + 1))
            if heat >= 400 then
                step_path = step_path .. "_hot"
            end
            local sprites = {
               SPRITE = "mods/foolish_gauges/files/tank/sprite.png",
               STEP =  step_path .. "/" .. step .. ".png",
               OVERLAY = "mods/foolish_gauges/files/tank/overlay.png",
            }
            return sprites
        end,
    },
    {
        id = "market",
        name = "$ff_display_market",
        name_t = "Market",
        sprite = "mods/foolish_gauges/files/market/sprite.png",
        draw_order = {
            "SPRITE", "STEP", "MARKET_LAST", "MARKET_NOW",
        },
        func_unlocked = function() return true end,
        custom_logic = function(heat)
            local step_count = 379
            local step = math.min(math.floor((heat / 300) * step_count), step_count)
            local sprites = {
               SPRITE = "mods/foolish_gauges/files/market/sprite.png",
               STEP = "mods/foolish_gauges/files/market/generated/" .. step .. ".png",
               MARKET_LAST = "mods/foolish_gauges/files/market/last_0.png",
               MARKET_NOW = "mods/foolish_gauges/files/market/now_0.png",
            }
            local frame_now = GameGetFrameNum()
            local frame_last = tonumber(GlobalsGetValue("ff_market_gauge_frame", "0"))
            local heat_last = tonumber(GlobalsGetValue("ff_market_gauge_heat", "0"))
            local status_last = tonumber(GlobalsGetValue("ff_market_gauge_status", "0"))
            local step = 6
            local a = math.floor(heat * step) / step - math.floor(heat_last * step) / step
            local status_now = 0
            if a > 0 then 
                status_now = 1 
                sprites["MARKET_NOW"] = "mods/foolish_gauges/files/market/now_1.png"
            elseif a < 0 then 
                status_now = -1
                sprites["MARKET_NOW"] = "mods/foolish_gauges/files/market/now_-1.png"
            end
            if status_last > 0 then
                sprites["MARKET_LAST"] = "mods/foolish_gauges/files/market/last_1.png"
            elseif status_last < 0 then
                sprites["MARKET_LAST"] = "mods/foolish_gauges/files/market/last_-1.png"
            end
            if frame_now >= frame_last + 60 then
                GlobalsSetValue("ff_market_gauge_frame", tostring(frame_now))
                GlobalsSetValue("ff_market_gauge_heat", tostring(heat))
                GlobalsSetValue("ff_market_gauge_status", tostring(status_now))
            end
            if heat >= 400 then
                sprites["SPRITE"] = "mods/foolish_gauges/files/market/sprite_hot.png"
            end
            return sprites
        end,
    },
    {
        id = "relic",
        name = "$ff_display_relic",
        name_t = "Relic",
        sprite = "mods/foolish_gauges/files/relic/sprite.png",
        draw_order = {
            "SPRITE", "STEP",
        },
        func_unlocked = function() return true end,
        custom_logic = function(heat)
            local step_count = 182
            local step = math.min(math.floor((heat / 300) * step_count), step_count)
            local sprites = {
               SPRITE = "mods/foolish_gauges/files/relic/sprite.png",
               STEP = "mods/foolish_gauges/files/relic/generated/" .. step .. ".png",
            }
            if heat >= 400 then
                sprites["SPRITE"] = "mods/foolish_gauges/files/relic/sprite_hot.png"
            end
            return sprites
        end,
    },
}

for i,v in ipairs(foolish_gauges) do
    table.insert(heat_gauges, v)
end