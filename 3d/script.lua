--------------------------------------ONELUA 3D-----------------------------------
TIMER = 0
--INIT
os.cpu(333)
amg.init(__8888)
amg.perspective(40.0)
model3d.initphysics(20,{-100,-100,-100},{100,100,100}) --Tamaño del mundo físico
--CAM
camera1 = cam3d.new()
cam3d.position(camera1,{0,9,12})
cam3d.eye(camera1,{0,2,0})

--LIGHT
amg.typelight(1,__DIRECTIONAL)
amg.colorlight(1,color.new(250,250,250),color.new(90,90,90),color.new(250,250,250))
amg.poslight(1,{0.5,1,0.5})

--LOADING
b = 10
Ball ={}
for a = 1,b do Ball[a] = model3d.load(files.cdir().."/3d/data/ball.obj") end
Water = model3d.load(files.cdir().."/3d/data/plane.obj")
Ramp = model3d.load(files.cdir().."/3d/data/ramp.obj")

for a = 1,b do model3d.setphysics(Ball[a],1,{0,0,0},{0,0,0},20,__SPHERE) end
model3d.setphysics(Water,1,{0,0,0},{0,0,0},0,__CONVEX)
model3d.setphysics(Ramp,1,{0,0,0},{0,0,0},0,__CONVEX)

for a = 1,b do model3d.physics(Ball[a]) end
model3d.physics(Water)
model3d.physics(Ramp)

for a = 1,b do model3d.setdamping(Ball[a],1,0.1,0.1) end
for a = 1,b do model3d.position(Ball[a],1,{-2,6+(2*a),0}) end

while true do
	amg.begin()
	amg.gravity(0,-9.8,0) --Gravedad
	BallV = model3d.getvelocity(Ball[1],1)

	--Set camara
	cam3d.set(camera1)

	amg.light(1,1);--activar luz 1

		model3d.render(Ramp)

		model3d.startreflection(Water,1)  
			for a = 1,b do model3d.mirror(Ball[a],1,2) end
			model3d.mirror(Ramp,1,2)
		model3d.finishreflection() 

		for a = 1,b do model3d.blitshadow(Ball[a],1,1,100,1) end

		for a = 1,b do model3d.render(Ball[a]) end

	amg.light(1,0);--desactivar luz 1

	amg.mode2d(1)
		screen.print(15,240,"Press START to return ")
		if buttons.start then dofile("script.lua") end
	amg.mode2d(0)
	screen.flip()

	amg.update()
	model3d.updatephysics()

	buttons.read()
	if buttons.held.up then model3d.setvelocity(Ball[1],1,{BallV.x,BallV.y,-2}) end
		if buttons.held.down then model3d.setvelocity(Ball[1],1,{BallV.x,BallV.y,2}) end
			if buttons.held.left then model3d.setvelocity(Ball[1],1,{-2,BallV.y,BallV.z}) end
				if buttons.held.right then model3d.setvelocity(Ball[1],1,{2,BallV.y,BallV.z}) end

	if buttons.start then
		model3d.finishphysics()
		Ball,Water,Ramp = nil,nil,nil
		collectgarbage()
		os.delay(100)
	
		amg.finish()
		dofile("script.lua")
	end
end