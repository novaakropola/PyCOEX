-- 1. Dissolution: edit the original (HF instead of sulfuric, now makes a fluid)
local dissolve = RECIPE('waste-mox-disolving')
dissolve.energy_required = 15
dissolve.ingredients = {
    {type = 'item',  name = 'high-energy-waste-2', amount = 8},
    {type = 'fluid', name = 'hydrofluoric-acid',   amount = 50},
}
dissolve.results = {{type = 'fluid', name = 'coex-concentrate-1', amount = 100}}
dissolve.main_product = 'coex-concentrate-1' -- must be a result, or the load fails
dissolve.order = 'c-00'
