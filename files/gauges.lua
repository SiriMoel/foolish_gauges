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
            local step_count = 6 * 20 - 1
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
}

for i=1,#foolish_gauges do
    heat_gauges[#heat_gauges+i] = foolish_gauges[i]
end