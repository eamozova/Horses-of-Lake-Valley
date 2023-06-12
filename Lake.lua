Lake = Class{}

function Lake:init(stage)
    local game_width = love.graphics.getWidth()
    local game_height = love.graphics.getHeight()

    self.background = love.graphics.newImage("images/lake_mg.png")
    self.ring1 = love.graphics.newImage("images/ring1.png")
    self.ring2 = love.graphics.newImage("images/ring2.png")
    self.ring3 = love.graphics.newImage("images/ring3.png")
    self.fishPlace = {}
    self.fishImage = nil
    self.ringQueue = 0
    self.fishingStage = stage
    self.fish = nil
    self.fishPosition = game_width/2 - 500*sx
    self.fishRight = true
    self.targetPosition = game_width/2 - 500*sx
    self.targetRight = true
end


function Lake:render()
    local game_width = love.graphics.getWidth()
    local game_height = love.graphics.getHeight()

    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(self.background, 0, 0, 0, sx, sy)
    love.graphics.setColor(colorJasmine)
    love.graphics.rectangle("fill", game_width/2 - 300*sx, 50*sy, 600*sx, 60*sy)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.rectangle("line", game_width/2 - 300*sx, 50*sy, 600*sx, 60*sy)
    love.graphics.setFont(medium_font)
    love.graphics.print("Click on the appearing ripples to catch fish!", game_width/2 - 250*sx, 60*sy, 0, sx, sy)
    exit_to_map:render(50*sx, 50*sy, true)

    if self.fishingStage == "bit" then
        love.graphics.setColor(1,1,1,1)
        if self.ringQueue == 1 then
            love.graphics.draw(self.ring1, self.fishPlace[1] - 100*sx, self.fishPlace[2] - 53*sy, 0, sx, sy)
        elseif self.ringQueue == 2 then
            love.graphics.draw(self.ring1, self.fishPlace[1] - 100*sx, self.fishPlace[2] - 53*sy, 0, sx, sy)
            love.graphics.draw(self.ring2, self.fishPlace[1] - 100*sx, self.fishPlace[2] - 53*sy, 0, sx, sy)
        elseif self.ringQueue == 3 then
            love.graphics.draw(self.ring1, self.fishPlace[1] - 100*sx, self.fishPlace[2] - 53*sy, 0, sx, sy)
            love.graphics.draw(self.ring2, self.fishPlace[1] - 100*sx, self.fishPlace[2] - 53*sy, 0, sx, sy)
            love.graphics.draw(self.ring3, self.fishPlace[1] - 100*sx, self.fishPlace[2] - 53*sy, 0, sx, sy)
        elseif self.ringQueue == 4 then
            love.graphics.draw(self.ring2, self.fishPlace[1] - 100*sx, self.fishPlace[2] - 53*sy, 0, sx, sy)
            love.graphics.draw(self.ring3, self.fishPlace[1] - 100*sx, self.fishPlace[2] - 53*sy, 0, sx, sy)
        elseif self.ringQueue == 5 then
            love.graphics.draw(self.ring3, self.fishPlace[1] - 100*sx, self.fishPlace[2] - 53*sy, 0, sx, sy)
        end
    elseif self.fishingStage == "catching" then
        love.graphics.setColor(colorYRed)
        love.graphics.rectangle("fill", game_width/2 - 500*sx, game_height - 120*sy, 1000*sx, 60*sy)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.rectangle("line", game_width/2 - 500*sx, game_height - 120*sy, 1000*sx, 60*sy)
        love.graphics.rectangle("fill", self.targetPosition, game_height - 120*sy, 130*sx, 60*sy)
        love.graphics.setColor(colorJasmine)
        love.graphics.setFont(medium_font)
        love.graphics.print("Press Space when the fish is inside the moving rectangle", game_width/2 - 350*sx, game_height - 50*sy, 0, sx, sy)
        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(self.fishImage, self.fishPosition, game_height - 130*sy, 0, 0.5*sx, 0.5*sy)
    elseif self.fishingStage == "caught" then
        love.graphics.setColor(colorYRed)
        love.graphics.rectangle("fill", game_width/2 - 220*sx, game_height/2 - 150*sy, 440*sx, 160*sy)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.rectangle("line", game_width/2 - 220*sx, game_height/2 - 150*sy, 440*sx, 160*sy)
        love.graphics.print("Congratulations! You caught a", game_width/2 - 170*sx, game_height/2 - 130*sy, 0, sx, sy)
        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(self.fishImage, game_width/2 - 50*sx, game_height/2 - 80*sy, 0, 0.5*sx, 0.5*sy)
    end
end

function Lake:determineFish()
    local game_width = love.graphics.getWidth()
    local game_height = love.graphics.getHeight()
    local fishX = math.random(100, game_width - 100)
    local fishY = math.random(53, game_height - 53)
    self.fishPlace = {fishX, fishY}
    local fishChance = math.random(1, 115)
    if fishChance < 15 then
        self.fish = "redfish"
        self.fishImage = love.graphics.newImage("images/red_fish.png")
    elseif fishChance > 14 and fishChance < 30 then
        self.fish = "orangefish"
        self.fishImage = love.graphics.newImage("images/orange_fish.png")
    elseif fishChance > 29 and fishChance < 45 then
        self.fish = "yellowfish"
        self.fishImage = love.graphics.newImage("images/yellow_fish.png")
    elseif fishChance > 44 and fishChance < 60 then
        self.fish = "greenfish"
        self.fishImage = love.graphics.newImage("images/green_fish.png")
    elseif fishChance > 59 and fishChance < 75 then
        self.fish = "turquoisefish"
        self.fishImage = love.graphics.newImage("images/turquoise_fish.png")
    elseif fishChance > 74 and fishChance < 90 then
        self.fish = "bluefish"
        self.fishImage = love.graphics.newImage("images/blue_fish.png")
    elseif fishChance > 89 and fishChance < 105 then
        self.fish = "purplefish"
        self.fishImage = love.graphics.newImage("images/violet_fish.png")
    elseif fishChance == 115 then
        self.fish = "rainbowfish"
        self.fishImage = love.graphics.newImage("images/rainbow_fish.png")
    else
        self.fish = "kelp"
        self.fishImage = love.graphics.newImage("images/kelp.png")
    end

    self.fishPosition = game_width/2 - 500*sx
    self.targetPosition = math.random(game_width/2 - 500*sx, game_width/2 + 370*sx)
    self.fishRight = true
    self.targetRight = true
end