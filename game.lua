
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
    return (map[math.floor(y)][math.floor(x)] ~= -1); 
end

minimapF = function()
    m = {}
    
      
      m.width = 300;
      m.height = 300;
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


minimap = minimapF()
player = playerF()

player.init()



drawAll = function()
    minimap.draw();
    player.draw(); 
end



-- update = function()
--     if(jaws.pressed("left")) { player.direction = -1 };
--     if(jaws.pressed("right")) { player.direction = 1 };
--     if(jaws.pressed("up")) { player.speed = 1 };
--     if(jaws.pressed("down")) { player.speed = -1 }; 

--     if(jaws.on_keyup(["left", "right"], function(){
--        player.direction = 0;
--     })); 
--     if(jaws.on_keyup(["up", "down"], function(){
--        player.speed = 0;
--     })); 
--     player.move();
-- end



while true do
    buttons.read()

    drawAll()

    screen.flip() 
end



