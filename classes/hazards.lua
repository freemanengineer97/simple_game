m = {}

Hazard = {}

Lava = {}

function Hazard:init(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Lava:init(o)
  o.type = "lava"
  o.dpt = 0.2
  o.color = {225, 0, 0}
  -- o.status
  return Hazard:init(o)
end

m = {
  Hazard = Hazard,
  Lava = Lava
}

return m