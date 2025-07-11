local p = require("params")
local k = require("keys")

local m = {}

function resolve_keys()
  move_vector = { x = 0, y = 0 }
    
  if love.keyboard.isDown(k.move_key.up) then
    move_vector.y = move_vector.y - p.velocity
  end
  if love.keyboard.isDown(k.move_key.down) then
    move_vector.y = move_vector.y + p.velocity
  end
  if love.keyboard.isDown(k.move_key.left) then
    move_vector.x = move_vector.x - p.velocity
  end
  if love.keyboard.isDown(k.move_key.right) then
    move_vector.x = move_vector.x + p.velocity
  end

  -- if moving diagonally, apply penalty
  if math.abs(move_vector.x) > 0 and math.abs(move_vector.y) > 0 then
    move_vector.x = move_vector.x * p.diag_mult
    move_vector.y = move_vector.y * p.diag_mult
  end

  return move_vector
end


function m.move(player)
  if input_mode == "keyboard" then
    move_vector = resolve_keys()
    player:move(move_vector.x, move_vector.y)
  end
end

return m