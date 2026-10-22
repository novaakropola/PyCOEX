for _, name in pairs {
    'uranium-oxide-mox', 'americium-oxide-mox',
} do
    ITEM {
        type = 'item',
        name = name,
        icon = '__PyCOEX__/graphics/icons/' .. name .. '.png',
        icon_size = 64,
        flags = {},
        subgroup = 'py-nuclear',
        order = 'a',
        stack_size = 100,
    }
end
