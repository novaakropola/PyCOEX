-- Old UF6 temps:        242  836 2893 10000
-- Old reactor maximums: 250 1000 3000 10000
-- New UF6 temps:        213  648 1972  6000

-- We should require that to use a new reactor, the engineer must implement the
-- corresponding Uranium Processing research. They should not be able to pump
-- 10C UF6 through a MK04 reactor and reap the efficiency benefits. This better
-- simulates different fuel cells, which is how the real world handles UF6.
-- Reactors don't just accept straight UF6.

local entity = ENTITY('nuclear-reactor-mk01')
entity.energy_source.minimum_temperature = 10
entity.energy_source.maximum_temperature = 250
entity = ENTITY('nuclear-reactor-mk02')
entity.energy_source.minimum_temperature = 250
entity.energy_source.maximum_temperature = 650
entity = ENTITY('nuclear-reactor-mk03')
entity.energy_source.minimum_temperature = 650
entity.energy_source.maximum_temperature = 2000
entity = ENTITY('nuclear-reactor-mk04')
entity.energy_source.minimum_temperature = 2000
entity.energy_source.maximum_temperature = 6000
