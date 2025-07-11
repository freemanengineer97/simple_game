m = {}

function m.add_follower()
  num_followers = num_followers + 1
  followers[num_followers] = {
    parent_id = num_followers - 1,
    x = followers[num_followers - 1].x,
    y = followers[num_followers - 1].y,
    v = { x = 0, y = 0 }
  }
end

return m