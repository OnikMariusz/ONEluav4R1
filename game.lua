
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
    return (map[math.floor(y+1)][math.floor(x+1)] ~= -1); 
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

raycasterF = function()
    init: function(){
      var numberOfRays = 300;
      var angleBetweenRays = .2 * Math.PI /180;
      this.castRays = function() {
        for (var i=0;i<numberOfRays;i++) {
          var rayNumber = -numberOfRays/2 + i;
          var rayAngle = angleBetweenRays * rayNumber + player.angle;
          this.castRay(rayAngle);
        }
      }
      this.castRay = function(rayAngle){
        var twoPi = Math.PI * 2; 
        rayAngle %= twoPi;
        if (rayAngle < 0) rayAngle += twoPi;
        var right = (rayAngle > twoPi * 0.75 || rayAngle < twoPi * 0.25);
        var up = rayAngle > Math.PI;
        var slope = Math.tan(rayAngle);
        var distance = 0;
        var xHit = 0;
        var yHit = 0;
        var wallX;  
        var wallY;
        var dX = right ? 1 : -1; 
        var dY = dX * slope;  
        var x = right ? Math.ceil(player.x) : Math.floor(player.x);
        var y = player.y + (x - player.x) * slope; 
        while (x >= 0 && x < minimap.cellsAcross && y >= 0 && y < minimap.cellsDown) {
          wallX = Math.floor(x + (right ? 0 : -1));
          wallY = Math.floor(y);
          if (map[wallY][wallX] > -1) {
            var distanceX = x - player.x;
            var distanceY = y - player.y;
            distance = Math.sqrt(distanceX*distanceX + distanceY*distanceY);  
            xHit = x;  
            yHit = y;
            break;
          }
          x += dX; 
          y += dY;
        }
        slope = 1/slope;
        dY = up ? -1 : 1;
        dX = dY * slope;
        y = up ? Math.floor(player.y) : Math.ceil(player.y);
        x = player.x + (y - player.y) * slope;
        while (x >= 0 && x < minimap.cellsAcross && y >= 0 && y < minimap.cellsDown) {
          wallY = Math.floor(y + (up ? -1 : 0));
          wallX = Math.floor(x);
          if (map[wallY][wallX] > -1) {
            var distanceX = x - player.x;
            var distanceY = y - player.y;
            var blockDistance = Math.sqrt(distanceX*distanceX + distanceY*distanceY);
            if (!distance || blockDistance < distance) {
              distance = blockDistance;
              xHit = x;
              yHit = y;
            }
            break;
          }
          x += dX;
          y += dY;
        }
        this.draw(xHit, yHit); 
      };
      this.draw = function(rayX, rayY){
        minimap.context.beginPath();
        minimap.context.moveTo(minimap.cellWidth*player.x, minimap.cellHeight*player.y);
        minimap.context.lineTo(rayX * minimap.cellWidth, rayY * minimap.cellHeight);
        minimap.context.closePath();
        minimap.context.stroke();
      }
end


minimap = minimapF()
player = playerF()

player.init()



drawAll = function()
    minimap.draw();
    player.draw(); 
end



update = function()
    if  buttons.left then  player.direction = -1 end
    if  buttons.right then  player.direction = 1 end
    if  buttons.up  then player.speed = 1 end
    if  buttons.down then player.speed = -1 end 

    if buttons.released.left then 
        player.direction = 0;
    end
    if buttons.released.right then 
        player.direction = 0;
    end
    if buttons.released.up then
        player.speed = 0
    end
    if buttons.released.down then
        player.speed = 0
    end      
    player.move();
end



while true do
    buttons.read()

    update()
    drawAll()

    screen.flip() 
end



