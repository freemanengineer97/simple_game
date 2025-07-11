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
  love.graphics.circle("fill", player.x, player.y, 20)
  for i, follower in pairs(followers) do
    love.graphics.circle("fill", follower.x, follower.y, 10)
  end
  
  -- love.graphics.print("Distance to Follower", 0, 0)
  -- love.graphics.print(distance, 0, 10)

end

function love.keypressed(key)
  if key==k.util_key.add_follower then 
    u_a.add_follower()
  end
end