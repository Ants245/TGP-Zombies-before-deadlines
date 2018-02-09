local Vec2 = {}

function Vec2:new(x,y)
local vec2 = {}

  vec2.x = x or 0
  vec2.y = y or 0
  vec2.DirX = 0
  vec2.DirY = 0
  vec2.AngleX = 0
  vec2.AngleY = 0
  vec2.Distance = 0
  
  function vec2:move(nx,ny)
    local delta = dt or 1 
    self.x = self.x + nx * delta
    self.y = self.y + ny + delta
  end
  
  function vec2:setXY(x,y)
    self.x = x
    self.y = y
  end
  
    
  function vec2:setX(x)
    self.x = x 
  end
  
  function vec2:setY(y)
    self.y = y
  end
  
  function vec2:getX()
    return self.x;
  end
  
  function vec2:getY()
    return self.y
  end
  
  function vec2:setDis(num)
    self.Disance = num
  end
  
  function vec2:getDis()
   return self.Distance
  end  
  
  function vec2:setDirX(x)
    self.DirX = x
  end
   
  function vec2:setDirY(y)
    self.DirY = y
  end
  
  function vec2:getDirX()
    return self.DirX
  end
  
  function vec2:getDirY()
    return self.DirY
  end
  
  function vec2:getAngleX()
    return self.AngleX
  end
  
  function vec2:getAngleY()
    return self.AngleY
  end
  
  function vec2:setAngleX(x)
    self.AngleX = x
  end
  
  function vec2:setAngleY(y)
    self.AngleY = y
  end
  
  
  
  
  return vec2

end

return Vec2