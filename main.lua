Class = require 'class'
push = require 'push'

require 'Horse'
require 'Button'
require 'Util'
require 'TSerial'
require 'Map'
require 'Stable'
require 'Stables'
require 'Variables'
require 'Inventory'
require 'Cell'
require 'Lake'
require 'Quest'
require 'Shop'

WINDOW_WIDTH = 1600
WINDOW_HEIGHT = 900

local utf8 = require("utf8")

game_width = love.graphics.getWidth()
game_height = love.graphics.getHeight()

local next_bit = math.random(0.5, 3)
local time = 0

function love.load()

    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = true,
        vsync = 0
    })

    bg_music = love.audio.newSource("sounds/Livio Amato - Fairy Tale.mp3", "stream")
    lake_bg_sounds = love.audio.newSource("sounds/water_loch_ness_ambience_small_waves_lap_distant_traffic_scotland.mp3", "stream")
    fish_bit = love.audio.newSource("sounds/zapsplat_foley_liquid_water_blow_bubble_single_plastic_container_002_51593.mp3", "static")
    click_sound = love.audio.newSource("sounds/zapsplat_technology_studio_speaker_active_power_switch_click_003_68875.mp3", "static")
    fish_bit:setLooping(false)
    click_sound:setLooping(false)
    click_sound:setVolume(0.5)
    lake_bg_sounds:setVolume(0.6)
    fish_bit:setVolume(1.3)
    
    sx = love.graphics.getWidth() / menu_background:getWidth()
    sy = love.graphics.getHeight() / menu_background:getHeight()

    love.graphics.setFont(love.graphics.newFont('Curse Casual.ttf', 40))

    map = Map()
    user_stables = Stables(4, 0)
    playerInventory = Inventory(nil)
    lake_mg = Lake("idle")
    shop = Shop()

    love.window.setTitle('Horses of Lake Valley')

    math.randomseed(os.time())

    love.keyboard.setKeyRepeat(true)

    game_mode = modes[1]
    notification = windows[1]
    currently_playing = false
    name_window_open = false
    place_window_open = false
    buying_confirmation = false
    inventory_open = false
    changing_spec = false
    choosing_equipment = false
    selling_confirmation = false
    spec_equipment = ""
    name_text = ""
    event_type = ""
    event_tier = ""
    event = ""

    availableForTraining = {}
    availableForCompeting = {}
    availableMales = {}
    availableFemales = {}
    myStuds = {}
    deadHorses = {}
    bornFoals = {}
    grownFoals = {}
    openedNotif = 0
    currentGrowing = 1
    trainingPagesNumber = 1
    trainingPageOpen = 1
    competingPagesNumber = 1
    competingPageOpen = 1
    treatmentPage = 1
    salesPageOpen = 1
    studsPageOpen = 1
    subjectPage = 1
    geneticsPage = 1
    myStudsOpen = true
    studdingBought = false
    paidStudOpen = false
    questDialogOpen = false
    questTestSubjectsOpen = false
    kelpieToBe = nil
    savingNotif = false
    newGameDialog = false
    loadGameDialog = false
    exitGameDialog = false
    musicPlaying = true
    credits = false

    pair_to_render = 1
    playerCoins = 0
    dayOfPlaying = 1
    breeding_page_m = 1
    breeding_page_f = 1
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.textinput(t)
    if #name_text < 15 then
        name_text = name_text .. t
    end
end

function love.mousepressed(x, y, key)
    local game_width = love.graphics.getWidth()
    local game_height = love.graphics.getHeight()
    --main menu
    if game_mode == modes[1] then
        if newGameDialog == false and loadGameDialog == false and exitGameDialog == false then
            if new_game_button.mouseIn == true and key == 1 then
                click_sound:play()
                if currently_playing == false then
                    game_mode = modes[3]
                    user_stables.stables[1]:setHorse(Horse:generateGender("m"))
                    user_stables.stables[2]:setHorse(Horse:generateGender("f"))
                    playerCoins = 500
                    playerInventory = Inventory({0, 0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0,
                    0})
                    currently_playing = true
                    horsesForBuying = {}
                    horsesForBuying[1] = Horse:generateHorseToBuy(true)
                    horsesForBuying[2] = Horse:generateHorseToBuy(true)
                    horsesForBuying[3] = Horse:generateHorseToBuy(true)
                    studOfTheDay = Horse:generateStudOfTheDay(true)
                    quest = Quest(0)
                else
                    newGameDialog = true
                end
            elseif load_game_button.mouseIn == true and key == 1 then
                click_sound:play()
                if currently_playing == false then
                    loadExistingStables()
                    game_mode = modes[3]
                    currently_playing = true
                    if musicPlaying == false then
                        bg_music:setVolume(0)
                        lake_bg_sounds:setVolume(0)
                        fish_bit:setVolume(0)
                        click_sound:setVolume(0)
                    end
                else
                    loadGameDialog = true
                end
            elseif currently_playing == true and resume_game_button.mouseIn == true and key == 1 then
                click_sound:play()
                game_mode = modes[3]
            elseif currently_playing == true and save_game_button.mouseIn == true and key == 1 then
                click_sound:play()
                saveGame(user_stables)
                savingNotif = true
                time = 0
            elseif exit_button.mouseIn == true and key == 1 then
                click_sound:play()
                if currently_playing == false then
                    time = 0
                    credits = true
                else
                    exitGameDialog = true
                end
            end
        elseif newGameDialog == true then
            if yes.mouseIn == true and key == 1 then
                click_sound:play()
                newGameDialog = false
                game_mode = modes[3]
                user_stables.stables[1]:setHorse(Horse:generateGender("m"))
                user_stables.stables[2]:setHorse(Horse:generateGender("f"))
                playerCoins = 500
                playerInventory = Inventory({0, 0, 0, 0, 0, 0, 0, 0, 0,
                0, 0, 0, 0, 0, 0, 0, 0, 0,
                0, 0, 0, 0, 0, 0, 0, 0, 0,
                0, 0, 0,
                0, 0, 0, 0, 0, 0, 0, 0,
                0})
                currently_playing = true
                horsesForBuying = {}
                horsesForBuying[1] = Horse:generateHorseToBuy(true)
                horsesForBuying[2] = Horse:generateHorseToBuy(true)
                horsesForBuying[3] = Horse:generateHorseToBuy(true)
                studOfTheDay = Horse:generateStudOfTheDay(true)
                quest = Quest(0)
            elseif no.mouseIn == true and key == 1 then
                click_sound:play()
                newGameDialog = false
            end
        elseif loadGameDialog == true then
            if yes.mouseIn == true and key == 1 then
                click_sound:play()
                loadGameDialog = false
                loadExistingStables()
                game_mode = modes[3]
                currently_playing = true
                if musicPlaying == false then
                    bg_music:setVolume(0)
                    lake_bg_sounds:setVolume(0)
                    fish_bit:setVolume(0)
                    click_sound:setVolume(0)
                end
            elseif no.mouseIn == true and key == 1 then
                click_sound:play()
                loadGameDialog = false
            end
        elseif exitGameDialog == true then
            if yes.mouseIn == true and key == 1 then
                click_sound:play()
                exitGameDialog = false
                time = 0
                credits = true
            elseif no.mouseIn == true and key == 1 then
                click_sound:play()
                exitGameDialog = false
            end
        end
    -- map
    elseif game_mode == modes[3] then
        if inventory_open == false then
            if questDialogOpen == false then
                if notification == windows[1] then
                    if map.stables_mouseIn == true and key == 1 then
                        click_sound:play()
                        game_mode = modes[4]
                        pair_to_render = 1
                    elseif map.training_mouseIn == true and key == 1 then
                        click_sound:play()
                        game_mode = modes[8]
                        event = "training"
                    elseif map.competitions_mouseIn == true and key == 1 then
                        click_sound:play()
                        game_mode = modes[8]
                        event = "competing"
                    elseif map.medical_mouseIn == true and key == 1 then
                        click_sound:play()
                        game_mode = modes[6]
                    elseif map.shop_mouseIn == true and key == 1 then
                        click_sound:play()
                        game_mode = modes[7]
                    elseif map.lake_mouseIn == true and key == 1 then
                        click_sound:play()
                        game_mode = modes[10]
                        next_bit = math.random(1, 4)
                        time = 0
                    elseif change_day.mouseIn == true and key == 1 then
                        click_sound:play()
                        changeDay()
                    elseif musicPlaying == true and musicBtn1.mouseIn == true and key == 1 then
                        click_sound:play()
                        musicPlaying = false
                        bg_music:setVolume(0)
                        click_sound:setVolume(0)
                        lake_bg_sounds:setVolume(0)
                        fish_bit:setVolume(0)
                    elseif musicPlaying == false and musicBtn2.mouseIn == true and key == 1 then
                        click_sound:play()
                        musicPlaying = true
                        bg_music:setVolume(1)
                        click_sound:setVolume(0.5)
                        lake_bg_sounds:setVolume(0.6)
                        fish_bit:setVolume(1.3)
                    elseif x > game_width - 380*sx and x < game_width - 180*sx and y > game_height/2 - 90*sy
                    and y < game_height/2 + 100*sy and quest.stage ~= 0 then
                        click_sound:play()
                        questDialogOpen = true
                    --[[elseif magic.mouseIn == true and key == 1 then
                        for k, stable in ipairs(user_stables.stables) do
                            if stable.horse ~= nil then
                                stable.clean = true
                                stable.horse.mood = stable.horse.mood + 10
                                if stable.horse.mood > 100 then
                                    stable.horse.mood = 100
                                end
                                stable.horse.needs = {true, true, true}
                            end
                        end]]--
                    end
                else
                    if notification == windows[2] and confirm_notif.mouseIn == true and key == 1 then
                        click_sound:play()
                        if #bornFoals ~= 0 then
                            notification = windows[3]
                        elseif #grownFoals ~= 0 then
                            notification = windows[4]
                        else
                            notification = windows[1]
                        end
                    end
                    if notification == windows[3] and confirm_notif.mouseIn == true and key == 1 then
                        click_sound:play()
                        if #grownFoals == 0 then
                            notification = windows[1]
                        else
                            notification = windows[4]
                        end
                    end
                    if notification == windows[4] and buying_confirmation == false then
                        if sell_foal.mouseIn == true and key == 1 then
                            click_sound:play()
                            playerCoins = playerCoins + 100
                            if #grownFoals > currentGrowing then
                                currentGrowing = currentGrowing + 1
                            else
                                notification = windows[1]
                            end
                        elseif keep_foal.mouseIn == true and key == 1 then
                            click_sound:play()
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
                                freeStable:setHorse(grownFoals[currentGrowing])
                                if #grownFoals > currentGrowing then
                                    currentGrowing = currentGrowing + 1
                                else
                                    notification = windows[1]
                                end
                            else
                                buying_confirmation = true
                            end
                        end
                    elseif notification == windows[4] and buying_confirmation == true then
                        if yes.mouseIn == true and key == 1 and yes.active == true then
                            click_sound:play()
                            playerCoins = playerCoins - 500
                            user_stables:addStable()
                            user_stables.stables[user_stables.number]:setHorse(grownFoals[currentGrowing])
                            buying_confirmation = false
                            if #grownFoals > currentGrowing then
                                currentGrowing = currentGrowing + 1
                            else
                                notification = windows[1]
                            end
                        elseif no.mouseIn == true and key == 1 then
                            click_sound:play()
                            buying_confirmation = false
                        end
                    end
                end
            else
                if questTestSubjectsOpen == false then
                    if quest.stage == 1 and okBtn.mouseIn == true and key == 1 then
                        quest.stage = 2
                    elseif quest.stage == 2 and giveFishBtn.mouseIn == true and giveFishBtn.active == true and key == 1 then
                        playerInventory:removeItem("redfish", 5)
                        playerInventory:removeItem("orangefish", 5)
                        playerInventory:removeItem("yellowfish", 5)
                        playerInventory:removeItem("greenfish", 5)
                        playerInventory:removeItem("turquoisefish", 5)
                        playerInventory:removeItem("bluefish", 5)
                        playerInventory:removeItem("purplefish", 5)
                        quest.stage = 3
                    elseif quest.stage == 3 and okBtn.mouseIn == true and key == 1 then
                        quest.stage = 4
                    elseif quest.stage == 4 and giveFishBtn.mouseIn == true and giveFishBtn.active == true and key == 1 then
                        playerInventory:removeItem("rainbowfish", 5)
                        quest.color = "random"
                        quest.stage = 5
                    elseif quest.stage == 5 and okBtn.mouseIn == true and key == 1 then
                        quest.stage = 6
                    elseif quest.stage == 6 and chooseHorseBtn.mouseIn == true and key == 1 then
                        questTestSubjectsOpen = true
                    elseif quest.stage == 7 or quest.stage == 8 or quest.stage == 9
                    or quest.stage == 13 or quest.stage == 14
                    and okBtn.mouseIn == true and key == 1 then
                        questDialogOpen = false
                        if quest.stage == 8 or quest.stage == 14 then
                            quest.stage = 9
                        end
                    elseif quest.stage == 10 then
                        if kred.mouseIn == true and key == 1 then
                            quest.color = "red"
                            quest.stage = 11
                        elseif korange.mouseIn == true and key == 1 then
                            quest.color = "orange"
                            quest.stage = 11
                        elseif kyellow.mouseIn == true and key == 1 then
                            quest.color = "yellow"
                            quest.stage = 11
                        elseif kgreen.mouseIn == true and key == 1 then
                            quest.color = "green"
                            quest.stage = 11
                        elseif kturquoise.mouseIn == true and key == 1 then
                            quest.color = "turquoise"
                            quest.stage = 11
                        elseif kblue.mouseIn == true and key == 1 then
                            quest.color = "blue"
                            quest.stage = 11
                        elseif kpurple.mouseIn == true and key == 1 then
                            quest.color = "purple"
                            quest.stage = 11
                        end
                    elseif quest.stage == 11 and giveFishBtn.mouseIn == true and giveFishBtn.active == true and key == 1 then
                        playerInventory:removeItem(quest.color .. "fish", 10)
                        playerInventory:removeItem("rainbowfish", 1)
                        quest.stage = 12
                    elseif quest.stage == 12 and chooseHorseBtn.mouseIn == true and key == 1 then
                        questTestSubjectsOpen = true
                    end
                else
                    local subjectNumber = 0
                    if #testSubjects - subjectPage*4 > 0 and nextTestSubjects.mouseIn == true and key == 1 then
                        subjectPage = subjectPage + 1
                    elseif subjectPage > 1 and previousTestSubjects.mouseIn == true and key == 1 then
                        subjectPage = subjectPage - 1
                    elseif testSubjects[4*(subjectPage - 1) + 1] ~= nil and choose1.mouseIn == true and key == 1 then
                        kelpieToBe = testSubjects[4*(subjectPage - 1) + 1]
                        for k, stable in ipairs(user_stables.stables) do
                            if stable.horse == testSubjects[4*(subjectPage - 1) + 1] then
                                subjectNumber = stable.number
                            end
                        end
                        user_stables.stables[subjectNumber]:setEmpty()
                        user_stables:shift()
                        questTestSubjectsOpen = false
                        if quest.stage == 6 then
                            quest.stage = 7
                        elseif quest.stage == 12 then
                            quest.stage = 13
                        end
                    elseif testSubjects[4*(subjectPage - 1) + 2] ~= nil and choose2.mouseIn == true and key == 1 then
                        kelpieToBe = testSubjects[4*(subjectPage - 1) + 2]
                        for k, stable in ipairs(user_stables.stables) do
                            if stable.horse == testSubjects[4*(subjectPage - 1) + 2] then
                                subjectNumber = stable.number
                            end
                        end
                        user_stables.stables[subjectNumber]:setEmpty()
                        user_stables:shift()
                        questTestSubjectsOpen = false
                        if quest.stage == 6 then
                            quest.stage = 7
                        elseif quest.stage == 12 then
                            quest.stage = 13
                        end
                    elseif testSubjects[4*(subjectPage - 1) + 3] ~= nil and choose3.mouseIn == true and key == 1 then
                        kelpieToBe = testSubjects[4*(subjectPage - 1) + 3]
                        for k, stable in ipairs(user_stables.stables) do
                            if stable.horse == testSubjects[4*(subjectPage - 1) + 3] then
                                subjectNumber = stable.number
                            end
                        end
                        user_stables.stables[subjectNumber]:setEmpty()
                        user_stables:shift()
                        questTestSubjectsOpen = false
                        if quest.stage == 6 then
                            quest.stage = 7
                        elseif quest.stage == 12 then
                            quest.stage = 13
                        end
                    elseif testSubjects[4*(subjectPage - 1) + 4] ~= nil and choose4.mouseIn == true and key == 1 then
                        kelpieToBe = testSubjects[4*(subjectPage - 1) + 4]
                        for k, stable in ipairs(user_stables.stables) do
                            if stable.horse == testSubjects[4*(subjectPage - 1) + 4] then
                                subjectNumber = stable.number
                            end
                        end
                        user_stables.stables[subjectNumber]:setEmpty()
                        user_stables:shift()
                        questTestSubjectsOpen = false
                        if quest.stage == 6 then
                            quest.stage = 7
                        elseif quest.stage == 12 then
                            quest.stage = 13
                        end
                    end
                end
            end
        else
            if (playerInventory.pageOpen == 1 or playerInventory.pageOpen == 2) and inv_next_button.mouseIn == true and key == 1 then
                click_sound:play()
                playerInventory.pageOpen = playerInventory.pageOpen + 1
            elseif (playerInventory.pageOpen == 2 or playerInventory.pageOpen == 3) and inv_previous_button.mouseIn == true and key == 1 then
                click_sound:play()
                playerInventory.pageOpen = playerInventory.pageOpen - 1
            elseif close_inventory.mouseIn == true and key == 1 then
                click_sound:play()
                inventory_open = false
                playerInventory.pageOpen = 1
            end
        end
    -- stables
    elseif game_mode == modes[4] then
        if inventory_open == false then
            if x > 0 and x < 960 * sx and y > 0 and y < 790 * sy and key == 1 then
                click_sound:play()
                game_mode = modes[5]
                load_stable = user_stables.stables[2*user_stables.rendered_pair - 1]
                if load_stable.empty == false then
                    name_text = load_stable:getHorseName()
                end
                chosen_saddle = nil
                chosen_bridle = nil
                chosen_pad = nil
            elseif x > 960 * sx and y > 0 and y < 790 * sy and key == 1 and user_stables.rendered_pair*2 <= user_stables.number then
                click_sound:play()
                game_mode = modes[5]
                load_stable = user_stables.stables[2*user_stables.rendered_pair]
                if load_stable.empty == false then
                    name_text = load_stable:getHorseName()
                end
                chosen_saddle = nil
                chosen_bridle = nil
                chosen_pad = nil
            elseif exit_to_map.mouseIn == true and key == 1 then
                click_sound:play()
                game_mode = modes[3]
            elseif user_stables.number > pair_to_render * 2 then
                if next_stables_button.mouseIn == true and key == 1 then
                    click_sound:play()
                    pair_to_render = pair_to_render + 1
                elseif pair_to_render ~= 1 then
                    if previous_stables_button.mouseIn == true and key == 1 then
                        click_sound:play()
                        pair_to_render = pair_to_render - 1
                    end
                end
            elseif pair_to_render ~= 1 then
                if previous_stables_button.mouseIn == true and key == 1 then
                    click_sound:play()
                    pair_to_render = pair_to_render - 1
                end
            end
        else
            if (playerInventory.pageOpen == 1 or playerInventory.pageOpen == 2) and inv_next_button.mouseIn == true and key == 1 then
                click_sound:play()
                playerInventory.pageOpen = playerInventory.pageOpen + 1
            elseif (playerInventory.pageOpen == 2 or playerInventory.pageOpen == 3) and inv_previous_button.mouseIn == true and key == 1 then
                click_sound:play()
                playerInventory.pageOpen = playerInventory.pageOpen - 1
            elseif close_inventory.mouseIn == true and key == 1 then
                click_sound:play()
                inventory_open = false
                playerInventory.pageOpen = 1
            end
        end
    --stable
    elseif game_mode == modes[5] then
        if inventory_open == false then
            if changing_spec == false and choosing_equipment == false then
                if exit_stable.mouseIn == true and key == 1 then
                    click_sound:play()
                    game_mode = modes[4]
                elseif edit_name.mouseIn == true and key == 1 then
                    click_sound:play()
                    name_window_open = true
                elseif name_window_open == true and confirm_edit_name.mouseIn == true and key == 1 then
                    click_sound:play()
                    load_stable:changeHorseName(name_text)
                    name_window_open = false
                    name_text = ""
                elseif load_stable.clean == false and clean_stable_action.mouseIn == true and key == 1 then
                    click_sound:play()
                    load_stable.clean = true
                elseif clean_horse_action.mouseIn == true and key == 1 then
                    click_sound:play()
                    load_stable.horse.needs[3] = true
                elseif give_food_action.mouseIn == true and give_food_action.active == true
                and (load_stable.horse.life_state == "horse"
                or (load_stable.horse.life_state == "hybrid" and load_stable.foodChance == 1)) and key == 1 then
                    click_sound:play()
                    if load_stable.horse.needs[1] == false then
                        load_stable.horse.needs[1] = true
                    else
                        load_stable.horse.health = load_stable.horse.health - 5
                    end
                    playerInventory:removeItem("hay", 1)
                elseif give_kelp_action.mouseIn == true and give_kelp_action.active == true
                and (load_stable.horse.life_state == "kelpie"
                or (load_stable.horse.life_state == "hybrid" and load_stable.foodChance == 2)) and key == 1 then
                    click_sound:play()
                    if load_stable.horse.needs[1] == false then
                        load_stable.horse.needs[1] = true
                    else
                        load_stable.horse.health = load_stable.horse.health - 5
                    end
                    playerInventory:removeItem("kelp", 1)
                elseif give_water_action.mouseIn == true and key == 1 then
                    click_sound:play()
                    load_stable.horse.needs[2] = true
                elseif (load_stable.treatChance == 1 and give_carrot_action.mouseIn == true and give_carrot_action.active == true)
                or (load_stable.treatChance == 2 and give_apple_action.mouseIn == true and give_apple_action.active == true)
                and key == 1 then
                    click_sound:play()
                    if load_stable.horse.mood <= 90 then
                        load_stable.horse.mood = load_stable.horse.mood + 10
                    elseif load_stable.horse.mood > 90 and load_stable.horse.mood < 100 then
                        load_stable.horse.mood = 100
                    else
                        load_stable.horse.health = load_stable.horse.health - 2
                    end
                    if load_stable.treatChance == 1 then
                        playerInventory:removeItem("carrot", 1)
                    else
                        playerInventory:removeItem("apple", 1)
                    end
                elseif change_spec.mouseIn == true and load_stable.horse.age_y > 1 and key == 1 then
                    click_sound:play()
                    changing_spec = true
                elseif load_stable.horse.equipped == true and load_stable.horse.preg == -1 and load_stable.horse.foal == nil then
                    if load_stable.horse.eq_hidden == true and show_equip_button.mouseIn == true and key == 1 then
                        click_sound:play()
                        load_stable.horse.eq_hidden = false
                    elseif load_stable.horse.eq_hidden == false and hide_equip_button.mouseIn == true and key == 1 then
                        click_sound:play()
                        load_stable.horse.eq_hidden = true
                    end
                end
            elseif changing_spec == true then
                if change_spec_none.mouseIn == true and key == 1 then
                    click_sound:play()
                    spec_to_change = 'none'
                    if load_stable.horse.equipped == true then
                        playerInventory:addItem(load_stable.horse.equipment[1], 1)
                        playerInventory:addItem(load_stable.horse.equipment[2], 1)
                        playerInventory:addItem(load_stable.horse.equipment[3], 1)
                        load_stable.horse.equipment = {}
                        load_stable.horse.equipped = false
                        load_stable.horse.specialization = spec_to_change
                    end
                    changing_spec = false
                elseif change_spec_jump.mouseIn == true and key == 1 and change_spec_jump.active == true then
                    click_sound:play()
                    changing_spec = false
                    spec_to_change = "jumping"
                    if load_stable.horse.equipped == true then
                        playerInventory:addItem(load_stable.horse.equipment[1], 1)
                        playerInventory:addItem(load_stable.horse.equipment[2], 1)
                        playerInventory:addItem(load_stable.horse.equipment[3], 1)
                        load_stable.horse.equipment = {}
                        load_stable.horse.equipped = false
                    end
                    playerInventory:chooseEquipment(spec_to_change)
                    choosing_equipment = true
                elseif change_spec_dres.mouseIn == true and key == 1 and change_spec_dres.active == true then
                    click_sound:play()
                    spec_to_change = 'dressage'
                    changing_spec = false
                    if load_stable.horse.equipped == true then
                        playerInventory:addItem(load_stable.horse.equipment[1], 1)
                        playerInventory:addItem(load_stable.horse.equipment[2], 1)
                        playerInventory:addItem(load_stable.horse.equipment[3], 1)
                        load_stable.horse.equipment = {}
                        load_stable.horse.equipped = false
                    end
                    playerInventory:chooseEquipment(spec_to_change)
                    choosing_equipment = true
                elseif change_spec_cc.mouseIn == true and key == 1 and change_spec_cc.active == true then
                    click_sound:play()
                    spec_to_change = 'cross-country'
                    changing_spec = false
                    if load_stable.horse.equipped == true then
                        playerInventory:addItem(load_stable.horse.equipment[1], 1)
                        playerInventory:addItem(load_stable.horse.equipment[2], 1)
                        playerInventory:addItem(load_stable.horse.equipment[3], 1)
                        load_stable.horse.equipment = {}
                        load_stable.horse.equipped = false
                    end
                    playerInventory:chooseEquipment(spec_to_change)
                    choosing_equipment = true
                end
            elseif changing_spec == false and choosing_equipment == true then
                if playerInventory.currentEquipment[1].mouseIn == true and key == 1 then
                    click_sound:play()
                    checkChosenEquipment(1)
                elseif playerInventory.currentEquipment[2].mouseIn == true and key == 1 then
                    click_sound:play()
                    checkChosenEquipment(2)
                elseif playerInventory.currentEquipment[3].mouseIn == true and key == 1 then
                    click_sound:play()
                    checkChosenEquipment(3)
                elseif playerInventory.currentEquipment[4].mouseIn == true and key == 1 then
                    click_sound:play()
                    checkChosenEquipment(4)
                elseif playerInventory.currentEquipment[5].mouseIn == true and key == 1 then
                    click_sound:play()
                    checkChosenEquipment(5)
                elseif playerInventory.currentEquipment[6].mouseIn == true and key == 1 then
                    click_sound:play()
                    checkChosenEquipment(6)
                elseif playerInventory.currentEquipment[7].mouseIn == true and key == 1 then
                    click_sound:play()
                    checkChosenEquipment(7)
                elseif playerInventory.currentEquipment[8].mouseIn == true and key == 1 then
                    click_sound:play()
                    checkChosenEquipment(8)
                elseif playerInventory.currentEquipment[9].mouseIn == true and key == 1 then
                    click_sound:play()
                    checkChosenEquipment(9)
                elseif confirm_equipment.mouseIn == true and confirm_equipment.active == true then
                    click_sound:play()
                    load_stable.horse.equipment[1] = chosen_saddle
                    load_stable.horse.equipment[2] = chosen_bridle
                    load_stable.horse.equipment[3] = chosen_pad
                    load_stable.horse.equipped = true
                    load_stable.horse.specialization = spec_to_change
                    choosing_equipment = false
                    playerInventory:removeItem(chosen_saddle, 1)
                    playerInventory:removeItem(chosen_bridle, 1)
                    playerInventory:removeItem(chosen_pad, 1)
                end
            end
        else
            if (playerInventory.pageOpen == 1 or playerInventory.pageOpen == 2) and inv_next_button.mouseIn == true and key == 1 then
                click_sound:play()
                playerInventory.pageOpen = playerInventory.pageOpen + 1
            elseif (playerInventory.pageOpen == 2 or playerInventory.pageOpen == 3) and inv_previous_button.mouseIn == true and key == 1 then
                click_sound:play()
                playerInventory.pageOpen = playerInventory.pageOpen - 1
            elseif close_inventory.mouseIn == true and key == 1 then
                click_sound:play()
                inventory_open = false
                playerInventory.pageOpen = 1
            end
        end
    -- medical centre
    elseif game_mode == modes[6] then
        if breeding_button.mouseIn == true and key == 1 then
            click_sound:play()
            game_mode = modes[11]
            breeding_page_f = 1
            breeding_page_m = 1
        elseif medical_test_button.mouseIn == true and key == 1 then
            click_sound:play()
            game_mode = modes[12]
        elseif treatment_button.mouseIn == true and key == 1 then
            click_sound:play()
            game_mode = modes[13]
            treatmentPage = 1
        end
    -- shop and market
    elseif game_mode == modes[7] then
        if buyHorsesBtn.mouseIn == true and key == 1 then
            click_sound:play()
            game_mode = modes[14]
        elseif sellHorsesBtn.mouseIn == true and key == 1 then
            click_sound:play()
            game_mode = modes[15]
        elseif studdingBtn.mouseIn == true and key == 1 then
            click_sound:play()
            game_mode = modes[16]
        elseif enterShopBtn.mouseIn == true and key == 1 then
            click_sound:play()
            game_mode = modes[17]
        end
    -- training/competing
    elseif game_mode == modes[8] then
        if event == "training" then
            if cross_training_button.mouseIn == true and key == 1 then
                click_sound:play()
                game_mode = modes[9]
                event_type = "cross-country"
                trainingPageOpen = 1
            elseif jumping_training_button.mouseIn == true and key == 1 then
                click_sound:play()
                game_mode = modes[9]
                event_type = "jumping"
                trainingPageOpen = 1
            elseif dressage_training_button.mouseIn == true and key == 1 then
                click_sound:play()
                game_mode = modes[9]
                event_type = "dressage"
                trainingPageOpen = 1
            end
        elseif event == "competing" then
            if cc_tier1.mouseIn == true and key == 1 then
                click_sound:play()
                game_mode = modes[9]
                event_type = "cross-country"
                event_tier = 1
                competingPageOpen = 1
            elseif cc_tier2.mouseIn == true and key == 1 then
                click_sound:play()
                game_mode = modes[9]
                event_type = "cross-country"
                event_tier = 2
                competingPageOpen = 1
            elseif cc_tier3.mouseIn == true and key == 1 then
                click_sound:play()
                game_mode = modes[9]
                event_type = "cross-country"
                event_tier = 3
                competingPageOpen = 1
            elseif cc_tier4.mouseIn == true and key == 1 then
                click_sound:play()
                game_mode = modes[9]
                event_type = "cross-country"
                event_tier = 4
                competingPageOpen = 1
            elseif cc_tier5.mouseIn == true and key == 1 then
                click_sound:play()
                game_mode = modes[9]
                event_type = "cross-country"
                event_tier = 5
                competingPageOpen = 1
            elseif j_tier1.mouseIn == true and key == 1 then
                click_sound:play()
                game_mode = modes[9]
                event_type = "jumping"
                event_tier = 1
                competingPageOpen = 1
            elseif j_tier2.mouseIn == true and key == 1 then
                click_sound:play()
                game_mode = modes[9]
                event_type = "jumping"
                event_tier = 2
                competingPageOpen = 1
            elseif j_tier3.mouseIn == true and key == 1 then
                click_sound:play()
                game_mode = modes[9]
                event_type = "jumping"
                event_tier = 3
                competingPageOpen = 1
            elseif j_tier4.mouseIn == true and key == 1 then
                click_sound:play()
                game_mode = modes[9]
                event_type = "jumping"
                event_tier = 4
                competingPageOpen = 1
            elseif j_tier5.mouseIn == true and key == 1 then
                click_sound:play()
                game_mode = modes[9]
                event_type = "jumping"
                event_tier = 5
                competingPageOpen = 1
            elseif d_tier1.mouseIn == true and key == 1 then
                click_sound:play()
                game_mode = modes[9]
                event_type = "dressage"
                event_tier = 1
                competingPageOpen = 1
            elseif d_tier2.mouseIn == true and key == 1 then
                click_sound:play()
                game_mode = modes[9]
                event_type = "dressage"
                event_tier = 2
                competingPageOpen = 1
            elseif d_tier3.mouseIn == true and key == 1 then
                click_sound:play()
                game_mode = modes[9]
                event_type = "dressage"
                event_tier = 3
                competingPageOpen = 1
            elseif d_tier4.mouseIn == true and key == 1 then
                click_sound:play()
                game_mode = modes[9]
                event_type = "dressage"
                event_tier = 4
                competingPageOpen = 1
            elseif d_tier5.mouseIn == true and key == 1 then
                click_sound:play()
                game_mode = modes[9]
                event_type = "dressage"
                event_tier = 5
                competingPageOpen = 1
            end
        end
    elseif game_mode == modes[9] then
        if event == "training" then
            if train_1_button.mouseIn == true and key == 1 then
                click_sound:play()
                trainHorse(1, trainingPageOpen, event_type)
            elseif train_2_button.mouseIn == true and key == 1 then
                click_sound:play()
                trainHorse(2, trainingPageOpen, event_type)
            elseif train_3_button.mouseIn == true and key == 1 then
                click_sound:play()
                trainHorse(3, trainingPageOpen, event_type)
            elseif train_4_button.mouseIn == true and key == 1 then
                click_sound:play()
                trainHorse(4, trainingPageOpen, event_type)
            elseif #availableForTraining - trainingPageOpen*4 > 0 then
                if next_button.mouseIn == true and key == 1 then
                    click_sound:play()
                    trainingPageOpen = trainingPageOpen + 1
                end
            elseif trainingPageOpen > 1 then
                if previous_button.mouseIn == true and key == 1 then
                    click_sound:play()
                    trainingPageOpen = trainingPageOpen - 1
                end
            end
        elseif event == "competing" then
            if place_window_open == false and compete_1_button.mouseIn == true and key == 1 then
                click_sound:play()
                compResults = enterCompetition(1, trainingPageOpen, event_type, event_tier)
                place_window_open = true
            elseif place_window_open == false and compete_2_button.mouseIn == true and key == 1 then
                click_sound:play()
                compResults = enterCompetition(2, trainingPageOpen, event_type, event_tier)
                place_window_open = true
            elseif place_window_open == false and compete_3_button.mouseIn == true and key == 1 then
                click_sound:play()
                compResults = enterCompetition(3, trainingPageOpen, event_type, event_tier)
                place_window_open = true
            elseif place_window_open == false and compete_4_button.mouseIn == true and key == 1 then
                click_sound:play()
                compResults = enterCompetition(4, trainingPageOpen, event_type, event_tier)
                place_window_open = true
            elseif #availableForCompeting - competingPageOpen*4 > 0 then
                if next_button.mouseIn == true and key == 1 then
                    click_sound:play()
                    competingPageOpen = competingPageOpen + 1
                end
            elseif competingPageOpen > 1 then
                if previous_button.mouseIn == true and key == 1 then
                    click_sound:play()
                    competingPageOpen = competingPageOpen - 1
                end
            elseif place_window_open == true and confirm_place.mouseIn == true and key == 1 then
                click_sound:play()
                place_window_open = false
            end
        end
    elseif game_mode == modes[10] and lake_mg.fishingStage == "bit" then
        if x > lake_mg.fishPlace[1] - 100*sx and x < lake_mg.fishPlace[1] + 100*sx and y > lake_mg.fishPlace[2] - 60*sy
        and y < lake_mg.fishPlace[2] + 60*sy and key == 1 then
            lake_mg.fishingStage = "catching"
        end
    elseif game_mode == modes[10] and exit_to_map.mouseIn == true and key == 1 then
        lake_bg_sounds:stop()
        click_sound:play()
        lake_mg.fishingStage = "idle"
        next_bit = 1 + math.random(1, 4)
        time = 0
        lake_mg.fish = nil
        lake_mg.fishImage = nil
        game_mode = modes[3]
    -- breeding
    elseif game_mode == modes[11] then
        if breedButton.mouseIn == true and key == 1 and breedButton.active == true then
            click_sound:play()
            if paidStudOpen == false then
                availableFemales[breeding_page_f]:initiatePregnancy(availableMales[breeding_page_m])
                availableMales[breeding_page_m].energy = availableMales[breeding_page_m].energy - 20
            else
                availableFemales[breeding_page_f]:initiatePregnancy(studOfTheDay)
                studOfTheDay.energy = studOfTheDay.energy - 25
            end
            breeding_page_f = 1
        elseif paidStudOpen == false and paidStudsBtn.mouseIn == true and key == 1 then
            click_sound:play()
            paidStudOpen = true
        elseif paidStudOpen == true and myStudsBtn.mouseIn == true and key == 1 then
            click_sound:play()
            paidStudOpen = false
        end
        if breeding_page_m > 1 then
            if previousMaleButton.mouseIn == true and key == 1 then
                click_sound:play()
                breeding_page_m = breeding_page_m - 1
            end
        end
        if breeding_page_m < #availableMales then
            if nextMaleButton.mouseIn == true and key == 1 then
                click_sound:play()
                breeding_page_m = breeding_page_m + 1
            end
        end
        if breeding_page_f > 1 then
            if previousFemaleButton.mouseIn == true and key == 1 then
                click_sound:play()
                breeding_page_f = breeding_page_f - 1
            end
        end
        if breeding_page_f < #availableFemales then
            if nextFemaleButton.mouseIn == true and key == 1 then
                click_sound:play()
                breeding_page_f = breeding_page_f + 1
            end
        end
    elseif game_mode == modes[12] then
        if #allHorses > geneticsPage and nextArrow.mouseIn == true and key == 1 then
            click_sound:play()
            geneticsPage = geneticsPage + 1
        end
        if geneticsPage > 1 and prevArrow.mouseIn == true and key == 1 then
            click_sound:play()
            geneticsPage = geneticsPage - 1
        end
        if orderTest.active == true and orderTest.mouseIn == true and allHorses[geneticsPage].tested == false then
            click_sound:play()
            playerCoins = playerCoins - 250
            allHorses[geneticsPage].tested = true
        end
    -- treating horses
    elseif game_mode == modes[13] then
        if sickHorses[4*(treatmentPage - 1) + 1] ~= nil and treat1_button.mouseIn == true
        and treat1_button.active == true and key == 1 then
            click_sound:play()
            playerCoins = playerCoins - treatmentPrice1
            sickHorses[4*(treatmentPage - 1) + 1].effects[1] = false
        elseif sickHorses[4*(treatmentPage - 1) + 2] ~= nil and treat2_button.mouseIn == true and
        treat2_button.active == true and key == 1 then
            click_sound:play()
            playerCoins = playerCoins - treatmentPrice2
            sickHorses[4*(treatmentPage - 1) + 2].effects[1] = false
        elseif sickHorses[4*(treatmentPage - 1) + 3] ~= nil and treat3_button.mouseIn == true and
        treat3_button.active == true and key == 1 then
            click_sound:play()
            playerCoins = playerCoins - treatmentPrice3
            sickHorses[4*(treatmentPage - 1) + 3].effects[1] = false
        elseif sickHorses[4*(treatmentPage - 1) + 4] ~= nil and treat4_button.mouseIn == true and
        treat4_button.active == true and key == 1 then
            click_sound:play()
            playerCoins = playerCoins - treatmentPrice4
            sickHorses[4*(treatmentPage - 1) + 4].effects[1] = false
        elseif #sickHorses - treatmentPage*4 > 0 and nextSickHorses.mouseIn == true and key == 1 then
            click_sound:play()
            treatmentPage = treatmentPage + 1
        elseif treatmentPage > 1 and previousSickHorses.mouseIn == true and key == 1 then
            click_sound:play()
            treatmentPage = treatmentPage - 1
        end
    -- buying horses
    elseif game_mode == modes[14] then
        if buying_confirmation == false then
            if horsesForBuying[1] ~= nil and buyHorse1.mouseIn == true and buyHorse1.active == true and key == 1 then
                click_sound:play()
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
                    freeStable:setHorse(horsesForBuying[1])
                    playerCoins = playerCoins - buyingPrice1
                    horsesForBuying[1] = nil
                else
                    buying_confirmation = true
                end
            elseif horsesForBuying[2] ~= nil and buyHorse2.mouseIn == true and buyHorse2.active == true and key == 1 then
                click_sound:play()
                local foundEmpty = false
                local checking = 1
                local freeStable
                while foundEmpty == false and checking <= user_stables.number do
                    if user_stables.stables[checking].empty == true then
                        freeStable = user_stables.stables[checking]
                        playerCoins = playerCoins - buyingPrice2
                        foundEmpty = true
                    end
                    checking = checking + 1
                end
                if foundEmpty == true then
                    freeStable:setHorse(horsesForBuying[2])
                    horsesForBuying[2] = nil
                else
                    buying_confirmation = true
                end
            elseif horsesForBuying[3] ~= nil and buyHorse3.mouseIn == true and buyHorse3.active == true and key == 1 then
                click_sound:play()
                local foundEmpty = false
                local checking = 1
                local freeStable
                while foundEmpty == false and checking <= user_stables.number do
                    if user_stables.stables[checking].empty == true then
                        freeStable = user_stables.stables[checking]
                        playerCoins = playerCoins - buyingPrice3
                        foundEmpty = true
                    end
                    checking = checking + 1
                end
                if foundEmpty == true then
                    freeStable:setHorse(horsesForBuying[3])
                    horsesForBuying[3] = nil
                else
                    buying_confirmation = true
                end
            end
        else
            if yes.mouseIn == true and key == 1 and yes.active == true then
                click_sound:play()
                playerCoins = playerCoins - 500
                user_stables:addStable()
                buying_confirmation = false
            elseif no.mouseIn == true and key == 1 then
                click_sound:play()
                buying_confirmation = false
            end
        end
    -- selling horses
    elseif game_mode == modes[15] then
        if selling_confirmation == false then
            if horsesForSale[3*(salesPageOpen - 1) + 1] ~= nil and sellHorse1.mouseIn == true and key == 1 then
                click_sound:play()
                selling_confirmation = true
                selling = 1
            elseif horsesForSale[3*(salesPageOpen - 1) + 2] ~= nil and sellHorse2.mouseIn == true and key == 1 then
                click_sound:play()
                selling_confirmation = true
                selling = 2
            elseif horsesForSale[3*(salesPageOpen - 1) + 3] ~= nil and sellHorse3.mouseIn == true and key == 1 then
                click_sound:play()
                selling_confirmation = true
                selling = 3
            elseif #horsesForSale - 3*salesPageOpen > 0 and nextArrow.mouseIn == true and key == 1 then
                click_sound:play()
                salesPageOpen = salesPageOpen + 1
            elseif salesPageOpen > 1 and prevArrow.mouseIn == true and key == 1 then
                click_sound:play()
                salesPageOpen = salesPageOpen - 1
            end
        else
            if yes.mouseIn == true and key == 1 then
                click_sound:play()
                local sellingNumber = 0
                if selling == 1 then
                    playerCoins = playerCoins + buyingPrice1
                    for k, stable in ipairs(user_stables.stables) do
                        if stable.horse == horsesForSale[3*(salesPageOpen - 1) + 1] then
                            sellingNumber = stable.number
                        end
                    end
                    user_stables.stables[sellingNumber]:setEmpty()
                    user_stables:shift()
                elseif selling == 2 then
                    playerCoins = playerCoins + buyingPrice2
                    for k, stable in ipairs(user_stables.stables) do
                        if stable.horse == horsesForSale[3*(salesPageOpen - 1) + 2] then
                            sellingNumber = stable.number
                        end
                    end
                    user_stables.stables[sellingNumber]:setEmpty()
                    user_stables:shift()
                else
                    playerCoins = playerCoins + buyingPrice3
                    for k, stable in ipairs(user_stables.stables) do
                        if stable.horse == horsesForSale[3*(salesPageOpen - 1) + 3] then
                            sellingNumber = stable.number
                        end
                    end
                    user_stables.stables[sellingNumber]:setEmpty()
                    user_stables:shift()
                end
                selling_confirmation = false
            elseif no.mouseIn == true and key == 1 then
                click_sound:play()
                selling_confirmation = false
            end
        end
    -- studding
    elseif game_mode == modes[16] then
        if myStudsOpen == true then
            if myStuds[3*(studsPageOpen - 1) + 1] ~= nil and studHorse1.mouseIn == true and key == 1 then
                click_sound:play()
                myStuds[3*(studsPageOpen - 1) + 1].energy = myStuds[3*(studsPageOpen - 1) + 1].energy - 25
                playerCoins = playerCoins + studdingPrice1
            elseif myStuds[3*(studsPageOpen - 1) + 2] ~= nil and studHorse2.mouseIn == true and key == 1 then
                click_sound:play()
                myStuds[3*(studsPageOpen - 1) + 2].energy = myStuds[3*(studsPageOpen - 1) + 2].energy - 25
                playerCoins = playerCoins + studdingPrice2
            elseif myStuds[3*(studsPageOpen - 1) + 3] ~= nil and studHorse3.mouseIn == true and key == 1 then
                click_sound:play()
                myStuds[3*(studsPageOpen - 1) + 3].energy = myStuds[3*(studsPageOpen - 1) + 3].energy - 25
                playerCoins = playerCoins + studdingPrice3
            elseif #myStuds - 3*studsPageOpen > 0 and nextArrow.mouseIn == true and key == 1 then
                click_sound:play()
                studsPageOpen = studsPageOpen + 1
            elseif studsPageOpen > 1 and prevArrow.mouseIn == true and key == 1 then
                click_sound:play()
                studsPageOpen = studsPageOpen - 1
            elseif sotdTab.mouseIn == true and key == 1 then
                click_sound:play()
                myStudsOpen = false
            end
        else
            if myStudsTab.mouseIn == true and key == 1 then
                click_sound:play()
                myStudsOpen = true
            elseif buyStudding.mouseIn == true and buyStudding.active == true and key == 1 then
                click_sound:play()
                playerCoins = playerCoins - studPrice
                studdingBought = true
            end
        end
    elseif game_mode == modes[17] then
        if shop.curItems[8*(shop.page - 1) + 1] ~= nil then
            if plus1.active == true and plus1.mouseIn == true and key == 1 then
                click_sound:play()
                shop.curItems[8*(shop.page - 1) + 1][3] = shop.curItems[8*(shop.page - 1) + 1][3] + 1
                shop.total = shop.total + shop.curItems[8*(shop.page - 1) + 1][4]
            elseif minus1.active == true and minus1.mouseIn == true and key == 1 then
                click_sound:play()
                shop.curItems[8*(shop.page - 1) + 1][3] = shop.curItems[8*(shop.page - 1) + 1][3] - 1
                shop.total = shop.total - shop.curItems[8*(shop.page - 1) + 1][4]
            end
        end
        if shop.curItems[8*(shop.page - 1) + 2] ~= nil then
            if plus2.active == true and plus2.mouseIn == true and key == 1 then
                click_sound:play()
                shop.curItems[8*(shop.page - 1) + 2][3] = shop.curItems[8*(shop.page - 1) + 2][3] + 1
                shop.total = shop.total + shop.curItems[8*(shop.page - 1) + 2][4]
            elseif minus2.active == true and minus2.mouseIn == true and key == 1 then
                click_sound:play()
                shop.curItems[8*(shop.page - 1) + 2][3] = shop.curItems[8*(shop.page - 1) + 2][3] - 1
                shop.total = shop.total - shop.curItems[8*(shop.page - 1) + 2][4]
            end
        end
        if shop.curItems[8*(shop.page - 1) + 3] ~= nil then
            if plus3.active == true and plus3.mouseIn == true and key == 1 then
                click_sound:play()
                shop.curItems[8*(shop.page - 1) + 3][3] = shop.curItems[8*(shop.page - 1) + 3][3] + 1
                shop.total = shop.total + shop.curItems[8*(shop.page - 1) + 3][4]
            elseif minus3.active == true and minus3.mouseIn == true and key == 1 then
                click_sound:play()
                shop.curItems[8*(shop.page - 1) + 3][3] = shop.curItems[8*(shop.page - 1) + 3][3] - 1
                shop.total = shop.total - shop.curItems[8*(shop.page - 1) + 3][4]
            end
        end
        if shop.curItems[8*(shop.page - 1) + 4] ~= nil then
            if plus4.active == true and plus4.mouseIn == true and key == 1 then
                click_sound:play()
                shop.curItems[8*(shop.page - 1) + 4][3] = shop.curItems[8*(shop.page - 1) + 4][3] + 1
                shop.total = shop.total + shop.curItems[8*(shop.page - 1) + 4][4]
            elseif minus4.active == true and minus4.mouseIn == true and key == 1 then
                click_sound:play()
                shop.curItems[8*(shop.page - 1) + 4][3] = shop.curItems[8*(shop.page - 1) + 4][3] - 1
                shop.total = shop.total - shop.curItems[8*(shop.page - 1) + 4][4]
            end
        end
        if shop.curItems[8*(shop.page - 1) + 5] ~= nil then
            if plus5.active == true and plus5.mouseIn == true and key == 1 then
                click_sound:play()
                shop.curItems[8*(shop.page - 1) + 5][3] = shop.curItems[8*(shop.page - 1) + 5][3] + 1
                shop.total = shop.total + shop.curItems[8*(shop.page - 1) + 5][4]
            elseif minus5.active == true and minus5.mouseIn == true and key == 1 then
                click_sound:play()
                shop.curItems[8*(shop.page - 1) + 5][3] = shop.curItems[8*(shop.page - 1) + 5][3] - 1
                shop.total = shop.total - shop.curItems[8*(shop.page - 1) + 5][4]
            end
        end
        if shop.curItems[8*(shop.page - 1) + 6] ~= nil then
            if plus6.active == true and plus6.mouseIn == true and key == 1 then
                click_sound:play()
                shop.curItems[8*(shop.page - 1) + 6][3] = shop.curItems[8*(shop.page - 1) + 6][3] + 1
                shop.total = shop.total + shop.curItems[8*(shop.page - 1) + 6][4]
            elseif minus6.active == true and minus6.mouseIn == true and key == 1 then
                click_sound:play()
                shop.curItems[8*(shop.page - 1) + 6][3] = shop.curItems[8*(shop.page - 1) + 6][3] - 1
                shop.total = shop.total - shop.curItems[8*(shop.page - 1) + 6][4]
            end
        end
        if shop.curItems[8*(shop.page - 1) + 7] ~= nil then
            if plus7.active == true and plus7.mouseIn == true and key == 1 then
                click_sound:play()
                shop.curItems[8*(shop.page - 1) + 7][3] = shop.curItems[8*(shop.page - 1) + 7][3] + 1
                shop.total = shop.total + shop.curItems[8*(shop.page - 1) + 7][4]
            elseif minus7.active == true and minus7.mouseIn == true and key == 1 then
                click_sound:play()
                shop.curItems[8*(shop.page - 1) + 7][3] = shop.curItems[8*(shop.page - 1) + 7][3] - 1
                shop.total = shop.total - shop.curItems[8*(shop.page - 1) + 7][4]
            end
        end
        if shop.curItems[8*(shop.page - 1) + 8] ~= nil then
            if plus8.active == true and plus8.mouseIn == true and key == 1 then
                click_sound:play()
                shop.curItems[8*(shop.page - 1) + 8][3] = shop.curItems[8*(shop.page - 1) + 8][3] + 1
                shop.total = shop.total + shop.curItems[8*(shop.page - 1) + 8][4]
            elseif minus8.active == true and minus8.mouseIn == true and key == 1 then
                click_sound:play()
                shop.curItems[8*(shop.page - 1) + 8][3] = shop.curItems[8*(shop.page - 1) + 8][3] - 1
                shop.total = shop.total - shop.curItems[8*(shop.page - 1) + 8][4]
            end
        end
        if equipTab.mouseIn == true and key == 1 and (shop.tab == 1 or shop.tab == 3) then
            click_sound:play()
            shop.tab = 2
            shop:clearQuantities()
            shop.page = 1
            shop.total = 0
            shop.curItems = shop.equipItems
        elseif sellTab.mouseIn == true and key == 1 and (shop.tab == 1 or shop.tab == 2) then
            click_sound:play()
            shop.tab = 3
            shop:clearQuantities()
            shop.page = 1
            shop.total = 0
            shop:getFromInventory()
        elseif foodTab.mouseIn == true and key == 1 and (shop.tab == 2 or shop.tab == 3) then
            click_sound:play()
            shop.tab = 1
            shop:clearQuantities()
            shop.page = 1
            shop.total = 0
            shop.curItems = shop.foodItems
        elseif #shop.curItems - 8*shop.page > 0 and nextArrow.mouseIn == true and key == 1 then
            click_sound:play()
            shop.page = shop.page + 1
        elseif shop.page > 1 and prevArrow.mouseIn == true and key == 1 then
            click_sound:play()
            shop.page = shop.page - 1
        elseif shop.tab == 1 and buyThings.mouseIn == true and buyThings.active == true and key == 1 then
            click_sound:play()
            shop:buyOrSell(1)
        elseif shop.tab == 2 and buyThings.mouseIn == true and buyThings.active == true and key == 1 then
            click_sound:play()
            shop:buyOrSell(2)
        elseif shop.tab == 3 and sellThings.mouseIn == true and key == 1 then
            click_sound:play()
            shop:buyOrSell(3)
        end
    end
end


function love.keypressed(key)
    local game_width = love.graphics.getWidth()
    local game_height = love.graphics.getHeight()

    if key == "escape" then
        if game_mode == modes[1] then
            if newGameDialog == true then
                newGameDialog = false
            elseif loadGameDialog == true then
                loadGameDialog = false
            elseif exitGameDialog == true then
                exitGameDialog = false
            end
        elseif game_mode == modes[3] then
            if notification == windows[1] then
                if inventory_open == false then
                    if questDialogOpen == true then
                        if questTestSubjectsOpen == false then
                            questDialogOpen = false
                        else
                            questTestSubjectsOpen = false
                        end
                    else
                        game_mode = modes[1]
                    end
                else
                    inventory_open = false
                    playerInventory.pageOpen = 1
                end
            elseif notification == windows[2] then
                if #bornFoals ~= 0 then
                    notification = windows[3]
                else
                    if #grownFoals ~= 0 then
                        notification = windows[4]
                    else
                        notification = windows[1]
                    end
                end
            elseif notification == windows[3] then
                if #grownFoals ~= 0 then
                    notification = windows[4]
                else
                    notification = windows[1]
                end
            end
        elseif game_mode == modes[4] or game_mode == modes[8] or game_mode == modes[6] or game_mode == modes[7]
            or game_mode == modes[10] then
            lake_bg_sounds:stop()
            if inventory_open == false then
                game_mode = modes[3]
            else
                inventory_open = false
                playerInventory.pageOpen = 1
            end
        elseif game_mode == modes[11] or game_mode == modes[12] or game_mode == modes[13] then
            game_mode = modes[6]
        elseif game_mode == modes[9] then
            if place_window_open == true then
                place_window_open = false
                compResults = {}
            else
                game_mode = modes[8]
                event_type = ""
            end
        elseif game_mode == modes[5] then
            if inventory_open == false then
                if changing_spec == false then
                    if choosing_equipment == false then
                        game_mode = modes[4]
                    else
                        choosing_equipment = false
                        changing_spec = true
                    end
                else
                    changing_spec = false
                end
            else
                inventory_open = false
                playerInventory.pageOpen = 1
            end
        elseif game_mode == modes[14] or game_mode == modes[15] or game_mode == modes[16] or game_mode == modes[17] then
            game_mode = modes[7]
            shop.tab = 1
        elseif name_window_open == true then
            name_window_open = false
        elseif changing_spec == true then
            changing_spec = false
        elseif choosing_equipment == true then
            choosing_equipment = false
            changing_spec = true
        end
    elseif key == "return" then
        if game_mode == modes[9] then
            if place_window_open == true then
                place_window_open = false
                compResults = {}
            end
        end
    elseif key == "i" then
        if game_mode == modes[3] and notification == windows[1] then
            if inventory_open == false then
                inventory_open = true
            else
                inventory_open = false
                playerInventory.pageOpen = 1
            end
        elseif game_mode == modes[4] or (game_mode == modes[5] and name_window_open == false) then
            if inventory_open == false then
                inventory_open = true
            else
                inventory_open = false
                playerInventory.pageOpen = 1
            end
        end
    elseif game_mode == modes[10] and lake_mg.fishingStage == "catching" then
        if key == "space" then
            if lake_mg.fishPosition + 5*sx >= lake_mg.targetPosition
            and lake_mg.fishPosition + 80*sx <= lake_mg.targetPosition + 130*sx then
                time = 0
                lake_mg.fishingStage = "caught"
            else
                lake_mg.fish = nil
                lake_mg.fishImage = nil
                next_bit = 1 + math.random(1, 4)
                time = 0
                lake_mg.fishingStage = "idle"
            end
        elseif key == "escape" then
            lake_mg.fish = nil
            lake_mg.fishImage = nil
            next_bit = 1 + math.random(1, 4)
            time = 0
            lake_mg.fishingStage = "idle"
        end
    end
    if name_window_open == true then
        if key == "backspace" then
            local byteoffset = utf8.offset(name_text, -1)
            if byteoffset then
                name_text = string.sub(name_text, 1, byteoffset - 1)
            end
        elseif key == "return" then
            load_stable:changeHorseName(name_text)
            name_window_open = false
            name_text = ""
        end
    end
end

function love.update(dt)
    local game_width = love.graphics.getWidth()
    local game_height = love.graphics.getHeight()

    love.audio.play(bg_music)

    if game_mode == modes[1] then
        if savingNotif == true then
            time = time + dt
            if time > 1 then
                savingNotif = false
                time = 0
            end
        else
            if credits == true then
                time = time + dt
                if time > 3 then
                    love.event.quit()
                end
            elseif newGameDialog == true or loadGameDialog == true or exitGameDialog == true then
                no:checkHover()
                yes:checkHover()
            else
                resume_game_button:checkHover()
                new_game_button:checkHover()
                load_game_button:checkHover()
                save_game_button:checkHover()
                exit_button:checkHover()
            end
        end
        -- map hovering over objects
    elseif game_mode == modes[3] then
        if notification == windows[1] then
            if inventory_open == false then
                if questDialogOpen == false then
                    map:checkHover()
                    change_day:checkHover()
                    musicBtn1:checkHover()
                    musicBtn2:checkHover()
                else
                    if quest.stage == 1 or quest.stage == 3 or quest.stage == 5
                    or quest.stage == 7 or quest.stage == 8 or quest.stage == 9
                    or quest.stage == 13 or quest.stage == 14 then
                        okBtn:checkHover()
                    elseif quest.stage == 2 or quest.stage == 4 or quest.stage == 11 then
                        giveFishBtn:checkHover()
                    elseif quest.stage == 6 or quest.stage == 12 then
                        if questTestSubjectsOpen == false then
                            chooseHorseBtn:checkHover()
                        else
                            choose1:checkHover()
                            choose2:checkHover()
                            choose3:checkHover()
                            choose4:checkHover()
                            nextTestSubjects:checkHover()
                            previousTestSubjects:checkHover()
                        end
                    elseif quest.stage == 10 then
                        kred:checkHover()
                        korange:checkHover()
                        kyellow:checkHover()
                        kgreen:checkHover()
                        kturquoise:checkHover()
                        kblue:checkHover()
                        kpurple:checkHover()
                    end
                end
            else
                playerInventory:checkCellsHover()
                if playerInventory.pageOpen == 1 then
                    inv_next_button:checkHover()
                elseif playerInventory.pageOpen == 2 then
                    inv_next_button:checkHover()
                    inv_previous_button:checkHover()
                else
                    inv_previous_button:checkHover()
                end
                close_inventory:checkHover()
            end
        elseif notification == windows[2] or notification == windows[3] then
            confirm_notif:checkHover()
        elseif notification == windows[4] then
            if buying_confirmation == false then
                sell_foal:checkHover()
                keep_foal:checkHover()
            else
                yes:checkHover()
                no:checkHover()
            end
        end
    elseif game_mode == modes[4] then
        if inventory_open == false then
            exit_to_map:checkHover()
            next_stables_button:checkHover()
            previous_stables_button:checkHover()
        else
            playerInventory:checkCellsHover()
            if playerInventory.pageOpen == 1 then
                inv_next_button:checkHover()
            elseif playerInventory.pageOpen == 2 then
                inv_next_button:checkHover()
                inv_previous_button:checkHover()
            else
                inv_previous_button:checkHover()
            end
            close_inventory:checkHover()
        end
    elseif game_mode == modes[5] then
        if inventory_open == false then
            if changing_spec == false then
                if choosing_equipment == false then
                    exit_stable:checkHover()
                    edit_name:checkHover()
                    clean_horse_action:checkHover()
                    give_carrot_action:checkHover()
                    give_food_action:checkHover()
                    give_water_action:checkHover()
                    give_apple_action:checkHover()
                    give_kelp_action:checkHover()
                    if load_stable.clean == false then
                        clean_stable_action:checkHover()
                    end
                    if name_window_open == true then
                        confirm_edit_name:checkHover()
                    end
                    change_spec:checkHover()
                    hide_equip_button:checkHover()
                    show_equip_button:checkHover()
                else
                    if #playerInventory.currentEquipment > 0 then
                        playerInventory:checkEquipmentHover()
                    end
                    if confirm_equipment.active == true then
                        confirm_equipment:checkHover()
                    end
                end
            else
                change_spec_none:checkHover()
                change_spec_jump:checkHover()
                change_spec_dres:checkHover()
                change_spec_cc:checkHover()
            end
        else
            playerInventory:checkCellsHover()
            if playerInventory.pageOpen == 1 then
                inv_next_button:checkHover()
            elseif playerInventory.pageOpen == 2 then
                inv_next_button:checkHover()
                inv_previous_button:checkHover()
            else
                inv_previous_button:checkHover()
            end
            close_inventory:checkHover()
        end
    elseif game_mode == modes[6] then
        breeding_button:checkHover()
        medical_test_button:checkHover()
        treatment_button:checkHover()
    elseif game_mode == modes[7] then
        buyHorsesBtn:checkHover()
        sellHorsesBtn:checkHover()
        studdingBtn:checkHover()
        enterShopBtn:checkHover()
    elseif game_mode == modes[8] then
        if event == "training" then
            cross_training_button:checkHover()
            jumping_training_button:checkHover()
            dressage_training_button:checkHover()
        elseif event == "competing" then
            cc_tier1:checkHover()
            cc_tier2:checkHover()
            cc_tier3:checkHover()
            cc_tier4:checkHover()
            cc_tier5:checkHover()
            --cc_extra:checkHover()

            d_tier1:checkHover()
            d_tier2:checkHover()
            d_tier3:checkHover()
            d_tier4:checkHover()
            d_tier5:checkHover()
            --d_extra:checkHover()

            j_tier1:checkHover()
            j_tier2:checkHover()
            j_tier3:checkHover()
            j_tier4:checkHover()
            j_tier5:checkHover()
            --j_extra:checkHover()
        end
    elseif game_mode == modes[9] then
        if event == "training" then
            if #availableForTraining - trainingPageOpen*4 > 0 then
                next_button:checkHover()
            end
            if trainingPageOpen > 1 then
                previous_button:checkHover()
            end
            if availableForTraining[4*(trainingPageOpen - 1) + 1] ~= nil then
                train_1_button:checkHover()
            end
            if availableForTraining[4*(trainingPageOpen - 1) + 2] ~= nil then
                train_2_button:checkHover()
            end
            if availableForTraining[4*(trainingPageOpen - 1) + 3] ~= nil then
                train_3_button:checkHover()
            end
            if availableForTraining[4*(trainingPageOpen - 1) + 4] ~= nil then
                train_4_button:checkHover()
            end
        elseif event == "competing" then
            if #availableForCompeting - competingPageOpen*4 > 0 then
                next_button:checkHover()
            end
            if competingPageOpen > 1 then
                previous_button:checkHover()
            end
            if availableForCompeting[4*(competingPageOpen - 1) + 1] ~= nil then
                compete_1_button:checkHover()
            end
            if availableForCompeting[4*(competingPageOpen - 1) + 2] ~= nil then
                compete_2_button:checkHover()
            end
            if availableForCompeting[4*(competingPageOpen - 1) + 3] ~= nil then
                compete_3_button:checkHover()
            end
            if availableForCompeting[4*(competingPageOpen - 1) + 4] ~= nil then
                compete_4_button:checkHover()
            end
        end
        if event == "competing" and place_window_open == true then
            confirm_place:checkHover()
        end
    elseif game_mode == modes[10] then
        love.audio.play(lake_bg_sounds)
        exit_to_map:checkHover()
        time = time + dt
        if lake_mg.fishingStage == "idle" then
            if time > next_bit then
                lake_mg:determineFish()
                next_bit = 2 + math.random(2, 5)
                time = 0
                lake_mg.fishingStage = "bit"
                love.audio.play(fish_bit)
            end
        elseif lake_mg.fishingStage == "bit" then
            if time <= 0.25 then
                lake_mg.ringQueue = 1
            elseif time > 0.25 and time <= 0.5 then
                lake_mg.ringQueue = 2
            elseif time > 0.5 and time <= 0.75 then
                lake_mg.ringQueue = 3
            elseif time > 0.75 and time <= 1 then
                lake_mg.ringQueue = 4
            elseif time > 1 and time <= 1.25 then
                lake_mg.ringQueue = 5
            elseif time > 1.5 then
                lake_mg.fishingStage = "idle"
                lake_mg.ringQueue = 0
            end
        elseif lake_mg.fishingStage == "catching" then
            if lake_mg.targetRight == true then
                if lake_mg.targetPosition < game_width/2 + 370*sx then
                    lake_mg.targetPosition = lake_mg.targetPosition + 0.7*sx
                else
                    lake_mg.targetRight = false
                end
            else
                if lake_mg.targetPosition > game_width/2 - 500*sx then
                    lake_mg.targetPosition = lake_mg.targetPosition - 0.7*sx
                else
                    lake_mg.targetRight = true
                end
            end
            if lake_mg.fishRight == true then
                if lake_mg.fishPosition < game_width/2 + 410*sx then
                    lake_mg.fishPosition = lake_mg.fishPosition + 1*sx
                else
                    lake_mg.fishRight = false
                end
            else
                if lake_mg.fishPosition > game_width/2 - 500*sx then
                    lake_mg.fishPosition = lake_mg.fishPosition - 1*sx
                else
                    lake_mg.fishRight = true
                end
            end
        elseif lake_mg.fishingStage == "caught" then
            if time > 1.5 then
                lake_mg.fishingStage = "idle"
                playerInventory:addItem(lake_mg.fish, 1)
                lake_mg.fish = nil
                lake_mg.fishImage = nil
                next_bit = 1 + math.random(1, 4)
                time = 0
            end
        end
    elseif game_mode == modes[11] then
        breedButton:checkHover()
        nextMaleButton:checkHover()
        nextFemaleButton:checkHover()
        previousMaleButton:checkHover()
        previousFemaleButton:checkHover()
        myStudsBtn:checkHover()
        paidStudsBtn:checkHover()
    elseif game_mode == modes[12] then
        prevArrow:checkHover()
        nextArrow:checkHover()
        orderTest:checkHover()
    elseif game_mode == modes[13] then
        treat1_button:checkHover()
        treat2_button:checkHover()
        treat3_button:checkHover()
        treat4_button:checkHover()
        nextSickHorses:checkHover()
        previousSickHorses:checkHover()
    elseif game_mode == modes[14] then
        if buying_confirmation == false then
            buyHorse1:checkHover()
            buyHorse2:checkHover()
            buyHorse3:checkHover()
        else
            yes:checkHover()
            no:checkHover()
        end
    elseif game_mode == modes[15] then
        if selling_confirmation == false then
            sellHorse1:checkHover()
            sellHorse2:checkHover()
            sellHorse3:checkHover()
            nextArrow:checkHover()
            prevArrow:checkHover()
        else
            yes:checkHover()
            no:checkHover()
        end
    elseif game_mode == modes[16] then
        myStudsTab:checkHover()
        sotdTab:checkHover()
        if myStudsOpen == true then
            studHorse1:checkHover()
            studHorse2:checkHover()
            studHorse3:checkHover()
            nextArrow:checkHover()
            prevArrow:checkHover()
        else
            buyStudding:checkHover()
        end
    elseif game_mode == modes[17] then
        foodTab:checkHover()
        equipTab:checkHover()
        sellTab:checkHover()

        plus1:checkHover()
        minus1:checkHover()
        plus2:checkHover()
        minus2:checkHover()
        plus3:checkHover()
        minus3:checkHover()
        plus4:checkHover()
        minus4:checkHover()
        plus5:checkHover()
        minus5:checkHover()
        plus6:checkHover()
        minus6:checkHover()
        plus7:checkHover()
        minus7:checkHover()
        plus8:checkHover()
        minus8:checkHover()

        nextArrow:checkHover()
        prevArrow:checkHover()

        if shop.tab ~= 3 then
            buyThings:checkHover()
        else
            sellThings:checkHover()
        end
    end
end


function love.draw()

    local game_width = love.graphics.getWidth()
    local game_height = love.graphics.getHeight()
    
    if game_mode == modes[1] then
        if credits == false then
            renderMenu()
            if savingNotif == true then
                love.graphics.setColor(colorYRed)
                love.graphics.rectangle('fill', game_width/2 - 200*sx, game_height/2 - 100*sx, 400*sx, 100*sy)
                love.graphics.setLineWidth(4)
                love.graphics.setColor(colorGoldenrod)
                love.graphics.rectangle('line', game_width/2 - 200*sx, game_height/2 - 100*sx, 400*sx, 100*sy)
                love.graphics.setFont(bigger_font)
                love.graphics.print("Your game is saved.", game_width/2 - 140*sx, game_height/2 - 70*sx, 0, sx, sy)
            end
            if newGameDialog == true or loadGameDialog == true or exitGameDialog == true then
                newLoadExitGameDialog()
            end
        else
            love.graphics.clear(colorYRed)
            love.graphics.setColor(colorGoldenrod)
            love.graphics.setFont(biggest_font)
            love.graphics.print("CREDITS", game_width/2 - 100*sx, 100*sy, 0, sx, sy)
            love.graphics.setFont(bigger_font)
            love.graphics.print("Music: Livio Amato - Fairy Tale (CC BY-NC-SA 4.0)\nfound on www.freemusicarchive.org",
            game_width/2 - 300*sx, game_height/2 - 200*sy, 0, sx, sy)
            love.graphics.print("Sounds: www.zapsplat.com",
            game_width/2 - 150*sx, game_height/2 - 50*sy, 0, sx, sy)
        end
    elseif game_mode == modes[3] then
        if inventory_open == false then
            love.graphics.clear(115/255, 171/255, 150/255, 1)
            love.graphics.setColor(1,1,1,1)
            map:render()
            renderPanel()
            change_day:render(game_width - 160*sx, game_height - 50*sy, true)
            if musicPlaying == true then
                musicBtn1:render(game_width - 210*sx, game_height - 50*sy, true)
            else
                musicBtn2:render(game_width - 210*sx, game_height - 50*sy, true)
            end
            --magic:render(game_width - 320*sx, game_height - 50*sy, true)
            if questDialogOpen == false then
                if notification == windows[2] then
                    showDeathsNotif()
                elseif notification == windows[3] then
                    showBirthsNotif()
                elseif notification == windows[4] then
                    showGrowingNotif()
                    if buying_confirmation == true then
                        buyStableDialog(true)
                    end
                end
            else
                quest:renderDialogWindow()
                if questTestSubjectsOpen == true then
                    quest:renderTestSubjectMenu()
                end
            end
        else
            playerInventory:render()
            renderPanel()
        end
    elseif game_mode == modes[4] then
        love.graphics.clear(115/255, 171/255, 150/255, 1)
        love.graphics.setColor(1,1,1,1)
        user_stables:render(pair_to_render)
        renderPanel()
        exit_to_map:render(game_width/2 - 50*sx, game_height - 50*sy, true)
        if inventory_open == true then
            playerInventory:render()
            renderPanel()
        end
    elseif game_mode == modes[5] then
        love.graphics.clear(115/255, 171/255, 150/255, 1)
        love.graphics.setColor(1,1,1,1)
        load_stable:render()
        exit_stable:render(50*sx, 50*sy, true)
        renderPanel()
        if load_stable.empty == false then
            load_stable:showHorseInfo()
            if load_stable.horse.preg == -1 and load_stable.horse.equipped == true and load_stable.horse.effects[1] == false then
                if load_stable.horse.eq_hidden == true then
                    show_equip_button:render(game_width/2 - 127*sx, game_height - 50*sy)
                else
                    hide_equip_button:render(game_width/2 - 127*sx, game_height - 50*sy)
                end
            end
        end
        if name_window_open == true then
            renderNameWindow()
            love.graphics.print(name_text, game_width/2 - 110 * sx, game_height/2 - 135 * sy)
            confirm_edit_name:render(game_width/2 - 50 * sx, game_height/2 - 60 * sy, true)
        end
        if inventory_open == true then
            playerInventory:render()
        end
        if changing_spec == true then
            changeSpecDialog()
        end
        if choosing_equipment == true then
            playerInventory:renderEquipment()
            if chosen_bridle == nil or chosen_pad == nil or chosen_saddle == nil then
                confirm_equipment:render(game_width - 120*sx, game_height - 100*sy, false)
            else
                confirm_equipment:render(game_width - 120*sx, game_height - 100*sy, true)
            end
        end
    elseif game_mode == modes[6] then
        love.graphics.setColor(1,1,1,1)
        renderMedicalCentreMenu()
    elseif game_mode == modes[7] then
        renderShopAndMarket()
    elseif game_mode == modes[8] then
        renderTrainingMenu()
        if event == "training" then
            love.graphics.setColor(1,1,1,1)
            love.graphics.draw(cross_train, 265*sx, game_height/2 - 200*sy, 0, 1.25*sx, 1.25*sy)
            cross_training_button:render(320*sx, game_height/2 + 120 * sy, true)
            love.graphics.draw(jumping_train, game_width/2 - 155*sx, game_height/2 - 200*sy, 0, 1.1*sx, 1.1*sy)
            jumping_training_button:render(game_width/2 - 160*sx, game_height/2 + 120 * sy, true)
            love.graphics.draw(dressage_train, game_width/2 + 315*sx, game_height/2 - 200*sy, 0, sx, sy)
            dressage_training_button:render(game_width/2 + 310*sx, game_height/2 + 120 * sy, true)
        elseif event == "competing" then
            love.graphics.setFont(bigger_font)
            love.graphics.print("Cross-country", 370*sx, game_height/2 - 270 * sy)
            cc_tier1:render(410*sx, game_height/2 - 180 * sy, true)
            cc_tier2:render(410*sx, game_height/2 - 100 * sy, true)
            cc_tier3:render(410*sx, game_height/2 - 20 * sy, true)
            cc_tier4:render(410*sx, game_height/2 + 60 * sy, true)
            cc_tier5:render(410*sx, game_height/2 + 140 * sy, true)
            --cc_extra:render()
            love.graphics.setColor(colorGoldenrod)
            love.graphics.print("Jumping", game_width/2 - 90*sx, game_height/2 - 270 * sy)
            j_tier1:render(game_width/2 - 98*sx, game_height/2 - 180 * sy, true)
            j_tier2:render(game_width/2 - 98*sx, game_height/2 - 100 * sy, true)
            j_tier3:render(game_width/2 - 98*sx, game_height/2 - 20 * sy, true)
            j_tier4:render(game_width/2 - 98*sx, game_height/2 + 60 * sy, true)
            j_tier5:render(game_width/2 - 98*sx, game_height/2 + 140 * sy, true)
            --j_extra:render()
            love.graphics.setColor(colorGoldenrod)
            love.graphics.print("Dressage", game_width/2 + 350*sx, game_height/2 - 270 * sy)
            d_tier1:render(game_width/2 + 345*sx, game_height/2 - 180 * sy, true)
            d_tier2:render(game_width/2 + 345*sx, game_height/2 - 100 * sy, true)
            d_tier3:render(game_width/2 + 345*sx, game_height/2 - 20 * sy, true)
            d_tier4:render(game_width/2 + 345*sx, game_height/2 + 60 * sy, true)
            d_tier5:render(game_width/2 + 345*sx, game_height/2 + 140 * sy, true)
            --d_extra:render()
        end
        renderPanel()
    elseif game_mode == modes[9] then
        renderHorsesList(event, event_type)
        renderPanel()
        if event == "competing" and place_window_open == true then
            displayCompetitionResults(compResults[1], compResults[2])
            confirm_place:render(game_width/2 - 50 * sx, game_height/2 - 60 * sy, true)
        end
    elseif game_mode == modes[10] then
        lake_mg:render()
    elseif game_mode == modes[11] then
        renderBreedingMenu()
        renderPanel()
    elseif game_mode == modes[12] then
        renderGeneticTest()
    elseif game_mode == modes[13] then
        renderTreatmentMenu()
        renderPanel()
    elseif game_mode == modes[14] then
        renderMarketHorses()
        if buying_confirmation == true then
            buyStableDialog(true)
        end
        renderPanel()
    elseif game_mode == modes[15] then
        renderHorsesForSale()
        if selling_confirmation == true then
            sellHorseDialog()
        end
        renderPanel()
    elseif game_mode == modes[16] then
        if myStudsOpen == false then
            renderStudOfTheDay()
            renderPanel()
        else
            renderMyStuds()
            renderPanel()
        end
    elseif game_mode == modes[17] then
        shop:render()
        renderPanel()
    end
end