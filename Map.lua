Map = Class{}

function Map:init()
    self.background = love.graphics.newImage("images/map.png")
    self.stables = love.graphics.newImage("images/stables.png")
    self.stables_p = love.graphics.newImage("images/stables_p.png")
    self.competitions = love.graphics.newImage("images/competition_arena.png")
    self.competitions_p = love.graphics.newImage("images/competition_arena_p.png")
    self.training = love.graphics.newImage("images/training_arena.png")
    self.training_p = love.graphics.newImage("images/training_arena_p.png")
    self.shop = love.graphics.newImage("images/horse_shop.png")
    self.shop_p = love.graphics.newImage("images/horse_shop_p.png")
    self.medical = love.graphics.newImage("images/medical_center.png")
    self.medical_p = love.graphics.newImage("images/medical_center_p.png")
    self.houses = love.graphics.newImage("images/houses.png")
    self.houses_q1 = love.graphics.newImage("images/houses_q1.png")
    self.park = love.graphics.newImage("images/park.png")
    self.lake = love.graphics.newImage("images/lake.png")
    self.lake_p = love.graphics.newImage("images/lake_p.png")

    self.stablesX = 0
    self.stablesY = love.graphics.getHeight() - (self.stables:getHeight() * sy)

    self.trainingX = 0
    self.trainingY = 120 * sy;

    self.competitionsX = 300 * sx
    self.competitionsY = love.graphics.getHeight()/2 - (300 * sy)

    self.medicalX = love.graphics.getWidth()/2 - 120*sx
    self.medicalY = love.graphics.getHeight()/2 - 70*sy

    self.marketX = love.graphics.getWidth()/2 - 300*sx
    self.marketY = love.graphics.getHeight()/2 + (120 * sy)

    self.lakeX = love.graphics.getWidth()/2 + 80*sx
    self.lakeY = love.graphics.getHeight()/2 - 300*sy

    self.stables_mouseIn = false
    self.training_mouseIn = false
    self.competitions_mouseIn = false
    self.lake_mouseIn = false
    self.shop_mouseIn = false
    self.medical_mouseIn = false
    self.manMouseIn = false
end

function Map:render()
    local game_width = love.graphics.getWidth()
    local game_height = love.graphics.getHeight()

    love.graphics.draw(self.background, 0, 0, 0, sx, sy)
    if self.stables_mouseIn == false then
        love.graphics.draw(self.stables, self.stablesX, self.stablesY, 0, sx, sy)
    else
        love.graphics.draw(self.stables_p, self.stablesX, self.stablesY, 0, sx, sy)
    end
    if self.training_mouseIn == false then
        love.graphics.draw(self.training, self.trainingX, self.trainingY, 0, sx, sy)
    else
        love.graphics.draw(self.training_p, self.trainingX, self.trainingY, 0, sx, sy)
    end
    if self.competitions_mouseIn == false then
        love.graphics.draw(self.competitions, self.competitionsX, self.competitionsY, 0, sx, sy)
    else
        love.graphics.draw(self.competitions_p, self.competitionsX, self.competitionsY, 0, sx, sy)
    end
    if self.lake_mouseIn == false then
        love.graphics.draw(self.lake, self.lakeX, self.lakeY, 0, sx, sy)
    else
        love.graphics.draw(self.lake_p, self.lakeX, self.lakeY, 0, sx, sy)
    end
    if self.shop_mouseIn == false then
        love.graphics.draw(self.shop, self.marketX, self.marketY, 0, sx, sy)
    else
        love.graphics.draw(self.shop_p, self.marketX, self.marketY, 0, sx, sy)
    end
    if self.medical_mouseIn == false then
        love.graphics.draw(self.medical, self.medicalX, self.medicalY, 0, sx, sy)
    else
        love.graphics.draw(self.medical_p, self.medicalX, self.medicalY, 0, sx, sy)
    end
    if quest.stage == 0 then
        love.graphics.draw(self.houses, 0, 0, 0, sx, sy)
    else
        if quest.stage == 1 or quest.stage == 8 then
            love.graphics.setColor(1,1,1,1)
            love.graphics.draw(quest_ind1, game_width - 320*sx, game_height/2 - 140*sy, 0, sx, sy)
        end
        if self.manMouseIn == false then
            love.graphics.draw(self.houses, 0, 0, 0, sx, sy)
        else
            love.graphics.draw(self.houses_q1, 0, 0, 0, sx, sy)
        end
    end
    love.graphics.draw(self.park, 0, 0, 0, sx, sy)
end

function Map:checkHover()
    local game_width = love.graphics.getWidth()
    local game_height = love.graphics.getHeight()
    local mx, my = love.mouse.getPosition()

    if mx > self.stablesX and mx < (self.stablesX + self.stables:getWidth() - 100*sx)
    and my > self.stablesY and my < (self.stablesY + self.stables:getHeight()) then
        self.stables_mouseIn = true
    else
        self.stables_mouseIn = false
    end
    if mx > self.trainingX and mx < (self.trainingX + self.training:getWidth() - 100*sx)
    and my > self.trainingY and my < (self.trainingY + self.training:getHeight() - 60*sy) then
        self.training_mouseIn = true
    else
        self.training_mouseIn = false
    end
    if mx > self.competitionsX and mx < (self.competitionsX + self.competitions:getWidth() - 100*sx)
    and my > self.competitionsY and my < (self.competitionsY + self.competitions:getHeight() - 100*sy) then
        self.competitions_mouseIn = true
    else
        self.competitions_mouseIn = false
    end
    if mx > self.lakeX and mx < (self.lakeX + self.lake:getWidth() - 100*sx)
    and my > self.lakeY and my < (self.lakeY + self.lake:getHeight()) then
        self.lake_mouseIn = true
    else
        self.lake_mouseIn = false
    end
    if mx > self.marketX and mx < (self.marketX + self.shop:getWidth() - 120*sx)
    and my > self.marketY + 50*sy and my < (self.marketY + self.shop:getHeight() - 150*sy) then
        self.shop_mouseIn = true
    else
        self.shop_mouseIn = false
    end
    if mx > self.medicalX and mx < (self.medicalX + self.medical:getWidth() - 120*sx)
    and my > self.medicalY + 50*sy and my < (self.medicalY + self.medical:getHeight() - 150*sy) then
        self.medical_mouseIn = true
    else
        self.medical_mouseIn = false
    end
    if mx > game_width - 380*sx and mx < game_width - 180*sx
    and my > game_height/2 - 90*sy and my < game_height/2 + 100*sy then
        self.manMouseIn = true
    else
        self.manMouseIn = false
    end
end