color.loadpalette()
dofile(files.cdir().."/Maps/table_map.lua")
iMap=image.load(files.cdir().."/Maps/tileset.png")

if iMap then _map=map.new(iMap,tabla,16,16) end

x,y=0,0
while true do
buttons.read()

--Blit
map.blit(_map,x,y)

screen.print(200,5,"RAM: "..os.ram(),0.5)

if buttons.held.down then
    y=y+10
elseif buttons.held.up then
    y=y-10
end

if buttons.held.right then
    x=x+10
elseif buttons.held.left then
    x=x-10
end


if buttons.start then
iMap=nil
_map=nil
collectgarbage("collect")
dofile("script.lua") end

screen.flip()
end