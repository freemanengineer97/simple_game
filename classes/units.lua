m = {}

Unit = {}

Player = {} 
Follower = {}

function Unit:init(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Unit:move(x, y)
  self.x = self.x + x
  self.y = self.y + y
end

function Unit:getPos()
  return { x = self.x, y = self.y }
end



function Player:init(o)
  o.type = "player"
  o.hp = 100
  o.v = { x = 0, y = 0 }
  o.max_v = 5
  return Unit:init(o)
end



function Follower:init(o)
  o.type = "follower" 
  o.hp = 10
  o.v = { x = 0, y = 0 }
  return Unit:init(o)
end

m = {
  Player = Player,
  Follower = Follower
}

return m