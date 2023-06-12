function generateQuads(atlas, tilewidth, tileheight)
    local sheetWidth = atlas:getWidth() / tilewidth
    local sheetHeight = atlas:getHeight() / tileheight

    local sheetCounter = 1
    local quads = {}

    for y = 0, sheetHeight - 1 do
        for x = 0, sheetWidth - 1 do
            quads[sheetCounter] = love.graphics.newQuad(x * tilewidth, y * tileheight,
            tilewidth, tileheight, atlas:getDimensions())
            sheetCounter = sheetCounter + 1
        end
    end

    return quads
end

function string.explode(str, div)
    assert(type(str) == "string" and type(div) == "string", "invalid arguments")
    local o = {}
    while true do
        local pos1,pos2 = str:find(div)
        if not pos1 then
            o[#o+1] = str
            break
        end
        o[#o+1],str = str:sub(1,pos1-1),str:sub(pos2+1)
    end
    return o
end

-- SAVING
function saveGame(stables)
    love.filesystem.setIdentity("Horse_game_saves")

    t = {}
    -- number of bought stables
    t[1] = stables.number
    t[2] = {}
    for k, stable in ipairs(stables.stables) do
        if stable.empty == true then
            t[2][k] = {"empty", stable.number}
        else
            if stable.horse.foal == nil then
                t[2][k] = {"horse", stable.number, stable.horse.name, stable.horse.age_y, stable.horse.age_m,
                stable.horse.gender, stable.horse.genes, stable.horse.specialization, stable.horse.equipped,
                stable.horse.equipment, stable.horse.eq_hidden, stable.horse.coat_layers, stable.horse.gen_skills, stable.horse.cur_skills,
                stable.horse.health, stable.horse.energy, stable.horse.mood, stable.horse.needs, stable.horse.effects,
                stable.horse.preg, stable.horse.foal_parent, "nil", stable.horse.life_state, stable.horse.kelpie_traits,
                stable.horse.tested}
            -- horses with foals
            else
                t[2][k] = {"horse", stable.number, stable.horse.name, stable.horse.age_y, stable.horse.age_m,
                stable.horse.gender, stable.horse.genes, stable.horse.specialization, stable.horse.equipped,
                stable.horse.equipment, stable.horse.eq_hidden, stable.horse.coat_layers, stable.horse.gen_skills, stable.horse.cur_skills,
                stable.horse.health, stable.horse.energy, stable.horse.mood, stable.horse.needs, stable.horse.effects,
                stable.horse.preg, stable.horse.foal_parent,
                -- foal info
                {stable.horse.foal.name, stable.horse.foal.age_m, stable.horse.foal.gender,
                stable.horse.foal.genes, stable.horse.foal.coat_layers, stable.horse.foal.gen_skills,
                stable.horse.foal.life_state, stable.horse.foal.kelpie_traits, stable.horse.foal.tested},
                stable.horse.life_state, stable.horse.kelpie_traits, stable.horse.tested}
            end
        end
    end

    t[3] = playerCoins
    t[4] = dayOfPlaying
    t[5] = playerInventory.items
    t[6] = {}
    if horsesForBuying[1] ~= nil then
        t[6][1] = {horsesForBuying[1].name, horsesForBuying[1].age_y, horsesForBuying[1].age_m,
        horsesForBuying[1].gender, horsesForBuying[1].genes, "none", false, horsesForBuying[1].equipment,
        horsesForBuying[1].eq_hidden, horsesForBuying[1].coat_layers, horsesForBuying[1].gen_skills,
        horsesForBuying[1].cur_skills, 100, 100, 100, horsesForBuying[1].needs, horsesForBuying[1].effects,
        horsesForBuying[1].preg, horsesForBuying[1].foal_parent, "nil", "horse", {}, horsesForBuying[1].tested}
    else
        t[6][1] = "nil"
    end
    if horsesForBuying[2] ~= nil then
        t[6][2] = {horsesForBuying[2].name, horsesForBuying[2].age_y, horsesForBuying[2].age_m,
        horsesForBuying[2].gender, horsesForBuying[2].genes, "none", false, horsesForBuying[2].equipment,
        horsesForBuying[2].eq_hidden, horsesForBuying[2].coat_layers, horsesForBuying[2].gen_skills,
        horsesForBuying[2].cur_skills, 100, 100, 100, horsesForBuying[2].needs, horsesForBuying[2].effects,
        horsesForBuying[2].preg, horsesForBuying[2].foal_parent, "nil", "horse", {}, horsesForBuying[2].tested}
    else
        t[6][2] = "nil"
    end
    if horsesForBuying[3] ~= nil then
        t[6][3] = {horsesForBuying[3].name, horsesForBuying[3].age_y, horsesForBuying[3].age_m,
        horsesForBuying[3].gender, horsesForBuying[3].genes, "none", false, horsesForBuying[3].equipment,
        horsesForBuying[3].eq_hidden, horsesForBuying[3].coat_layers, horsesForBuying[3].gen_skills,
        horsesForBuying[3].cur_skills, 100, 100, 100, horsesForBuying[3].needs, horsesForBuying[3].effects,
        horsesForBuying[3].preg, horsesForBuying[3].foal_parent, "nil", "horse", {}, horsesForBuying[3].tested}
    else
        t[6][3] = "nil"
    end
    t[7] = {studOfTheDay.name, studOfTheDay.age_y, studOfTheDay.age_m, studOfTheDay.gender,
    studOfTheDay.genes, studOfTheDay.specialization, studOfTheDay.equipped, studOfTheDay.equipment,
    studOfTheDay.eq_hidden, studOfTheDay.coat_layers, studOfTheDay.gen_skills, studOfTheDay.cur_skills,
    studOfTheDay.health, studOfTheDay.energy, studOfTheDay.mood, studOfTheDay.needs, studOfTheDay.effects,
    studOfTheDay.preg, studOfTheDay.foal_parent, "nil", "horse", {}, studOfTheDay.tested}
    t[8] = studdingBought
    t[9] = {}
    t[9][1] = quest.stage
    t[9][2] = quest.color
    if kelpieToBe == nil then
        t[10] = "nil"
    else
        t[10] = {kelpieToBe.name, kelpieToBe.age_y, kelpieToBe.age_m, kelpieToBe.gender,
        kelpieToBe.genes, kelpieToBe.specialization, kelpieToBe.equipped, kelpieToBe.equipment,
        kelpieToBe.eq_hidden, kelpieToBe.coat_layers, kelpieToBe.gen_skills, kelpieToBe.cur_skills,
        kelpieToBe.health, kelpieToBe.energy, kelpieToBe.mood, kelpieToBe.needs, kelpieToBe.effects,
        kelpieToBe.preg, kelpieToBe.foal_parent, "nil", "horse", {}, kelpieToBe.tested}
    end
    t[11] = musicPlaying
    
    packed = TSerial.pack(t, false)
    txt_name = "saved_game_1.txt"

    file = love.filesystem.write(txt_name, packed)
end

-- LOADING
function loadGame()

    love.filesystem.setIdentity("Horse_game_saves")
    local txt_name = "saved_game_1.txt"
    local info = love.filesystem.read(txt_name)
    local table = TSerial.unpack(info)

    local stable_number = table[1]
    local load_stables = {}
    for k, t in ipairs(table[2]) do
        load_stables[#load_stables + 1] = t
    end
    local coins = table[3]
    local day = table[4]
    local inventory = table[5]
    local marketHorses = table[6]
    local stud = table[7]
    local studding = table[8]
    local qstage = table[9]
    local kelpie = table[10]
    local music = table[11]

    return {Stables(stable_number, stable_number), load_stables, coins, day, inventory, marketHorses, stud, studding,
    qstage, kelpie, music}
end

function loadExistingStables()
    loading_table = loadGame()
    user_stables = loading_table[1]
    for k, loadstable in ipairs(loading_table[2]) do
        if loadstable[1] == "empty" then
            user_stables.stables[loadstable[2]] = Stable(loadstable[2])
        elseif loadstable[1] == "horse" then
            if loadstable[22] == "nil" then
                local load_horse = Horse(
                    --name
                    loadstable[3],
                    -- years of age
                    loadstable[4],
                    -- months of age
                    loadstable[5],
                    -- gender
                    loadstable[6],
                    -- genes
                    loadstable[7],
                    -- specialization
                    loadstable[8],
                    -- equipped
                    loadstable[9],
                    -- equipment
                    loadstable[10],
                    -- hidden equipment
                    loadstable[11],
                    -- coat layers
                    loadstable[12],
                    -- genetic potential
                    loadstable[13],
                    -- acquired skills
                    loadstable[14],
                    -- health
                    loadstable[15],
                    -- energy
                    loadstable[16], 
                    -- mood
                    loadstable[17],
                    -- needs
                    loadstable[18],
                    -- effects
                    loadstable[19],
                    -- preg 
                    loadstable[20],
                    -- second parent of a foal
                    loadstable[21],
                    nil,
                    loadstable[23],
                    loadstable[24],
                    loadstable[25])
                user_stables.stables[loadstable[2]] = Stable(loadstable[2])
                user_stables.stables[loadstable[2]]:setHorse(load_horse)
            else
                local load_horse = Horse(loadstable[3], loadstable[4], loadstable[5], loadstable[6], loadstable[7],
                            loadstable[8], loadstable[9], loadstable[10], loadstable[11], loadstable[12], loadstable[13],
                            loadstable[14], loadstable[15], loadstable[16], loadstable[17], loadstable[18], loadstable[19],
                            loadstable[20], loadstable[21],
                            Horse(loadstable[22][1], 0, loadstable[22][2], loadstable[22][3], loadstable[22][4], 'none',
                            false, {nil, nil, nil}, false, loadstable[22][5], loadstable[22][6], {0,0,0,0},
                            100, 100, 100, {true, true, true}, {false}, -1, -1, nil, loadstable[22][7], loadstable[22][8]),
                            loadstable[23], loadstable[24], loadstable[25])
                user_stables.stables[loadstable[2]] = Stable(loadstable[2])
                user_stables.stables[loadstable[2]]:setHorse(load_horse)
            end
        end
    end
    playerCoins = loading_table[3]
    dayOfPlaying = loading_table[4]
    playerInventory = Inventory(loading_table[5])
    horsesForBuying = {}
    if loading_table[6][1] == "nil" then
        horsesForBuying[1] = nil
    else
        horsesForBuying[1] = Horse(loading_table[6][1][1], loading_table[6][1][2], loading_table[6][1][3], loading_table[6][1][4],
        loading_table[6][1][5], loading_table[6][1][6], loading_table[6][1][7], loading_table[6][1][8], loading_table[6][1][9],
        loading_table[6][1][10], loading_table[6][1][11], loading_table[6][1][12], loading_table[6][1][13],
        loading_table[6][1][14], loading_table[6][1][15], loading_table[6][1][16], loading_table[6][1][17],
        loading_table[6][1][18], loading_table[6][1][19], nil, loading_table[6][1][21], loading_table[6][1][22],
        loading_table[6][1][23])
    end
    if loading_table[6][2] == "nil" then
        horsesForBuying[2] = nil
    else
        horsesForBuying[2] = Horse(loading_table[6][2][1], loading_table[6][2][2], loading_table[6][2][3], loading_table[6][2][4],
        loading_table[6][2][5], loading_table[6][2][6], loading_table[6][2][7], loading_table[6][2][8], loading_table[6][2][9],
        loading_table[6][2][10], loading_table[6][2][11], loading_table[6][2][12], loading_table[6][2][13],
        loading_table[6][2][14], loading_table[6][2][15], loading_table[6][2][16], loading_table[6][2][17],
        loading_table[6][2][18], loading_table[6][2][19], nil, loading_table[6][2][21], loading_table[6][2][22],
        loading_table[6][2][23])
    end
    if loading_table[6][3] == "nil" then
        horsesForBuying[3] = nil
    else
        horsesForBuying[3] = Horse(loading_table[6][3][1], loading_table[6][3][2], loading_table[6][3][3], loading_table[6][3][4],
        loading_table[6][3][5], loading_table[6][3][6], loading_table[6][3][7], loading_table[6][3][8], loading_table[6][3][9],
        loading_table[6][3][10], loading_table[6][3][11], loading_table[6][3][12], loading_table[6][3][13],
        loading_table[6][3][14], loading_table[6][3][15], loading_table[6][3][16], loading_table[6][3][17],
        loading_table[6][3][18], loading_table[6][3][19], nil, loading_table[6][3][21], loading_table[6][3][22],
        loading_table[6][3][23])
    end
    
    studOfTheDay = Horse(loading_table[7][1], loading_table[7][2], loading_table[7][3], loading_table[7][4],
        loading_table[7][5], loading_table[7][6], loading_table[7][7], loading_table[7][8], loading_table[7][9],
        loading_table[7][10], loading_table[7][11], loading_table[7][12], loading_table[7][13],
        loading_table[7][14], loading_table[7][15], loading_table[7][16], loading_table[7][17],
        loading_table[7][18], loading_table[7][19], nil, loading_table[7][21], loading_table[7][22], loading_table[7][23])
    studdingBought = loading_table[8]
    quest = Quest(loading_table[9][1])
    quest.color = loading_table[9][2]
    if loading_table[10] == "nil" then
        kelpieToBe = nil
    else
        kelpieToBe = Horse(loading_table[10][1], loading_table[10][2], loading_table[10][3], loading_table[10][4],
        loading_table[10][5], loading_table[10][6], loading_table[10][7], loading_table[10][8], loading_table[10][9],
        loading_table[10][10], loading_table[10][11], loading_table[10][12], loading_table[10][13],
        loading_table[10][14], loading_table[10][15], loading_table[10][16], loading_table[10][17],
        loading_table[10][18], loading_table[10][19], nil, loading_table[10][21], loading_table[10][22], loading_table[10][23])
    end
    musicPlaying = loading_table[11]
end

function drawBar(type, x, y, width, height, part, full)
    love.graphics.setColor(1, 1, 1, 1)
    if type == "skill" then
        love.graphics.setColor(colorJasmine)
        love.graphics.rectangle('fill', x, y, width, height)
        love.graphics.setColor(255/255, 185/255, 71/255, 1)
        if part/full < 1 then
            love.graphics.rectangle('fill', x, y, width * (part / full), height)
        else
            love.graphics.rectangle('fill', x, y, width, height)
        end
        love.graphics.setColor(colorGoldenrod)
        love.graphics.rectangle('line', x, y, width, height)
    elseif type == "health" then
        love.graphics.setColor(colorYRed)
        love.graphics.rectangle('fill', x, y, width, height)
        love.graphics.setColor(255/255, 187/255, 163/255, 1)
        love.graphics.rectangle('fill', x, y, width * (part / full), height)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.rectangle('line', x, y, width, height)
    elseif type == "energy" then
        love.graphics.setColor(colorYRed)
        love.graphics.rectangle('fill', x, y, width, height)
        love.graphics.setColor(186/255, 213/255, 246/255, 1)
        love.graphics.rectangle('fill', x, y, width * (part / full), height)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.rectangle('line', x, y, width, height)
    elseif type == "mood" then
        love.graphics.setColor(colorYRed)
        love.graphics.rectangle('fill', x, y, width, height)
        love.graphics.setColor(243/255, 236/255, 150/255, 1)
        love.graphics.rectangle('fill', x, y, width * (part / full), height)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.rectangle('line', x, y, width, height)
    end
end

function renderNameWindow()
    local game_width = love.graphics.getWidth()
    local game_height = love.graphics.getHeight()

    love.graphics.setColor(colorYRed)
    love.graphics.rectangle('fill', game_width/2 - 250 * sx, game_height/2 - 230 * sy, 400, 200)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.rectangle('line', game_width/2 - 250 * sx, game_height/2 - 230 * sy, 400, 200)
    
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.rectangle('fill', game_width/2 - 130 * sx, game_height/2 - 150 * sy, 200, 50)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.rectangle('line', game_width/2 - 130 * sx, game_height/2 - 150 * sy, 200, 50)
    love.graphics.print("Type new name here:", game_width/2 - 120 * sx, game_height/2 - 210 * sy)
end

function renderMenu()
    local game_width = love.graphics.getWidth()
    local game_height = love.graphics.getHeight()

    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(menu_background, 0, 0, 0, sx, sy)
    love.graphics.setColor(colorYRed)
    love.graphics.rectangle('fill', game_width/2 - 250*sx, game_height/2 - 250*sy, 500*sx, 520*sy)
    love.graphics.setLineWidth(4)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.rectangle('line', game_width/2 - 250*sx, game_height/2 - 250*sy, 500*sx, 520*sy)

    if (currently_playing == false) then
        resume_game_button:render(game_width/2 - 150*sx, game_height/2 - 210*sy, false)
    else
        resume_game_button:render(game_width/2 - 150*sx, game_height/2 - 210*sy, true)
    end
    new_game_button:render(game_width/2 - 150*sx, game_height/2 - 120*sy, true)
    load_game_button:render(game_width/2 - 150*sx, game_height/2 - 30*sy, true)
    if (currently_playing == false) then
        save_game_button:render(game_width/2 - 150*sx, game_height/2 + 60*sy, false)
    else
        save_game_button:render(game_width/2 - 150*sx, game_height/2 + 60*sy, true)
    end
    exit_button:render(game_width/2 - 150*sx, game_height/2 + 150*sy, true)
end

function renderTrainingMenu()
    local sx = love.graphics.getWidth() / menu_background:getWidth()
    local sy = love.graphics.getHeight() / menu_background:getHeight()
    local game_width = love.graphics.getWidth()
    local game_height = love.graphics.getHeight()

    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(training_background, 0, 0, 0, sx, sy)
    love.graphics.setColor(colorYRed)
    love.graphics.rectangle("fill", 200*sx, 250*sy, 1500*sx, 600*sy)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.setLineWidth(4)
    love.graphics.rectangle("line", 200*sx, 250*sy, 1500*sx, 600*sy)
end

function renderHorsesList(event, type)
    local game_width = love.graphics.getWidth()
    local game_height = love.graphics.getHeight()

    availableForCompeting = {}
    availableForTraining = {}

    if event == "training" then
        for k, stable in ipairs(user_stables.stables) do
            if stable.horse ~= nil then
                if stable.horse.age_y >= 2 and stable.horse.preg == -1 and stable.horse.effects[1] == false then
                        availableForTraining[#availableForTraining + 1] = stable:getHorse()
                end
            end
        end
    elseif event == "competing" then
        for k, stable in ipairs(user_stables.stables) do
            if stable.horse ~= nil then
                if stable.horse.age_y >= 2 and stable.horse.preg == -1 and stable.horse.equipped == true
                and stable.horse.specialization == type  and stable.horse.effects[1] == false then
                    availableForCompeting[#availableForCompeting + 1] = stable:getHorse()
                end
            end
        end
    end

    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(training_background, 0, 0, 0, sx, sy)
    love.graphics.setColor(colorYRed)
    love.graphics.rectangle("fill", 200*sx, 150*sy, 1500*sx, 800*sy)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.setLineWidth(4)
    love.graphics.rectangle("line", 200*sx, 150*sy, 1500*sx, 800*sy)

    love.graphics.setFont(bigger_font)
    if event == "training" then
        love.graphics.print("Select horse to train:", game_width/2 - 250*sx, 180*sy)
        if #availableForTraining - trainingPageOpen*4 > 0 then
            next_button:render(game_width/2 + 600*sx, game_height-220*sy, true)
        end
        if trainingPageOpen > 1 then
            previous_button:render(250*sx, game_height-220*sy, true)
        end
        if availableForTraining[4*(trainingPageOpen - 1) + 1] ~= nil then
            availableForTraining[4*(trainingPageOpen - 1) + 1]:showTrainingInfo(event, type, 1)
        end
        if availableForTraining[4*(trainingPageOpen - 1) + 2] ~= nil then
            availableForTraining[4*(trainingPageOpen - 1) + 2]:showTrainingInfo(event, type, 2)
        end
        if availableForTraining[4*(trainingPageOpen - 1) + 3] ~= nil then
            availableForTraining[4*(trainingPageOpen - 1) + 3]:showTrainingInfo(event, type, 3)
        end
        if availableForTraining[4*(trainingPageOpen - 1) + 4] ~= nil then
            availableForTraining[4*(trainingPageOpen - 1) + 4]:showTrainingInfo(event, type, 4)
        end
    elseif event == "competing" then
        love.graphics.print("Select horse to compete:", game_width/2 - 250*sx, 180*sy)
        if #availableForCompeting - competingPageOpen*4 > 0 then
            next_button:render(game_width/2 + 600*sx, game_height-220*sy, true)
        end
        if competingPageOpen > 1 then
            previous_button:render(250*sx, game_height-220*sy, true)
        end
        if availableForCompeting[4*(competingPageOpen - 1) + 1] ~= nil then
            availableForCompeting[4*(competingPageOpen - 1) + 1]:showTrainingInfo(event, type, 1)
        end
        if availableForCompeting[4*(competingPageOpen - 1) + 2] ~= nil then
            availableForCompeting[4*(competingPageOpen - 1) + 2]:showTrainingInfo(event, type, 2)
        end
        if availableForCompeting[4*(competingPageOpen - 1) + 3] ~= nil then
            availableForCompeting[4*(competingPageOpen - 1) + 3]:showTrainingInfo(event, type, 3)
        end
        if availableForCompeting[4*(competingPageOpen - 1) + 4] ~= nil then
            availableForCompeting[4*(competingPageOpen - 1) + 4]:showTrainingInfo(event, type, 4)
        end
    end

end

function trainHorse(number, page, type)
    horseToTrain = availableForTraining[number + (4*(page-1))]
    horseToTrain:train(type)
end

function enterCompetition(number, page, type, tier)
    horseToCompete = availableForCompeting[number + (4*(page-1))]
    return {horseToCompete:getName(), horseToCompete:compete(type, tier)}
end

function displayCompetitionResults(name, place)
    local game_width = love.graphics.getWidth()
    local game_height = love.graphics.getHeight()

    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(training_background, 0, 0, 0, sx, sy)
    love.graphics.setColor(colorYRed)
    love.graphics.rectangle('fill', game_width/2 - 250 * sx, game_height/2 - 230 * sy, 400, 200)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.rectangle('line', game_width/2 - 250 * sx, game_height/2 - 230 * sy, 400, 200)

    love.graphics.setFont(medium_font)
    if place == -1 then
        love.graphics.print(name .. " doesn't have", game_width/2 - 140 * sx, game_height/2 - 200 * sy)
        love.graphics.print("enough energy to compete.", game_width/2 - 170 * sx, game_height/2 - 160 * sy)
    elseif place == -2 then
        love.graphics.print("It seems your horse", game_width/2 - 140 * sx, game_height/2 - 230 * sy)
        love.graphics.print("got injured while competing.", game_width/2 - 200 * sx, game_height/2 - 190 * sy)
        love.graphics.print("You should take better care", game_width/2 - 200 * sx, game_height/2 - 150 * sy)
        local nametext = love.graphics.newText(medium_font,"of " .. name )
        love.graphics.print("of " .. name, game_width/2 - nametext:getWidth()/2, game_height/2 - 110 * sy)
    else
        love.graphics.print(name .. "'s place: " .. place, game_width/2 - 130 * sx, game_height/2 - 200 * sy)
        if place == 3 then
            love.graphics.print("You win " .. prize, game_width/2 - 130 * sx, game_height/2 - 150 * sy)
            love.graphics.setColor(1,1,1,1)
            love.graphics.draw(coin_icon, game_width/2 + 50*sx, game_height/2 - 145 * sy, 0, 0.7, 0.7)
        elseif place == 2 then
            love.graphics.print("You win " .. prize, game_width/2 - 130 * sx, game_height/2 - 150 * sy)
            love.graphics.setColor(1,1,1,1)
            love.graphics.draw(coin_icon, game_width/2 + 50*sx, game_height/2 - 145 * sy, 0, 0.7, 0.7)
        elseif place == 1 then
            love.graphics.print("You win " .. prize, game_width/2 - 130 * sx, game_height/2 - 150 * sy)
            love.graphics.setColor(1,1,1,1)
            love.graphics.draw(coin_icon, game_width/2 + 50*sx, game_height/2 - 145 * sy, 0, 0.7, 0.7)
        elseif place == 5 or place == 4 then
            love.graphics.print("You win " .. prize, game_width/2 - 130 * sx, game_height/2 - 150 * sy)
            love.graphics.setColor(1,1,1,1)
            love.graphics.draw(coin_icon, game_width/2 + 35*sx, game_height/2 - 145 * sy, 0, 0.7, 0.7)
        end
    end
end

function renderBreedingMenu()
    local game_width = love.graphics.getWidth()
    local game_height = love.graphics.getHeight()
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(med_background, 0, 0, 0, sx, sy)
    love.graphics.setColor(colorYRed)
    love.graphics.rectangle('fill', 100*sx, 50*sy, 700*sx, 950*sy)
    love.graphics.setLineWidth(4)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.rectangle('line', 100*sx, 50*sy, 700*sx, 950*sy)

    love.graphics.setColor(colorYRed)
    love.graphics.rectangle('fill', game_width - 800*sx, 50*sy, 700*sx, 950*sy)
    love.graphics.setLineWidth(4)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.rectangle('line', game_width - 800*sx, 50*sy, 700*sx, 950*sy)

    love.graphics.setColor(1,1,1,1)
    myStudsBtn:render(100*sx, 50*sy, true)
    paidStudsBtn:render(450*sx, 50*sy, true)

    availableMales = {}
    availableFemales = {}

    for k, stable in ipairs(user_stables.stables) do
        if stable.horse ~= nil then
            if stable.horse.age_y >= 2 then
                if stable.horse:getGender() == "m" and stable.horse.energy >= 20 then
                    availableMales[#availableMales + 1] = stable:getHorse()
                elseif stable.horse:getGender() == "f" and stable.horse.preg == -1
                and stable.horse.foal == nil then
                    availableFemales[#availableFemales + 1] = stable:getHorse()
                end
            end
        end
    end

    if paidStudOpen == false then
        if availableMales[breeding_page_m] ~= nil then
            availableMales[breeding_page_m]:showBreedingInfo("m")
        end
    else
        if studdingBought == true then
            studOfTheDay:showBreedingInfo("m")
        end
    end
    if availableFemales[breeding_page_f] ~= nil then
        availableFemales[breeding_page_f]:showBreedingInfo("f")
    end
    if paidStudOpen == true then
        if studOfTheDay.energy < 25 or studdingBought == false then
            breedButton:render(game_width/2 - 100*sx, game_height/2 - 100*sy, false)
        else
            breedButton:render(game_width/2 - 100*sx, game_height/2 - 100*sy, true)
        end
    else
        if #availableMales == 0 or #availableFemales == 0 or
        (availableMales[breeding_page_m] ~= nil and availableMales[breeding_page_m].energy < 20) then
            breedButton:render(game_width/2 - 100*sx, game_height/2 - 100*sy, false)
        else
            breedButton:render(game_width/2 - 100*sx, game_height/2 - 100*sy, true)
        end
    end

    if breeding_page_f < #availableFemales then
        nextFemaleButton:render(game_width - 210*sx, 580*sy, true)
    end
    if breeding_page_f > 1 then
        previousFemaleButton:render(game_width - 780*sx, 580*sy, true)
    end
    if paidStudOpen == false then
        if breeding_page_m < #availableMales then
            nextMaleButton:render(game_width/2 - 270*sx, 580*sy, true)
        end
        if breeding_page_m > 1 then
            previousMaleButton:render(120*sx, 580*sy, true)
        end
    end
end

function changeDay()
    local foals = {}
    deadHorses = {}
    bornFoals = {}
    grownFoals = {}
    local stableForFoal
    local notFound = true
    local check
    dayOfPlaying = dayOfPlaying + 1
    horsesForBuying = {}
    horsesForBuying[1] = Horse:generateHorseToBuy(false)
    horsesForBuying[2] = Horse:generateHorseToBuy(false)
    horsesForBuying[3] = Horse:generateHorseToBuy(false)
    studOfTheDay = Horse:generateStudOfTheDay(false)
    studdingBought = false
    if quest.stage == 0 then
        if math.random(2) == 1 then
            quest.stage = 1
        end
    elseif quest.stage == 7 or quest.stage == 13 then
        if math.random(2) == 1 then
            quest.stage = quest.stage + 1
            kelpieToBe:turnToKelpie(quest.color)
            local foundEmpty = false
            local checking = 1
            local freeStable
            while foundEmpty == false and checking <= user_stables.number do
                if user_stables.stables[checking].empty == true then
                    freeStable = user_stables.stables[checking]
                    foundEmpty = true
                end
                checking = checking + 1
            end
            if foundEmpty == true then
                freeStable:setHorse(kelpieToBe)
                kelpieToBe = nil
            else
                user_stables:addStable()
                user_stables.stables[#user_stables.number]:setHorse(kelpieToBe)
                kelpieToBe = nil
            end
        end
    elseif quest.stage == 9 then
        if math.random(2) == 1 then
            quest.stage = 10
        end
    end

    for k, stable in ipairs(user_stables.stables) do
        if stable.horse ~= nil then
            -- restoring energy
            stable.horse.energy = 100
            -- randomly worse or better mood
            if math.random(5) == 1 then
                stable.horse.mood = stable.horse.mood + math.random(1, 10)
            elseif math.random(5) == 2 then
                stable.horse.mood = stable.horse.mood - math.random(1, 10)
            end
            if stable.clean == false then
                stable.horse.mood = stable.horse.mood - 5
            end
            if stable.horse.health < 100 then
                stable.horse.mood = stable.horse.mood - 5
            end
            if stable.horse.needs[1] == false then
                stable.horse.health = stable.horse.health - 5
                stable.horse.mood = stable.horse.mood - 5
            end
            if stable.horse.needs[2] == false then
                stable.horse.health = stable.horse.health - 5
                stable.horse.mood = stable.horse.mood - 5
            end
            if stable.horse.needs[3] == false then
                stable.horse.health = stable.horse.health - 5
                stable.horse.mood = stable.horse.mood - 5
            end
            if stable.horse.effects[1] == true then
                stable.horse.health = stable.horse.health - 10
            end
            if stable.horse.health < 0 then
                stable.horse.health = 0
            end
            if stable.horse.mood < 0 then
                stable.horse.mood = 0
            end
            if stable.horse.mood > 100 then
                stable.horse.mood = 100
            end
            if stable.horse.health < 100 and stable.horse.effects[1] == false
            and stable.horse.needs[1] == true and stable.horse.needs[2] == true and stable.horse.needs[3] == true then
                stable.horse.health = stable.horse.health + 5
                if stable.horse.health > 100 then
                    stable.horse.health = 100
                end
            end
            -- refreshing needs
            stable.horse.needs[1] = false
            stable.horse.needs[2] = false
            stable.horse.needs[3] = false

            -- 33% chance the stable gets dirty
            if math.random(3) == 1 and stable.clean == true then
                stable.clean = false
            end

            if stable.horse.age_m < 10 then
                stable.horse.age_m = stable.horse.age_m + 2
            else
                stable.horse.age_m = 0
                stable.horse.age_y = stable.horse.age_y + 1
                if stable.horse.age_y == 2 and stable.horse.age_m == 0 then
                    stable.horse:ageUp()
                end
            end
            if stable.horse.foal ~= nil then
                stable.horse.foal.age_m = stable.horse.foal.age_m + 2
                if stable.horse.foal.age_m == 6 then
                    grownFoals[#grownFoals + 1] = stable.horse.foal
                    stable.horse.foal = nil
                end
            end
            if stable.horse.preg >= 0 and stable.horse.preg < 10 then
                stable.horse.preg = stable.horse.preg + 2
            elseif stable.horse.preg == 10 then
                stable.horse:giveBirth()
                bornFoals[#bornFoals + 1] = {stable.horse.name, stable.horse.foal.gender}
            end
            if stable.horse.age_y >= 25 then
                if math.random(25) == 1 then
                    deadHorses[#deadHorses + 1] = {stable.horse, "old age."}
                    stable:setEmpty()
                end
            end
            if stable.horse.health <= 30 then
                if math.random(10) == 1 then
                    deadHorses[#deadHorses + 1] = {stable.horse, "health issues."}
                    stable:setEmpty()
                end
            end

            if stable.empty == false then
                if stable.horse.life_state == "hybrid" then
                    stable.foodChance = math.random(2)
                end
                stable.treatChance = math.random(2)
            end
        end
    end

    -- notifications: TO DO
    if #deadHorses ~= 0 then
        notification = windows[2]
    elseif #deadHorses == 0 and #bornFoals ~= 0 then
        notification = windows[3]
    elseif #deadHorses == 0 and #bornFoals == 0 and #grownFoals ~= 0 then
        notification = windows[4]
    else
        notification = windows[1]
    end
end

function renderPanel()
    local game_width = love.graphics.getWidth()
    local game_height = love.graphics.getHeight()

    love.graphics.setColor(colorJasmine)
    love.graphics.rectangle('fill', 0, game_height - 50 * sy, game_width, 50)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.rectangle('line', 0, game_height - 50 * sy, game_width, 50)

    local coinText = love.graphics.newText(smaller_font, playerCoins)
    local dayText = love.graphics.newText(smaller_font, "Day " .. dayOfPlaying)

    love.graphics.setFont(smaller_font)
    love.graphics.print("Day " .. dayOfPlaying, 20*sx, game_height - 45*sy)
    love.graphics.print(playerCoins, 20*sx + dayText:getWidth() + 40*sx, game_height - 45*sy)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(coin_icon, 20*sx + dayText:getWidth() + 40*sx + coinText:getWidth() + 10*sx, game_height - 42*sy, 0, 0.6, 0.6)
end

function showDeathsNotif()
    notification = windows[2]
    local game_width = love.graphics.getWidth()
    local game_height = love.graphics.getHeight()

    local game_width = love.graphics.getWidth()
    local game_height = love.graphics.getHeight()

    love.graphics.setColor(colorJasmine)
    love.graphics.rectangle('fill', game_width/2 - 400*sx, 150*sy, 800*sx, 220*sy + 60*(#deadHorses - 1)*sy)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.rectangle('line', game_width/2 - 400*sx, 150*sy, 800*sx, 220*sy + 60*(#deadHorses - 1)*sy)

    love.graphics.setFont(medium_font)
    love.graphics.print("Deaths:", game_width/2 - 50*sx, 165*sy)
    love.graphics.setFont(smaller_font)
    local printY = 230*sy

    for k, death in ipairs(deadHorses) do
        love.graphics.print(death[1].name .. " died of " .. death[2], game_width/2 - 350*sx, printY)
        love.graphics.setColor(colorGoldenrod)
        printY = printY + 30*sy
    end

    confirm_notif:render(game_width/2 - 40*sx, printY + 40*sy, true)
end

function showBirthsNotif()
    notification = windows[3]
    local game_width = love.graphics.getWidth()
    local game_height = love.graphics.getHeight()

    love.graphics.setColor(colorJasmine)
    love.graphics.rectangle('fill', game_width/2 - 400*sx, 150*sy, 800*sx, 220*sy + 60*(#bornFoals - 1)*sy)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.rectangle('line', game_width/2 - 400*sx, 150*sy, 800*sx, 220*sy + 60*(#bornFoals - 1)*sy)

    love.graphics.setFont(medium_font)
    love.graphics.print("Births:", game_width/2 - 50*sx, 165*sy)
    love.graphics.setFont(smaller_font)
    local printY = 230*sy

    for k, birth in ipairs(bornFoals) do
        local foalText = love.graphics.newText(smaller_font, birth[1] .. " has given birth to a foal (")
        love.graphics.print(birth[1] .. " has given birth to a foal (", game_width/2 - 350*sx, printY)
        love.graphics.setColor(1,1,1,1)
        if birth[2] == "m" then
            love.graphics.draw(male_sign, game_width/2 - 350*sx + foalText:getWidth() + 2*sx, printY, 0, sx, sy)
        else
            love.graphics.draw(female_sign, game_width/2 - 350*sx + foalText:getWidth() + 2*sx, printY, 0, sx, sy)
        end
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print(")", game_width/2 - 350*sx + foalText:getWidth() + 30*sx, printY)
        printY = printY + 30*sy
    end

    confirm_notif:render(game_width/2 - 40*sx, printY + 40*sy, true)
end

function showGrowingNotif()
    notification = windows[4]
    local game_width = love.graphics.getWidth()
    local game_height = love.graphics.getHeight()
        
    love.graphics.setColor(colorJasmine)
    love.graphics.rectangle('fill', game_width/2 - 400*sx, 150*sy, 800*sx, 500*sy)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.rectangle('line', game_width/2 - 400*sx, 150*sy, 800*sx, 500*sy)

    love.graphics.setFont(medium_font)
    love.graphics.print("Aging up", game_width/2 - 50*sx, 165*sy)
    love.graphics.setFont(smaller_font)

    love.graphics.print("This foal is aging up and now needs its own stable.", game_width/2 - 310*sx, 220*sy)

    love.graphics.setColor(1,1,1,1)
    grownFoals[currentGrowing]:render(game_width/2 - 280*sx, 270*sy, 0.7*sx, 0.7*sy)

    if grownFoals[currentGrowing].gender == "m" then
        love.graphics.draw(male_sign, game_width/2, 280*sy, 0, 0.8*sx, 0.8*sy)
    else
        love.graphics.draw(female_sign, game_width/2, 282*sy, 0, 0.8*sx, 0.8*sy)
    end
    love.graphics.setColor(colorGoldenrod)
    love.graphics.print(grownFoals[currentGrowing].name, game_width/2 + 35*sx, 280*sy)

    love.graphics.print("Genetic potential:", game_width/2, 320*sy)
    love.graphics.print("Stamina " .. grownFoals[currentGrowing].gen_skills[1], game_width/2 + 40*sx, 360*sy)
    love.graphics.print("Speed " .. grownFoals[currentGrowing].gen_skills[2], game_width/2 + 40*sx, 400*sy)
    love.graphics.print("Jumping " .. grownFoals[currentGrowing].gen_skills[3], game_width/2 + 40*sx, 440*sy)
    love.graphics.print("Dressage " .. grownFoals[currentGrowing].gen_skills[4], game_width/2 + 40*sx, 480*sy)

    sell_foal:render(game_width/2 - 150*sx, 560*sy, true)
    keep_foal:render(game_width/2 + 50*sx, 560*sy, true)
end

function buyStableDialog(notEnough)
    local game_width = love.graphics.getWidth()
    local game_height = love.graphics.getHeight()

    love.graphics.setColor(colorYRed)
    love.graphics.rectangle('fill', game_width/2 - 300*sx, 200*sy, 600*sx, 180*sy)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.rectangle('line', game_width/2 - 300*sx, 200*sy, 600*sx, 180*sy)

    if notEnough == true then
        love.graphics.print("You don't have any empty stables.", game_width/2 - 230*sx, 210*sy)
        love.graphics.print("Buy a stable for 500?", game_width/2 - 160*sx, 250*sy)
        if playerCoins >= 500 then
            yes:render(game_width/2 - 100*sx, 310*sy, true)
        else
            yes:render(game_width/2 - 100*sx, 310*sy, false)
        end
        no:render(game_width/2 + 30*sx, 310*sy, true)
    else
        love.graphics.print("Buy a stable for 500?", game_width/2 - 200*sx, 230*sy)
        if playerCoins >= 500 then
            yes:render(game_width/2 - 270*sx, 240*sy, true)
        else
            yes:render(game_width/2 - 270*sx, 240*sy, false)
        end
        yes:render(game_width/2 + 270*sx, 240*sy, true)
    end
end

function changeSpecDialog()
    local game_width = love.graphics.getWidth()
    local game_height = love.graphics.getHeight()

    love.graphics.setColor(colorJasmine)
    love.graphics.rectangle('fill', game_width/2 - 400*sx, 200*sy, 800*sx, 180*sy)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.rectangle('line', game_width/2 - 400*sx, 200*sy, 800*sx, 180*sy)

    love.graphics.setFont(medium_font)
    love.graphics.print("Choose specialization:", game_width/2 - 150*sx, 220*sy)

    change_spec_none:render(game_width/2 - 355*sx, 290*sy, true)
    if (playerInventory.items[4] > 0 or playerInventory.items[5] > 0 or playerInventory.items[6] > 0)
    and (playerInventory.items[13] > 0 or playerInventory.items[14] > 0 or playerInventory.items[15] > 0)
    and (playerInventory.items[22] > 0 or playerInventory.items[23] > 0 or playerInventory.items[24] > 0) then
        change_spec_jump:render(game_width/2 - 230*sx, 290*sy, true)
    else
        change_spec_jump:render(game_width/2 - 230*sx, 290*sy, false)
    end
    if (playerInventory.items[1] > 0 or playerInventory.items[2] > 0 or playerInventory.items[3] > 0)
    and (playerInventory.items[10] > 0 or playerInventory.items[11] > 0 or playerInventory.items[12] > 0)
    and (playerInventory.items[19] > 0 or playerInventory.items[20] > 0 or playerInventory.items[21] > 0) then
        change_spec_dres:render(game_width/2 - 50*sx, 290*sy, true)
    else
        change_spec_dres:render(game_width/2 - 50*sx, 290*sy, false)
    end
    if (playerInventory.items[7] > 0 or playerInventory.items[8] > 0 or playerInventory.items[9] > 0)
    and (playerInventory.items[16] > 0 or playerInventory.items[17] > 0 or playerInventory.items[18] > 0)
    and (playerInventory.items[25] > 0 or playerInventory.items[26] > 0 or playerInventory.items[27] > 0) then
        change_spec_cc:render(game_width/2 + 130*sx, 290*sy, true)
    else
        change_spec_cc:render(game_width/2 + 130*sx, 290*sy, false)
    end
end

function checkChosenEquipment(i)
    if playerInventory.currentEquipment[i].type == 'saddle' then
        if chosen_saddle == nil then
            playerInventory.currentEquipment[i].checked = true
            chosen_saddle = playerInventory.currentEquipment[i].item
        else
            if playerInventory.currentEquipment[i].item == chosen_saddle then
                playerInventory.currentEquipment[i].checked = false
                chosen_saddle = nil
            else
                for j = 1, 15 do
                    if playerInventory.currentEquipment[j].item == chosen_saddle then
                        playerInventory.currentEquipment[j].checked = false
                    end
                end
                playerInventory.currentEquipment[i].checked = true
                chosen_saddle = playerInventory.currentEquipment[i].item
            end
        end
    elseif playerInventory.currentEquipment[i].type == 'bridle' then
        if chosen_bridle == nil then
            playerInventory.currentEquipment[i].checked = true
            chosen_bridle = playerInventory.currentEquipment[i].item
        else
            if playerInventory.currentEquipment[i].item == chosen_bridle then
                playerInventory.currentEquipment[i].checked = false
                chosen_bridle = nil
            else
                for j = 1, 15 do
                    if playerInventory.currentEquipment[j].item == chosen_bridle then
                        playerInventory.currentEquipment[j].checked = false
                    end
                end
                playerInventory.currentEquipment[i].checked = true
                chosen_bridle = playerInventory.currentEquipment[i].item
            end
        end
    elseif playerInventory.currentEquipment[i].type == 'pad' then
        if chosen_pad == nil then
            playerInventory.currentEquipment[i].checked = true
            chosen_pad = playerInventory.currentEquipment[i].item
        else
            if playerInventory.currentEquipment[i].item == chosen_pad then
                playerInventory.currentEquipment[i].checked = false
                chosen_pad = nil
            else
                for j = 1, 15 do
                    if playerInventory.currentEquipment[j].item == chosen_pad then
                        playerInventory.currentEquipment[j].checked = false
                    end
                end
                playerInventory.currentEquipment[i].checked = true
                chosen_pad = playerInventory.currentEquipment[i].item
            end
        end
    end

    if chosen_bridle ~= nil and chosen_pad ~= nil and chosen_saddle ~= nil then
        confirm_equipment.active = true
    end
end

function renderMedicalCentreMenu()
    local game_width = love.graphics.getWidth()
    local game_height = love.graphics.getHeight()

    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(med_background, 0, 0, 0, sx, sy)
    love.graphics.setColor(colorYRed)
    love.graphics.rectangle('fill', game_width/2 - 300*sx, game_height/2 - 300*sy, 600*sx, 600*sy)
    love.graphics.setLineWidth(4)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.rectangle('line', game_width/2 - 300*sx, game_height/2 - 300*sy, 600*sx, 600*sy)

    breeding_button:render(game_width/2 - 150*sx, 350*sy, true)
    treatment_button:render(game_width/2 - 150*sx, 500*sy, true)
    medical_test_button:render(game_width/2 - 150*sx, 650*sy, true)
end

function renderTreatmentMenu()
    local game_width = love.graphics.getWidth()
    local game_height = love.graphics.getHeight()

    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(med_background, 0, 0, 0, sx, sy)
    love.graphics.setColor(colorYRed)
    love.graphics.rectangle('fill', game_width/2 - 350*sx, game_height/2 - 450*sy, 700*sx, 865*sy)
    love.graphics.setLineWidth(4)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.rectangle('line', game_width/2 - 350*sx, game_height/2 - 450*sy, 700*sx, 865*sy)

    sickHorses = {}

    for k, stable in ipairs(user_stables.stables) do
        if stable.horse ~= nil then
            if stable.horse.age_y >= 2 then
                if stable.horse.effects[1] == true then
                    sickHorses[#sickHorses + 1] = stable:getHorse()
                end
            end
        end
    end

    if #sickHorses == 0 then
        love.graphics.setFont(bigger_font)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print("You don't have any", game_width/2 - 170*sx, game_height/2 - 210*sy)
        love.graphics.print("horses that need", game_width/2 - 160*sx, game_height/2 - 150*sy)
        love.graphics.print("treatment right now.", game_width/2 - 190*sx, game_height/2 - 90*sy)
    else
        if sickHorses[4*(treatmentPage - 1) + 1] ~= nil then
            sickHorses[4*(treatmentPage - 1) + 1]:showHealthInfo(1)
        end
        if sickHorses[4*(treatmentPage - 1) + 2] ~= nil then
            sickHorses[4*(treatmentPage - 1) + 2]:showHealthInfo(2)
        end
        if sickHorses[4*(treatmentPage - 1) + 3] ~= nil then
            sickHorses[4*(treatmentPage - 1) + 3]:showHealthInfo(3)
        end
        if sickHorses[4*(treatmentPage - 1) + 4] ~= nil then
            sickHorses[4*(treatmentPage - 1) + 4]:showHealthInfo(4)
        end
    end

    if #sickHorses - treatmentPage*4 > 0 then
        nextSickHorses:render(game_width/2 + 20*sx, game_height/2 + 350*sy, true)
    end
    if treatmentPage > 1 then
        previousSickHorses:render(game_width/2 - 100*sx, game_height/2 + 350*sy, true)
    end
end

function renderShopAndMarket()
    local game_width = love.graphics.getWidth()
    local game_height = love.graphics.getHeight()

    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(pattern_background, 0, 0, 0, sx, sy)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.setColor(colorYRed)
    love.graphics.rectangle('fill', 0, 0, game_width/2, game_height)
    love.graphics.setLineWidth(4)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.line(game_width/2, 0, game_width/2, game_height)

    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(market_sign, game_width/2 + game_width/4 - 300*sx, 50*sy, 0, sx, sy)

    love.graphics.setColor(colorYRed)
    love.graphics.rectangle('fill', game_width/2 + game_width/4 - 250*sx, 280*sy, 500*sx, 600*sy)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.rectangle('line', game_width/2 + game_width/4 - 250*sx, 280*sy, 500*sx, 600*sy)

    buyHorsesBtn:render(game_width/2 + game_width/4 - 150*sx, 370*sy, true)
    sellHorsesBtn:render(game_width/2 + game_width/4 - 150*sx, 520*sy, true)
    studdingBtn:render(game_width/2 + game_width/4 - 150*sx, 670*sy, true)

    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(shop_logo, 50*sx, 380*sy, 0, 0.3*sx, 0.3*sy)
    enterShopBtn:render(game_width/2 - game_width/4 - 183*sx, 520*sy, true)
end

function renderMarketHorses()
    local game_width = love.graphics.getWidth()
    local game_height = love.graphics.getHeight()

    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(pattern_background, 0, 0, 0, sx, sy)
    love.graphics.setColor(colorYRed)
    love.graphics.rectangle('fill', game_width/2 - 150*sx, 40*sy, 300*sx, 80*sy)
    love.graphics.setLineWidth(4)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.rectangle('line', game_width/2 - 150*sx, 40*sy, 300*sx, 80*sy)
    love.graphics.setColor(colorGoldenrod)
    local headingText = love.graphics.newText(bigger_font, "TODAY'S HORSES")
    love.graphics.setFont(bigger_font)
    love.graphics.print("TODAY'S HORSES", game_width/2 - headingText:getWidth()/2, 50*sy)


    love.graphics.setColor(colorYRed)
    love.graphics.rectangle('fill', 100*sx, 150*sy, 500*sx, 840*sy)
    love.graphics.setLineWidth(4)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.rectangle('line', 100*sx, 150*sy, 500*sx, 840*sy)

    love.graphics.setColor(colorYRed)
    love.graphics.rectangle('fill', 700*sx, 150*sy, 500*sx, 840*sy)
    love.graphics.setLineWidth(4)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.rectangle('line', 700*sx, 150*sy, 500*sx, 840*sy)

    love.graphics.setColor(colorYRed)
    love.graphics.rectangle('fill', 1300*sx, 150*sy, 500*sx, 840*sy)
    love.graphics.setLineWidth(4)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.rectangle('line', 1300*sx, 150*sy, 500*sx, 840*sy)

    love.graphics.setColor(1,1,1,1)

    if horsesForBuying[1] ~= nil then
        horsesForBuying[1]:render(140*sx, 190*sy, 0.5, 0.5)
        horsesForBuying[1]:displayBuyingInfo(1)
        love.graphics.setColor(1,1,1,1)
        if playerCoins >= buyingPrice1 then
            buyHorse1:render(290*sx, game_height - 215*sy, true)
        else
            buyHorse1:render(290*sx, game_height - 215*sy, false)
        end
    end
    if horsesForBuying[2] ~= nil then
        horsesForBuying[2]:render(740*sx, 190*sy, 0.5, 0.5)
        horsesForBuying[2]:displayBuyingInfo(2)
        love.graphics.setColor(1,1,1,1)
        if playerCoins >= buyingPrice2 then
            buyHorse2:render(890*sx, game_height - 215*sy, true)
        else
            buyHorse2:render(890*sx, game_height - 215*sy, false)
        end
    end
    if horsesForBuying[3] ~= nil then
        horsesForBuying[3]:render(1340*sx, 190*sy, 0.5, 0.5)
        horsesForBuying[3]:displayBuyingInfo(3)
        love.graphics.setColor(1,1,1,1)
        if playerCoins >= buyingPrice3 then
            buyHorse3:render(1490*sx, game_height - 215*sy, true)
        else
            buyHorse3:render(1490*sx, game_height - 215*sy, false)
        end
    end
end

function renderHorsesForSale()
    local game_width = love.graphics.getWidth()
    local game_height = love.graphics.getHeight()

    horsesForSale = {}

    for k, stable in ipairs(user_stables.stables) do
        if stable.horse ~= nil then
            if stable.horse.age_y >= 2 and stable.horse.effects[1] == false and stable.horse.health == 100
            and stable.horse.preg == -1 and stable.horse.foal == nil then
                horsesForSale[#horsesForSale + 1] = stable.horse
            end
        end
    end

    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(pattern_background, 0, 0, 0, sx, sy)
    love.graphics.setColor(colorYRed)
    love.graphics.rectangle('fill', game_width/2 - 170*sx, 40*sy, 340*sx, 80*sy)
    love.graphics.setLineWidth(4)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.rectangle('line', game_width/2 - 170*sx, 40*sy, 340*sx, 80*sy)
    love.graphics.setColor(colorGoldenrod)
    local headingText = love.graphics.newText(bigger_font, "HORSES FOR SALE")
    love.graphics.setFont(bigger_font)
    love.graphics.print("HORSES FOR SALE", game_width/2 - headingText:getWidth()/2, 50*sy)


    love.graphics.setColor(colorYRed)
    love.graphics.rectangle('fill', 100*sx, 150*sy, 500*sx, 840*sy)
    love.graphics.setLineWidth(4)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.rectangle('line', 100*sx, 150*sy, 500*sx, 840*sy)

    love.graphics.setColor(colorYRed)
    love.graphics.rectangle('fill', 700*sx, 150*sy, 500*sx, 840*sy)
    love.graphics.setLineWidth(4)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.rectangle('line', 700*sx, 150*sy, 500*sx, 840*sy)

    love.graphics.setColor(colorYRed)
    love.graphics.rectangle('fill', 1300*sx, 150*sy, 500*sx, 840*sy)
    love.graphics.setLineWidth(4)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.rectangle('line', 1300*sx, 150*sy, 500*sx, 840*sy)

    love.graphics.setColor(1,1,1,1)

    if horsesForSale[3*(salesPageOpen - 1) + 1] ~= nil then
        local name1 = horsesForSale[3*(salesPageOpen - 1) + 1].name
        local nameText1 = love.graphics.newText(medium_font, name1)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.setFont(medium_font)
        love.graphics.print(name1, 350*sx - nameText1:getWidth()/2, 160*sy)
        love.graphics.setColor(1,1,1,1)
        horsesForSale[3*(salesPageOpen - 1) + 1]:render(140*sx, 190*sy, 0.5, 0.5)
        horsesForSale[3*(salesPageOpen - 1) + 1]:displayBuyingInfo(1)
        love.graphics.setColor(1,1,1,1)
        sellHorse1:render(290*sx, game_height - 215*sy, true)
    end
    if horsesForSale[3*(salesPageOpen - 1) + 2] ~= nil then
        local name2 = horsesForSale[3*(salesPageOpen - 1) + 2].name
        local nameText2 = love.graphics.newText(medium_font, name2)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.setFont(medium_font)
        love.graphics.print(name2, 950*sx - nameText2:getWidth()/2, 160*sy)
        love.graphics.setColor(1,1,1,1)
        horsesForSale[3*(salesPageOpen - 1) + 2]:render(740*sx, 190*sy, 0.5, 0.5)
        horsesForSale[3*(salesPageOpen - 1) + 2]:displayBuyingInfo(2)
        love.graphics.setColor(1,1,1,1)
        sellHorse2:render(890*sx, game_height - 215*sy, true)
    end
    if horsesForSale[3*(salesPageOpen - 1) + 3] ~= nil then
        local name3 = horsesForSale[3*(salesPageOpen - 1) + 3].name
        local nameText3 = love.graphics.newText(medium_font, name3)
        love.graphics.setFont(medium_font)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print(name3, 1550*sx - nameText3:getWidth()/2, 160*sy)
        love.graphics.setColor(1,1,1,1)
        horsesForSale[3*(salesPageOpen - 1) + 3]:render(1340*sx, 190*sy, 0.5, 0.5)
        horsesForSale[3*(salesPageOpen - 1) + 3]:displayBuyingInfo(3)
        love.graphics.setColor(1,1,1,1)
        sellHorse3:render(1490*sx, game_height - 215*sy, true)
    end

    if #horsesForSale - 3*salesPageOpen > 0 then
        nextArrow:render(game_width - 90*sx, game_height/2 - 25*sy, true)
    end
    if salesPageOpen > 1 then
        prevArrow:render(20*sx, game_height/2 - 25*sy, true)
    end
end

function sellHorseDialog()
    local game_width = love.graphics.getWidth()
    local game_height = love.graphics.getHeight()

    love.graphics.setColor(colorYRed)
    love.graphics.rectangle('fill', game_width/2 - 315*sx, 200*sy, 630*sx, 150*sy)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.rectangle('line', game_width/2 - 315*sx, 200*sy, 630*sx, 150*sy)

    love.graphics.print("Are you sure you want to sell this horse?", game_width/2 - 290*sx, 210*sy)

    yes:render(game_width/2 - 100*sx, 280*sy, true)
    no:render(game_width/2 + 30*sx, 280*sy, true)
end

function renderHorsesForSale()
    local game_width = love.graphics.getWidth()
    local game_height = love.graphics.getHeight()

    horsesForSale = {}

    for k, stable in ipairs(user_stables.stables) do
        if stable.horse ~= nil then
            if stable.horse.age_y >= 2 and stable.horse.effects[1] == false and stable.horse.health == 100
            and stable.horse.preg == -1 and stable.horse.foal == nil then
                horsesForSale[#horsesForSale + 1] = stable.horse
            end
        end
    end

    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(pattern_background, 0, 0, 0, sx, sy)
    love.graphics.setColor(colorYRed)
    love.graphics.rectangle('fill', game_width/2 - 170*sx, 40*sy, 340*sx, 80*sy)
    love.graphics.setLineWidth(4)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.rectangle('line', game_width/2 - 170*sx, 40*sy, 340*sx, 80*sy)
    love.graphics.setColor(colorGoldenrod)
    local headingText = love.graphics.newText(bigger_font, "HORSES FOR SALE")
    love.graphics.setFont(bigger_font)
    love.graphics.print("HORSES FOR SALE", game_width/2 - headingText:getWidth()/2, 50*sy)


    love.graphics.setColor(colorYRed)
    love.graphics.rectangle('fill', 100*sx, 150*sy, 500*sx, 840*sy)
    love.graphics.setLineWidth(4)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.rectangle('line', 100*sx, 150*sy, 500*sx, 840*sy)

    love.graphics.setColor(colorYRed)
    love.graphics.rectangle('fill', 700*sx, 150*sy, 500*sx, 840*sy)
    love.graphics.setLineWidth(4)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.rectangle('line', 700*sx, 150*sy, 500*sx, 840*sy)

    love.graphics.setColor(colorYRed)
    love.graphics.rectangle('fill', 1300*sx, 150*sy, 500*sx, 840*sy)
    love.graphics.setLineWidth(4)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.rectangle('line', 1300*sx, 150*sy, 500*sx, 840*sy)

    love.graphics.setColor(1,1,1,1)

    if horsesForSale[3*(salesPageOpen - 1) + 1] ~= nil then
        local name1 = horsesForSale[3*(salesPageOpen - 1) + 1].name
        local nameText1 = love.graphics.newText(medium_font, name1)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.setFont(medium_font)
        love.graphics.print(name1, 350*sx - nameText1:getWidth()/2, 160*sy)
        love.graphics.setColor(1,1,1,1)
        horsesForSale[3*(salesPageOpen - 1) + 1]:render(140*sx, 190*sy, 0.5, 0.5)
        horsesForSale[3*(salesPageOpen - 1) + 1]:displayBuyingInfo(1)
        love.graphics.setColor(1,1,1,1)
        sellHorse1:render(290*sx, game_height - 215*sy, true)
    end
    if horsesForSale[3*(salesPageOpen - 1) + 2] ~= nil then
        local name2 = horsesForSale[3*(salesPageOpen - 1) + 2].name
        local nameText2 = love.graphics.newText(medium_font, name2)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.setFont(medium_font)
        love.graphics.print(name2, 950*sx - nameText2:getWidth()/2, 160*sy)
        love.graphics.setColor(1,1,1,1)
        horsesForSale[3*(salesPageOpen - 1) + 2]:render(740*sx, 190*sy, 0.5, 0.5)
        horsesForSale[3*(salesPageOpen - 1) + 2]:displayBuyingInfo(2)
        love.graphics.setColor(1,1,1,1)
        sellHorse2:render(890*sx, game_height - 215*sy, true)
    end
    if horsesForSale[3*(salesPageOpen - 1) + 3] ~= nil then
        local name3 = horsesForSale[3*(salesPageOpen - 1) + 3].name
        local nameText3 = love.graphics.newText(medium_font, name3)
        love.graphics.setFont(medium_font)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print(name3, 1550*sx - nameText3:getWidth()/2, 160*sy)
        love.graphics.setColor(1,1,1,1)
        horsesForSale[3*(salesPageOpen - 1) + 3]:render(1340*sx, 190*sy, 0.5, 0.5)
        horsesForSale[3*(salesPageOpen - 1) + 3]:displayBuyingInfo(3)
        love.graphics.setColor(1,1,1,1)
        sellHorse3:render(1490*sx, game_height - 215*sy, true)
    end

    if #horsesForSale - 3*salesPageOpen > 0 then
        nextArrow:render(game_width - 90*sx, game_height/2 - 25*sy, true)
    end
    if salesPageOpen > 1 then
        prevArrow:render(20*sx, game_height/2 - 25*sy, true)
    end
end

function renderMyStuds()
    local game_width = love.graphics.getWidth()
    local game_height = love.graphics.getHeight()

    myStuds = {}

    for k, stable in ipairs(user_stables.stables) do
        if stable.horse ~= nil then
            if stable.horse.age_y >= 2 and stable.horse.effects[1] == false and stable.horse.health == 100
            and stable.horse.gender == "m" then
                myStuds[#myStuds + 1] = stable.horse
            end
        end
    end

    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(pattern_background, 0, 0, 0, sx, sy)
    
    myStudsTab:render(game_width/2 - 500*sx, 25*sy, true)
    sotdTab:render(game_width/2 + 50*sx, 25*sy, true)

    love.graphics.setColor(colorYRed)
    love.graphics.rectangle('fill', 100*sx, 150*sy, 500*sx, 840*sy)
    love.graphics.setLineWidth(4)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.rectangle('line', 100*sx, 150*sy, 500*sx, 840*sy)

    love.graphics.setColor(colorYRed)
    love.graphics.rectangle('fill', 700*sx, 150*sy, 500*sx, 840*sy)
    love.graphics.setLineWidth(4)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.rectangle('line', 700*sx, 150*sy, 500*sx, 840*sy)

    love.graphics.setColor(colorYRed)
    love.graphics.rectangle('fill', 1300*sx, 150*sy, 500*sx, 840*sy)
    love.graphics.setLineWidth(4)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.rectangle('line', 1300*sx, 150*sy, 500*sx, 840*sy)

    love.graphics.setColor(1,1,1,1)

    if myStuds[3*(studsPageOpen - 1) + 1] ~= nil then
        local name1 = myStuds[3*(studsPageOpen - 1) + 1].name
        local nameText1 = love.graphics.newText(medium_font, name1)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.setFont(medium_font)
        love.graphics.print(name1, 350*sx - nameText1:getWidth()/2, 160*sy)
        love.graphics.setColor(1,1,1,1)
        myStuds[3*(studsPageOpen - 1) + 1]:render(140*sx, 210*sy, 0.5, 0.5)
        myStuds[3*(studsPageOpen - 1) + 1]:displayStuddingInfo(true, 1)
        love.graphics.setColor(1,1,1,1)
        if myStuds[3*(studsPageOpen - 1) + 1].energy >= 25 then
            studHorse1:render(200*sx, game_height - 200*sy, true)
        else
            studHorse1:render(200*sx, game_height - 200*sy, false)
        end
    end
    if myStuds[3*(studsPageOpen - 1) + 2] ~= nil then
        local name2 = myStuds[3*(studsPageOpen - 1) + 2].name
        local nameText2 = love.graphics.newText(medium_font, name2)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.setFont(medium_font)
        love.graphics.print(name2, 950*sx - nameText2:getWidth()/2, 160*sy)
        love.graphics.setColor(1,1,1,1)
        myStuds[3*(studsPageOpen - 1) + 2]:render(740*sx, 210*sy, 0.5, 0.5)
        myStuds[3*(studsPageOpen - 1) + 2]:displayStuddingInfo(true, 2)
        love.graphics.setColor(1,1,1,1)
        if myStuds[3*(studsPageOpen - 1) + 1].energy >= 25 then
            studHorse2:render(800*sx, game_height - 200*sy, true)
        else
            studHorse2:render(800*sx, game_height - 200*sy, false)
        end
    end
    if myStuds[3*(studsPageOpen - 1) + 3] ~= nil then
        local name3 = myStuds[3*(studsPageOpen - 1) + 3].name
        local nameText3 = love.graphics.newText(medium_font, name3)
        love.graphics.setFont(medium_font)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print(name3, 1550*sx - nameText3:getWidth()/2, 160*sy)
        love.graphics.setColor(1,1,1,1)
        myStuds[3*(studsPageOpen - 1) + 3]:render(1340*sx, 210*sy, 0.5, 0.5)
        myStuds[3*(studsPageOpen - 1) + 3]:displayStuddingInfo(true, 3)
        love.graphics.setColor(1,1,1,1)
        if myStuds[3*(studsPageOpen - 1) + 1].energy >= 25 then
            studHorse3:render(1400*sx, game_height - 200*sy, true)
        else
            studHorse3:render(1400*sx, game_height - 200*sy, false)
        end
    end

    if #myStuds - 3*studsPageOpen > 0 then
        nextArrow:render(game_width - 90*sx, game_height/2 - 25*sy, true)
    end
    if studsPageOpen > 1 then
        prevArrow:render(20*sx, game_height/2 - 25*sy, true)
    end
end

function renderStudOfTheDay()
    local game_width = love.graphics.getWidth()
    local game_height = love.graphics.getHeight()

    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(pattern_background, 0, 0, 0, sx, sy)

    myStudsTab:render(game_width/2 - 500*sx, 25*sy, true)
    sotdTab:render(game_width/2 + 50*sx, 25*sy, true)

    love.graphics.setColor(colorYRed)
    love.graphics.rectangle('fill', 100*sx, 150*sy, 900*sx, 840*sy)
    love.graphics.setLineWidth(4)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.rectangle('line', 100*sx, 150*sy, 900*sx, 840*sy)

    love.graphics.setColor(colorYRed)
    love.graphics.rectangle('fill', game_width/2 + 100*sx, 150*sy, 700*sx, 840*sy)
    love.graphics.setLineWidth(4)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.rectangle('line', game_width/2 + 100*sx, 150*sy, 700*sx, 840*sy)

    love.graphics.setColor(1,1,1,1)
    studOfTheDay:render(170*sx, 210*sy, 0.9, 0.9)
    studOfTheDay:displayStuddingInfo(false, 1)
    love.graphics.setColor(1,1,1,1)
    if studdingBought == false and playerCoins >= studPrice then
        buyStudding:render(game_width/2 + 300*sx, game_height - 210*sy, true)
    else
        buyStudding:render(game_width/2 + 300*sx, game_height - 210*sy, false)
    end
end

function renderGeneticTest()
    local game_width = love.graphics.getWidth()
    local game_height = love.graphics.getHeight()

    allHorses = {}

    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(med_background, 0, 0, 0, sx, sy)

    love.graphics.setColor(colorYRed)
    love.graphics.rectangle('fill', 100*sx, 150*sy, 900*sx, 840*sy)
    love.graphics.setLineWidth(4)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.rectangle('line', 100*sx, 150*sy, 900*sx, 840*sy)

    love.graphics.setColor(colorYRed)
    love.graphics.rectangle('fill', game_width/2 + 100*sx, 150*sy, 700*sx, 840*sy)
    love.graphics.setLineWidth(4)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.rectangle('line', game_width/2 + 100*sx, 150*sy, 700*sx, 840*sy)

    for k, stable in ipairs(user_stables.stables) do
        if stable.horse ~= nil then
            allHorses[#allHorses + 1] = stable.horse
        end
    end

    allHorses[geneticsPage]:render(170*sx, 210*sy, 0.9, 0.9)

    if allHorses[geneticsPage].tested == true then
        local ext, ag, gr, cr_prl, dun, ch, fl, sil, sty, rb, rn, sab, wh, to, ov, spl, lp, patn1, patn2
        if allHorses[geneticsPage].genes[EXTENSION] == 11 then
            ext = "E-E"
        elseif allHorses[geneticsPage].genes[EXTENSION] == 10 then
            ext = "E-e"
        else
            ext = "e-e"
        end
        if allHorses[geneticsPage].genes[AGOUTI] == 11 then
            ag = "At-At"
        elseif allHorses[geneticsPage].genes[AGOUTI] == 10 then
            ag = "At-a"
        elseif allHorses[geneticsPage].genes[AGOUTI] == 21 then
            ag = "A-At"
        elseif allHorses[geneticsPage].genes[AGOUTI] == 20 then
            ag = "A-a"
        elseif allHorses[geneticsPage].genes[AGOUTI] == 22 then
            ag = "A-A"
        else
            ag = "a-a"
        end
        if allHorses[geneticsPage].genes[GREY] == 11 then
            gr = "G-G"
        elseif allHorses[geneticsPage].genes[GREY] == 10 then
            gr = "G-g"
        else
            gr = "g-g"
        end
        if allHorses[geneticsPage].genes[CREAM_PEARL] == 11 then
            cr_prl = "prl-prl"
        elseif allHorses[geneticsPage].genes[CREAM_PEARL] == 10 then
            cr_prl = "prl-cr"
        elseif allHorses[geneticsPage].genes[CREAM_PEARL] == 21 then
            cr_prl = "Cr-prl"
        elseif allHorses[geneticsPage].genes[CREAM_PEARL] == 20 then
            cr_prl = "Cr-cr"
        elseif allHorses[geneticsPage].genes[CREAM_PEARL] == 22 then
            cr_prl = "Cr-Cr"
        else
            cr_prl = "cr-cr"
        end
        if allHorses[geneticsPage].genes[DUN] == 11 then
            dun = "D-D"
        elseif allHorses[geneticsPage].genes[DUN] == 10 then
            dun = "D-d"
        else
            dun = "d-d"
        end
        if allHorses[geneticsPage].genes[CHAMPAGNE] == 11 then
            ch = "Ch-Ch"
        elseif allHorses[geneticsPage].genes[CHAMPAGNE] == 10 then
            ch = "Ch-ch"
        else
            ch = "ch-ch"
        end
        if allHorses[geneticsPage].genes[FLAXEN] == 11 then
            fl = "F-F"
        elseif allHorses[geneticsPage].genes[FLAXEN] == 10 then
            fl = "F-f"
        else
            fl = "f-f"
        end
        if allHorses[geneticsPage].genes[SILVER] == 11 then
            sil = "Z-Z"
        elseif allHorses[geneticsPage].genes[SILVER] == 10 then
            sil = "Z-z"
        else
            sil = "z-z"
        end
        if allHorses[geneticsPage].genes[SOOTY] == 11 then
            sty = "STY-STY"
        elseif allHorses[geneticsPage].genes[SOOTY] == 10 then
            sty = "STY-sty"
        else
            sty = "sty-sty"
        end
        if allHorses[geneticsPage].genes[RABICANO] == 11 then
            rb = "Rb-Rb"
        elseif allHorses[geneticsPage].genes[RABICANO] == 10 then
            rb = "Rb-rb"
        else
            rb = "rb-rb"
        end
        if allHorses[geneticsPage].genes[ROAN] == 11 then
            rn = "Rn-Rn"
        elseif allHorses[geneticsPage].genes[ROAN] == 10 then
            rn = "Rn-rn"
        else
            rn = "rn-rn"
        end
        if allHorses[geneticsPage].genes[SABINO] == 11 then
            sab = "Sb1-Sb1"
        elseif allHorses[geneticsPage].genes[SABINO] == 10 then
            sab = "Sb1-sb1"
        else
            sab = "sb1-sb1"
        end
        if allHorses[geneticsPage].genes[DOMINANT_WHITE] == 11 then
            wh = "W-W"
        elseif allHorses[geneticsPage].genes[DOMINANT_WHITE] == 10 then
            wh = "W-w"
        else
            wh = "w-w"
        end
        if allHorses[geneticsPage].genes[TOBIANO] == 11 then
            to = "To-To"
        elseif allHorses[geneticsPage].genes[TOBIANO] == 10 then
            to = "To-to"
        else
            to = "to-to"
        end
        if allHorses[geneticsPage].genes[LETHAL_WHITE_OVERO] == 11 then
            ov = "O-O"
        elseif allHorses[geneticsPage].genes[LETHAL_WHITE_OVERO] == 10 then
            ov = "O-o"
        else
            ov = "o-o"
        end
        if allHorses[geneticsPage].genes[SPLASHED_WHITE] == 11 then
            spl = "SPL-SPL"
        elseif allHorses[geneticsPage].genes[SPLASHED_WHITE] == 10 then
            spl = "SPL-spl"
        else
            spl = "spl-spl"
        end
        if allHorses[geneticsPage].genes[LEOPARD] == 11 then
            lp = "Lp-Lp"
        elseif allHorses[geneticsPage].genes[LEOPARD] == 10 then
            lp = "Lp-lp"
        else
            lp = "lp-lp"
        end
        if allHorses[geneticsPage].genes[PATTERN_1] == 11 then
            patn1 = "PATN1-PATN1"
        elseif allHorses[geneticsPage].genes[PATTERN_1] == 10 then
            patn1 = "PATN1-patn1"
        else
            patn1 = "patn1-patn1"
        end
        if allHorses[geneticsPage].genes[PATTERN_2] == 11 then
            patn2 = "PATN2-PATN2"
        elseif allHorses[geneticsPage].genes[PATTERN_2] == 10 then
            patn2 = "PATN2-patn2"
        else
            patn2 = "patn2-patn2"
        end

        love.graphics.setColor(colorGoldenrod)
        love.graphics.setFont(bigger_font)
        love.graphics.print("Extension (black/red): " .. ext, game_width/2 + 140*sx, 180*sy, 0, sx, sy)
        love.graphics.print("Agouti/bay: " .. ag, game_width/2 + 140*sx, 220*sy, 0, sx, sy)
        love.graphics.print("Grey: " .. gr, game_width/2 + 140*sx, 260*sy, 0, sx, sy)
        love.graphics.print("Cream/pearl: " .. cr_prl, game_width/2 + 140*sx, 300*sy, 0, sx, sy)
        love.graphics.print("Dun: " .. dun, game_width/2 + 140*sx, 340*sy, 0, sx, sy)
        love.graphics.print("Champagne: " .. ch, game_width/2 + 140*sx, 380*sy, 0, sx, sy)
        love.graphics.print("Flaxen: " .. fl, game_width/2 + 140*sx, 420*sy, 0, sx, sy)
        love.graphics.print("Silver: " .. sil, game_width/2 + 140*sx, 460*sy, 0, sx, sy)
        love.graphics.print("Sooty: " .. sty, game_width/2 + 140*sx, 500*sy, 0, sx, sy)
        love.graphics.print("Rabicano: " .. rb, game_width/2 + 140*sx, 540*sy, 0, sx, sy)
        love.graphics.print("Roan: " .. rn, game_width/2 + 140*sx, 580*sy, 0, sx, sy)
        love.graphics.print("Sabino: " .. sab, game_width/2 + 140*sx, 620*sy, 0, sx, sy)
        love.graphics.print("Dominant white: " .. wh, game_width/2 + 140*sx, 660*sy, 0, sx, sy)
        love.graphics.print("Tobiano: " .. to, game_width/2 + 140*sx, 700*sy, 0, sx, sy)
        love.graphics.print("Overo: " .. ov, game_width/2 + 140*sx, 740*sy, 0, sx, sy)
        love.graphics.print("Splashed white: " .. spl, game_width/2 + 140*sx, 780*sy, 0, sx, sy)
        love.graphics.print("Leopard complex spotting: " .. lp, game_width/2 + 140*sx, 820*sy, 0, sx, sy)
        if lp ~= "lp-lp" then
            love.graphics.print("LP pattern 1: " .. patn1, game_width/2 + 140*sx, 860*sy, 0, sx, sy)
            love.graphics.print("LP pattern 2: " .. patn2, game_width/2 + 140*sx, 900*sy, 0, sx, sy)
        end
    else
        if playerCoins >= 250 then
            orderTest:render(game_width/2 + 300*sx, 500*sy, true)
        else
            orderTest:render(game_width/2 + 300*sx, 500*sy, false)
        end
        love.graphics.setFont(bigger_font)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print("250", game_width/2 + 400*sx, 560*sy, 0, sx, sy)
        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(coin_icon, game_width/2 + 470*sx, 565*sy, 0, 0.7, 0.7)
    end


    if #allHorses > geneticsPage then
        nextArrow:render(game_width/2 + 460*sx, game_height - 80*sy, true)
    end
    if geneticsPage > 1 then
        prevArrow:render(game_width/2 + 380*sx, game_height - 80*sy, true)
    end
end

function newLoadExitGameDialog()
    local game_width = love.graphics.getWidth()
    local game_height = love.graphics.getHeight()

    love.graphics.setColor(colorYRed)
    love.graphics.rectangle('fill', game_width/2 - 315*sx, 400*sy, 630*sx, 150*sy)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.rectangle('line', game_width/2 - 315*sx, 400*sy, 630*sx, 150*sy)
    love.graphics.setFont(smaller_font)

    love.graphics.print("Are you sure? Your current game won't be saved.", game_width/2 - 270*sx, 420*sy)

    yes:render(game_width/2 - 100*sx, 480*sy, true)
    no:render(game_width/2 + 30*sx, 480*sy, true)
end