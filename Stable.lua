Stable = Class{}

function Stable:init(number)
    self.empty = true
    self.clean = true
    self.clean_texture = love.graphics.newImage("images/stable_background.png")
    self.dirty_texture = love.graphics.newImage("images/dirty_stable.png")
    self.number = number
    self.horse = nil
    self.foodChance = 1
    self.treatChance = 1
end

function Stable:setHorse(horse)
    self.horse = horse
    self.empty = false
end

function Stable:setEmpty()
    self.horse = nil
    self.empty = true
end

function Stable:getHorse()
    return self.horse
end

function Stable:renderHorse(x, y, sx, sy)
    if self.horse.age_y >= 2 then
        self.horse:renderHead(x, y, sx, sy)
    end
end

function Stable:getHorseName()
    return self.horse:getName()
end

function Stable:showHorseInfo()
    self.horse:showInfo()
end

function Stable:changeHorseName(name)
    self.horse:setName(name)
end

function Stable:render()
    local game_width = love.graphics.getWidth()
    local game_height = love.graphics.getHeight()

    if self.clean == true then
        love.graphics.draw(self.clean_texture, 0, 0, 0, sx, sy)
    else
        love.graphics.draw(self.dirty_texture, 0, 0, 0, sx, sy)
        clean_stable_action:render(50*sx, 620*sy, true)
    end
    if self.horse ~= nil then
        if self.horse.age_y < 2 then
            self.horse:render(630*sx, 370*sy, 1.15, 1.15)
        else
            if self.horse.foal == nil then
                self.horse:render(370*sx, 100*sy, 1.15, 1.15)
            else
                self.horse:render(340*sx, 120*sy, 1, 1)
                self.horse.foal:render(750*sx, 450*sy, 1.15, 1.15)
            end
        end
        if self.horse.life_state == "horse" then
            if playerInventory.items[28] == 0 then
                give_food_action:render(50*sx, 140*sy, false)
            else
                give_food_action:render(50*sx, 140*sy, true)
            end
        elseif self.horse.life_state == "kelpie" then
            if playerInventory.items[39] == 0 then
                give_kelp_action:render(50*sx, 140*sy, false)
            else
                give_kelp_action:render(50*sx, 140*sy, true)
            end
        elseif self.horse.life_state == "hybrid" then
            if self.foodChance == 1 then
                if playerInventory.items[39] == 0 then
                    give_kelp_action:render(50*sx, 140*sy, false)
                else
                    give_kelp_action:render(50*sx, 140*sy, true)
                end
            else
                if playerInventory.items[28] == 0 then
                    give_food_action:render(50*sx, 140*sy, false)
                else
                    give_food_action:render(50*sx, 140*sy, true)
                end
            end
        end
        give_water_action:render(50*sx, 260*sy, true)
        clean_horse_action:render(50*sx, 380*sy, true)
        if self.treatChance == 1 then
            if playerInventory.items[30] == 0 then
                give_carrot_action:render(50*sx, 500*sy, false)
            else
                give_carrot_action:render(50*sx, 500*sy, true)
            end
        else
            if playerInventory.items[29] == 0 then
                give_apple_action:render(50*sx, 500*sy, false)
            else
                give_apple_action:render(50*sx, 500*sy, true)
            end
        end
    end
end