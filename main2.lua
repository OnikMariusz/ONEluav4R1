-- A simple raycasting engine
-- Uses LuaPlayer as framework
os.cpu(333)
map = {
    width = 10,
    height = 10,
    --mapping decor : 1 = Wall, 0 = No Wall
    {1,1,1,1,1,1,1,1,1,1},
    {1,0,0,0,0,0,0,0,0,1},
    {1,0,0,1,1,1,1,0,0,1},
    {1,0,0,0,0,0,0,0,0,1},
    {1,1,0,0,0,0,0,0,1,1},
    {1,0,0,0,1,0,1,0,0,1},
    {1,0,0,0,1,0,1,0,0,1},
    {1,0,0,0,1,0,1,0,0,1},
    {1,0,0,1,1,0,0,0,0,1},
    {1,1,1,1,1,1,1,1,1,1},
    }
    
    --Player's Starting Position
    posx = 2
  
    posy = 3
    
    --Initial Directior Vector, Plane Setting and Time Settings
    dirx = 1
    diry = 0
    planex = 0
    planey = 0.66
    
    move = 1
    rotation = math.pi/2
    direction = 1
    
    timer = 0
    oldtime = 10
    
    --screen Dimensions
    screenx = 480
    screeny = 272
    
            colorRoof = color.new(30, 70, 30)
            colorSky = color.new(30, 70, 200)
            colorStripes = color.new(70, 56, 90)
            
    while true do
        buttons.read()
    
    
        x=0
        
        for x = 0,screenx do
        camx = 2*x/screenx - 1
        rayposx = posx
        rayposy = posy
        raydirx = dirx + planex*camx
        raydiry = diry + planey*camx
    
        mapx = rayposx
        mapy = rayposy
    
        sidedistx = 0
        sidedisty = 0
    
        deltadistx = math.sqrt(1+(raydiry*raydiry)/(raydirx*raydirx))
        deltadisty = math.sqrt(1+(raydirx*raydirx)/(raydiry*raydiry))
        perp = 0
    
        stepx = 0
        stepy = 0
        hit = 0
        side = 0
    
            if raydirx < 0 then
            stepx = -1
            sidedistx = (rayposx - mapx)*deltadistx
            else stepx = 1
            sidedistx = (mapx + 1 - rayposx)*deltadistx end
    
            if raydiry < 0 then
            stepy = -1
            sidedisty = (rayposy - mapy)*deltadisty
            else stepy = 1
            sidedisty = (mapy + 1 - rayposy)*deltadisty end
    
            while hit == 0 do
                if sidedistx < sidedisty then
                sidedistx = sidedistx + deltadistx
                mapx = mapx + stepx
                side = 0
                else
                sidedisty = sidedisty + deltadisty
                mapy = mapy + stepy
                side = 1
                end
                
                if map[mapx][mapy] > 0 then hit = 1 end
            end
            
            if side == 0 then
            perp = math.abs((mapx - rayposx + (1-stepx)/2)/raydirx)
            else perp = math.abs((mapy - rayposy + (1-stepy)/2)/raydiry)
            end
            
            lineheight = math.abs(screeny/perp)	
            
            draw2 = -lineheight/2 + screeny/2
            if draw2 < 0 then draw2 = 0 end
            draw2E = lineheight/2 + screeny/2
            if draw2E >= screenx then draw2E = screenx - 1 end
            
    
            a = 65
            b = 58
            c = 63	
    
            if side == 1 then
            a = a-30
            b = b-30
            c = c-30
            end
            color = color.new(a, b, c) 
            bandUp = screeny/2+draw2E
            bandDown = screeny/2+draw2    
            draw.rect(x, draw2, 1, draw2E, color)--screen:fillRect(x, draw, 1, drawE, color);
            draw.rect(x, draw2E, 1, 272, colorRoof)-- screen:fillRect(x, drawE, 1, 272, colorRoof);
            draw.rect(x, 0, 1, draw2, colorSky)-- screen:fillRect(x, 0, 1, draw, colorSky);
            draw.rect(x, bandUp/2, 1, 1, colorStripes)-- screen:fillRect(x, bandUp/2, 1, 1,colorStripes)
            draw.rect(x, bandDown/2, 1, 1, colorStripes)-- screen:fillRect(x, bandDown/2, 1, 1,colorStripes)
            draw.rect(x, screeny/2, 1, 1, colorStripes)-- screen:fillRect(x, screeny/2, 1, 1,colorStripes)
        end	
        
    
        
    if buttons.up then
    --timer = timer+1
    --if timer >= oldtime then
          if map[posx + dirx * move][posy] == 0 then posx = posx + dirx * move end
          if map[posx][posy + diry * move] == 0 then posy = posy + diry * move end
    --timer = 0
    --end
    end
    
    if buttons.down then
    --timer = timer+1
    --if timer >= oldtime then
          if map[posx - dirx * move][posy] == 0 then posx = posx - dirx * move end
          if map[posx][posy - diry * move] == 0 then posy = posy - diry * move end
    --timer = 0
    --end
    end
    
    if buttons.right then
    --timer = timer+1.5
    --if timer >= oldtime then
          --both camera direction and camera plane must be rotated
          oldDirX = dirx;
          dirx = dirx * math.cos(-rotation) - diry * math.sin(-rotation);
          diry = oldDirX * math.sin(-rotation) + diry * math.cos(-rotation);
          oldPlaneX = planex;
          planex = planex * math.cos(-rotation) - planey * math.sin(-rotation);
          planey = oldPlaneX * math.sin(-rotation) + planey * math.cos(-rotation);
    direction = direction + 1
    --timer = 0
    --end
    end
    
    if buttons.left then
    --timer = timer+1.5
    --if timer >= oldtime then
          --both camera direction and camera plane must be rotated
          oldDirX = dirx;
          dirx = dirx * math.cos(rotation) - diry * math.sin(rotation);
          diry = oldDirX * math.sin(rotation) + diry * math.cos(rotation);
          oldPlaneX = planex;
          planex = planex * math.cos(rotation) - planey * math.sin(rotation);
          planey = oldPlaneX * math.sin(rotation) + planey * math.cos(rotation);
    direction = direction - 1
    --timer = 0
    --end
    end
        
    
        
        
    screen.flip() 
    end