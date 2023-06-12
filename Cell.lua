Cell = Class{}

function Cell:init(number, item, type, quantity, description)
    self.item = item
    self.type = type
    self.quantity = quantity
    self.number = number
    self.mouseIn = false
    self.bg = love.graphics.newImage("buttons/inventory_cell.png")
    self.bg_p = love.graphics.newImage("buttons/inventory_cell_p.png")
    self.check = love.graphics.newImage("buttons/check.png")
    self.checked = false
    self.description = description

    self.height = 200*sy
    self.width = 200*sx

    if self.number == 1 or self.number == 16 or self.number == 31 then
        self.x = 105*sx
        self.y = 200*sy
    elseif self.number == 2 or self.number == 17 or self.number == 32 then
        self.x = 365*sx
        self.y = 200*sy
    elseif self.number == 3 or self.number == 18 or self.number == 33 then
        self.x = 625*sx
        self.y = 200*sy
    elseif self.number == 4 or self.number == 19 or self.number == 34 then
        self.x = 885*sx
        self.y = 200*sy
    elseif self.number == 5 or self.number == 20 or self.number == 35 then
        self.x = 1145*sx
        self.y = 200*sy
    elseif self.number == 6 or self.number == 21 or self.number == 36 then
        self.x = 105*sx
        self.y = 450*sy
    elseif self.number == 7 or self.number == 22 or self.number == 37 then
        self.x = 365*sx
        self.y = 450*sy
    elseif self.number == 8 or self.number == 23 or self.number == 38 then
        self.x = 625*sx
        self.y = 450*sy
    elseif self.number == 9 or self.number == 24 or self.number == 39 then
        self.x = 885*sx
        self.y = 450*sy
    elseif self.number == 10 or self.number == 25 or self.number == 40 then
        self.x = 1145*sx
        self.y = 450*sy
    elseif self.number == 11 or self.number == 26 or self.number == 41 then
        self.x = 105*sx
        self.y = 700*sy
    elseif self.number == 12 or self.number == 27 or self.number == 42 then
        self.x = 365*sx
        self.y = 700*sy
    elseif self.number == 13 or self.number == 28 or self.number == 43 then
        self.x = 625*sx
        self.y = 700*sy
    elseif self.number == 14 or self.number == 29 or self.number == 44 then
        self.x = 885*sx
        self.y = 700*sy
    elseif self.number == 15 or self.number == 30 or self.number == 45 then
        self.x = 1145*sx
        self.y = 700*sy
    end
end

function Cell:render()
    local game_width = love.graphics.getWidth()
    local game_height = love.graphics.getHeight()

    love.graphics.setColor(1,1,1,1)
    if self.item ~= nil then 
        love.graphics.draw(self.bg, self.x, self.y, 0, sx, sy)
        love.graphics.draw(love.graphics.newImage("inventory/" .. self.item .. ".png"), self.x, self.y, 0, sx, sy)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.setFont(bigger_font)
        love.graphics.print("x" .. self.quantity, self.x + 140*sx, self.y + 150*sy, 0, sx, sy)
        if self.checked == true then
            love.graphics.draw(self.check, self.x, self.y, 0, sx, sy)
        end
        if self.mouseIn == true then
            love.graphics.setColor(1,1,1,1)
            love.graphics.draw(self.bg_p, self.x, self.y, 0, sx, sy)
            love.graphics.draw(love.graphics.newImage("inventory/" .. self.item .. ".png"), self.x, self.y, 0, sx, sy)
            love.graphics.setColor(colorGoldenrod)
            love.graphics.setFont(bigger_font)
            love.graphics.print("x" .. self.quantity, self.x + 140*sx, self.y + 150*sy, 0, sx, sy)
            if self.checked == true then
                love.graphics.draw(self.check, self.x, self.y, 0, sx, sy)
            end
            love.graphics.setFont(medium_font)
            love.graphics.print(self.description, game_width - 440*sx, 160*sy)
        end
    else
        love.graphics.draw(self.bg, self.x, self.y, 0, sx, sy)
    end
end

function Cell:checkHover()
    local mx, my = love.mouse.getPosition()
    if mx > self.x and mx < (self.x + self.width) and my > self.y and my < (self.y + self.height) then
        self.mouseIn = true
    else
        self.mouseIn = false
    end
end