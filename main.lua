dofile("raycaster.lua")
os.cpu(333)
--load colors
color.loadpalette()

function DrawFieldOvView(tableX, tableY, _p, _color)

   
    for y=1, #tableY, 1 do
        --local z = tableX[y+1]
        --screen.print(400,2*10,"pointY"..z,0.8)
    
        if (y+1) <= #tableY then 
            draw.filltriangle(_p.x, _p.y, tableX[y+1], tableY[y+1], tableX[y], tableY[y], _color)
        end
            -- draw.filltriangle(p.x, p.y, pointX[3], pointY[3], pointX[2], pointY[2], alpha)
            -- draw.filltriangle(p.x, p.y, pointX[4], pointY[4], pointX[3], pointY[3], alpha)
            -- draw.filltriangle(p.x, p.y, pointX[5], pointY[5], pointX[4], pointY[4], alpha)
            -- draw.filltriangle(p.x, p.y, pointX[6], pointY[6], pointX[5], pointY[5], alpha)
            -- draw.filltriangle(p.x, p.y, pointX[7], pointY[7], pointX[6], pointY[6], alpha)
            -- draw.filltriangle(p.x, p.y, pointX[8], pointY[8], pointX[7], pointY[7], alpha)
            -- draw.filltriangle(p.x, p.y, pointX[9], pointY[9], pointX[8], pointY[8], alpha)
            -- draw.filltriangle(p.x, p.y, pointX[10], pointY[10], pointX[9], pointY[9], alpha)
            -- draw.filltriangle(p.x, p.y, pointX[11], pointY[11], pointX[10], pointY[10], alpha)
            -- draw.filltriangle(p.x, p.y, pointX[12], pointY[12], pointX[11], pointY[11], alpha)
            -- draw.filltriangle(p.x, p.y, pointX[13], pointY[13], pointX[12], pointY[12], alpha)
            -- draw.filltriangle(p.x, p.y, pointX[14], pointY[14], pointX[13], pointY[13], alpha)
            -- draw.filltriangle(p.x, p.y, pointX[15], pointY[15], pointX[14], pointY[14], alpha)
            -- draw.filltriangle(p.x, p.y, pointX[16], pointY[16], pointX[15], pointY[15], alpha)
            -- draw.filltriangle(p.x, p.y, pointX[17], pointY[17], pointX[16], pointY[16], alpha)
            -- draw.filltriangle(p.x, p.y, pointX[18], pointY[18], pointX[17], pointY[17], alpha)
            -- draw.filltriangle(p.x, p.y, pointX[19], pointY[19], pointX[18], pointY[18], alpha)
        
    end

end

map = {}
--mapa
map.data = {
    {46, 46, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 25, 13, 13, 13, 13, 13, 9, 24, 24, 24, 24, 24, 10, 13, 13},
    {46, 46, 35, 36, 34, 35, 36, 34, 35, 36, 34, 37, 36, 34, 35, 36, 13, 13, 13, 13, 13, 14, 46, 46, 46, 46, 46, 12, 13, 13},
    {46, 13, 13, 13, 13, 13, 13, 13, 13, 13, 14, 46, 12, 13, 13, 13, 13, 13, 13, 13, 13, 14, 46, 46, 46, 46, 46, 12, 13, 13},
    {46, 13, 9, 24, 24, 24, 24, 24, 24, 24, 25, 46, 23, 10, 13, 13, 13, 13, 13, 13, 13, 14, 46, 46, 46, 46, 46, 12, 13, 13},
    {46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 12, 13, 13, 13, 13, 13, 13, 13, 14, 46, 46, 46, 46, 46, 12, 13, 13},
    {13, 13, 14, 46, 46, 46, 46, 46, 46, 1, 2, 3, 46, 23, 24, 24, 24, 24, 24, 24, 24, 25, 46, 46, 46, 46, 46, 12, 13, 13},
    {13, 13, 14, 46, 46, 46, 46, 46, 46, 12, 13, 14, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 12, 13, 13},
    {13, 13, 20, 2, 2, 2, 2, 2, 2, 21, 13, 20, 2, 2, 2, 2, 2, 2, 3, 46, 46, 46, 46, 46, 46, 46, 46, 12, 13, 13},
    {13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 14, 46, 46, 46, 46, 46, 46, 46, 46, 12, 13, 13},
    {13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 14, 46, 46, 46, 46, 46, 46, 46, 46, 12, 13, 13},
    {13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 14, 46, 46, 46, 46, 46, 46, 46, 46, 12, 13, 13},
    {13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 9, 24, 24, 24, 25, 46, 46, 46, 46, 46, 46, 46, 46, 12, 13, 13},
    {13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 14, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 12, 13, 13},
    {13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 14, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 12, 13, 13},
    {13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 20, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 21, 13, 13},
    {13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13},
    {13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13}
}
map.width = 480
map.height = 272
map.tileWidth = 16
map.tileHeight = 16

map.widthInTile = 30
map.heightIntile = 17
map.img = image.load("Tile2.png", map.tileWidth, map.tileHeight)



map.draw = function()

    for y = 1, #map.data, 1 do 
        for x = 1, #map.data[1], 1 do
           -- test = map.data[x][y] 
            image.blitsprite(map.img, (x-1)*map.tileWidth, (y-1)*map.tileHeight, (map.data[y][x] -1))
            
        end
    end
end




function player(_x,_y, _color, _img)
    local o = {}
    o.x = _x or 0
    o.y = _y or 0
    --red color
    o.color = _color or color.new( 250, 0, 0)
    o.directionAngle = 90
    o.speedX = 0
    o.radius =8
    o.speedY = 0
    o.width = 10
    o.height = 10
    o.halfWidth = o.width/2
    o.halfHeight = o.height/2
    o.circleSections = 60
    o.rotationSpeed = 90
    o.img = image.load(_img)

    o.CheckColision = function(_x, _y, _colisionTileIndex)

            local playerTilePositionX = math.floor(_x / map.tileWidth) +1
            local playerTilePositionY = math.floor(_y / map.tileHeight) +1

            local maxX = #map.data[1]
            local maxY = #map.data

            if playerTilePositionX < 1 or playerTilePositionY < 1 or playerTilePositionX > maxX or playerTilePositionY > maxY then 

                return "true"
            else
                if map.data[playerTilePositionY][playerTilePositionX] == _colisionTileIndex then 
                    return "false"
                else
                    return "true"
                end
            end
           
    end

    --Draw player
    --x = radius + radius * sin(45);
    --y = radius + radius * cos(45);
    o.Draw = function()
        --draw.rect(o.x, o.y, o.width,o.height, o.color )
        -- local x2 = o.x + o.width
        -- local y2 = o.y + o.height
        -- draw.line(o.x, o.y, x2, o.y, o.color)
        -- draw.line(x2, o.y, x2, y2, o.color)
        -- draw.line(x2,y2, o.x, y2, o.color)
        -- draw.line(o.x,y2, o.x, o.y, o.color)

        -- draw.circle(o.x, o.y, o.radius, o.color, o.circleSections)

        local xx = (o.x) + (20  * math.cos(math.rad(o.directionAngle))) 
        local yy = (o.y) +(20 * math.sin(math.rad(o.directionAngle))) 

        -- local nextX1 = (o.x + o.radius) + (o.speedX * math.cos(math.rad(o.directionAngle)))
        -- local nextY1 = (o.y + o.radius) + (o.speedY * math.sin(math.rad(o.directionAngle)))
        -- local nextX = (o.x - o.radius) + (o.speedX * math.cos(math.rad(o.directionAngle)))
        -- local nextY = (o.y - o.radius) + (o.speedY * math.sin(math.rad(o.directionAngle)))
        -- local nextX2 = (o.x - o.radius) + (o.speedX * math.cos(math.rad(o.directionAngle)))
        -- local nextY2 = (o.y + o.radius) + (o.speedY * math.sin(math.rad(o.directionAngle)))

        -- local nextX3 = (o.x + o.radius) + (o.speedX * math.cos(math.rad(o.directionAngle)))
        -- local nextY3 = (o.y - o.radius) + (o.speedY * math.sin(math.rad(o.directionAngle)))


        -- local colision = o.CheckColision(nextX, nextY, 46)
        -- local colision2 = o.CheckColision(nextX1, nextY1, 46)
        -- local colision3 = o.CheckColision(nextX2, nextY2, 46)
        -- local colision4 = o.CheckColision(nextX3, nextY3, 46)

        -- if colision == "true" or colision2 == "true"or colision3 == "true" or colision4 == "true" then 
        --     o.x = o.x
        --     o.y = o.y
        -- else
            o.x = o.x + (o.speedX * math.cos(math.rad(o.directionAngle)))
            o.y = o.y + (o.speedY * math.sin(math.rad(o.directionAngle)))
        --end 
            

        
        image.blit(o.img, o.x, o.y)
        --draw.line(o.x , o.y , xx, yy, color.red)
    end
    return o
end


--initialization 

--image
p = player(5*16+8, 5*16+8,color.red, "player.png")
image.center(p.img)
map.img = image.load("16x16.png", map.tileWidth, map.tileHeight)
r = Raycaster(p)

--rr = Raycaster(p);

--main game loop
while true do
    buttons.read()

    

     



    -- if buttons.left then
    --     p.directionAngle = p.directionAngle - p.rotationSpeed
        
    -- end
    -- if buttons.right then
    --     p.directionAngle = p.directionAngle + p.rotationSpeed
    -- end

   

    if buttons.up then 
        p.x = p.x + (16 * math.cos(math.rad(p.directionAngle)))
        p.y = p.y + (16 * math.sin(math.rad(p.directionAngle)))
        
    end
    if buttons.down then 
        p.x = p.x - (16 * math.cos(math.rad(p.directionAngle)))
        p.y = p.y - (16 * math.sin(math.rad(p.directionAngle)))
    end
    

    if buttons.left then 
        --p.x  = p.x -16 
        p.directionAngle = p.directionAngle-90
    end
    if buttons.right then 
       -- p.x  = p.x + 16 
        p.directionAngle = p.directionAngle + 90
    end

    
    --     p.speedY = 1
    --     p.speedX = 1
    -- end

    -- if buttons.down then 
    --     p.speedY = -1
    --     p.speedX = -1
    -- end

    -- if not buttons.held.down and not buttons.held.up then 

    --     p.speedY = 0
    --     p.speedX = 0
    -- end

    --local colision  = p.CheckColision()

    --local playerTilePositionX = math.floor(p.x / map.tileWidth)
    --local playerTilePositionY = math.floor(p.y / map.tileHeight)
 

    map.draw()
    p.Draw()

    pointX = {}
    pointY = {}

    maxDistance = 3
    
    
    --r.CastRays(p)
    for i = -45, 45 , 5 do 
    
    
    plusAngle = (p.directionAngle+i) %360
    if plusAngle < 0 then plusAngle = plusAngle + 360 end
    twoPi = math.pi * 2
    plusAngle = math.rad(plusAngle)

    tangensAlfa = math.tan(plusAngle)
    up = plusAngle > math.pi

    if up == true then up = "true" else up = "false" end

    right = (plusAngle >  twoPi *0.75 or plusAngle < twoPi * 0.25)
    if right == true then right = "true" else right = "false" end

    localX =((p.x/16) - math.floor(p.x/16)) 
    localY =((p.y/16) - math.floor(p.y/16)) 

   

    dk = math.abs((1)/math.cos(plusAngle))
    dl = math.abs((1)/math.sin(plusAngle))

    k = (localX * dk)
    l = (localY * dl) 

    index = (plusAngle%twoPi)/(math.pi/2)

    arrX = {1, -1, -1, 1}
    arrY = {1, 1, -1, -1}

    stepX =arrX[math.floor(index) + 1]
    stepY = arrY[math.floor(index) + 1]

    ceilPosX = math.floor(p.x/16)
    ceilPosY = math.floor(p.y/16)

    hit = false
    distance = 0 

    licznik = 0 

    while hit == false do
        
        if k>l then
            distance = l
            ceilPosY = ceilPosY + stepY
                if map.data[ceilPosY+1][ceilPosX+1] ~= 46 then 
                   
                    if distance > maxDistance then distance = maxDistance end 
                    hit = true
                   
                    
                    
                else
                    
                   if distance  >=maxDistance then 
                    
                        if distance > maxDistance then distance = maxDistance end 
                            hit = true
                   else

                    l = l + dl

                   end
                   
                    
                end
        else
            ceilPosX = ceilPosX + stepX
            distance = k 
            if map.data[ceilPosY+1][ceilPosX+1] ~= 46 then 
                if distance > maxDistance then distance = maxDistance end 
                hit = true
               
            
                
               
            else
               
                if distance   >=maxDistance then 
                    
                    if distance  > maxDistance then distance = maxDistance end
                    hit = true
                else
                    k = k + dk

                end
            
                
            end
        end
       -- licznik = licznik +1

    end

    tx = p.x+ (math.cos(plusAngle) * distance *16) 
    ty = p.y + (math.sin(plusAngle) * distance*16) 

    table.insert(pointX, tx)
    table.insert(pointY, ty)
    --draw.line(p.x, p.y, tx, ty , color.green)

    end

    alpha = color.new(0,255,0, 50)
    
            --screen.print(400,2*10,"pointY"..pointX[1],0.8)

            DrawFieldOvView(pointX, pointY, p, alpha)
            --draw.filltriangle(p.x, p.y, pointX[20], pointY[20], pointX[19], pointY[19], alpha)
    
    


    --local fps = screen.fps()
    --screen.print(5,105,"k = "..k*16,0.3)
    --screen.print(400,5,"fps = "..fps,0.8)
    --[[ screen.print(5,115,"l = "..l*16,0.3)
    screen.print(5,125,"localY = "..localY,0.3)
    screen.print(5,135,"localX = "..localX,0.3)
    screen.print(5,145,"player direction: "..(p.directionAngle%360),0.3)
    screen.print(5,155,"tangens alfa = "..tangensAlfa,0.3)
    screen.print(5,165,"plusAngle = "..plusAngle,0.3)
    screen.print(5,175,"dk = "..dk,0.3)
    screen.print(5,185,"dl = "..dl,0.3)
    screen.print(5,195,"index = "..index,0.3)
    screen.print(5,205,"stepX = "..stepX,0.3)
    screen.print(5,215,"stepY = "..stepY,0.3)
    screen.print(5,225,"distance = "..(distance*16),0.3)
    screen.print(5,235,"player.speedY = "..p.speedY,0.3) ]]

    --[[ local odp = nil
    if IsCenterSprite(p) then 
        odp = "true"
    else
        odp = "false"
    end 
    screen.print(5,245,"can move = "..odp,0.3) ]]




    

    --[[ if up == "true" and right == "true" then 
    localX =  math.abs(localX)
    localY = math.abs(localY)
    end

    if up == "false" and right == "false" then 
        localX = 16 - math.abs(localX)
        localY = 16 - math.abs(localY)
    end



    localXIntersection =( (localX / math.cos(plusAngle)))
    localYIntersection = ( (localY / math.sin(plusAngle)))

    if localXIntersection == math.huge then localXIntersection = 0 end
    if localYIntersection == math.huge then localYIntersection = 0 end

    
    ppx = p.x + math.cos(plusAngle) * math.abs(localYIntersection)
    ppy = p.y + math.sin(plusAngle) * math.abs(localYIntersection)

    ppx2 = p.x + math.cos(plusAngle) * math.abs(localXIntersection)
    ppy2 = p.y + math.sin(plusAngle) * math.abs(localXIntersection)


    dx = -40000
    dy = -40000

    pkafelX = math.floor(p.x/16) + 1
    pkafelY = math.floor(p.y/16) +1

    dk = math.abs(16/math.cos(plusAngle)) 
    dl = math.abs(16/math.sin(plusAngle))  ]]


    

    --[[ if math.abs(localXIntersection) == math.abs(localYIntersection) or math.floor(math.abs(localXIntersection)) ==math.floor(math.abs(localYIntersection)) then 
        if up == "true" then
            dy = -1
        else
            dy = 1
        end
    else
        if localXIntersection ~= 0 then 

            if math.abs(localYIntersection) < math.abs(localXIntersection)  then
           
                if up == "true" then 
                    dy = -1
                else
                    dy = 1
                end
            else
                dy = 0

            end
        
        
            
        else
            if localYIntersection ~= 0 then 
                if up == "true" then
                    dy = -1
                else
                    dy = 1
                end
            else
                dy = 1
            end
        end
    end

    if math.abs(localXIntersection) == math.abs(localYIntersection) or math.floor(math.abs(localXIntersection)) ==math.floor(math.abs(localYIntersection)) then 
        if right == "false" then
            dx = -1
        else
            dx = 1
        end
    else
        if localXIntersection ~= 0 then 

            if math.abs(localYIntersection) > math.abs(localXIntersection)  then
           
                if right == "false" then 
                    dx = -1
                else
                    dx = 1
                end
            else
                dx = 0

            end
        
        
            
        else
            if localYIntersection ~= 0 then 
                if right == "false" then
                    dx = -1
                else
                    dx = 1
                end
            else
                dx = 1
            end
        end
    end ]]


    --[[ distanceX = 0
    distanceY = 0 
    hit = false

    startCellX = math.floor(p.x/16) + 1
    startCellY = math.floor(p.y/16) +1



    while hit == false do

        nextCellX = startCellX + math.floor(  (16/math.cos(plusAngle) )* dx)
        nextCellY = startCellY + math.floor ( (16/math.sin(plusAngle) )* dy)
        if map.data[nextCellY+1][nextCellX+1] ~= 46 then 
            hit = true
            distanceX = nextCellX
            distanceY = nextCellY
        else
        startCellX = nextCellX
        startCellY = nextCellY
        end
    
    end ]]


    --deltaX = 


    --hitX =p.x +  math.cos(plusAngle) *( p.x  (distanceX * 16)  )
    --hitY = math.sin(plusAngle) * (distanceY * 16)  


    --draw.fillrect((distanceX*16)-16, (distanceY*16)-16, 16,16,color.red)
    --draw.line(p.x, p.y, ppx2, ppy2, color.blue)

    --screen.print(5,0,"player index on map "..colision,0.5)
    --screen.print(5,0,"player index X on map "..playerTilePositionX,0.5)
    --screen.print(5,10,"player index Y on map "..playerTilePositionY,0.5)
    --local fps = screen.fps()
    --map.data[wallY][wallX] = 77
    --screen.print(5,85,"wallY = "..wallY,0.3)
    --screen.print(5,95,"wallX = "..wallX,0.3)
    --screen.print(5,105,"y = "..y,0.3)
    --screen.print(5,105,"localYIntersection  = "..localYIntersection,0.3)
    --screen.print(5,115,"localXIntersection  = "..localXIntersection,0.3)
    

    --screen.print(5,175,"right = "..right,0.3)
    --screen.print(5,185,"up = "..up,0.3)

    --screen.print(5,195,"dk = "..dk,0.3)
    --screen.print(5,205,"dl = "..dl,0.3)
    --screen.print(5,170,"r.a = "..r.a,0.3)
    --screen.print(5,175,"r.distance = "..r.distance,0.3)


   -- screen.print(5,20,"player speedX : "..p.speedX,0.5)
   --local modX = p.x% map.tileWidth
  
   
    screen.flip() 
end

