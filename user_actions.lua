c__units = require("classes.units")

m = {}

function m.add_follower(followers, player)
  max_follower = nil
  max_id = 0
  for i, follower in pairs(followers) do
    if i > max_id then
      max_id = i
      max_follower = follower
    end
  end
  if max_id > 0 then
    table.insert(followers, c__units.Follower:init{
      parent_id = max_id,
      x = max_follower.x,
      y = max_follower.y,
    })
  else -- no followers, use player as parent
    table.insert(followers, c__units.Follower:init{
      parent_id = 0,
      x = player.x,
      y = player.y,
    })

  end
end

return m