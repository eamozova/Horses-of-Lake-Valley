Inventory = Class{}

function Inventory:init(items)
    self.itemkeys = {'dsaddle1', 'dsaddle2', 'dsaddle3', 'jsaddle1', 'jsaddle2', 'jsaddle3', 'ccsaddle1', 'ccsaddle2', 'ccsaddle3',
    --                  1           2           3           4           5           6           7              8            9
    'dbridle1', 'dbridle2', 'dbridle3', 'jbridle1', 'jbridle2', 'jbridle3', 'ccbridle1', 'ccbridle2', 'ccbridle3',
    -- 10            11           12           13        14          15          16          17          18
    'dsaddlepad1', 'dsaddlepad2', 'dsaddlepad3', 'jsaddlepad1', 'jsaddlepad2', 'jsaddlepad3',
    -- 19               20              21              22              23          24
    'ccsaddlepad1', 'ccsaddlepad2', 'ccsaddlepad3',
    --  25              26              27
    'hay', 'apple', 'carrot',
    --28      29        30
    'redfish', 'orangefish', 'yellowfish', 'greenfish', 'turquoisefish', 'bluefish', 'purplefish', 'rainbowfish',
    --  31          32              33          34              35          36              37          38
    'kelp'
    --  39
    }
    self.itemdesc = {'Dressage saddle\n(black)', 'Dressage saddle\n(brown)', 'Dressage saddle\n(blue)',
    'Jumping saddle\n(black)', 'Jumping saddle\n(brown)', 'Jumping saddle\n(blue)',
    'Cross-country saddle\n(black)', 'Cross-country saddle\n(brown)', 'Cross-country saddle\n(blue)',
    'Dressage bridle (black)', 'Dressage bridle\n(brown)', 'Dressage bridle\n(blue)',
    'Jumping bridle\n(black)', 'Jumping bridle\n(brown)', 'Jumping bridle\n(blue)',
    'Cross-country bridle\n(black)', 'Cross-country bridle\n(brown)', 'Cross-country bridle\n(blue)',
    'Dressage saddle pad\n(red)', 'Dressage saddle pad\n(blue)', 'Dressage saddle pad\n(white)',
    'Jumping saddle pad\n(red)', 'Jumping saddle pad\n(blue)', 'Jumping saddle pad\n(white)',
    'Cross-country\nsaddle pad (red)', 'Cross-country\nsaddle pad (blue)', 'Cross-country\nsaddle pad (white)',
    'Hay for your horses\nto eat', 'An apple, tasty treat\nfor your horses', 'A carrot, tasty treat\nfor your horses',
    'Fiery red fish', 'Orange fish', 'Sunny yellow fish', 'Forest green fish', 'Sky blue fish', 'Ocean dark blue fish',
    'Purple fish', 'Magical rainbow fish', 'Kelp from the lake'}

    if items ~= nil then
        self.items = items
    end
    self.cells = {}
    self.currentEquipment = {}
    self.pageOpen = 1
    if self.items ~= nil then
        for k, v in ipairs(self.items) do
            if v ~= 0 then
                if k < 10 then
                    self.cells[#self.cells + 1] = Cell(#self.cells + 1, self.itemkeys[k], "saddle", v, self.itemdesc[k])
                elseif k > 9 and k < 19 then
                    self.cells[#self.cells + 1] = Cell(#self.cells + 1, self.itemkeys[k], "bridle", v, self.itemdesc[k])
                elseif k > 18 and k < 28 then
                    self.cells[#self.cells + 1] = Cell(#self.cells + 1, self.itemkeys[k], "pad", v, self.itemdesc[k])
                elseif k == 28 then
                    self.cells[#self.cells + 1] = Cell(#self.cells + 1, self.itemkeys[k], "hay", v, self.itemdesc[k])
                elseif k == 29 or k == 30 then
                    self.cells[#self.cells + 1] = Cell(#self.cells + 1, self.itemkeys[k], "treat", v, self.itemdesc[k])
                elseif k > 30 and k < 39 then
                    self.cells[#self.cells + 1] = Cell(#self.cells + 1, self.itemkeys[k], "fish", v, self.itemdesc[k])
                else
                    self.cells[#self.cells + 1] = Cell(#self.cells + 1, self.itemkeys[k], "kelp", v, self.itemdesc[k])
                end
            end
        end
    end
    for i = #self.cells + 1, 45 do
        self.cells[i] = Cell(i, nil, nil, nil, nil)
    end
end

function Inventory:render()
    local game_width = love.graphics.getWidth()
    local game_height = love.graphics.getHeight()
    love.graphics.clear(colorYRed)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.setFont(bigger_font)
    love.graphics.print('INVENTORY', game_width/2 - 100*sx, 30*sy)
    love.graphics.rectangle('line', 50*sx, 150*sy, 1350*sx, 800*sy)
    love.graphics.rectangle('line', 1450*sx, 150*sy, 400*sx, 800*sy)
    if #self.cells - 15*self.pageOpen > 0 then
        inv_next_button:render(game_width - 235*sx, game_height - 280*sy, true)
    end
    if self.pageOpen > 1 then
        inv_previous_button:render(game_width - 395*sx, game_height - 280*sy, true)
    end
    for i = 15*(self.pageOpen - 1) + 1, 15*(self.pageOpen - 1) +  15 do
        self.cells[i]:render()
    end
    
    close_inventory:render(game_width - 325*sx, game_height - 200*sy, true)
end

function Inventory:chooseEquipment(spec)
    local game_width = love.graphics.getWidth()
    local game_height = love.graphics.getHeight()

    self.currentEquipment = {}

    if spec == 'jumping' then
        for k, cell in ipairs(self.cells) do
            if cell.item ~= nil then
                if cell.item == self.itemkeys[4] or cell.item == self.itemkeys[5] or cell.item == self.itemkeys[6]
                or cell.item == self.itemkeys[13] or cell.item == self.itemkeys[14] or cell.item == self.itemkeys[15]
                or cell.item == self.itemkeys[22] or cell.item == self.itemkeys[23] or cell.item == self.itemkeys[24] then
                    self.currentEquipment[#self.currentEquipment + 1] =
                    Cell(#self.currentEquipment + 1, cell.item, cell.type, cell.quantity, cell.description)
                end
            end
        end
    elseif spec == 'dressage' then
        for k, cell in ipairs(self.cells) do
            if cell.item ~= nil then
                if cell.item == self.itemkeys[1] or cell.item == self.itemkeys[2] or cell.item == self.itemkeys[3]
                or cell.item == self.itemkeys[10] or cell.item == self.itemkeys[11] or cell.item == self.itemkeys[12]
                or cell.item == self.itemkeys[19] or cell.item == self.itemkeys[20] or cell.item == self.itemkeys[21] then
                    self.currentEquipment[#self.currentEquipment + 1] =
                    Cell(#self.currentEquipment + 1, cell.item, cell.type, cell.quantity, cell.description)
                end
            end
        end
    elseif spec == 'cross-country' then
        for k, cell in ipairs(self.cells) do
            if cell.item ~= nil then
                if cell.item == self.itemkeys[7] or cell.item == self.itemkeys[8] or cell.item == self.itemkeys[9]
                or cell.item == self.itemkeys[16] or cell.item == self.itemkeys[17] or cell.item == self.itemkeys[18]
                or cell.item == self.itemkeys[25] or cell.item == self.itemkeys[26] or cell.item == self.itemkeys[27] then
                    self.currentEquipment[#self.currentEquipment + 1] =
                    Cell(#self.currentEquipment + 1, cell.item, cell.type, cell.quantity, cell.description)
                end
            end
        end
    end

    for i = #self.currentEquipment + 1, 15 do
        self.currentEquipment[i] = Cell(i, nil, nil, nil, nil)
    end
end

function Inventory:renderEquipment()
    local game_width = love.graphics.getWidth()
    local game_height = love.graphics.getHeight()
    love.graphics.clear(colorYRed)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.setFont(bigger_font)
    love.graphics.print('EQUIPMENT', game_width/2 - 100*sx, 30*sy)
    love.graphics.rectangle('line', 50*sx, 150*sy, 1350*sx, 800*sy)
    love.graphics.rectangle('line', 1450*sx, 150*sy, 400*sx, 800*sy)

    for i = 1, 15 do
        self.currentEquipment[i]:render()
    end
end

function Inventory:checkCellsHover()
    self.cells[15*(self.pageOpen - 1) + 1]:checkHover()
    self.cells[15*(self.pageOpen - 1) + 2]:checkHover()
    self.cells[15*(self.pageOpen - 1) + 3]:checkHover()
    self.cells[15*(self.pageOpen - 1) + 4]:checkHover()
    self.cells[15*(self.pageOpen - 1) + 5]:checkHover()
    self.cells[15*(self.pageOpen - 1) + 6]:checkHover()
    self.cells[15*(self.pageOpen - 1) + 7]:checkHover()
    self.cells[15*(self.pageOpen - 1) + 8]:checkHover()
    self.cells[15*(self.pageOpen - 1) + 9]:checkHover()
    self.cells[15*(self.pageOpen - 1) + 10]:checkHover()
    self.cells[15*(self.pageOpen - 1) + 11]:checkHover()
    self.cells[15*(self.pageOpen - 1) + 12]:checkHover()
    self.cells[15*(self.pageOpen - 1) + 13]:checkHover()
    self.cells[15*(self.pageOpen - 1) + 14]:checkHover()
    self.cells[15*(self.pageOpen - 1) + 15]:checkHover()
end

function Inventory:checkEquipmentHover()
    self.currentEquipment[1]:checkHover()
    self.currentEquipment[2]:checkHover()
    self.currentEquipment[3]:checkHover()
    self.currentEquipment[4]:checkHover()
    self.currentEquipment[5]:checkHover()
    self.currentEquipment[6]:checkHover()
    self.currentEquipment[7]:checkHover()
    self.currentEquipment[8]:checkHover()
    self.currentEquipment[9]:checkHover()
    self.currentEquipment[10]:checkHover()
    self.currentEquipment[11]:checkHover()
    self.currentEquipment[12]:checkHover()
    self.currentEquipment[13]:checkHover()
    self.currentEquipment[14]:checkHover()
    self.currentEquipment[15]:checkHover()
end

function Inventory:refreshCells()
    self.cells = {}
    if self.items ~= nil then
        for k, v in ipairs(self.items) do
            if v ~= 0 then
                if k < 10 then
                    self.cells[#self.cells + 1] = Cell(#self.cells + 1, self.itemkeys[k], "saddle", v, self.itemdesc[k])
                elseif k > 9 and k < 19 then
                    self.cells[#self.cells + 1] = Cell(#self.cells + 1, self.itemkeys[k], "bridle", v, self.itemdesc[k])
                elseif k > 18 and k < 28 then
                    self.cells[#self.cells + 1] = Cell(#self.cells + 1, self.itemkeys[k], "pad", v, self.itemdesc[k])
                elseif k == 28 then
                    self.cells[#self.cells + 1] = Cell(#self.cells + 1, self.itemkeys[k], "hay", v, self.itemdesc[k])
                elseif k == 29 or k == 30 then
                    self.cells[#self.cells + 1] = Cell(#self.cells + 1, self.itemkeys[k], "treat", v, self.itemdesc[k])
                elseif k > 30 and k < 39 then
                    self.cells[#self.cells + 1] = Cell(#self.cells + 1, self.itemkeys[k], "fish", v, self.itemdesc[k])
                else
                    self.cells[#self.cells + 1] = Cell(#self.cells + 1, self.itemkeys[k], "kelp", v, self.itemdesc[k])
                end
            end
        end
    end
    for i = #self.cells + 1, 45 do
        self.cells[i] = Cell(i, nil, nil, nil, nil)
    end
end

function Inventory:removeItem(item, quantity)
    local needed
    for k, v in ipairs(self.itemkeys) do
        if v == item then
            needed = k
        end
    end
    self.items[needed] = self.items[needed] - quantity
    if self.items[needed] < 0 then
        self.items[needed] = 0
    end
    self:refreshCells()
end

function Inventory:addItem(item, quantity)
    local needed
    for k, v in ipairs(self.itemkeys) do
        if v == item then
            needed = k
        end
    end
    self.items[needed] = self.items[needed] + quantity
    self:refreshCells()
end