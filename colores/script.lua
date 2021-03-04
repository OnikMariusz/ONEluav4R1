color.loadpalette()
pixelimg = image.load(files.cdir().."/colores/pic.bmp")
x,y=100,100
if pixelimg then ctx,ctx2 = pixelimg:pixel(x,y) else ctx,ctx2 = color.red,0xFFFFFF03 end


function drawPointer(x,y,c)
	draw.gradline(x-5,y,x+5,y,color.yellow,color.red)
		draw.gradline(x,y-5,x,y+5,color.red,color.yellow)
end

function toHex(num)
    local hexstr = '0123456789ABCDEF'
    local s = ''
    while num > 0 do
        local mod = math.fmod(num, 16)
        s = string.sub(hexstr, mod+1, mod+1) .. s
        num = math.floor(num / 16)
    end
    if s == '' then s = '0' end
    return "0x"..s
end

while true do
	buttons.read()
		if pixelimg then pixelimg:blit(0,0) end

	if (buttons.held.right or buttons.held.circle) and x<479 then x+=1; ctx,ctx2 = pixelimg:pixel(x,y) end
		if (buttons.held.left or buttons.held.square) and x>1 then x-=1; ctx,ctx2 = pixelimg:pixel(x,y) end
			if (buttons.held.up or buttons.held.triangle) and y>1 then y-=1; ctx,ctx2 = pixelimg:pixel(x,y) end
				if (buttons.held.down or buttons.held.cross) and y<271 then y+=1; ctx,ctx2 = pixelimg:pixel(x,y) end

		screen.print(10,10,string.format("X: %d\t Y: %d",x,y),1,ctx,0xFF000000)
		screen.print(10,30,string.format("(%s)",toHex(ctx2)),1,color.red,0xFF000000)
		drawPointer(x,y,0xFFFFFF00)

	screen.print(15,240,"Press START to return ")  
	if buttons.start then dofile("script.lua") end

	screen.flip()
end
