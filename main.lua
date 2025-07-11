-- require "input"
local p_m = require("player_movement")
local f_m = require("follower_movement")
local k = require("keys")
local u_a = require("user_actions")
local s_c = require("stage_configs.0_2") -- TODO: parameterize
local h = require("hazards")

function love.load()
  a, hazards = unpack(s_c.init())
  input_mode = "keyboard" -- TODO: parameterize when working on control scheme
end

function love.update(dt)
  p_m.move(a.player)
  f_m.move(a.followers)
  h.dmg(a, hazards)
end


function love.draw()
  -- hazards
  for i, hazard_list in pairs(hazards) do 
    for j, hazard in pairs(hazard_list) do
      love.graphics.setColor(unpack(hazard.color))
      love.graphics.rectangle("fill", hazard.x, hazard.y, hazard.w, hazard.h)
    end
  end
  -- followers
  love.graphics.setColor(1, 1, 1, 1)
  for i, follower in pairs(a.followers) do 
    love.graphics.circle("fill", follower.x, follower.y, 10)
    love.graphics.print("HP:", follower.x - 25, follower.y - 30)
    love.graphics.print(string.format("%.1f", follower.hp), follower.x - 5, follower.y - 30)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.print(tostring(i), follower.x - 5, follower.y - 5)
    love.graphics.setColor(1, 1, 1, 1)
  end

  -- player
  love.graphics.circle("fill", a.player.x, a.player.y, 20)
  love.graphics.print("HP:", a.player.x - 30, a.player.y - 40)
  love.graphics.print(string.format("%.1f", a.player.hp), a.player.x - 10, a.player.y - 40)
  love.graphics.setColor(0, 0, 0, 1)
  love.graphics.print("P", a.player.x - 5, a.player.y - 5)
  love.graphics.setColor(1, 1, 1, 1)
  -- love.graphics.print(distance, 0, 10)

end

function love.keypressed(key)
  if key==k.util_key.add_follower then 
    u_a.add_follower(a.followers, a.player)
  end
end