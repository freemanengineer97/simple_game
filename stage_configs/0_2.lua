local c__units = require("classes.units")
local c__hazards = require("classes.hazards")

m = {}

local num_followers = 3
local init_loc_player = { x = 500, y = 250 }
local init_follower_displacement_vector = { x = -10, y = -10 }

function m.init()
  -- player = c__units.Player:init{init_loc_player.x, init_loc_player.y}

  player = c__units.Player:init{
    x = 200, 
    y = 400, 
  }

  -- for i, m in pairs(player) do
  --   print("\t" .. tostring(i) .. "\t" .. tostring(m))
  -- end

  followers = {}
  for i=1,num_followers do
    followers[i] = c__units.Follower:init{
      parent_id = i - 1,
      x = init_loc_player.x + (init_follower_displacement_vector.x * i),
      y = init_loc_player.y + (init_follower_displacement_vector.y * i),
    }
    -- for j, n in pairs(followers[i]) do
    --   print("\t" .. tostring(j) .. "\t" .. tostring(n))
    -- end
  end


  a = { player = player, followers = followers }
  
  hazards = {
    lava_list = {
      c__hazards.Lava:init{
        x = 800, 
        y = 600,
        w = 200,
        h = 100
      }
    } 
  }

  return { a, hazards }
end

return m