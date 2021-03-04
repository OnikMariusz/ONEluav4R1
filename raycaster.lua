function Raycaster(_player)

    local r = {}
    local player = _player
    r.numberOfRay = 90
    r.angleBetwinRays = 0.5 * math.pi/180
    r.arrX = {1,-1,-1,1}
    r.arrY = {1,1,-1,-1}
    r.index = nil
    r.a = nil
    r.b = nil
    local halfViewAngle = 45
    local wynik = 0 
    r.CastRays = function(player)

        --local pd = player.directionAngle % 360 
        --if pd < 0 then pd = pd + 360 end
        for i = player.directionAngle, player.directionAngle , 1 do

            local ceilPosX = math.floor(player.x/16)
            local ceilPosY = math.floor(player.y/16)

            ceilPosX = ceilPosX + 1
            ceilPosY = ceilPosY + 1

            r.a =16 - (16 - (player.x % 16))
            r.b =16 - (16 - (player.y % 16) )

            -- if a == 0 then a = 1 end
            -- if b == 0 then b = 1 end

          

            local dk = math.abs(16/(math.cos(math.rad(i))))
            local dl = math.abs(16/(math.sin(math.rad(i))))

            local k = r.a*dk
            local l = r.b*dl

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
                            break
                        else
                            l = l + dl
                        end
                else
                        ceilPosX = ceilPosX + stepX
                            if map.data[ceilPosY][ceilPosX] ~= 46 then 
                                hit = "true"
                                distance = k 
                                leftHit = 2
                                break
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