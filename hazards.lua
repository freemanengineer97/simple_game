m = {}

function collidesWith(unit, hazards)
  stati = {}
  dpt = 0
  for i, hazard_list in pairs(hazards) do
    for j, hazard in pairs(hazard_list) do
      if unit.x > hazard.x and unit.y > hazard.y and 
          unit.x < hazard.x + hazard.w and 
          unit.y < hazard.y + hazard.h then
        dpt = hazard.dpt or 0
        if hazard.status then
          for k, status in hazard.status do
            stati[status] = 1
          end
        break -- only apply one hazard of each type at a time
        end
      end
    end
  end
  unit.hp = unit.hp - dpt
  -- TODO: Add status effects
end

function m.dmg(a, hazards)
  for i, follower in pairs(a.followers) do
    collidesWith(follower, hazards)
  end
  collidesWith(a.player, hazards)
end

return m