
os.cpu(333)
--load colors
color.loadpalette()

map = {}
--mapa
map.data = {
    {13, 23, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 25, 13, 13, 13, 13, 13, 9, 24, 24, 24, 24, 24, 10, 13, 13},
    {13, 34, 35, 36, 34, 35, 36, 34, 35, 36, 34, 37, 36, 34, 35, 36, 13, 13, 13, 13, 13, 14, 46, 46, 46, 46, 46, 12, 13, 13},
    {13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 14, 46, 12, 13, 13, 13, 13, 13, 13, 13, 13, 14, 46, 46, 46, 46, 46, 12, 13, 13},
    {13, 13, 9, 24, 24, 24, 24, 24, 24, 24, 25, 46, 23, 10, 13, 13, 13, 13, 13, 13, 13, 14, 46, 46, 46, 46, 46, 12, 13, 13},
    {13, 13, 14, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 12, 13, 13, 13, 13, 13, 13, 13, 14, 46, 46, 46, 46, 46, 12, 13, 13},
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
map.img = image.load("16x16.png", map.tileWidth, map.tileHeight)



map.draw = function()

    for y = 1, #map.data, 1 do 
        for x = 1, #map.data[1], 1 do
           -- test = map.data[x][y] 
            image.blitsprite(map.img, (x-1)*map.tileWidth, (y-1)*map.tileHeight, (map.data[y][x] -1))
            
        end
    end
end

function Raycaster(_player)

    local r = {}
    r.numberOfRay = 300
    r.angleBetwinRays = 0.2 * math.pi/180

    r.CastRays = function(_player)
        for i = 1, r.numberOfRay, 1 do
            local rayNumber = -r.numberOfRay/2 + i
            local rayAngle = r.angleBetwinRays * rayNumber +(math.rad(_player.directionAngle))
            r.CastRay(rayAngle)
        end
      
        --r.CastRay(math.rad(_player.directionAngle))
    end

    r.CastRay = function(_angle)

        local twoPi = math.pi *2
        local rayAngle = _angle% twoPi

        if rayAngle < 0 then rayAngle = rayAngle + twoPi end
        local right  = (rayAngle > twoPi * 0.75 or rayAngle < twoPi * 0.25)
        local up = rayAngle > math.pi
        local slope = math.tan(rayAngle)
        local distance = 0
        local xHit = 0
        local yHit = 0 
        local wallX = nil
        local wallY = nil
        local dX = 0
        if right == true then dX = 1 else dX = -1 end
        local dY = dX * slope

        local x = 0

        if right == true then x = math.ceil(_player.x) else x = math.floor(_player.x) end 
        local y = _player.y + (x - _player.x) * slope


        while x >= 1 and x < #map.data[1] and y >=1 and y < #mapd.data do

            
            if right == true then 

                wallX = math.floor(x)
            else
                wallX = math.floor(x + -1)
            end

            wallY = math.floor(y)

            if map.data[wallY+1][wallX+1] ~= 46  then 
                local distanceX = x - _player.x 
                local distanceY = y - _player.y
                distance = math.sqrt(distanceX*distanceX + distanceY*distanceY)
                xHit = x
                yHit = y
                break
            end

            x = x+ dX
            y = y + dY
        end 
        -----------------------------------------------------

        slope = 1/slope
        dY = dY * slope

        if up == true then 
            y = math.floor(_player.y)
        else
            y = math.ceil(_player.y)
        end

        x = _player.x + (y - _player.y) * slope

        while x >= 1 and x < #map.data[1] and y >=1 and y < #mapd.data do

            if up == true then 

                wallY = math.floor(y + -1)
            else
                wallY = math.floor(y)
            end

            wallX = math.floor(x)

            if map.data[wallY+1][wallX+1] ~= 46  then 
                local distanceX = x - _player.x 
                local distanceY = y - _player.y
                local blockDistance = math.sqrt(distanceX*distanceX + distanceY*distanceY)
                if not distance or blockDistance < distance then 
                    distance = blockDistance
                    xHit = x
                    yHit = y
                end
                break
            end

            x = x + dX
            y = y + dY

        end

        draw.line(_player.x, _player.y, xHit, yHit, color.green)

        -- local px = _player.x + 30  * math.cos(_angle)
        -- local py = _player.y + 30  * math.sin(_angle) 
        -- draw.line(_player.x, _player.y, px, py, color.green)
    end

    ------------------------------------------------------------------------------------------

    return r
end


function player(_x,_y, _color, _img)
    local o = {}
    o.x = _x or 0
    o.y = _y or 0
    --red color
    o.color = _color or color.new( 250, 0, 0)
    o.directionAngle = 90
    o.speedX = 0
    o.radius =7.5
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

        local xx = (o.x) + (o.radius  * math.cos(math.rad(o.directionAngle))) 
        local yy = (o.y) +(o.radius * math.sin(math.rad(o.directionAngle))) 

        local nextX1 = (o.x + o.radius) + (o.speedX * math.cos(math.rad(o.directionAngle)))
        local nextY1 = (o.y + o.radius) + (o.speedY * math.sin(math.rad(o.directionAngle)))
        local nextX = (o.x - o.radius) + (o.speedX * math.cos(math.rad(o.directionAngle)))
        local nextY = (o.y - o.radius) + (o.speedY * math.sin(math.rad(o.directionAngle)))
        local nextX2 = (o.x - o.radius) + (o.speedX * math.cos(math.rad(o.directionAngle)))
        local nextY2 = (o.y + o.radius) + (o.speedY * math.sin(math.rad(o.directionAngle)))

        local nextX3 = (o.x + o.radius) + (o.speedX * math.cos(math.rad(o.directionAngle)))
        local nextY3 = (o.y - o.radius) + (o.speedY * math.sin(math.rad(o.directionAngle)))


        local colision = o.CheckColision(nextX, nextY, 46)
        local colision2 = o.CheckColision(nextX1, nextY1, 46)
        local colision3 = o.CheckColision(nextX2, nextY2, 46)
        local colision4 = o.CheckColision(nextX3, nextY3, 46)

        if colision == "true" or colision2 == "true"or colision3 == "true" or colision4 == "true" then 
            o.x = o.x
            o.y = o.y
        else
            o.x = o.x + (o.speedX * math.cos(math.rad(o.directionAngle)))
            o.y = o.y + (o.speedY * math.sin(math.rad(o.directionAngle)))
        end 
            

        
        image.blit(o.img, o.x, o.y)
        draw.line(o.x , o.y , xx, yy, color.red)
    end
    return o
end


--initialization 

--image
p = player(64, 80,color.red, "player.png")
image.center(p.img)
map.img = image.load("16x16.png", map.tileWidth, map.tileHeight)

--rr = Raycaster(p);

--main game loop
while true do
    buttons.read()

    if buttons.left then
        p.directionAngle = p.directionAngle - p.rotationSpeed
        
    end
    if buttons.right then
        p.directionAngle = p.directionAngle + p.rotationSpeed
    end
    if buttons.held.up then

        p.speedY = 1
        p.speedX = 1
    end

    if buttons.held.down then 
        p.speedY = -1
        p.speedX = -1 
    end

    if not buttons.held.down and not buttons.held.up then 

        p.speedY = 0
        p.speedX = 0
    end

    --local colision  = p.CheckColision()

    --local playerTilePositionX = math.floor(p.x / map.tileWidth)
    --local playerTilePositionY = math.floor(p.y / map.tileHeight)
    

    map.draw()
    p.Draw()
    --rr.CastRays(p)
    --screen.print(5,0,"player index on map "..colision,0.5)
    --screen.print(5,0,"player index X on map "..playerTilePositionX,0.5)
    --screen.print(5,10,"player index Y on map "..playerTilePositionY,0.5)
    local fps = screen.fps()
    screen.print(5,0,"fps"..fps,0.5)
    --screen.print(5,10,"player direction: "..(p.directionAngle%360),0.5)
   -- screen.print(5,20,"player speedX : "..p.speedX,0.5)
   -- screen.print(5,30,"player speedY: "..p.speedY,0.5)
    screen.flip() 
end