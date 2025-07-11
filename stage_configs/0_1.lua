m = {}

local num_followers = 3
local init_loc_player = { x = 500, y = 250 }
local init_follower_displacement_vector = { x = -10, y = -10 }

function m.init()
  player = { 
    hp = 100,
    x = init_loc_player.x,
    y = init_loc_player.y
  }

  followers = {}
  for i=1,num_followers do
    followers[i] = {
      hp = 10,
      parent_id = i-1,
      x = init_loc_player.x + (init_follower_displacement_vector.x * i),
      y = init_loc_player.y + (init_follower_displacement_vector.y * i),
      v = { x = 0, y = 0 }
    }
  end

  m.hazards = {
    {
      x = 600,
      y = 600,
      w = 200,
      h = 200,
      dpt = 0.1
    }
  }

  return { player, followers, hazards }
end

return m