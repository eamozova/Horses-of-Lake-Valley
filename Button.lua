Button = Class{}

function Button:init(w, h, normal, pressed, inactive)
    self.width = w
    self.height = h
    self.x = 0
    self.y = 0
    self.normal = love.graphics.newImage(normal)
    self.pressed = love.graphics.newImage(pressed)
    self.active = false
    self.mouseIn = false
    if inactive ~= nil then
        self.inactive = love.graphics.newImage(inactive)
    else
        self.inactive = love.graphics.newImage(normal)
    end
end

function Button:render(x, y, active)
    self.x = x
    self.y = y
    self.active = active
    love.graphics.setColor(1,1,1,1)
    if active == true then 
        love.graphics.draw(self.normal, x, y, 0, sx, sy)
        if self.mouseIn == true then
            love.graphics.setColor(1,1,1,1)
            love.graphics.draw(self.pressed, self.x, self.y, 0, sx, sy)
        end
    else
        love.graphics.draw(self.inactive, x, y, 0, sx, sy)
    end
end

function Button:checkHover()
    local mx, my = love.mouse.getPosition()
    if mx > self.x and mx < (self.x + self.width*sx) and my > self.y and my < (self.y + self.height*sy) then
        self.mouseIn = true
    else
        self.mouseIn = false
    end
end