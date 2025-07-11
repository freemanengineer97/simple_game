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
  h.handler()
end


function love.draw()
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.circle("fill", player.x, player.y, 20)
  love.graphics.print("HP:", player.x - 30, player.y - 40)
  love.graphics.print(string.format("%.1f", player.hp), player.x - 10, player.y - 40)
  love.graphics.setColor(0, 0, 0, 1)
  love.graphics.print("P", player.x - 5, player.y - 5)
  love.graphics.setColor(1, 1, 1, 1)

  for i, follower in pairs(followers) do 
    love.graphics.circle("fill", follower.x, follower.y, 10)
    love.graphics.print("HP:", follower.x - 25, follower.y - 30)
    love.graphics.print(string.format("%.1f", follower.hp), follower.x - 5, follower.y - 30)
  end

  -- love.graphics.print(distance, 0, 10)

end

function love.keypressed(key)
  if key==k.util_key.add_follower then 
    u_a.add_follower(a.followers, a.player)
  end
end