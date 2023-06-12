Quest = Class{}

function Quest:init(stage)
    self.stage = stage
    self.scientist = love.graphics.newImage("images/scientist.png")
end

function Quest:renderDialogWindow()
    local game_width = love.graphics.getWidth()
    local game_height = love.graphics.getHeight()

    love.graphics.setColor(colorYRed)
    love.graphics.rectangle("fill", game_width/2 - 500*sx, game_height/2 - 350*sy, 1000*sx, 700*sy)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.rectangle("line", game_width/2 - 500*sx, game_height/2 - 350*sy, 1000*sx, 700*sy)
    love.graphics.setColor(colorJasmine)
    love.graphics.rectangle("fill", game_width/2 - 450*sx, game_height/2 - 270*sy, 350*sx, 500*sy)
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(self.scientist, game_width/2 - 440*sx, game_height/2 - 260*sy, 0, sx, sy)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.rectangle("line", game_width/2 - 450*sx, game_height/2 - 270*sy, 350*sx, 500*sy)
    love.graphics.setFont(bigger_font)
    love.graphics.print("Jonathan", game_width/2 - 350*sx, game_height/2 + 240*sy, 0, sx, sy)

    if self.stage == 1 then
        love.graphics.setColor(colorGoldenrod)
        love.graphics.setFont(medium_font)
        love.graphics.print("Hello! My name is Jonathan. I've seen you\non the lake a couple of times, fishing. I\nhave a favor to ask of you. I'm notoriously\nbad at fishing, the only thing I'd achieve is\nthat all the fish in the lake would grow legs\nand flee to a better place. So... Would you be\nso kind and bring me five fish of every color?\nI need them for my experiments. Don't worry,\nyou will be rewarded. Take all the time you\nneed, I'm not going anywhere.\nOh, my experiments? I'm a scientist.",
        game_width/2 - 60*sx, game_height/2 - 240*sy, 0, sx, sy)
        love.graphics.setColor(1,1,1,1)
        okBtn:render(game_width/2 + 100*sx, game_height/2 + 230*sy, true)
        self.color = "random"
    elseif self.stage == 2 then
        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(love.graphics.newImage("images/red_fish.png"), game_width/2 - 30*sx, game_height/2 - 150*sy, 0, 0.4*sx, 0.4*sy)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print(playerInventory.items[31] .. "/5", game_width/2 + 60*sx, game_height/2 - 145*sy, 0, sx, sy)
        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(love.graphics.newImage("images/orange_fish.png"), game_width/2 - 30*sx, game_height/2 - 80*sy, 0, 0.4*sx, 0.4*sy)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print(playerInventory.items[32] .. "/5", game_width/2 + 60*sx, game_height/2 - 75*sy, 0, sx, sy)
        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(love.graphics.newImage("images/yellow_fish.png"), game_width/2 - 30*sx, game_height/2 - 10*sy, 0, 0.4*sx, 0.4*sy)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print(playerInventory.items[33] .. "/5", game_width/2 + 60*sx, game_height/2 - 5*sy, 0, sx, sy)
        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(love.graphics.newImage("images/green_fish.png"), game_width/2 - 30*sx, game_height/2 + 60*sy, 0, 0.4*sx, 0.4*sy)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print(playerInventory.items[34] .. "/5", game_width/2 + 60*sx, game_height/2 + 65*sy, 0, sx, sy)

        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(love.graphics.newImage("images/turquoise_fish.png"), game_width/2 + 180*sx, game_height/2 - 150*sy, 0, 0.4*sx, 0.4*sy)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print(playerInventory.items[35] .. "/5", game_width/2 + 270*sx, game_height/2 - 145*sy, 0, sx, sy)
        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(love.graphics.newImage("images/blue_fish.png"), game_width/2 + 180*sx, game_height/2 - 80*sy, 0, 0.4*sx, 0.4*sy)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print(playerInventory.items[36] .. "/5", game_width/2 + 270*sx, game_height/2 - 75*sy, 0, sx, sy)
        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(love.graphics.newImage("images/violet_fish.png"), game_width/2 + 180*sx, game_height/2 - 10*sy, 0, 0.4*sx, 0.4*sy)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print(playerInventory.items[37] .. "/5", game_width/2 + 270*sx, game_height/2 - 5*sy, 0, sx, sy)

        if playerInventory.items[31] >= 5 and playerInventory.items[32] >= 5 and playerInventory.items[33] >= 5
        and playerInventory.items[34] >= 5 and playerInventory.items[35] >= 5 and playerInventory.items[36] >= 5
        and playerInventory.items[37] >= 5 then
            love.graphics.setColor(colorGoldenrod)
            love.graphics.setFont(medium_font)
            love.graphics.print("Let's see what we have here...\nYes, it's more than enough! Thank you!",
            game_width/2 - 60*sx, game_height/2 - 250*sy, 0, sx, sy)
            giveFishBtn:render(game_width/2 + 50*sx, game_height/2 + 230*sy, true)
        else
            love.graphics.setColor(colorGoldenrod)
            love.graphics.setFont(medium_font)
            love.graphics.print("Let's see what we have here...",
            game_width/2 - 60*sx, game_height/2 - 240*sy, 0, sx, sy)
            giveFishBtn:render(game_width/2 + 50*sx, game_height/2 + 230*sy, false)
        end
    elseif self.stage == 3 then
        love.graphics.setColor(colorGoldenrod)
        love.graphics.setFont(medium_font)
        love.graphics.print("Umm, about the reward... I just thought of\na better idea! I will share the results of my\nexperiments with you. I promise, they will\nbe worth a fortune. So, if you're still\ninterested... I've heard rumors about a\nrainbow fish living in the lake. It is\nreally difficult to catch, but I'm sure\nyou have all the needed skills and luck.\nI have a feeling it will have a crucial role\nin my last experiment.\nI need five rainbow fish.",
            game_width/2 - 60*sx, game_height/2 - 240*sy, 0, sx, sy)
        okBtn:render(game_width/2 + 100*sx, game_height/2 + 230*sy, true)
    elseif self.stage == 4 then
        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(love.graphics.newImage("images/rainbow_fish.png"), game_width/2 - 30*sx, game_height/2 - 150*sy, 0, 0.4*sx, 0.4*sy)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print(playerInventory.items[38] .. "/5", game_width/2 + 60*sx, game_height/2 - 145*sy, 0, sx, sy)
        if playerInventory.items[38] >= 5 then
            love.graphics.setColor(colorGoldenrod)
            love.graphics.setFont(medium_font)
            love.graphics.print("Let's see what we have here... I knew you\nwere good at fishing, but your luck is\nsomething else.",
            game_width/2 - 60*sx, game_height/2 - 270*sy, 0, sx, sy)
            giveFishBtn:render(game_width/2 + 50*sx, game_height/2 + 230*sy, true)
        else
            love.graphics.setColor(colorGoldenrod)
            love.graphics.setFont(medium_font)
            love.graphics.print("Let's see what we have here...",
            game_width/2 - 60*sx, game_height/2 - 230*sy, 0, sx, sy)
            giveFishBtn:render(game_width/2 + 50*sx, game_height/2 + 230*sy, false)
        end
    elseif self.stage == 5 then
        love.graphics.setColor(colorGoldenrod)
        love.graphics.setFont(medium_font)
        love.graphics.print("Thank you. I'm at the last stage of my\nexperiment. I know it is too much to ask,\nbut could you give me one of your horses?\nI won't harm it in any way.",
            game_width/2 - 60*sx, game_height/2 - 240*sy, 0, sx, sy)
        okBtn:render(game_width/2 + 100*sx, game_height/2 + 230*sy, true)
    elseif self.stage == 6 or self.stage == 12 then
        love.graphics.setColor(colorGoldenrod)
        love.graphics.setFont(medium_font)
        love.graphics.print("Choose a horse when you're ready.", game_width/2 - 60*sx, game_height/2 - 240*sy, 0, sx, sy)
        chooseHorseBtn:render(game_width/2 + 50*sx, game_height/2 + 230*sy, false)
    elseif self.stage == 7 then
        love.graphics.setColor(colorGoldenrod)
        love.graphics.setFont(medium_font)
        love.graphics.print("My experiment is not completed yet... I'll\ninform you when everything's ready!", game_width/2 - 60*sx, game_height/2 - 240*sy, 0, sx, sy)
        okBtn:render(game_width/2 + 100*sx, game_height/2 + 230*sy, true)
    elseif self.stage == 8 then
        love.graphics.setColor(colorGoldenrod)
        love.graphics.setFont(medium_font)
        love.graphics.print("My experiment is finally completed. Check your\nstables, your present is waiting here!", game_width/2 - 60*sx, game_height/2 - 240*sy, 0, sx, sy)
        okBtn:render(game_width/2 + 100*sx, game_height/2 + 230*sy, true)
    elseif self.stage == 9 then
        love.graphics.setColor(colorGoldenrod)
        love.graphics.setFont(medium_font)
        love.graphics.print("Sorry, I don't have any tasks for you at\nthe moment.", game_width/2 - 60*sx, game_height/2 - 240*sy, 0, sx, sy)
        okBtn:render(game_width/2 + 100*sx, game_height/2 + 230*sy, true)
    elseif self.stage == 10 then
        love.graphics.setColor(colorGoldenrod)
        love.graphics.setFont(medium_font)
        love.graphics.print("Hello again. I think we can repeat our\nexperiment. This time you can choose\nwhich color your kelpie will be! There's\na small chance I'll manage to create a\nrainbow one.", game_width/2 - 60*sx, game_height/2 - 240*sy, 0, sx, sy)
        
        kred:render(game_width/2 - 60*sx, game_height/2 - 10*sy, true)
        korange:render(game_width/2 + 70*sx, game_height/2 - 10*sy, true)
        kyellow:render(game_width/2 + 250*sx, game_height/2 - 10*sy, true)
        kgreen:render(game_width/2 - 20*sx, game_height/2 + 60*sy, true)
        kturquoise:render(game_width/2 + 160*sx, game_height/2 + 60*sy, true)
        kblue:render(game_width/2 + 10*sx, game_height/2 + 130*sy, true)
        kpurple:render(game_width/2 + 160*sx, game_height/2 + 130*sy, true)
    elseif self.stage == 11 then
        love.graphics.setColor(colorGoldenrod)
        love.graphics.setFont(medium_font)
        love.graphics.print("Here's what I need.", game_width/2 - 60*sx, game_height/2 - 240*sy, 0, sx, sy)

        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(love.graphics.newImage("images/" .. self.color .. "_fish.png"), game_width/2 - 30*sx, game_height/2 - 150*sy, 0, 0.4*sx, 0.4*sy)
        love.graphics.setColor(colorGoldenrod)
        local itemNo
        for k, v in ipairs(playerInventory.itemkeys) do
            if v == self.color .. "fish" then
                itemNo = k
            end
        end
        love.graphics.print(playerInventory.items[itemNo] .. "/10", game_width/2 + 60*sx, game_height/2 - 145*sy, 0, sx, sy)
        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(love.graphics.newImage("images/rainbow_fish.png"), game_width/2 + 180*sx, game_height/2 - 150*sy, 0, 0.4*sx, 0.4*sy)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print(playerInventory.items[38] .. "/1", game_width/2 + 270*sx, game_height/2 - 145*sy, 0, sx, sy)

        if playerInventory.items[itemNo] >= 10 and playerInventory.items[38] >= 1 then
            giveFishBtn:render(game_width/2 + 50*sx, game_height/2 + 230*sy, true)
        else
            giveFishBtn:render(game_width/2 + 50*sx, game_height/2 + 230*sy, false)
        end
    elseif self.stage == 13 then
        love.graphics.setColor(colorGoldenrod)
        love.graphics.setFont(medium_font)
        love.graphics.print("My experiment is not completed yet... I'll\ninform you when everything's ready!", game_width/2 - 60*sx, game_height/2 - 240*sy, 0, sx, sy)
        okBtn:render(game_width/2 + 100*sx, game_height/2 + 230*sy, true)
    elseif self.stage == 14 then
        love.graphics.setColor(colorGoldenrod)
        love.graphics.setFont(medium_font)
        love.graphics.print("My experiment is finally completed. Check your\nstables, your present is waiting here!", game_width/2 - 60*sx, game_height/2 - 240*sy, 0, sx, sy)
        okBtn:render(game_width/2 + 100*sx, game_height/2 + 230*sy, true)
    end
end

function Quest:renderTestSubjectMenu()
    local game_width = love.graphics.getWidth()
    local game_height = love.graphics.getHeight()

    love.graphics.setColor(colorYRed)
    love.graphics.rectangle('fill', game_width/2 - 350*sx, game_height/2 - 450*sy, 700*sx, 865*sy)
    love.graphics.setLineWidth(4)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.rectangle('line', game_width/2 - 350*sx, game_height/2 - 450*sy, 700*sx, 865*sy)

    testSubjects = {}

    for k, stable in ipairs(user_stables.stables) do
        if stable.horse ~= nil then
            if stable.horse.age_y >= 2 and stable.horse.preg == -1 and stable.horse.foal == nil
            and stable.horse.effects[1] == false and stable.horse.life_state == "horse" then
                testSubjects[#testSubjects + 1] = stable:getHorse()
            end
        end
    end

    if #testSubjects == 0 then
        love.graphics.setFont(bigger_font)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print("You don't have any", game_width/2 - 170*sx, game_height/2 - 210*sy)
        love.graphics.print("suitable horses.", game_width/2 - 160*sx, game_height/2 - 150*sy)
    else
        if testSubjects[4*(subjectPage - 1) + 1] ~= nil then
            testSubjects[4*(subjectPage - 1) + 1]:showSubjectInfo(1)
        end
        if testSubjects[4*(subjectPage - 1) + 2] ~= nil then
            testSubjects[4*(subjectPage - 1) + 2]:showSubjectInfo(2)
        end
        if testSubjects[4*(subjectPage - 1) + 3] ~= nil then
            testSubjects[4*(subjectPage - 1) + 3]:showSubjectInfo(3)
        end
        if testSubjects[4*(subjectPage - 1) + 4] ~= nil then
            testSubjects[4*(subjectPage - 1) + 4]:showSubjectInfo(4)
        end
    end

    if #testSubjects - subjectPage*4 > 0 then
        nextTestSubjects:render(game_width/2 + 20*sx, game_height/2 + 350*sy, true)
    end
    if subjectPage > 1 then
        previousTestSubjects:render(game_width/2 - 100*sx, game_height/2 + 350*sy, true)
    end
end