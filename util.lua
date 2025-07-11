m = {}

function kill_player(a)
  -- lol
  a.player = nil
end

function kill_follower(i, follower, a)
  -- will want something a bit more robust if persistence matters
  a.followers[i] = nil
  -- worst-case we default to player
  last_id = 0
  for j, other_follower in pairs(a.followers) do
    if other_follower.parent_id == i then
      other_follower.parent_id = last_id
      last_id = j
    end
  end
  
end

function m.check_hp(a)
  for i, follower in pairs(a.followers) do
    if follower.hp <= 0 then
      kill_follower(i, follower, a)
    end
  end
  if a.player.hp <= 0 then
    kill_player(a)
  end
end

return m