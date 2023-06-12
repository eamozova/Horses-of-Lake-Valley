Shop = Class{}

function Shop:init()
    self.foodItems = {{'Hay', 'hay', 0, 25}, {'Apple', 'apple', 0, 30}, {'Carrot', 'carrot', 0, 30}, {'Kelp', 'kelp', 0, 50}}
    self.equipItems = {{'Black dressage\nsaddle', 'dsaddle1', 0, 100}, {'Brown dressage\nsaddle', 'dsaddle2', 0, 100},
    {'Blue dressage\nsaddle', 'dsaddle3', 0, 100},
    {'Black jumping\nsaddle', 'jsaddle1', 0, 100}, {'Brown jumping\nsaddle', 'jsaddle2', 0, 100},
    {'Blue jumping\nsaddle', 'jsaddle3', 0, 100},
    {'Black cross-country\nsaddle', 'ccsaddle1', 0, 100}, {'Brown cross-country\nsaddle', 'ccsaddle2', 0, 100},
    {'Blue cross-country\nsaddle', 'ccsaddle3', 0, 100},
    {'Black dressage\nbridle', 'dbridle1', 0, 100}, {'Brown dressage\nbridle', 'dbridle2', 0, 100},
    {'Blue dressage\nbridle', 'dbridle3', 0, 100},
    {'Black jumping\nbridle', 'jbridle1', 0, 100}, {'Brown jumping\nbridle', 'jbridle2', 0, 100},
    {'Blue jumping\nbridle', 'jbridle3', 0, 100},
    {'Black cross-country\nbridle', 'ccbridle1', 0, 100}, {'Brown cross-country\nbridle', 'ccbridle2', 0, 100},
    {'Blue cross-country\nbridle', 'ccbridle3', 0, 100},
    {'Red dressage\nsaddle pad', 'dsaddlepad1', 0, 80}, {'Blue dressage\nsaddle pad', 'dsaddlepad2', 0, 80},
    {'White dressage\nsaddle pad', 'dsaddlepad3', 0, 80},
    {'Red jumping\nsaddle pad', 'jsaddlepad1', 0, 80}, {'Blue jumping\nsaddle pad', 'jsaddlepad2', 0, 80},
    {'White jumping\nsaddle pad', 'jsaddlepad3', 0, 80},
    {'Red cross-country\nsaddle pad', 'ccsaddlepad1', 0, 80}, {'Blue cross-country\nsaddle pad', 'ccsaddlepad2', 0, 80},
    {'White cross-country\nsaddle pad', 'ccsaddlepad3', 0, 80}}
    self.fishForSale = {{'Red fish', 'redfish', 0, 50}, {'Orange fish', 'orangefish', 0, 50},
    {'Yellow fish', 'yellowfish', 0, 50}, {'Green fish', 'greenfish', 0, 50}, {'Turquoise fish', 'turquoisefish', 0, 50},
    {'Blue fish', 'bluefish', 0, 50}, {'Purple fish', 'purplefish', 0, 50},
    {'Rainbow fish', 'rainbowfish', 0, 500},}
    self.page = 1
    self.tab = 1
    self.curItems = self.foodItems
    self.total = 0
end

function Shop:clearQuantities()
    for k, item in ipairs(self.foodItems) do
        item[3] = 0
    end
    for k, item in ipairs(self.equipItems) do
        item[3] = 0
    end
    for k, item in ipairs(self.curItems) do
        item[3] = 0
    end
end

function Shop:render()
    local game_width = love.graphics.getWidth()
    local game_height = love.graphics.getHeight()

    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(shop_pattern, 0, 0, 0, sx, sy)

    love.graphics.setColor(colorYRed)
    love.graphics.rectangle('fill', 50*sx, 200*sy, 1299*sx, 700*sy)
    love.graphics.setLineWidth(4)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.rectangle('line', 50*sx, 200*sy, 1299*sx, 700*sy)

    love.graphics.setColor(colorYRed)
    love.graphics.rectangle('fill', 50*sx, game_height - 150*sy, 1299*sx, 70*sy)
    love.graphics.setLineWidth(4)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.rectangle('line', 50*sx, game_height - 150*sy, 1299*sx, 70*sy)

    love.graphics.setColor(colorYRed)
    love.graphics.rectangle('fill', 1370*sx, 100*sy, 500*sx, 900*sy)
    love.graphics.setLineWidth(4)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.rectangle('line', 1370*sx, 100*sy, 500*sx, 900*sy)

    love.graphics.line(50*sx,550*sy,1349*sx,550*sy)

    love.graphics.line(374.75*sx,200*sy,374.75*sx,900*sy)
    love.graphics.line(699.5*sx,200*sy,699.5*sx,900*sy)
    love.graphics.line(1024.25*sx,200*sy,1024.25*sx,900*sy)

    love.graphics.setFont(bigger_font)
    love.graphics.print("Total: " .. self.total, 60*sx, game_height - 140*sy, 0, sx, sy)

    if self.curItems[8*(self.page - 1) + 1] ~= nil then
        love.graphics.setFont(bigger_font)
        love.graphics.setColor(colorGoldenrod)
        local nameText = love.graphics.newText(bigger_font, self.curItems[8*(self.page - 1) + 1][1])
        local priceText = love.graphics.newText(bigger_font, self.curItems[8*(self.page - 1) + 1][4])
        local image = love.graphics.newImage("inventory/" .. self.curItems[8*(self.page - 1) + 1][2] .. ".png")
        love.graphics.print(self.curItems[8*(self.page - 1) + 1][1], 212*sx - nameText:getWidth()*0.5*sx, 220*sy, 0, sx, sy)
        love.graphics.print(self.curItems[8*(self.page - 1) + 1][4], 180*sx - priceText:getWidth()*sx, 480*sy, 0, sx, sy)
        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(coin_icon, 190*sx, 487*sy, 0, 0.8*sx, 0.8*sy)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print("x" .. self.curItems[8*(self.page - 1) + 1][3], 235*sx, 480*sy, 0, sx, sy)
        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(image, 212*sx - image:getWidth()*0.5*sx, 280*sy, 0, sx, sy)
        if self.tab ~= 3 then
            if self.curItems[8*(self.page - 1) + 1][3] == 50 then
                plus1:render(310*sx, 480*sy, false)
            else
                plus1:render(310*sx, 480*sy, true)
            end
        else
            if self.curItems[8*(self.page - 1) + 1][3] < playerInventory.cells[8*(self.page - 1) + 1].quantity then
                plus1:render(310*sx, 480*sy, true)
            else
                plus1:render(310*sx, 480*sy, false)
            end
        end
        if self.curItems[8*(self.page - 1) + 1][3] == 0 then
            minus1:render(65*sx, 480*sy, false)
        else
            minus1:render(65*sx, 480*sy, true)
        end
    end
    if self.curItems[8*(self.page - 1) + 2] ~= nil then
        love.graphics.setFont(bigger_font)
        love.graphics.setColor(colorGoldenrod)
        local nameText = love.graphics.newText(bigger_font, self.curItems[8*(self.page - 1) + 2][1])
        local priceText = love.graphics.newText(bigger_font, self.curItems[8*(self.page - 1) + 2][4])
        local image = love.graphics.newImage("inventory/" .. self.curItems[8*(self.page - 1) + 2][2] .. ".png")
        love.graphics.print(self.curItems[8*(self.page - 1) + 2][1], 536.75*sx - nameText:getWidth()*0.5*sx, 220*sy, 0, sx, sy)
        love.graphics.print(self.curItems[8*(self.page - 1) + 2][4], 504.75*sx - priceText:getWidth()*sx, 480*sy, 0, sx, sy)
        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(coin_icon, 513*sx, 487*sy, 0, 0.8*sx, 0.8*sy)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print("x" .. self.curItems[8*(self.page - 1) + 2][3], 559.75*sx, 480*sy, 0, sx, sy)
        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(image, 536.75*sx - image:getWidth()*0.5*sx, 280*sy, 0, sx, sy)
        if self.tab ~= 3 then
            if self.curItems[8*(self.page - 1) + 2][3] == 50 then
                plus2:render(634.75*sx, 480*sy, false)
            else
                plus2:render(634.75*sx, 480*sy, true)
            end
        else
            if self.curItems[8*(self.page - 1) + 2][3] < playerInventory.cells[8*(self.page - 1) + 2].quantity then
                plus2:render(634.75*sx, 480*sy, true)
            else
                plus2:render(634.75*sx, 480*sy, false)
            end
        end
        if self.curItems[8*(self.page - 1) + 2][3] == 0 then
            minus2:render(389.75*sx, 480*sy, false)
        else
            minus2:render(389.75*sx, 480*sy, true)
        end
    end
    if self.curItems[8*(self.page - 1) + 3] ~= nil then
        love.graphics.setFont(bigger_font)
        love.graphics.setColor(colorGoldenrod)
        local nameText = love.graphics.newText(bigger_font, self.curItems[8*(self.page - 1) + 3][1])
        local priceText = love.graphics.newText(bigger_font, self.curItems[8*(self.page - 1) + 3][4])
        local image = love.graphics.newImage("inventory/" .. self.curItems[8*(self.page - 1) + 3][2] .. ".png")
        love.graphics.print(self.curItems[8*(self.page - 1) + 3][1], 861.5*sx - nameText:getWidth()*0.5*sx, 220*sy, 0, sx, sy)
        love.graphics.print(self.curItems[8*(self.page - 1) + 3][4], 829.5*sx - priceText:getWidth()*sx, 480*sy, 0, sx, sy)
        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(coin_icon, 837.75*sx, 487*sy, 0, 0.8*sx, 0.8*sy)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print("x" .. self.curItems[8*(self.page - 1) + 3][3], 884.5*sx, 480*sy, 0, sx, sy)
        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(image, 861.5*sx - image:getWidth()*0.5*sx, 280*sy, 0, sx, sy)
        if self.tab ~= 3 then
            if self.curItems[8*(self.page - 1) + 3][3] == 50 then
                plus3:render(959.5*sx, 480*sy, false)
            else
                plus3:render(959.5*sx, 480*sy, true)
            end
        else
            if self.curItems[8*(self.page - 1) + 3][3] < playerInventory.cells[8*(self.page - 1) + 3].quantity then
                plus3:render(959.5*sx, 480*sy, true)
            else
                plus3:render(959.5*sx, 480*sy, false)
            end
        end
        if self.curItems[8*(self.page - 1) + 3][3] == 0 then
            minus3:render(714.5*sx, 480*sy, false)
        else
            minus3:render(714.5*sx, 480*sy, true)
        end
    end
    if self.curItems[8*(self.page - 1) + 4] ~= nil then
        love.graphics.setFont(bigger_font)
        love.graphics.setColor(colorGoldenrod)
        local nameText = love.graphics.newText(bigger_font, self.curItems[8*(self.page - 1) + 4][1])
        local priceText = love.graphics.newText(bigger_font, self.curItems[8*(self.page - 1) + 4][4])
        local image = love.graphics.newImage("inventory/" .. self.curItems[8*(self.page - 1) + 4][2] .. ".png")
        love.graphics.print(self.curItems[8*(self.page - 1) + 4][1], 1186.25*sx - nameText:getWidth()*0.5*sx, 220*sy, 0, sx, sy)
        love.graphics.print(self.curItems[8*(self.page - 1) + 4][4], 1154.25*sx - priceText:getWidth()*sx, 480*sy, 0, sx, sy)
        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(coin_icon, 1162.5*sx, 487*sy, 0, 0.8*sx, 0.8*sy)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print("x" .. self.curItems[8*(self.page - 1) + 4][3], 1209.25*sx, 480*sy, 0, sx, sy)
        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(image, 1186.25*sx - image:getWidth()*0.5*sx, 280*sy, 0, sx, sy)
        if self.tab ~= 3 then
            if self.curItems[8*(self.page - 1) + 4][3] == 50 then
                plus4:render(1284.25*sx, 480*sy, false)
            else
                plus4:render(1284.25*sx, 480*sy, true)
            end
        else
            if self.curItems[8*(self.page - 1) + 4][3] < playerInventory.cells[8*(self.page - 1) + 4].quantity then
                plus4:render(1284.25*sx, 480*sy, true)
            else
                plus4:render(1284.25*sx, 480*sy, false)
            end
        end
        if self.curItems[8*(self.page - 1) + 4][3] == 0 then
            minus4:render(1039.25*sx, 480*sy, false)
        else
            minus4:render(1039.25*sx, 480*sy, true)
        end
    end
    if self.curItems[8*(self.page - 1) + 5] ~= nil then
        love.graphics.setFont(bigger_font)
        love.graphics.setColor(colorGoldenrod)
        local nameText = love.graphics.newText(bigger_font, self.curItems[8*(self.page - 1) + 5][1])
        local priceText = love.graphics.newText(bigger_font, self.curItems[8*(self.page - 1) + 5][4])
        local image = love.graphics.newImage("inventory/" .. self.curItems[8*(self.page - 1) + 5][2] .. ".png")
        love.graphics.print(self.curItems[8*(self.page - 1) + 5][1], 212*sx - nameText:getWidth()*0.5*sx, 570*sy, 0, sx, sy)
        love.graphics.print(self.curItems[8*(self.page - 1) + 5][4], 180*sx - priceText:getWidth()*sx, 830*sy, 0, sx, sy)
        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(coin_icon, 190*sx, 837*sy, 0, 0.8*sx, 0.8*sy)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print("x" .. self.curItems[8*(self.page - 1) + 5][3], 235*sx, 830*sy, 0, sx, sy)
        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(image, 212*sx - image:getWidth()*0.5*sx, 630*sy, 0, sx, sy)
        if self.tab ~= 3 then
            if self.curItems[8*(self.page - 1) + 5][3] == 50 then
                plus5:render(310*sx, 830*sy, false)
            else
                plus5:render(310*sx, 830*sy, true)
            end
        else
            if self.curItems[8*(self.page - 1) + 5][3] < playerInventory.cells[8*(self.page - 1) + 5].quantity then
                plus5:render(310*sx, 830*sy, true)
            else
                plus5:render(310*sx, 830*sy, false)
            end
        end
        if self.curItems[8*(self.page - 1) + 5][3] == 0 then
            minus5:render(65*sx, 830*sy, false)
        else
            minus5:render(65*sx, 830*sy, true)
        end
    end
    if self.curItems[8*(self.page - 1) + 6] ~= nil then
        love.graphics.setFont(bigger_font)
        love.graphics.setColor(colorGoldenrod)
        local nameText = love.graphics.newText(bigger_font, self.curItems[8*(self.page - 1) + 6][1])
        local priceText = love.graphics.newText(bigger_font, self.curItems[8*(self.page - 1) + 6][4])
        local image = love.graphics.newImage("inventory/" .. self.curItems[8*(self.page - 1) + 6][2] .. ".png")
        love.graphics.print(self.curItems[8*(self.page - 1) + 6][1], 536.75*sx - nameText:getWidth()*0.5*sx, 570*sy, 0, sx, sy)
        love.graphics.print(self.curItems[8*(self.page - 1) + 6][4], 504.75*sx - priceText:getWidth()*sx, 830*sy, 0, sx, sy)
        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(coin_icon, 513*sx, 837*sy, 0, 0.8*sx, 0.8*sy)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print("x" .. self.curItems[8*(self.page - 1) + 6][3], 559.75*sx, 830*sy, 0, sx, sy)
        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(image, 536.75*sx - image:getWidth()*0.5*sx, 630*sy, 0, sx, sy)
        if self.tab ~= 3 then
            if self.curItems[8*(self.page - 1) + 6][3] == 50 then
                plus6:render(634.75*sx, 830*sy, false)
            else
                plus6:render(634.75*sx, 830*sy, true)
            end
        else
            if self.curItems[8*(self.page - 1) + 6][3] < playerInventory.cells[8*(self.page - 1) + 6].quantity then
                plus6:render(634.75*sx, 830*sy, true)
            else
                plus6:render(634.75*sx, 830*sy, false)
            end
        end
        if self.curItems[8*(self.page - 1) + 6][3] == 0 then
            minus6:render(389.75*sx, 830*sy, false)
        else
            minus6:render(389.75*sx, 830*sy, true)
        end
    end
    if self.curItems[8*(self.page - 1) + 7] ~= nil then
        love.graphics.setFont(bigger_font)
        love.graphics.setColor(colorGoldenrod)
        local nameText = love.graphics.newText(bigger_font, self.curItems[8*(self.page - 1) + 7][1])
        local priceText = love.graphics.newText(bigger_font, self.curItems[8*(self.page - 1) + 7][4])
        local image = love.graphics.newImage("inventory/" .. self.curItems[8*(self.page - 1) + 7][2] .. ".png")
        love.graphics.print(self.curItems[8*(self.page - 1) + 7][1], 861.5*sx - nameText:getWidth()*0.5*sx, 570*sy, 0, sx, sy)
        love.graphics.print(self.curItems[8*(self.page - 1) + 7][4], 829.5*sx - priceText:getWidth()*sx, 830*sy, 0, sx, sy)
        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(coin_icon, 837.75*sx, 837*sy, 0, 0.8*sx, 0.8*sy)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print("x" .. self.curItems[8*(self.page - 1) + 7][3], 884.5*sx, 830*sy, 0, sx, sy)
        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(image, 861.5*sx - image:getWidth()*0.5*sx, 630*sy, 0, sx, sy)
        if self.tab ~= 3 then
            if self.curItems[8*(self.page - 1) + 7][3] == 50 then
                plus7:render(959.5*sx, 830*sy, false)
            else
                plus7:render(959.5*sx, 830*sy, true)
            end
        else
            if self.curItems[8*(self.page - 1) + 7][3] < playerInventory.cells[8*(self.page - 1) + 7].quantity then
                plus7:render(959.5*sx, 830*sy, true)
            else
                plus7:render(959.5*sx, 830*sy, false)
            end
        end
        if self.curItems[8*(self.page - 1) + 7][3] == 0 then
            minus7:render(714.5*sx, 830*sy, false)
        else
            minus7:render(714.5*sx, 830*sy, true)
        end
    end
    if self.curItems[8*(self.page - 1) + 8] ~= nil then
        love.graphics.setFont(bigger_font)
        love.graphics.setColor(colorGoldenrod)
        local nameText = love.graphics.newText(bigger_font, self.curItems[8*(self.page - 1) + 8][1])
        local priceText = love.graphics.newText(bigger_font, self.curItems[8*(self.page - 1) + 8][4])
        local image = love.graphics.newImage("inventory/" .. self.curItems[8*(self.page - 1) + 8][2] .. ".png")
        love.graphics.print(self.curItems[8*(self.page - 1) + 8][1], 1186.25*sx - nameText:getWidth()*0.5*sx, 570*sy, 0, sx, sy)
        love.graphics.print(self.curItems[8*(self.page - 1) + 8][4], 1154.25*sx - priceText:getWidth()*sx, 830*sy, 0, sx, sy)
        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(coin_icon, 1162.5*sx, 837*sy, 0, 0.8*sx, 0.8*sy)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print("x" .. self.curItems[8*(self.page - 1) + 8][3], 1209.25*sx, 830*sy, 0, sx, sy)
        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(image, 1186.25*sx - image:getWidth()*0.5*sx, 630*sy, 0, sx, sy)
        if self.tab ~= 3 then
            if self.curItems[8*(self.page - 1) + 8][3] == 50 then
                plus8:render(1284.25*sx, 830*sy, false)
            else
                plus8:render(1284.25*sx, 830*sy, true)
            end
        else
            if self.curItems[8*(self.page - 1) + 8][3] < playerInventory.cells[8*(self.page - 1) + 8].quantity then
                plus8:render(1284.25*sx, 830*sy, true)
            else
                plus8:render(1284.25*sx, 830*sy, false)
            end
        end
        if self.curItems[8*(self.page - 1) + 8][3] == 0 then
            minus8:render(1039.25*sx, 830*sy, false)
        else
            minus8:render(1039.25*sx, 830*sy, true)
        end
    end

    if #self.curItems - 8*self.page > 0 then
        nextArrow:render(709.5*sx, game_height - 140*sy, true)
    end
    if self.page > 1 then
        prevArrow:render(629.5*sx, game_height - 140*sy, true)
    end

    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(shop_logo, 250*sx, 10*sy, 0, 0.3*sx, 0.3*sy)

    foodTab:render(50*sx, 120*sy, true)
    equipTab:render(483*sx, 120*sy, true)
    sellTab:render(916*sx, 120*sy, true)


    love.graphics.setColor(colorJasmine)
    love.graphics.rectangle("fill", 1420*sx, 350*sy, 400*sx, 385*sy)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.rectangle("line", 1420*sx, 350*sy, 400*sx, 385*sy)

    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(shopkeeper, 1450*sx, 320*sy, 0, 0.4*sx, 0.4*sy)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.setFont(medium_font)
    love.graphics.print("Welcome! We sell everything you\nmight need, and we can find a new\npurpose for the items you don't\nneed anymore!", 1420*sx, 150*sy, 0, sx, sy)

    if self.tab == 1 or self.tab == 2 then
        if playerCoins >= self.total then
            buyThings:render(1229*sx, game_height - 150*sy, true)
        else
            buyThings:render(1229*sx, game_height - 150*sy, false)
        end
    elseif self.tab == 3 then
        sellThings:render(1229*sx, game_height - 150*sy, true)
    end
end

function Shop:getFromInventory()
    self.curItems = {}
    for k, cell in ipairs(playerInventory.cells) do
        if cell.item ~= nil then
            local shortName
            local price
            for i, item in ipairs(self.foodItems) do
                if cell.item == item[2] then
                    shortName = item[1]
                    price = item[4]
                end
            end
            for i, item in ipairs(self.equipItems) do
                if cell.item == item[2] then
                    shortName = item[1]
                    price = item[4]
                end
            end
            for i, item in ipairs(self.fishForSale) do
                if cell.item == item[2] then
                    shortName = item[1]
                    price = item[4]
                end
            end
            self.curItems[k] = {shortName, cell.item, 0, price}
        end
    end
end

function Shop:buyOrSell(i)
    if i == 1 then
        playerCoins = playerCoins - self.total
        for k, item in ipairs(self.foodItems) do
            if item[3] > 0 then
                playerInventory:addItem(item[2], item[3])
            end
        end
        self:clearQuantities()
        self.total = 0
    elseif i == 2 then
        playerCoins = playerCoins - self.total
        for k, item in ipairs(self.equipItems) do
            if item[3] > 0 then
                playerInventory:addItem(item[2], item[3])
            end
        end
        self:clearQuantities()
        self.total = 0
    elseif i == 3 then
        playerCoins = playerCoins + self.total
        for k, item in ipairs(self.curItems) do
            if item[3] > 0 then
                playerInventory:removeItem(item[2], item[3])
            end
        end
        self:clearQuantities()
        self.total = 0
        shop:getFromInventory()
    end
end