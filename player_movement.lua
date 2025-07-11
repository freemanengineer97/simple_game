local p = require("params")
local k = require("keys")

local m = {}

function resolve_keys(speed)
  move_vector = { x = 0, y = 0 }
    
  if love.keyboard.isDown(k.move_key.up) then
    move_vector.y = move_vector.y - speed
  end
  if love.keyboard.isDown(k.move_key.down) then
    move_vector.y = move_vector.y + speed
  end
  if love.keyboard.isDown(k.move_key.left) then
    move_vector.x = move_vector.x - speed
  end
  if love.keyboard.isDown(k.move_key.right) then
    move_vector.x = move_vector.x + speed
  end

  -- print("player move_vector:\n\tx: " .. tostring(move_vector.x) .. "\n\ty: " .. tostring(move_vector.y))
  -- if moving diagonally, apply penalty
  if math.abs(move_vector.x) > 0 and math.abs(move_vector.y) > 0 then
    move_vector.x = move_vector.x * p.diag_mult
    move_vector.y = move_vector.y * p.diag_mult
  end

  return move_vector
end


function m.move(player)
  move_vector = { x = 0, y = 0 }
  if input_mode == "keyboard" then
    move_vector = resolve_keys(player.speed)
  else
    move_vector = nil
  end

  player.v.x = player.v.x + move_vector.x - (player.v.x * player.drag)
  player.v.y = player.v.y + move_vector.y - (player.v.y * player.drag)

  player:move(player.v.x, player.v.y)

end

return m