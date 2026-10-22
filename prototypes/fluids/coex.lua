local function coex_fluid(name, color)
    FLUID {
        type = 'fluid',
        name = name,
        icon = '__PyCOEX__/graphics/icons/' .. name .. '.png',
        icon_size = 64,
        default_temperature = 10,
        max_temperature = 1000,
        base_color = color,
        flow_color = {r = 1, g = 1, b = 1},
        subgroup = 'py-nuclear',
        order = 'c',
    }
end

local function hsl(h, s, l)
    local r, g, b

    if s == 0 then
        -- greyscale
        r, g, b = l, l, l
    else
        local function hue2rgb(p, q, t)
            if t < 0 then t = t + 1 end
            if t > 1 then t = t - 1 end
            if t < 1/6 then return p + (q - p) * 6 * t end
            if t < 1/2 then return q end
            if t < 2/3 then return p + (q - p) * (2/3 - t) * 6 end
            return p
        end

        local q = l < 0.5 and (l * (1 + s)) or (l + s - l * s)
        local p = 2 * l - q

        local norm_h = h / 360

        r = hue2rgb(p, q, norm_h + 1/3)
        g = hue2rgb(p, q, norm_h)
        b = hue2rgb(p, q, norm_h - 1/3)
    end

    return {r = r, g = g, b = b}
end

-- Colors match icons.
coex_fluid('coex-concentrate-1', hsl(184, 1, .525))
coex_fluid('coex-concentrate-2', hsl(184, 1, .525))
coex_fluid('coex-concentrate-3', hsl(184, 1, .525))
coex_fluid('coex-waste-1',       hsl(186, .55, .3))
coex_fluid('coex-waste-2',       hsl(186, .55, .3))
coex_fluid('coex-mixed-concentrate', hsl(285, .65, .45))
coex_fluid('coex-peroxide',          hsl(225, .85, .35))
coex_fluid('coex-u-concentrate-1',   hsl(145, .85, .55))
coex_fluid('coex-u-concentrate-2',   hsl(145, .85, .55))
coex_fluid('coex-raffinate',         hsl(330, .65, .7))
coex_fluid('coex-ac-oxygenated',     hsl(50, .75, .5))
