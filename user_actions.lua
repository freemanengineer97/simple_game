m = {}

function m.add_follower(followers)
  i = 1
  while true do
    if followers[i] == nil then
      followers[i] = {
        parent_id = num_followers - 1,
        x = followers[num_followers - 1].x,
        y = followers[num_followers - 1].y,
        v = { x = 0, y = 0 }
      }
      break
    end
    i = i + 1
  end
end

return m