local m = {}

local desired_distance_player = 100
local desired_distance_follower = 60
local drag = 1.25
local magnetism = 0.005
-- may want to increase drag if upping this
local snappiness = 3


local flock_p = 80
local flock_f = 60
local flock_mag = -0.25
local flock_avoidance = 1.5


local fomo = 100
local fomo_mag = 0.02
local fomo_avoidance = 1.0


function follow_parent(follower, parent, desired_distance)
  -- follower
  -- attempts to be on top of player 
  -- follower_vector = { x = player.x - follower.x, y = player.y - follower.y }
  
  -- distance = math.sqrt(math.pow(follower_vector.x, 2) + math.pow(follower_vector.y, 2))
  -- follower.v = {
  --   x = (follower.v.x + (follower_vector.x * magnetism)) / drag,
  --   y = (follower.v.y + (follower_vector.y * magnetism)) / drag
  -- }
  -- follower.x = follower.x + follower.v.x
  -- follower.y = follower.y + follower.v.y

  -- attempts to always stay at distance of 100 units
  follower_vector = { x = parent.x - follower.x, y = parent.y - follower.y }

  -- get ratio of desired distance / distance
  distance = math.sqrt(math.pow(follower_vector.x, 2) + math.pow(follower_vector.y, 2))
  distance_modifier = desired_distance / distance

  -- add
  desired_vector = {
    x = (follower_vector.x - (distance_modifier * follower_vector.x)) * snappiness,
    y = (follower_vector.y - (distance_modifier * follower_vector.y)) * snappiness
  }

  follower.v = {
    x = (follower.v.x + (desired_vector.x * magnetism)) / drag,
    y = (follower.v.y + (desired_vector.y * magnetism)) / drag
  }
  return follower.v
end

-- keeping this simpler since this is n^2 instead of n above - drag should handle it!
function flock (follower, followers, num_followers, player)
  move_vector = { x = 0, y = 0 }
  for i, other_follower in pairs(followers) do
    -- may not want to sqrt here to save resources, we're already n^2 here
    follower_vector = { x = other_follower.x - follower.x, y = other_follower.y - follower.y }
    distance = math.sqrt(math.pow(follower_vector.x, 2) + math.pow(follower_vector.y, 2))
    if distance < flock_f then
      pctg_in = math.pow((flock_f - distance) / flock_f, flock_avoidance)
      move_vector = {
        x = move_vector.x + (follower_vector.x * flock_mag * pctg_in),
        y = move_vector.y + (follower_vector.y * flock_mag * pctg_in)
      }
    end
  end
  
  -- we'll do sqrt here bc player collision is more important (and larger) (and n)
  follower_vector = { x = player.x - follower.x, y = player.y - follower.y }
  -- if performance is ever an issue, maybe just check here if we're within twice flocking distance first?
  distance = math.sqrt(math.pow(follower_vector.x, 2) + math.pow(follower_vector.y, 2))
  if distance < flock_p then
    pctg_in = math.pow((flock_p - distance) / flock_p, flock_avoidance)
    move_vector = {
      x = move_vector.x + (follower_vector.x * flock_mag * pctg_in),
      y = move_vector.y + (follower_vector.y * flock_mag * pctg_in)
    }
  end
  return move_vector
end

function intuition (follower, player)
  move_vector = { x = 0, y = 0 }
  follower_vector = { x = player.x - follower.x, y = player.y - follower.y }
  distance = math.sqrt(math.pow(follower_vector.x, 2) + math.pow(follower_vector.y, 2))
  if distance > fomo then
    pctg_out = math.pow((distance - fomo) / fomo, fomo_avoidance)
    move_vector = {
      x = move_vector.x + (follower_vector.x * fomo_mag * pctg_out),
      y = move_vector.y + (follower_vector.y * fomo_mag * pctg_out)
    }
  end
  return move_vector
end

function m.move(followers)
  -- for i, follower in pairs(allies.followers) do
  --   print(follower.x)
  -- end
  for i, follower in pairs(followers) do
    local move_vector = { x = 0, y = 0 }

    if follower.parent_id == 0 then
      move_vector = follow_parent(follower, player, desired_distance_player)
    else 
      move_vector = follow_parent(follower, followers[follower.parent_id], desired_distance_follower)
    end
    move_vector_flock = flock(follower, followers, num_followers, player)
    move_vector = {
      x = move_vector.x + move_vector_flock.x,
      y = move_vector.y + move_vector_flock.y
    }
    move_vector_fomo = intuition(follower, player)
    move_vector = {
      x = move_vector.x + move_vector_fomo.x,
      y = move_vector.y + move_vector_fomo.y
    }
    follower:move(move_vector.x, move_vector.y)
  end
end

return m