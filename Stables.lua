Stables = Class{}

MAX_STABLES = 40

function Stables:init(number, stables)
    self.background2 = love.graphics.newImage("images/twostables_background.png")
    self.background1 = love.graphics.newImage("images/onestable_background.png")
    self.name_texture = love.graphics.newImage("images/stable_name.png")
    self.number = number
    self.stables = {}
    if stables == 0 then
        for i = 1, self.number do
            self.stables[#self.stables + 1] = Stable(#self.stables + 1)
        end
    end
end

function Stables:addStable()
    self.number = self.number + 1
    self.stables[#self.stables + 1] = Stable(self.number + 1)
end

function Stables:render(pair)

    local game_width = love.graphics.getWidth()
    local game_height = love.graphics.getHeight()

    if self.number < pair*2 then
        love.graphics.draw(self.background1, 0, 0, 0, sx, sy)
    else
        love.graphics.draw(self.background2, 0, 0, 0, sx, sy)
    end

    love.graphics.setFont(smaller_font)

    self.rendered_pair = pair

    if self.number >= pair * 2 - 1 then
        if self.stables[pair * 2 - 1].empty ~= true then
            self.stables[pair * 2 - 1]:renderHorse(317*sx, 102*sy, 0.8, 0.8)
            love.graphics.draw(self.name_texture, 360 * sx, 480 * sy)
            love.graphics.setColor(0, 0, 0, 1)
            love.graphics.print(self.stables[pair * 2 - 1]:getHorseName(), 400 * sx, 530 * sy)
            love.graphics.setColor(1, 1, 1, 1)
        end
    end
    if self.number >= pair * 2 then
        if self.stables[pair * 2].empty ~= true then
            self.stables[pair * 2]:renderHorse(love.graphics.getWidth()/2 + 297*sx, 102*sy, 0.8, 0.8)
            love.graphics.draw(self.name_texture, love.graphics.getWidth() - 622 * sx, 480 * sy)
            love.graphics.setColor(0, 0, 0, 1)
            love.graphics.print(self.stables[pair * 2]:getHorseName(), love.graphics.getWidth() - 582 * sx, 530 * sy)
            love.graphics.setColor(1, 1, 1, 1)
        end
    end

    if self.number > self.rendered_pair * 2 then
        next_stables_button:render(game_width - 150*sx, game_height - 200*sy, true)
    end
    if self.rendered_pair > 1 then
        previous_stables_button:render(50*sx, game_height - 200*sy, true)
    end
end

function Stables:shift()
    local tempHorses = {}
    for k, stable in ipairs(self.stables) do
        if stable.empty == false then
            tempHorses[#tempHorses + 1] = stable.horse
        end
    end
    self.stables = {}
    for i = 1, self.number do
        self.stables[i] = Stable(i)
        if tempHorses[i] ~= nil then
            self.stables[i]:setHorse(tempHorses[i])
        end
    end
end