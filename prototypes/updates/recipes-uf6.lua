-- See https://github.com/pyanodon/pyalternativeenergy/blob/0f99d5243a8a879b2ad655a23a9ab569df7ab418/prototypes/updates/pyrawores-updates.lua#L403-L533

-- The old system doesn't conserve energy. This is the main problem that allows
-- people to abuse temperature mixing to maximize/minimize temperature; PUREX-
-- only people would want to maximize UF6 concentration, while MOX-only people
-- would want to minimize.
--
-- Each stage produces a higher and a lower 'temperature'. Temperatures are
-- just an abstraction. They reflect the concentration of U-235. But it's good
-- enough. The problem is apparent when mixing the outputs; you get more energy
-- than you started with.
--
-- But yes, at each stage, the temperature is increased by a factor of ~1.28
-- and decreased by a factor of ~1.28. If we had equal amounts of output, we
-- would increase the energy by 3.09%. What we want to do instead is conserve
-- energy; choose proportions that give us equilibrium.
--
-- In the real world, nobody goes to 100% enrichment, and 100% is actually
-- unusable as fuel. You need U-238 in the mix. These are some designations:
-- * Depleted -- 0.2--0.3%
-- * Natural -- 0.7%
-- * LEU -- 3--5%
-- * LEU+ -- 5--10%
-- * HALEU -- 5--19.75%
-- * HEU -- 20%+
-- * Weapons-grade -- 90%+
-- * Naval propulsion fuel -- 93%+
-- As percentages go up, the amount of depleted uranium also goes up. It can
-- get out of control, really.
--
-- With the old set of recipes, we'd see (assuming no mixing cheats):
-- * 2750 yellowcake -> 25k UF6-242   + 30k  U-238
--   * 3226.67 waste-1 + 20000 waste-2
--   * 8.45 waste/yellowcake
-- * 4000 yellowcake -> 25k UF6-836   + 55k  U-238
--   * 27866.7 waste-1 + 117333. waste-2
--   * 36.3 waste/yellowcake
-- * 5250 yellowcake -> 25k UF6-2893  + 80k  U-238
--   * 192867. waste-1 + 384000. waste-2
--   * 110. waste/yellowcake
-- * 6500 yellowcake -> 25k UF6-10000 + 105k U-238
--   * 1333333 waste-1 + 1120000 waste-2
--   * 377. waste/yellowcake
--
-- Note the unwieldy amounts of U-238. You can't just mix your problems away
-- when you have energy-conserving recipes!
--
-- The following changes will occur:
-- * Maximum enrichment will be 60%. Starting at the natural level of 0.7%, the
--   thresholds will be (as 'temperatures'):
--   *   87  109  136  170  213
--   *  266  332  415  519  648
--   *  810 1011 1264 1578 1972
--   * 2463 3077 3845 4803 6000
-- * The UF6 yield will be multiplied by 100.
-- * The UF6 cost of U-238 will be multiplied by 200; corrects a large
--   discrepency between waste yield in the new system.
-- * Speed up UF6 centrifuges by a factor of 10.
--
-- With the new set of recipes, assuming precise heat separation:
-- * 278.75 yellowcake -> 25k UF6-213  + 2662.5 U-238
--   * 2840 waste-1 + 1775 waste-2
--   * 16.6 waste/yellowcake
-- * 822.5   yellowcake -> 25k UF6-648  + 8100   U-238
--   * 21600 waste-1 + 17280 waste-2
--   * 47.3 waste/yellowcake
-- * 2477.5  yellowcake -> 25k UF6-1972 + 24650  U-238
--   * 131467. waste-1 + 118320. waste-2
--   * 101. waste/yellowcake
-- * 7512.5  yellowcake -> 25k UF6-6000 + 75000  U-238
--   * 800000. waste-1 + 800000. waste-2
--   * 213. waste/yellowcake
--
-- Recipe timing was updated by a factor of 10. To consume all of the UF6 from
-- the yellowcake recipe at full speed, you would need 3.31129 buildings
-- processing 70C, and scale down when expanding outward. At later tiers, the
-- demands increase slightly (up to 4.65758). That seems like a lot, but it
-- isn't necessary. One building of each produces this much maxed UF6 per tier:
--      maxed-UF6 | waste     | reactor limit of maxed-UF6
-- * 1: 33.86/sec   3.847/sec   70.42/sec
-- * 2: 8.918       7.705       23.15
-- * 3: 2.766       14.53       7.614
-- * 4: .8931       28.5792     2.5
-- So if you beacon to 2.08, 2.60, 2.76, 2.80 (resp.), you can run a reactor
-- full speed.


-- To multiply yield by 100, first divide all ingredients/results/time by 5.
-- Time will be 0.8 sec.
-- Inputs will be 1 yellowcake, 10 hydrofluoric acid, 10 fluorine gas.
-- Output will be 2000 UF6 at 70C.
local recipe = RECIPE('yellow-cake-uf6')
recipe.energy_required = recipe.energy_required / 5
for _, ing in ipairs(recipe.ingredients) do
    -- Well these should all be divisible by 5 already.
    ing.amount = math.floor(ing.amount / 5 + .5)
end
for _, res in ipairs(recipe.results) do
    if res.name == 'uf6' then
        res.amount = res.amount * 100
    end
    res.amount = math.floor(res.amount / 5 + .5)
end

local total_recipes = 20
local starting_enrichment = 0.7
local recipe_num = 1
local og_enrichment = starting_enrichment
local og_multiplier = (100 / starting_enrichment) ^ (1 / total_recipes)
local nova_enrichment = starting_enrichment
local nova_multiplier = (60 / starting_enrichment) ^ (1 / total_recipes)

while og_enrichment < 100 do
    local og_u235 = og_enrichment * og_multiplier
    local og_u238 = og_enrichment / og_multiplier
    local nova_u235 = nova_enrichment * nova_multiplier
    local nova_u238 = nova_enrichment / nova_multiplier

    -- Cooling recipe temperatures won't be adjusted (but possibly rounded).
    if recipe_num == 1 then
        nova_u238 = og_u238
    elseif og_u235 > 100 then
        break
    end

    -- Renaming is a bad idea.
    -- Also, the old code was wrong-ish. It would use rounding here, but the
    -- temperatures in the recipe are not.
    local og_name = string.format('%.2f', tostring(og_u235))
    local nova_name = string.format('%.2f', tostring(nova_u235))
    local recipe_name = 'uf6-' .. string.gsub(og_name, '%.', '-')

    local recipe = RECIPE(recipe_name)
    local ing, res = recipe.ingredients, recipe.results
    if ing and res and #ing == 1 and #res == 2
        and ing[1].name == 'uf6' and ing[1].minimum_temperature
        and res[1].name == 'uf6' and res[2].name == 'uf6'
        and res[1].temperature and res[2].temperature then

        local max_temp = math.floor(nova_u235 * 100 + .5)
        local negative_mod = 10 ^ -(5 - math.floor(math.log(max_temp, 10)))

        local hi, lo = res[1], res[2]
        if hi.temperature < lo.temperature then hi, lo = lo, hi end

        local in_amt = ing[1].amount
        local in_temp = math.floor(nova_enrichment * 100 + .5)
        local hi_temp = math.floor(nova_u235 * 100 + .5)
        local lo_temp = math.floor(nova_u238 * 100 + .5)

        -- Rewrite them to use adjusted and rounded temperatures. And corrected amounts.
        ing[1].minimum_temperature = math.floor(nova_enrichment * 100 + .5)
        ing[1].maximum_temperature = hi_temp - negative_mod

        -- Energy input is in_amt*in_temp*T
        -- Energy output is p*in_amt*hi_temp*T + (1-p)*in_amt*lo_temp*T
        -- Set equal, solve for p:
        --   in_temp = p * hi_temp + (1 - p) * lo_temp
        --   p = (in_temp - lo_temp) / (hi_temp - lo_temp)
        -- So hi.amount should be in_amt * p.

        hi.temperature = hi_temp
        hi.amount = math.floor(in_amt * (in_temp - lo_temp) / (hi_temp - lo_temp) + .5)
        lo.temperature = lo_temp
        lo.amount = in_amt - hi.amount

        recipe.energy_required = recipe.energy_required / 10
        recipe.localised_name[2] = nova_name
    end

    og_enrichment = og_u235
    nova_enrichment = nova_u235
    recipe_num = recipe_num + 1
end

local duf_min = 0.1
local depleted_recipes = 5
local depleted_multiplier = (starting_enrichment / duf_min) ^ (1 / math.floor(depleted_recipes + 1))
local duf = starting_enrichment / og_multiplier
recipe_num = 1

while duf > duf_min do
    local u235 = duf * depleted_multiplier
    local u238 = duf / depleted_multiplier

    if recipe_num == 1 then
        u235 = starting_enrichment
    elseif recipe_num == depleted_recipes then
        u238 = duf_min
    end

    local name = string.format('%.2f', tostring(u238))
    local recipe_name = 'depleted-uf6-' .. string.gsub(name, '%.', '-')

    local recipe = RECIPE(recipe_name)
    local ing, res = recipe.ingredients, recipe.results
    if ing and res and #ing == 1 and #res == 2
        and ing[1].name == 'uf6' and ing[1].minimum_temperature
        and res[1].name == 'uf6' and res[2].name == 'uf6'
        and res[1].temperature and res[2].temperature then

        local max_temp = math.floor(u235 * 100 + .5)
        local negative_mod = 10 ^ -(5 - math.floor(math.log(max_temp, 10)))

        local hi, lo = res[1], res[2]
        if hi.temperature < lo.temperature then hi, lo = lo, hi end

        local in_amt = ing[1].amount
        local in_temp = math.floor(duf * 100 + .5)
        local hi_temp = math.floor(u235 * 100 + .5)
        local lo_temp = math.floor(u238 * 100 + .5)

        -- Rewrite them to use rounded temperatures. And corrected amounts.
        ing[1].minimum_temperature = in_temp
        ing[1].maximum_temperature = hi_temp - negative_mod
        hi.temperature = hi_temp
        hi.amount = math.floor(in_amt * (in_temp - lo_temp) / (hi_temp - lo_temp) + .5)
        lo.temperature = lo_temp
        lo.amount = in_amt - hi.amount

        recipe.energy_required = recipe.energy_required / 10
        -- The localised_name here is already correct. But I'll write it
        -- anyway.
        recipe.localised_name[2] = name
    end

    duf = u238
    recipe_num = recipe_num + 1
end

-- Multiply cost by 200.
-- Will be 8000 UF6 10C + 2 sec -> 40 U-238.
recipe = RECIPE('Depleted-uf6-to-u-oxide')
for _, ing in ipairs(recipe.ingredients) do
    if ing.name == 'uf6' then
        ing.amount = ing.amount * 200
        ing.maximum_temperature = math.floor(duf_min * 100 + .5) -- round it instead
    end
end
