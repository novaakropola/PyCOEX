-- Currently the yield for Nuclear Power 1, per high-energy waste 1:
-- .25629150 plutonium oxide    1.1148680 candy
--
-- For Nuclear Power 2:
-- .27836539 plutonium oxide    1.2108894 candy
-- .39201118 uranium oxide      .39201118
--
-- For Nuclear Power 3:
-- .24755022 plutonium oxide    1.0768435 candy
-- .30838177 uranium oxide      .30838177
-- .042927648 americium oxide   .042927648
-- .0057236865 Cm-250           .0057236865

-- With the figures below, per high-energy waste 2:
-- .26103653 mox plutonium oxide    1.2477546 candy
--
-- For Nuclear Power 2:
-- .26103653 mox plutonium oxide    1.2477546 candy
-- .34946174 mox uranium oxide      .34946174 candy
--
-- For Nuclear Power 3:
-- .26103653 mox plutonium oxide    1.2477546 candy
-- .32154719 mox uranium oxide      .32154719 candy
-- .058930713 mox americium oxide   .058930713 candy
-- .0078574284 Cm-250               .0078574284 candy

RECIPE{
    type = 'recipe',
    name = 'coex-extraction',
    categories = {'hydroclassifier'},
    enabled = false,
    energy_required = 10,
    ingredients = {
        {type = 'fluid', name = 'coex-concentrate-1', amount = 60},
        {type = 'item',  name = 'tbp',                amount = 1},
        {type = 'fluid', name = 'kerosene',           amount = 100},
    },
    results = {
        {type = 'fluid', name = 'coex-concentrate-2', amount = 60},
        {type = 'fluid', name = 'coex-waste-1',       amount = 30},
    },
    main_product = 'coex-concentrate-2',
    subgroup = 'py-nuclear-waste',
    order = 'c-01',
}:add_unlock('nuclear-power')

RECIPE{
    type = 'recipe',
    name = 'coex-scrubbing',
    categories = {'fluid-separator'},
    enabled = false,
    energy_required = 10,
    ingredients = {
        {type = 'fluid', name = 'coex-concentrate-2', amount = 80},
        {type = 'fluid', name = 'acetone',            amount = 100},
    },
    results = {
        {type = 'fluid', name = 'coex-concentrate-3', amount = 60},
        {type = 'fluid', name = 'coex-waste-1',       amount = 20},
    },
    main_product = 'coex-concentrate-3',
    subgroup = 'py-nuclear-waste',
    order = 'c-02',
}:add_unlock('nuclear-power')

RECIPE{
    type = 'recipe',
    name = 'coex-waste-washing',
    categories = {'fluid-separator'},
    enabled = false,
    energy_required = 10,
    ingredients = {
        {type = 'fluid', name = 'coex-waste-1',      amount = 200},
        {type = 'fluid', name = 'hydrogen-chloride', amount = 100},
    },
    results = {
        {type = 'fluid', name = 'coex-concentrate-1', amount = 25},
        {type = 'fluid', name = 'coex-waste-2',       amount = 40},
        {type = 'item',  name = 'sb-chloride',        amount = 5},
    },
    main_product = 'coex-waste-2',
    subgroup = 'py-nuclear-waste',
    order = 'c-03',
}:add_unlock('nuclear-power')

RECIPE{
    type = 'recipe',
    name = 'coex-waste-vitrification',
    categories = {'bof'},
    enabled = false,
    energy_required = 20,
    ingredients = {
        {type = 'fluid', name = 'coex-waste-2',    amount = 250},
        {type = 'item',  name = 'stainless-steel', amount = 2},
        {type = 'item',  name = 'sugar',           amount = 5},
        {type = 'fluid', name = 'molten-glass',    amount = 50},
    },
    results = {
        {type = 'fluid', name = 'coex-concentrate-2',   amount = 15},
        {type = 'fluid', name = 'coex-u-concentrate-1', amount = 10},
        {type = 'item',  name = 'molybdenum-ore',       amount = 5},
        {type = 'item',  name = 'vitrified-glass',      amount = 1},
    },
    main_product = 'vitrified-glass',
    subgroup = 'py-nuclear-waste',
    order = 'c-04',
}:add_unlock('nuclear-power')

RECIPE{
    type = 'recipe',
    name = 'coex-raffinate-vitrification',
    categories = {'bof'},
    enabled = false,
    energy_required = 20,
    ingredients = {
        {type = 'fluid', name = 'coex-raffinate',  amount = 200},
        {type = 'item',  name = 'stainless-steel', amount = 2},
        {type = 'item',  name = 'sugar',           amount = 5},
        {type = 'fluid', name = 'molten-glass',    amount = 50},
    },
    results = {
        {type = 'fluid', name = 'coex-u-concentrate-1', amount = 20},
        {type = 'item',  name = 'molybdenum-ore',       amount = 5},
        {type = 'item',  name = 'vitrified-glass',      amount = 1},
    },
    main_product = 'vitrified-glass',
    subgroup = 'py-nuclear-waste',
    order = 'c-05',
}:add_unlock('nuclear-power')

RECIPE{
    type = 'recipe',
    name = 'coex-partition',
    categories = {'fluid-separator'},
    enabled = false,
    energy_required = 10,
    ingredients = {
        {type = 'fluid', name = 'coex-concentrate-3', amount = 100},
    },
    results = {
        {type = 'fluid', name = 'coex-mixed-concentrate', amount = 50},
        {type = 'fluid', name = 'coex-u-concentrate-1',   amount = 30},
        {type = 'fluid', name = 'coex-raffinate',         amount = 10},
    },
    main_product = 'coex-mixed-concentrate',
    subgroup = 'py-nuclear-waste',
    order = 'c-06',
}:add_unlock('nuclear-power')

RECIPE{
    type = 'recipe',
    name = 'coex-peroxide',
    categories = {'chemistry'},
    enabled = false,
    energy_required = 10,
    ingredients = {
        {type = 'fluid', name = 'coex-mixed-concentrate', amount = 100},
        {type = 'fluid', name = 'hydrogen-peroxide',      amount = 100},
    },
    results = {{type = 'fluid', name = 'coex-peroxide', amount = 50}},
    main_product = 'coex-peroxide',
    subgroup = 'py-nuclear-waste',
    order = 'c-07',
}:add_unlock('nuclear-power')

RECIPE{
    type = 'recipe',
    name = 'coex-oxide',
    categories = {'evaporator'},
    enabled = false,
    energy_required = 2,
    ingredients = {
        {type = 'fluid', name = 'coex-peroxide', amount = 100},
        {type = 'fluid', name = 'ethanol',       amount = 50},
    },
    results = {{type = 'item', name = 'plutonium-oxide-mox', amount = 10}},
    subgroup = 'py-nuclear-waste',
    order = 'c-08',
}:add_unlock('nuclear-power')

-- NUCLEAR 2: MOX uranium
RECIPE{
    type = 'recipe',
    name = 'coex-uranium-washing',
    categories = {'hydroclassifier'},
    enabled = false,
    energy_required = 5,
    ingredients = {
        {type = 'fluid', name = 'coex-u-concentrate-1', amount = 100},
        {type = 'item',  name = 'tbp',                  amount = 1},
        {type = 'fluid', name = 'kerosene',             amount = 100},
    },
    results = {
        {type = 'fluid', name = 'coex-u-concentrate-2', amount = 20},
        {type = 'fluid', name = 'coex-raffinate',       amount = 10},
        {type = 'item',  name = 'tbp', amount = 1, independent_probability = 0.5, ignored_by_productivity = 1},
    },
    main_product = 'coex-u-concentrate-2',
    subgroup = 'py-nuclear-waste',
    order = 'c-10',
}:add_unlock('nuclear-power-mk02')

RECIPE{
    type = 'recipe',
    name = 'coex-uranium',
    categories = {'evaporator'},
    enabled = false,
    energy_required = 1,
    ingredients = {{type = 'fluid', name = 'coex-u-concentrate-2', amount = 10}},
    results = {{type = 'item', name = 'uranium-oxide-mox', amount = 1}},
    subgroup = 'py-nuclear-waste',
    order = 'c-11',
}:add_unlock('nuclear-power-mk02')

RECIPE{
    type = 'recipe',
    name = 'uranium-seperation-mox',
    categories = {'pa'},
    enabled = false,
    energy_required = 20,
    ingredients = {{type = 'item', name = 'uranium-oxide-mox', amount = 10}},
    results = {
        {type = 'item', name = 'u-232', amount = 10, shared_probability = {min = 0.000, max = 0.001}},
        {type = 'item', name = 'u-233', amount = 10, shared_probability = {min = 0.001, max = 0.002}},
        {type = 'item', name = 'u-234', amount = 10, shared_probability = {min = 0.002, max = 0.007}},
        {type = 'item', name = 'u-235', amount = 10, shared_probability = {min = 0.007, max = 0.017}},
        {type = 'item', name = 'u-236', amount = 10, shared_probability = {min = 0.017, max = 0.047}},
        {type = 'item', name = 'u-237', amount = 10, shared_probability = {min = 0.047, max = 0.097}},
        {type = 'item', name = 'u-238', amount = 10, shared_probability = {min = 0.097, max = 1.000}},
    },
    main_product = 'u-238',
    subgroup = 'py-nuclear',
    order = 'h',
}:add_unlock('nuclear-power-mk02')

-- NUCLEAR 3: MOX americium
RECIPE{
    type = 'recipe',
    name = 'coex-americium-oxygenation',
    categories = {'hydroclassifier'},
    enabled = false,
    energy_required = 10,
    ingredients = {
        {type = 'fluid', name = 'coex-raffinate', amount = 150},
        {type = 'fluid', name = 'oxygen',         amount = 200},
    },
    results = {{type = 'fluid', name = 'coex-ac-oxygenated', amount = 40}},
    subgroup = 'py-nuclear-waste',
    order = 'c-20',
}:add_unlock('nuclear-power-mk03')

RECIPE{
    type = 'recipe',
    name = 'americium-reduction-mox',
    categories = {'pan'},
    enabled = false,
    energy_required = 10,
    ingredients = {
        {type = 'fluid', name = 'coex-ac-oxygenated', amount = 60},
        {type = 'item',  name = 'th-oxide',           amount = 10},
    },
    results = {
        {type = 'fluid', name = 'c-oxygenated',       amount = 20},
        {type = 'item',  name = 'americium-oxide-mox', amount = 5},
    },
    main_product = 'americium-oxide-mox',
    subgroup = 'py-nuclear-waste',
    order = 'c-21',
}:add_unlock('nuclear-power-mk03')

RECIPE{
    type = 'recipe',
    name = 'americium-seperation-mox',
    categories = {'pa'},
    enabled = false,
    energy_required = 20,
    ingredients = {{type = 'item', name = 'americium-oxide-mox', amount = 5}},
    results = {
        {type = 'item', name = 'am-241', amount = 5, shared_probability = {min = 0, max = .3}},
        {type = 'item', name = 'am-243', amount = 5, shared_probability = {min = .3, max = 1}},
    },
    main_product = 'am-243',
    subgroup = 'py-nuclear',
    order = 'h',
}:add_unlock('nuclear-power-mk02')
