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


function Raycaster(_player)

    local r = {}
    local player = _player
    r.numberOfRay = 90
    r.angleBetwinRays = 0.5 * math.pi/180
    r.arrX = {1,-1,-1,1}
    r.arrY = {1,1,-1,-1}
    r.index = nil
    local halfViewAngle = 45
    local wynik = 0 
    r.CastRays = function(player)

        local pd = player.directionAngle % 360 
        if pd < 0 then pd = pd + 360 end
        for i = pd-halfViewAngle, pd+halfViewAngle-1, 1 do

            local ceilPosX = math.floor(player.x/16)
            local ceilPosY = math.floor(player.y/16)

            ceilPosX = ceilPosX + 1
            ceilPosY = ceilPosY + 1

            local a =(player.x % 16)
            local b = (player.y % 16) 

            -- if a == 0 then a = 1 end
            -- if b == 0 then b = 1 end

          

            local dk = math.abs(16/math.cos(math.rad(i)))
            local dl = math.abs(16/math.sin(math.rad(i)))

            local k = a*dk
            local l = b*dl

            r.index = math.floor((i%360) /90)

            r.index = r.index +1

            local stepX = r.arrX[r.index]
            local stepY = r.arrY[r.index]

            local distance = 0

            local hit = "false"

            local leftHit = 1

            while hit == "false" do 

                if k>l then 
                    ceilPosY = ceilPosY + stepY
                        if map.data[ceilPosY][ceilPosX] ~= 46 then 
                            hit = "true"
                            distance = l 
                        else
                            l = l + dl
                        end
                else
                        ceilPosX = ceilPosX + stepX
                            if map.data[ceilPosY][ceilPosX] ~= 46 then 
                                hit = "true"
                                distance = k 
                                leftHit = 2
                            else
                                k = k + dk
                            end

                    end

            end


            
            draw.line(player.x, player.y, (player.x) + math.cos(math.rad(i))*(distance), (player.y) + math.sin(math.rad(i))*(distance), color.green )
            

            --local rayNumber = -r.numberOfRay/2 + i
            --local rayAngle = r.angleBetwinRays * rayNumber +(math.rad(player.directionAngle))
           --
            --local angle = i--math.rad(i)
            --r.CastRay(i)
            --screen.consoleprint(a)
            --screen.print(5,30,"index: "..index,0.5)
        end
        --screen.print(5,30,"ceilPosX : "..ceilPosX,0.5)
        --screen.print(5,30,"wynik"..wynik,0.5)
        --wynik = 0
      
        --r.CastRay(math.rad(_player.directionAngle))
    end

    --[[ r.CastRay = function(_angle)
        draw.line(_player.x, _player.y, 
        player.x + math.cos(math.rad(_angle)) * 20, 
        player.y + math.sin(math.rad(_angle)) * 20, 
        color.green)
    end ]]

    return r
end