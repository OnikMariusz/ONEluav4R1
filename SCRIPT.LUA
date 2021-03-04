--[[ collectgarbage()
splash.show("OneLogoPow.png")
color.loadpalette()

if not img then img=image.load("PIC.PNG") end

option,y=1,17
buttons.interval(10,10)

while true do
buttons.read()

if img then img:blittint(0,0,color.red) end

screen.print(35,17,"Colors",0.6)
screen.print(35,29,"Batt",0.6)
screen.print(35,41,"Hw",0.6)
screen.print(35,53,"Os",0.6)
screen.print(35,65,"Maps",0.6)
screen.print(35,77,"Save",0.6)
screen.print(35,89,"3D",0.6)
screen.print(12,y," -> ",0.6)

screen.print(475,255,os.date("%I:%M %p"),0.5,color.white,color.gray,__ARIGHT)

if buttons.down then
    option += 1
    y += 12
elseif buttons.up then
    option -= 1
    y -= 12
end

if option < 1 then
    option,y = 7,89
end

if option > 7 then
    option,y = 1,17
end

if buttons.cross then

    if option == 1 then dofile("colores/script.lua")
    elseif option == 2 then dofile("Batt.lua")
    elseif option == 3 then dofile("hw.lua")
    elseif option == 4 then dofile("os.lua")
    elseif option == 5 then dofile("Maps/script.lua")
    elseif option == 6 then dofile("save.lua")
    elseif option == 7 then dofile("3d/script.lua")
    end
end

screen.flip()
end

 ]]

 --rysowanie punktu na okregu 
--x = radius + radius * sin(45);
--y = radius + radius * cos(45);

dofile("game.lua")