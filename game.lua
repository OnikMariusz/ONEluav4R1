
os.cpu(333)
--load colors
color.loadpalette()

map = { 
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}, 
        {1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,1}, 
        {1,-1,-1,-1,-1,-1,-1,0,-1,2,3,1,-1,-1,-1,1}, 
        {1,1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,1}, 
        {1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,1}, 
        {1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,1}, 
        {1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,1}, 
        {1,-1,3,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,1}, 
        {1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,2,-1,-1,-1,1}, 
        {1,-1,-1,1,-1,-1,-1,-1,-1,3,-1,-1,-1,-1,-1,1}, 
        {1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,1}, 
        {1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,1}, 
        {1,-1,-1,-1,-1,-1,1,-1,-1,2,-1,-1,-1,-1,-1,1}, 
        {1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,1}, 
        {1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,1}, 
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
}; 

playerF = function()

    local p = {}
    p.x = 0
    p.y = 0
    p.direction = 0
    p.angle = 0
    p.speed = 0
    p.movementSpeed = 0
    p.turnSpeed = 0
    
  
 

    p.init = function()
      p.x = 10;
      p.y = 6;
      p.direction = 0;
      p.angle = 0;
      p.speed = 0;
      p.movementSpeed = 0.1;
      p.turnSpeed = 4 * math.pi / 180; 
    end
      
    p.move = function()
        local moveStep = p.speed * p.movementSpeed;
        p.angle = p.angle + p.direction * p.turnSpeed;
        local newX = p.x + math.cos(p.angle) * moveStep;
        local newY = p.y + math.sin(p.angle) * moveStep;
        if not containsBlock(newX, newY) then
          p.x = newX;
          p.y = newY;
        end
    end
    
    p.draw = function()
        local playerXOnMinimap = p.x * minimap.cellWidth;
        local playerYOnMinimap = p.y * minimap.cellHeight;   
        draw.gradcircle(minimap.cellWidth*p.x, minimap.cellHeight*p.y, minimap.cellWidth/2, color.red, color.black, 60); 
        local projectedX = p.x + math.cos(p.angle);
        local projectedY = p.y + math.sin(p.angle);
        draw.fillrect(minimap.cellWidth*projectedX - minimap.cellWidth/4, minimap.cellHeight*projectedY - minimap.cellHeight/4, minimap.cellWidth/2, minimap.cellHeight/2, color.green);
    
    end

    return p
end


function containsBlock(x,y) 
    return (map[math.floor(y+1)][math.floor(x+1)] ~= -1); 
end

minimapF = function()
    m = {}
    
      
      m.width = 172;
      m.height = 172;
      m.cellsAcross = #map[1]
      m.cellsDown = #map;
      m.cellWidth = m.width/m.cellsAcross;
      m.cellHeight = m.height/m.cellsDown;
      m.colors = {color.yellow,color.magenta,color.cyan ,color.blue};
      m.curentColor = nil

    m.draw = function()

        for  y = 1, m.cellsDown, 1 do
            for  x = 1,  m.cellsAcross, 1 do
                local cell = map[y][x];
                    if cell ==-1 then
                        m.curentColor= color.white
                    else
                        m.curentColor = m.colors[map[y][x]+1];
                    end

                    draw.fillrect(m.cellWidth*(x-1), m.cellHeight*(y-1), m.cellWidth, m.cellHeight, m.curentColor);
            end
        
        end
    end

    return m
      
end

raycasterF = function()
    r = {}
    local numberOfRays = 300;
    local angleBetweenRays = 0.2 * math.pi /180;
    
    r.castRays = function() 
        for  i=1, numberOfRays-1, 1 do
            local rayNumber = -numberOfRays/2 + i;
            local rayAngle = angleBetweenRays * rayNumber + player.angle;
            r.castRay(rayAngle);
        end
    end
      
    r.castRay = function(rayAngle)
        local twoPi = math.pi * 2
        rayAngle = rayAngle % twoPi
        if rayAngle < 0 then  rayAngle = rayAngle +  twoPi end
        local right = (rayAngle > twoPi * 0.75 or rayAngle < twoPi * 0.25)
        local up = rayAngle > math.pi

        local slope = math.tan(rayAngle)
        local distance = 0
        local xHit = 0;
        local yHit = 0;
        local wallX 
        local wallY
        -- equivalent to var = cond ? a : b; var = cond and a or b ?: - https://pl.qaz.wiki/wiki/%3F:#Lua
        local dX = right and 1 or -1
        local dY = dX * slope  
        local x = right and  math.ceil(player.x) or math.floor(player.x)
        local y = player.y + (x - player.x) * slope 
        
        while  x >= 0 and  x < minimap.cellsAcross and y >= 0 and y < minimap.cellsDown do
            local rr = right and 0 or -1
            wallX = math.floor(x + rr)
            wallY = math.floor(y)
                if map[wallY+1][wallX+1] > -1 then
                    local distanceX = x - player.x
                    local distanceY = y - player.y
                    distance = math.sqrt(distanceX*distanceX + distanceY*distanceY)  
                    xHit = x
                    yHit = y
                    break;
                end
            x = x + dX
            y = y + dY
        end

        slope = 1/slope;
        dY = up and  -1 or 1;
        dX = dY * slope;
        y = up and  math.floor(player.y) or math.ceil(player.y);
        x = player.x + (y - player.y) * slope;
        
        while x >= 0 and x < minimap.cellsAcross and y >= 0 and y < minimap.cellsDown do
            local yy = up and -1 or 0
            wallY = math.floor(y + yy)
            wallX = math.floor(x)
            if map[wallY+1][wallX+1] > -1 then  
                local distanceX = x - player.x;
                local distanceY = y - player.y;
                local blockDistance = math.sqrt(distanceX*distanceX + distanceY*distanceY);
                    if not distance or blockDistance < distance then
                        distance = blockDistance;
                        xHit = x;
                        yHit = y;
                    end
            break;
            end
          x = x + dX;
          y = y + dY;
        end

        r.draw(xHit, yHit); 
    end

    r.draw = function(rayX, rayY)
     
        local alpha 
        draw.line(minimap.cellWidth*player.x, minimap.cellHeight*player.y, rayX * minimap.cellWidth, rayY * minimap.cellHeight, color.green )
    end

    return r
end


minimap = minimapF()
player = playerF()

player.init()

raycaster = raycasterF()



drawAll = function()
    minimap.draw();
    player.draw();
    raycaster.castRays() 

end



update = function()
    if  buttons.left then  player.direction = -1 end
    if  buttons.right then  player.direction = 1 end
    if  buttons.up  then player.speed = 1 end
    if  buttons.down then player.speed = -1 end 

    if buttons.released.left then 
        player.direction = 0;
    end
    if buttons.released.right then 
        player.direction = 0;
    end
    if buttons.released.up then
        player.speed = 0
    end
    if buttons.released.down then
        player.speed = 0
    end      
    player.move();
end



while true do
    buttons.read()

    update()
    drawAll()

    screen.flip() 
end



