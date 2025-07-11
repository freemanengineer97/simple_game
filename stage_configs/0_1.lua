local c__units = require("classes.units")

m = {}

local num_followers = 3
local init_loc_player = { x = 500, y = 250 }
local init_follower_displacement_vector = { x = -10, y = -10 }

function m.init()
  player = c__units.player.init(init_loc_player.x, init_loc_player.y)

  followers = {}
  for i=1,num_followers do
    followers[i] = c__units.follower.init(
      init_loc_player.x + (init_follower_displacement_vector.x * i),
      init_loc_player.y + (init_follower_displacement_vector.y * i),
      { x = 0, y = 0 }
    )
  end

  a = { player = player, followers = followers }

  m.hazards = {
    {
      x = 600,
      y = 600,
      w = 200,
      h = 200,
      dpt = 0.1
    }
  }

  return { a, hazards }
end

return m