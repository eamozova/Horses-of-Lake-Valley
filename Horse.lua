Horse = Class{}

function Horse:init(name, age_y, age_m, gender, genes, specialization, equipped, equipment, eq_hidden,
    coat_layers, gen_skills, cur_skills, health, energy, mood, needs, effects,
    preg, foal_parent, foal, life_state, kelpie_traits, tested)

    self.name = name
    self.gender = gender
    self.age_y = age_y
    self.age_m = age_m
    self.genes = genes

    self.specialization = specialization
    self.equipped = equipped
    self.equipment = equipment
    self.eq_hidden = eq_hidden

    self.health = health
    self.energy = energy
    self.mood = mood
    self.needs = needs
    self.effects = effects

    self.preg = preg
    self.foal_parent = foal_parent

    self.gen_skills = gen_skills
    self.cur_skills = cur_skills

    self.coat_layers = coat_layers

    self.foal = foal

    self.life_state = life_state
    self.kelpie_traits = kelpie_traits

    self.tested = tested
end

function Horse:generate()
    
    age_y = math.random(2, 10)
    age_m = math.random(0, 11)

    if math.random(2) == 1 then
        gender = "f"
        name = "Mare"
    else
        gender = "m"
        name = "Stallion"
    end

    genes = {}
    gen_skills = {}
    cur_skills = {}

    genes = Horse:generateNewGenes()
    
    gen_skills = Horse:generateNewSkills()

    cur_skills = Horse:generateCurSkills(gen_skills)

    coat_layers = {}

    local coatInfo = {}
    coatInfo = Horse:coatToDisplay(genes, "horse", {})

    local coat = coatInfo[1]
    local mane_data = coatInfo[2]
    local markings = coatInfo[3]

    for k, v in ipairs(coat) do
        coat_layers[#coat_layers + 1] = v
    end

    if type(markings) == "table" then
        for k, v in ipairs(markings) do
            coat_layers[#coat_layers + 1] = v
        end
    elseif type(markings) == "string" then
        coat_layers[#coat_layers + 1] = markings
    end

    coat_layers[#coat_layers + 1] = "line/horse_base.png"

    for k, v in ipairs(mane_data) do
        coat_layers[#coat_layers + 1] = v
    end

    coat_layers[#coat_layers + 1] = "line/mane_tail_wild.png"

    return Horse(name, age_y, age_m, gender, genes, 'none', false, {nil, nil, nil}, false, coat_layers, gen_skills, cur_skills,
    --health
    100,
    --energy
    100,
    --mood
    100,
    -- needs (food, water, hygiene)
    {true, true, true},
    {false},
    -1, -1, nil, "horse", {}, false)
end

function Horse:generateGender(gen)
    
    age_y = math.random(2, 10)
    age_m = math.random(0, 11)

    if gen == "f" then
        gender = "f"
        name = "Mare"
    elseif gen == "m" then
        gender = "m"
        name = "Stallion"
    end

    genes = {}
    gen_skills = {}
    cur_skills = {}

    genes = Horse:generateNewGenes()
    
    gen_skills = Horse:generateNewSkills()

    cur_skills = Horse:generateCurSkills(gen_skills)

    coat_layers = {}

    local coatInfo = {}
    coatInfo = Horse:coatToDisplay(genes, "horse", {})

    local coat = coatInfo[1]
    local mane_data = coatInfo[2]
    local markings = coatInfo[3]

    for k, v in ipairs(coat) do
        coat_layers[#coat_layers + 1] = v
    end

    if type(markings) == "string" then
        coat_layers[#coat_layers + 1] = markings
    else
        for k, v in ipairs(markings) do
            coat_layers[#coat_layers + 1] = v
        end
    end

    coat_layers[#coat_layers + 1] = "line/horse_base.png"

    for k, v in ipairs(mane_data) do
        coat_layers[#coat_layers + 1] = v
    end

    coat_layers[#coat_layers + 1] = "line/mane_tail_wild.png"

    return Horse(name, age_y, age_m, gender, genes, 'none', false, {nil, nil, nil}, false, coat_layers, gen_skills, cur_skills,
    --health
    100,
    --energy
    100,
    --mood
    100,
    -- needs (food, water, hygiene)
    {true, true, true},
    {false},
    -1, -1, nil, "horse", {}, false)
end

function Horse:generateFoal()
    
    age_y = 0
    age_m = 1

    name = "Foal"

    if math.random(2) == 1 then
        gender = "f"
    else
        gender = "m"
    end

    genes = {}
    gen_skills = {}
    cur_skills = {}

    genes = Horse:generateNewGenes()
    
    gen_skills = Horse:generateNewSkills()

    cur_skills = {0,0,0,0}

    coat_layers = {}

    local coatInfo = {}
    coatInfo = Horse:coatToDisplay(genes, "horse", {})

    local coat = coatInfo[1]
    local mane_data = coatInfo[2]
    local markings = coatInfo[3]

    for k, v in ipairs(coat) do
        coat_layers[#coat_layers + 1] = v
    end

    if type(markings) == "table" then
        for k, v in ipairs(markings) do
            coat_layers[#coat_layers + 1] = v
        end
    elseif type(markings) == "string" then
        coat_layers[#coat_layers + 1] = markings
    end

    coat_layers[#coat_layers + 1] = "line/foal_base.png"

    for k, v in ipairs(mane_data) do
        coat_layers[#coat_layers + 1] = v
    end

    coat_layers[#coat_layers + 1] = "line/mane_tail_foal.png"

    return Horse(name, age_y, age_m, gender, genes, 'none', false, {nil, nil, nil}, false, coat_layers, gen_skills, cur_skills,
    --health
    100,
    --energy
    100,
    --mood
    100,
    -- needs (food, water, hygiene)
    {true, true, true},
    {false},
    -1, -1, nil, "horse", {}, false)
end

function Horse:generateOffspring(parent1, geneset)
    local name = "Foal"

    age_y = 0
    age_m = 0

    if math.random(2) == 1 then
        gender = "f"
    else
        gender = "m"
    end

    local lifestate = ""
    local traits = {}

    if parent1.life_state == "horse" and geneset[4] == "horse" then
        lifestate = "horse"
    elseif parent1.life_state == "kelpie" and geneset[4] == "kelpie" then
        lifestate = "kelpie"
    elseif (parent1.life_state == "kelpie" and geneset[4] == "horse")
    or (parent1.life_state == "horse" and geneset[4] == "kelpie") then
        local chance = math.random(10)
        if chance < 3 then
            lifestate = "horse"
        elseif chance == 3 then
            lifestate = "kelpie"
        else
            lifestate = "hybrid"
        end
    elseif (parent1.life_state == "kelpie" and geneset[4] == "hybrid")
    or (parent1.life_state == "hybrid" and geneset[4] == "kelpie") then
        local chance = math.random(10)
        if chance == 1 then
            lifestate = "horse"
        elseif chance > 1 and chance < 5 then
            lifestate = "kelpie"
        else
            lifestate = "hybrid"
        end
    elseif (parent1.life_state == "horse" and geneset[4] == "hybrid")
    or (parent1.life_state == "hybrid" and geneset[4] == "horse") then
        local chance = math.random(10)
        if chance < 6 then
            lifestate = "horse"
        else
            lifestate = "hybrid"
        end
    elseif parent1.life_state == "hybrid" and geneset[4] == "hybrid" then
        local chance = math.random(10)
        if chance < 3 then
            lifestate = "horse"
        else
            lifestate = "hybrid"
        end
    end

    if (parent1.life_state == "kelpie" or parent1.life_state == "hybrid")
    and (geneset[4] == "kelpie" or geneset[4] == "hybrid") then
        if parent1.kelpie_traits[1] == "red" and geneset[5][1] == "red" then
            traits[1] = "red"
        elseif (parent1.kelpie_traits[1] == "red" and geneset[5][1] == "orange")
        or (parent1.kelpie_traits[1] == "orange" and geneset[5][1] == "red") then
            local chance = math.random(2)
            if chance == 1 then
                traits[1] = "red"
            else
                traits[1] = "orange"
            end
        elseif (parent1.kelpie_traits[1] == "red" and geneset[5][1] == "yellow")
        or (parent1.kelpie_traits[1] == "yellow" and geneset[5][1] == "red") then
            local chance = math.random(3)
            if chance == 1 then
                traits[1] = "red"
            elseif chance == 2 then
                traits[1] = "orange"
            else
                traits[1] = "yellow"
            end
        elseif (parent1.kelpie_traits[1] == "red" and geneset[5][1] == "green")
        or (parent1.kelpie_traits[1] == "green" and geneset[5][1] == "red") then
            local chance = math.random(3)
            if chance == 1 then
                traits[1] = "orange"
            elseif chance == 2 then
                traits[1] = "yellow"
            else
                traits[1] = "green"
            end
        elseif (parent1.kelpie_traits[1] == "red" and geneset[5][1] == "turquoise")
        or (parent1.kelpie_traits[1] == "turquoise" and geneset[5][1] == "red") then
            local chance = math.random(3)
            if chance == 1 then
                traits[1] = "yellow"
            elseif chance == 2 then
                traits[1] = "green"
            else
                traits[1] = "turquoise"
            end
        elseif (parent1.kelpie_traits[1] == "red" and geneset[5][1] == "blue")
        or (parent1.kelpie_traits[1] == "blue" and geneset[5][1] == "red") then
            local chance = math.random(4)
            if chance == 1 then
                traits[1] = "green"
            elseif chance == 2 then
                traits[1] = "turquoise"
            elseif chance == 3 then
                traits[1] = "blue"
            else
                traits[1] = "purple"
            end
        elseif (parent1.kelpie_traits[1] == "red" and geneset[5][1] == "purple")
        or (parent1.kelpie_traits[1] == "purple" and geneset[5][1] == "red") then
            local chance = math.random(2)
            if chance == 1 then
                traits[1] = "red"
            else
                traits[1] = "purple"
            end
        elseif (parent1.kelpie_traits[1] == "red" and geneset[5][1] == "rainbow")
        or (parent1.kelpie_traits[1] == "rainbow" and geneset[5][1] == "red") then
            local chance = math.random(17)
            if chance < 5 then
                traits[1] = "red"
            elseif chance == 5 or chance == 6 then
                traits[1] = "orange"
            elseif chance == 7 or chance == 8 then
                traits[1] = "yellow"
            elseif chance == 9 or chance == 10 then
                traits[1] = "green"
            elseif chance == 11 or chance == 12 then
                traits[1] = "turquoise"
            elseif chance == 13 or chance == 14 then
                traits[1] = "blue"
            elseif chance == 15 or chance == 16 then
                traits[1] = "purple"
            else
                traits[1] = "rainbow"
            end
        elseif parent1.kelpie_traits[1] == "orange" and geneset[5][1] == "orange" then
            traits[1] = "orange"
        elseif (parent1.kelpie_traits[1] == "orange" and geneset[5][1] == "yellow")
        or (parent1.kelpie_traits[1] == "yellow" and geneset[5][1] == "orange") then
            local chance = math.random(2)
            if chance == 1 then
                traits[1] = "orange"
            else
                traits[1] = "yellow"
            end
        elseif (parent1.kelpie_traits[1] == "orange" and geneset[5][1] == "green")
        or (parent1.kelpie_traits[1] == "green" and geneset[5][1] == "orange") then
            local chance = math.random(3)
            if chance == 1 then
                traits[1] = "orange"
            elseif chance == 2 then
                traits[1] = "yellow"
            else
                traits[1] = "green"
            end
        elseif (parent1.kelpie_traits[1] == "orange" and geneset[5][1] == "turquoise")
        or (parent1.kelpie_traits[1] == "turquoise" and geneset[5][1] == "orange") then
            local chance = math.random(3)
            if chance == 1 then
                traits[1] = "yellow"
            elseif chance == 2 then
                traits[1] = "green"
            else
                traits[1] = "turquoise"
            end
        elseif (parent1.kelpie_traits[1] == "orange" and geneset[5][1] == "blue")
        or (parent1.kelpie_traits[1] == "blue" and geneset[5][1] == "orange") then
            local chance = math.random(3)
            if chance == 1 then
                traits[1] = "green"
            elseif chance == 2 then
                traits[1] = "turquoise"
            else
                traits[1] = "blue"
            end
        elseif (parent1.kelpie_traits[1] == "orange" and geneset[5][1] == "purple")
        or (parent1.kelpie_traits[1] == "purple" and geneset[5][1] == "orange") then
            local chance = math.random(3)
            if chance == 1 then
                traits[1] = "red"
            elseif chance == 2 then
                traits[1] = "orange"
            else
                traits[1] = "purple"
            end
        elseif (parent1.kelpie_traits[1] == "orange" and geneset[5][1] == "rainbow")
        or (parent1.kelpie_traits[1] == "rainbow" and geneset[5][1] == "orange") then
            local chance = math.random(17)
            if chance < 5 then
                traits[1] = "orange"
            elseif chance == 5 or chance == 6 then
                traits[1] = "red"
            elseif chance == 7 or chance == 8 then
                traits[1] = "yellow"
            elseif chance == 9 or chance == 10 then
                traits[1] = "green"
            elseif chance == 11 or chance == 12 then
                traits[1] = "turquoise"
            elseif chance == 13 or chance == 14 then
                traits[1] = "blue"
            elseif chance == 15 or chance == 16 then
                traits[1] = "purple"
            else
                traits[1] = "rainbow"
            end
        elseif parent1.kelpie_traits[1] == "yellow" and geneset[5][1] == "yellow" then
            traits[1] = "yellow"
        elseif (parent1.kelpie_traits[1] == "yellow" and geneset[5][1] == "green")
        or (parent1.kelpie_traits[1] == "green" and geneset[5][1] == "yellow") then
            local chance = math.random(2)
            if chance == 1 then
                traits[1] = "yellow"
            else
                traits[1] = "green"
            end
        elseif (parent1.kelpie_traits[1] == "yellow" and geneset[5][1] == "turquoise")
        or (parent1.kelpie_traits[1] == "turquoise" and geneset[5][1] == "yellow") then
            local chance = math.random(2)
            if chance == 1 then
                traits[1] = "green"
            else
                traits[1] = "turquoise"
            end
        elseif (parent1.kelpie_traits[1] == "yellow" and geneset[5][1] == "blue")
        or (parent1.kelpie_traits[1] == "blue" and geneset[5][1] == "yellow") then
            local chance = math.random(2)
            if chance == 1 then
                traits[1] = "green"
            else
                traits[1] = "turquoise"
            end
        elseif (parent1.kelpie_traits[1] == "yellow" and geneset[5][1] == "purple")
        or (parent1.kelpie_traits[1] == "purple" and geneset[5][1] == "yellow") then
            local chance = math.random(2)
            if chance == 1 then
                traits[1] = "red"
            else
                traits[1] = "orange"
            end
        elseif (parent1.kelpie_traits[1] == "yellow" and geneset[5][1] == "rainbow")
        or (parent1.kelpie_traits[1] == "rainbow" and geneset[5][1] == "yellow") then
            local chance = math.random(17)
            if chance < 5 then
                traits[1] = "yellow"
            elseif chance == 5 or chance == 6 then
                traits[1] = "red"
            elseif chance == 7 or chance == 8 then
                traits[1] = "orange"
            elseif chance == 9 or chance == 10 then
                traits[1] = "green"
            elseif chance == 11 or chance == 12 then
                traits[1] = "turquoise"
            elseif chance == 13 or chance == 14 then
                traits[1] = "blue"
            elseif chance == 15 or chance == 16 then
                traits[1] = "purple"
            else
                traits[1] = "rainbow"
            end
        elseif parent1.kelpie_traits[1] == "green" and geneset[5][1] == "green" then
            traits[1] = "green"
        elseif (parent1.kelpie_traits[1] == "green" and geneset[5][1] == "turquoise")
        or (parent1.kelpie_traits[1] == "turquoise" and geneset[5][1] == "green") then
            local chance = math.random(2)
            if chance == 1 then
                traits[1] = "green"
            else
                traits[1] = "turquoise"
            end
        elseif (parent1.kelpie_traits[1] == "green" and geneset[5][1] == "blue")
        or (parent1.kelpie_traits[1] == "blue" and geneset[5][1] == "green") then
            local chance = math.random(2)
            if chance == 1 then
                traits[1] = "green"
            else
                traits[1] = "blue"
            end
        elseif (parent1.kelpie_traits[1] == "green" and geneset[5][1] == "purple")
        or (parent1.kelpie_traits[1] == "purple" and geneset[5][1] == "green") then
            local chance = math.random(2)
            if chance == 1 then
                traits[1] = "green"
            else
                traits[1] = "blue"
            end
        elseif (parent1.kelpie_traits[1] == "green" and geneset[5][1] == "rainbow")
        or (parent1.kelpie_traits[1] == "rainbow" and geneset[5][1] == "green") then
            local chance = math.random(17)
            if chance < 5 then
                traits[1] = "green"
            elseif chance == 5 or chance == 6 then
                traits[1] = "red"
            elseif chance == 7 or chance == 8 then
                traits[1] = "orange"
            elseif chance == 9 or chance == 10 then
                traits[1] = "yellow"
            elseif chance == 11 or chance == 12 then
                traits[1] = "turquoise"
            elseif chance == 13 or chance == 14 then
                traits[1] = "blue"
            elseif chance == 15 or chance == 16 then
                traits[1] = "purple"
            else
                traits[1] = "rainbow"
            end
        elseif parent1.kelpie_traits[1] == "turquoise" and geneset[5][1] == "turquoise" then
            traits[1] = "turquoise"
        elseif (parent1.kelpie_traits[1] == "turquoise" and geneset[5][1] == "blue")
        or (parent1.kelpie_traits[1] == "blue" and geneset[5][1] == "turquoise") then
            local chance = math.random(2)
            if chance == 1 then
                traits[1] = "turquoise"
            else
                traits[1] = "blue"
            end
        elseif (parent1.kelpie_traits[1] == "turquoise" and geneset[5][1] == "purple")
        or (parent1.kelpie_traits[1] == "purple" and geneset[5][1] == "turquoise") then
            local chance = math.random(3)
            if chance == 1 then
                traits[1] = "turquoise"
            elseif chance == 2 then
                traits[1] = "blue"
            else
                traits[1] = "purple"
            end
        elseif (parent1.kelpie_traits[1] == "turquoise" and geneset[5][1] == "rainbow")
        or (parent1.kelpie_traits[1] == "rainbow" and geneset[5][1] == "turquoise") then
            local chance = math.random(17)
            if chance < 5 then
                traits[1] = "turquoise"
            elseif chance == 5 or chance == 6 then
                traits[1] = "red"
            elseif chance == 7 or chance == 8 then
                traits[1] = "orange"
            elseif chance == 9 or chance == 10 then
                traits[1] = "yellow"
            elseif chance == 11 or chance == 12 then
                traits[1] = "green"
            elseif chance == 13 or chance == 14 then
                traits[1] = "blue"
            elseif chance == 15 or chance == 16 then
                traits[1] = "purple"
            else
                traits[1] = "rainbow"
            end
        elseif parent1.kelpie_traits[1] == "blue" and geneset[5][1] == "blue" then
            traits[1] = "blue"
        elseif (parent1.kelpie_traits[1] == "blue" and geneset[5][1] == "purple")
        or (parent1.kelpie_traits[1] == "purple" and geneset[5][1] == "blue") then
            local chance = math.random(2)
            if chance == 1 then
                traits[1] = "blue"
            else
                traits[1] = "purple"
            end
        elseif (parent1.kelpie_traits[1] == "blue" and geneset[5][1] == "rainbow")
        or (parent1.kelpie_traits[1] == "rainbow" and geneset[5][1] == "blue") then
            local chance = math.random(17)
            if chance < 5 then
                traits[1] = "blue"
            elseif chance == 5 or chance == 6 then
                traits[1] = "red"
            elseif chance == 7 or chance == 8 then
                traits[1] = "orange"
            elseif chance == 9 or chance == 10 then
                traits[1] = "yellow"
            elseif chance == 11 or chance == 12 then
                traits[1] = "green"
            elseif chance == 13 or chance == 14 then
                traits[1] = "turquoise"
            elseif chance == 15 or chance == 16 then
                traits[1] = "purple"
            else
                traits[1] = "rainbow"
            end
        elseif parent1.kelpie_traits[1] == "purple" and geneset[5][1] == "purple" then
            traits[1] = "purple"
        elseif (parent1.kelpie_traits[1] == "blue" and geneset[5][1] == "rainbow")
        or (parent1.kelpie_traits[1] == "rainbow" and geneset[5][1] == "blue") then
            local chance = math.random(17)
            if chance < 5 then
                traits[1] = "blue"
            elseif chance == 5 or chance == 6 then
                traits[1] = "red"
            elseif chance == 7 or chance == 8 then
                traits[1] = "orange"
            elseif chance == 9 or chance == 10 then
                traits[1] = "yellow"
            elseif chance == 11 or chance == 12 then
                traits[1] = "green"
            elseif chance == 13 or chance == 14 then
                traits[1] = "turquoise"
            elseif chance == 15 or chance == 16 then
                traits[1] = "purple"
            else
                traits[1] = "rainbow"
            end
        end

        if parent1.kelpie_traits[2] == "red" and geneset[5][2] == "red" then
            traits[2] = "red"
        elseif (parent1.kelpie_traits[2] == "red" and geneset[5][2] == "orange")
        or (parent1.kelpie_traits[2] == "orange" and geneset[5][2] == "red") then
            local chance = math.random(2)
            if chance == 1 then
                traits[2] = "red"
            else
                traits[2] = "orange"
            end
        elseif (parent1.kelpie_traits[2] == "red" and geneset[5][2] == "yellow")
        or (parent1.kelpie_traits[2] == "yellow" and geneset[5][2] == "red") then
            local chance = math.random(3)
            if chance == 1 then
                traits[2] = "red"
            elseif chance == 2 then
                traits[2] = "orange"
            else
                traits[2] = "yellow"
            end
        elseif (parent1.kelpie_traits[2] == "red" and geneset[5][2] == "green")
        or (parent1.kelpie_traits[2] == "green" and geneset[5][2] == "red") then
            local chance = math.random(3)
            if chance == 1 then
                traits[2] = "orange"
            elseif chance == 2 then
                traits[2] = "yellow"
            else
                traits[2] = "green"
            end
        elseif (parent1.kelpie_traits[2] == "red" and geneset[5][2] == "turquoise")
        or (parent1.kelpie_traits[2] == "turquoise" and geneset[5][2] == "red") then
            local chance = math.random(3)
            if chance == 1 then
                traits[2] = "yellow"
            elseif chance == 2 then
                traits[2] = "green"
            else
                traits[2] = "turquoise"
            end
        elseif (parent1.kelpie_traits[2] == "red" and geneset[5][2] == "blue")
        or (parent1.kelpie_traits[2] == "blue" and geneset[5][2] == "red") then
            local chance = math.random(4)
            if chance == 1 then
                traits[2] = "green"
            elseif chance == 2 then
                traits[2] = "turquoise"
            elseif chance == 3 then
                traits[2] = "blue"
            else
                traits[2] = "purple"
            end
        elseif (parent1.kelpie_traits[2] == "red" and geneset[5][2] == "purple")
        or (parent1.kelpie_traits[2] == "purple" and geneset[5][2] == "red") then
            local chance = math.random(2)
            if chance == 1 then
                traits[2] = "red"
            else
                traits[2] = "purple"
            end
        elseif parent1.kelpie_traits[2] == "orange" and geneset[5][2] == "orange" then
            traits[2] = "orange"
        elseif (parent1.kelpie_traits[2] == "orange" and geneset[5][2] == "yellow")
        or (parent1.kelpie_traits[2] == "yellow" and geneset[5][2] == "orange") then
            local chance = math.random(2)
            if chance == 1 then
                traits[2] = "orange"
            else
                traits[2] = "yellow"
            end
        elseif (parent1.kelpie_traits[2] == "orange" and geneset[5][2] == "green")
        or (parent1.kelpie_traits[2] == "green" and geneset[5][2] == "orange") then
            local chance = math.random(3)
            if chance == 1 then
                traits[2] = "orange"
            elseif chance == 2 then
                traits[2] = "yellow"
            else
                traits[2] = "green"
            end
        elseif (parent1.kelpie_traits[2] == "orange" and geneset[5][2] == "turquoise")
        or (parent1.kelpie_traits[2] == "turquoise" and geneset[5][2] == "orange") then
            local chance = math.random(3)
            if chance == 1 then
                traits[2] = "yellow"
            elseif chance == 2 then
                traits[2] = "green"
            else
                traits[2] = "turquoise"
            end
        elseif (parent1.kelpie_traits[2] == "orange" and geneset[5][2] == "blue")
        or (parent1.kelpie_traits[2] == "blue" and geneset[5][2] == "orange") then
            local chance = math.random(3)
            if chance == 1 then
                traits[2] = "green"
            elseif chance == 2 then
                traits[2] = "turquoise"
            else
                traits[2] = "blue"
            end
        elseif (parent1.kelpie_traits[2] == "orange" and geneset[5][2] == "purple")
        or (parent1.kelpie_traits[2] == "purple" and geneset[5][2] == "orange") then
            local chance = math.random(3)
            if chance == 1 then
                traits[2] = "red"
            elseif chance == 2 then
                traits[2] = "orange"
            else
                traits[2] = "purple"
            end
        elseif parent1.kelpie_traits[2] == "yellow" and geneset[5][2] == "yellow" then
            traits[2] = "yellow"
        elseif (parent1.kelpie_traits[2] == "yellow" and geneset[5][2] == "green")
        or (parent1.kelpie_traits[2] == "green" and geneset[5][2] == "yellow") then
            local chance = math.random(2)
            if chance == 1 then
                traits[2] = "yellow"
            else
                traits[2] = "green"
            end
        elseif (parent1.kelpie_traits[2] == "yellow" and geneset[5][2] == "turquoise")
        or (parent1.kelpie_traits[2] == "turquoise" and geneset[5][2] == "yellow") then
            local chance = math.random(2)
            if chance == 1 then
                traits[2] = "green"
            else
                traits[2] = "turquoise"
            end
        elseif (parent1.kelpie_traits[2] == "yellow" and geneset[5][2] == "blue")
        or (parent1.kelpie_traits[2] == "blue" and geneset[5][2] == "yellow") then
            local chance = math.random(2)
            if chance == 1 then
                traits[2] = "green"
            else
                traits[2] = "turquoise"
            end
        elseif (parent1.kelpie_traits[2] == "yellow" and geneset[5][2] == "purple")
        or (parent1.kelpie_traits[2] == "purple" and geneset[5][2] == "yellow") then
            local chance = math.random(2)
            if chance == 1 then
                traits[2] = "red"
            else
                traits[2] = "orange"
            end
        elseif parent1.kelpie_traits[2] == "green" and geneset[5][2] == "green" then
            traits[2] = "green"
        elseif (parent1.kelpie_traits[2] == "green" and geneset[5][2] == "turquoise")
        or (parent1.kelpie_traits[2] == "turquoise" and geneset[5][2] == "green") then
            local chance = math.random(2)
            if chance == 1 then
                traits[2] = "green"
            else
                traits[2] = "turquoise"
            end
        elseif (parent1.kelpie_traits[2] == "green" and geneset[5][2] == "blue")
        or (parent1.kelpie_traits[2] == "blue" and geneset[5][2] == "green") then
            local chance = math.random(2)
            if chance == 1 then
                traits[2] = "green"
            else
                traits[2] = "blue"
            end
        elseif (parent1.kelpie_traits[2] == "green" and geneset[5][2] == "purple")
        or (parent1.kelpie_traits[2] == "purple" and geneset[5][2] == "green") then
            local chance = math.random(2)
            if chance == 1 then
                traits[2] = "green"
            else
                traits[2] = "blue"
            end
        elseif parent1.kelpie_traits[2] == "turquoise" and geneset[5][2] == "turquoise" then
            traits[2] = "turquoise"
        elseif (parent1.kelpie_traits[2] == "turquoise" and geneset[5][2] == "blue")
        or (parent1.kelpie_traits[2] == "blue" and geneset[5][2] == "turquoise") then
            local chance = math.random(2)
            if chance == 1 then
                traits[2] = "turquoise"
            else
                traits[2] = "blue"
            end
        elseif (parent1.kelpie_traits[2] == "turquoise" and geneset[5][2] == "purple")
        or (parent1.kelpie_traits[2] == "purple" and geneset[5][2] == "turquoise") then
            local chance = math.random(3)
            if chance == 1 then
                traits[2] = "turquoise"
            elseif chance == 2 then
                traits[2] = "blue"
            else
                traits[2] = "purple"
            end
        elseif parent1.kelpie_traits[2] == "blue" and geneset[5][2] == "blue" then
            traits[2] = "blue"
        elseif (parent1.kelpie_traits[2] == "blue" and geneset[5][2] == "purple")
        or (parent1.kelpie_traits[2] == "purple" and geneset[5][2] == "blue") then
            local chance = math.random(2)
            if chance == 1 then
                traits[2] = "blue"
            else
                traits[2] = "purple"
            end
        elseif parent1.kelpie_traits[2] == "purple" and geneset[5][2] == "purple" then
            traits[2] = "purple"
        end

        if parent1.kelpie_traits[3] == "red" and geneset[5][3] == "red" then
            traits[3] = "red"
        elseif (parent1.kelpie_traits[3] == "red" and geneset[5][3] == "orange")
        or (parent1.kelpie_traits[3] == "orange" and geneset[5][3] == "red") then
            local chance = math.random(2)
            if chance == 1 then
                traits[3] = "red"
            else
                traits[3] = "orange"
            end
        elseif (parent1.kelpie_traits[3] == "red" and geneset[5][3] == "yellow")
        or (parent1.kelpie_traits[3] == "yellow" and geneset[5][3] == "red") then
            local chance = math.random(3)
            if chance == 1 then
                traits[3] = "red"
            elseif chance == 2 then
                traits[3] = "orange"
            else
                traits[3] = "yellow"
            end
        elseif (parent1.kelpie_traits[3] == "red" and geneset[5][3] == "green")
        or (parent1.kelpie_traits[3] == "green" and geneset[5][3] == "red") then
            local chance = math.random(3)
            if chance == 1 then
                traits[3] = "orange"
            elseif chance == 2 then
                traits[3] = "yellow"
            else
                traits[3] = "green"
            end
        elseif (parent1.kelpie_traits[3] == "red" and geneset[5][3] == "turquoise")
        or (parent1.kelpie_traits[3] == "turquoise" and geneset[5][3] == "red") then
            local chance = math.random(3)
            if chance == 1 then
                traits[3] = "yellow"
            elseif chance == 2 then
                traits[3] = "green"
            else
                traits[3] = "turquoise"
            end
        elseif (parent1.kelpie_traits[3] == "red" and geneset[5][3] == "blue")
        or (parent1.kelpie_traits[3] == "blue" and geneset[5][3] == "red") then
            local chance = math.random(4)
            if chance == 1 then
                traits[3] = "green"
            elseif chance == 2 then
                traits[3] = "turquoise"
            elseif chance == 3 then
                traits[3] = "blue"
            else
                traits[3] = "purple"
            end
        elseif (parent1.kelpie_traits[3] == "red" and geneset[5][3] == "purple")
        or (parent1.kelpie_traits[3] == "purple" and geneset[5][3] == "red") then
            local chance = math.random(2)
            if chance == 1 then
                traits[3] = "red"
            else
                traits[3] = "purple"
            end
        elseif parent1.kelpie_traits[3] == "orange" and geneset[5][3] == "orange" then
            traits[3] = "orange"
        elseif (parent1.kelpie_traits[3] == "orange" and geneset[5][3] == "yellow")
        or (parent1.kelpie_traits[3] == "yellow" and geneset[5][3] == "orange") then
            local chance = math.random(2)
            if chance == 1 then
                traits[3] = "orange"
            else
                traits[3] = "yellow"
            end
        elseif (parent1.kelpie_traits[3] == "orange" and geneset[5][3] == "green")
        or (parent1.kelpie_traits[3] == "green" and geneset[5][3] == "orange") then
            local chance = math.random(3)
            if chance == 1 then
                traits[3] = "orange"
            elseif chance == 2 then
                traits[3] = "yellow"
            else
                traits[3] = "green"
            end
        elseif (parent1.kelpie_traits[3] == "orange" and geneset[5][3] == "turquoise")
        or (parent1.kelpie_traits[3] == "turquoise" and geneset[5][3] == "orange") then
            local chance = math.random(3)
            if chance == 1 then
                traits[3] = "yellow"
            elseif chance == 2 then
                traits[3] = "green"
            else
                traits[3] = "turquoise"
            end
        elseif (parent1.kelpie_traits[3] == "orange" and geneset[5][3] == "blue")
        or (parent1.kelpie_traits[3] == "blue" and geneset[5][3] == "orange") then
            local chance = math.random(3)
            if chance == 1 then
                traits[3] = "green"
            elseif chance == 2 then
                traits[3] = "turquoise"
            else
                traits[3] = "blue"
            end
        elseif (parent1.kelpie_traits[3] == "orange" and geneset[5][3] == "purple")
        or (parent1.kelpie_traits[3] == "purple" and geneset[5][3] == "orange") then
            local chance = math.random(3)
            if chance == 1 then
                traits[3] = "red"
            elseif chance == 2 then
                traits[3] = "orange"
            else
                traits[3] = "purple"
            end
        elseif parent1.kelpie_traits[3] == "yellow" and geneset[5][3] == "yellow" then
            traits[3] = "yellow"
        elseif (parent1.kelpie_traits[3] == "yellow" and geneset[5][3] == "green")
        or (parent1.kelpie_traits[3] == "green" and geneset[5][3] == "yellow") then
            local chance = math.random(2)
            if chance == 1 then
                traits[3] = "yellow"
            else
                traits[3] = "green"
            end
        elseif (parent1.kelpie_traits[3] == "yellow" and geneset[5][3] == "turquoise")
        or (parent1.kelpie_traits[3] == "turquoise" and geneset[5][3] == "yellow") then
            local chance = math.random(2)
            if chance == 1 then
                traits[3] = "green"
            else
                traits[3] = "turquoise"
            end
        elseif (parent1.kelpie_traits[3] == "yellow" and geneset[5][3] == "blue")
        or (parent1.kelpie_traits[3] == "blue" and geneset[5][3] == "yellow") then
            local chance = math.random(2)
            if chance == 1 then
                traits[3] = "green"
            else
                traits[3] = "turquoise"
            end
        elseif (parent1.kelpie_traits[3] == "yellow" and geneset[5][3] == "purple")
        or (parent1.kelpie_traits[3] == "purple" and geneset[5][3] == "yellow") then
            local chance = math.random(2)
            if chance == 1 then
                traits[3] = "red"
            else
                traits[3] = "orange"
            end
        elseif parent1.kelpie_traits[3] == "green" and geneset[5][3] == "green" then
            traits[3] = "green"
        elseif (parent1.kelpie_traits[3] == "green" and geneset[5][3] == "turquoise")
        or (parent1.kelpie_traits[3] == "turquoise" and geneset[5][3] == "green") then
            local chance = math.random(2)
            if chance == 1 then
                traits[3] = "green"
            else
                traits[3] = "turquoise"
            end
        elseif (parent1.kelpie_traits[3] == "green" and geneset[5][3] == "blue")
        or (parent1.kelpie_traits[3] == "blue" and geneset[5][3] == "green") then
            local chance = math.random(2)
            if chance == 1 then
                traits[3] = "green"
            else
                traits[3] = "blue"
            end
        elseif (parent1.kelpie_traits[3] == "green" and geneset[5][3] == "purple")
        or (parent1.kelpie_traits[3] == "purple" and geneset[5][3] == "green") then
            local chance = math.random(2)
            if chance == 1 then
                traits[3] = "green"
            else
                traits[3] = "blue"
            end
        elseif parent1.kelpie_traits[3] == "turquoise" and geneset[5][3] == "turquoise" then
            traits[3] = "turquoise"
        elseif (parent1.kelpie_traits[3] == "turquoise" and geneset[5][3] == "blue")
        or (parent1.kelpie_traits[3] == "blue" and geneset[5][3] == "turquoise") then
            local chance = math.random(2)
            if chance == 1 then
                traits[3] = "turquoise"
            else
                traits[3] = "blue"
            end
        elseif (parent1.kelpie_traits[3] == "turquoise" and geneset[5][3] == "purple")
        or (parent1.kelpie_traits[3] == "purple" and geneset[5][3] == "turquoise") then
            local chance = math.random(3)
            if chance == 1 then
                traits[3] = "turquoise"
            elseif chance == 2 then
                traits[3] = "blue"
            else
                traits[3] = "purple"
            end
        elseif parent1.kelpie_traits[3] == "blue" and geneset[5][3] == "blue" then
            traits[3] = "blue"
        elseif (parent1.kelpie_traits[3] == "blue" and geneset[5][3] == "purple")
        or (parent1.kelpie_traits[3] == "purple" and geneset[5][3] == "blue") then
            local chance = math.random(2)
            if chance == 1 then
                traits[3] = "blue"
            else
                traits[3] = "purple"
            end
        elseif parent1.kelpie_traits[3] == "purple" and geneset[5][3] == "purple" then
            traits[3] = "purple"
        end

    elseif (parent1.life_state == "kelpie" or parent1.life_state == "hybrid") and geneset[4] == "horse"
    and (lifestate == "kelpie" or lifestate == "hybrid") then
        if parent1.kelpie_traits[1] == "rainbow" then
            local chance = math.random(7)
            if chance == 1 then
                traits[1] = "blue"
            elseif chance == 2 then
                traits[1] = "red"
            elseif chance == 3 then
                traits[1] = "orange"
            elseif chance == 4 then
                traits[1] = "yellow"
            elseif chance == 5 then
                traits[1] = "green"
            elseif chance == 6 then
                traits[1] = "turquoise"
            elseif chance == 7 then
                traits[1] = "purple"
            end
        else
            traits[1] = parent1.kelpie_traits[1]
        end
        traits[2] = parent1.kelpie_traits[2]
        traits[3] = parent1.kelpie_traits[3]
    elseif (geneset[4] == "kelpie" or geneset[4] == "hybrid") and parent1.life_state == "horse"
    and (lifestate == "kelpie" or lifestate == "hybrid") then
        if geneset[5][1] == "rainbow" then
            local chance = math.random(7)
            if chance == 1 then
                traits[1] = "blue"
            elseif chance == 2 then
                traits[1] = "red"
            elseif chance == 3 then
                traits[1] = "orange"
            elseif chance == 4 then
                traits[1] = "yellow"
            elseif chance == 5 then
                traits[1] = "green"
            elseif chance == 6 then
                traits[1] = "turquoise"
            elseif chance == 7 then
                traits[1] = "purple"
            end
        else
            traits[1] = geneset[5][1]
        end
        traits[2] = geneset[5][2]
        traits[3] = geneset[5][3]
    end

    if lifestate == "hybrid" then
        if math.random(10) < 6 then
            traits[4] = "colored"
        else
            traits[4] = "normal"
        end
        if math.random(10) < 5 then
            traits[5] = "none"
        else
            if math.random(10) < 3 then
                traits[5] = "full_scales"
            else
                traits[5] = "half_scales"
            end
        end
    end

    local genes = {}
    local gen_skills = {0, 0, 0, 0}
    local cur_skills = {}
    local coat_layers = {}

    genes = Horse:genetics(parent1.genes, geneset[1])
    
    gen_skills[1] = math.floor((parent1.gen_skills[1] + geneset[2][1])/2)
    gen_skills[2] = math.floor((parent1.gen_skills[2] + geneset[2][2])/2)
    gen_skills[3] = math.floor((parent1.gen_skills[3] + geneset[2][3])/2)
    gen_skills[4] = math.floor((parent1.gen_skills[4] + geneset[2][4])/2)

    if parent1.cur_skills[1] > parent1.gen_skills[1] then
        if math.random(2) == 1 then
            gen_skills[1] = gen_skills[1] + 1
        end
    end
    if parent1.cur_skills[2] > parent1.gen_skills[2] then
        if math.random(2) == 1 then
            gen_skills[2] = gen_skills[2] + 1
        end
    end
    if parent1.cur_skills[3] > parent1.gen_skills[3] then
        if math.random(2) == 1 then
            gen_skills[3] = gen_skills[3] + 1
        end
    end
    if parent1.cur_skills[4] > parent1.gen_skills[4] then
        if math.random(2) == 1 then
            gen_skills[4] = gen_skills[4] + 1
        end
    end

    if geneset[3][1] > geneset[2][1] then
        if math.random(2) == 1 then
            gen_skills[1] = gen_skills[1] + 1
        end
    end
    if geneset[3][2] > geneset[2][2] then
        if math.random(2) == 1 then
            gen_skills[2] = gen_skills[2] + 1
        end
    end
    if geneset[3][3] > geneset[2][3] then
        if math.random(2) == 1 then
            gen_skills[3] = gen_skills[3] + 1
        end
    end
    if geneset[3][4] > geneset[2][4] then
        if math.random(2) == 1 then
            gen_skills[4] = gen_skills[4] + 1
        end
    end

    cur_skills = {0, 0, 0, 0}

    coatInfo = {}
    coatInfo = Horse:coatToDisplay(genes, lifestate, traits)

    coat = coatInfo[1]
    mane_data = coatInfo[2]
    markings = coatInfo[3]

    for k, v in ipairs(coat) do
        coat_layers[#coat_layers + 1] = v
    end

    if type(markings) == "table" then
        for k, v in ipairs(markings) do
            coat_layers[#coat_layers + 1] = v
        end
    elseif type(markings) == "string" then
        coat_layers[#coat_layers + 1] = markings
    end
    
    if lifestate == "horse" then
        coat_layers[#coat_layers + 1] = "line/foal_base.png"
    else
        coat_layers[#coat_layers + 1] = "line/foal_kelpie_base.png"
    end

    if lifestate == "hybrid" and traits[5] ~= nil then
        if traits[5] == "full_scales" then
            coat_layers[#coat_layers + 1] = "line/foal_scales.png"
        elseif traits[5] == "half_scales" then
            coat_layers[#coat_layers + 1] = "line/foal_hybrid_scales.png"
        end
    end

    if lifestate == "kelpie" then
        coat_layers[#coat_layers + 1] = "line/foal_scales.png"
    end

    for k, v in ipairs(mane_data) do
        coat_layers[#coat_layers + 1] = v
    end

    if lifestate == "horse" then
        coat_layers[#coat_layers + 1] = "line/mane_tail_foal.png"
    else
        coat_layers[#coat_layers + 1] = "line/foal_kelpie_mane_tail.png"
    end

    return Horse(name, age_y, age_m, gender, genes, 'none', false, {nil, nil, nil}, false, coat_layers, gen_skills, cur_skills,
    --health
    100,
    --energy
    100,
    --mood
    100,
    -- needs (food, water, hygiene)
    {true, true, true},
    {false},
    -1, -1, nil, lifestate, traits, false)
end

function Horse:generateHorseToBuy(newgame)
    
    age_y = math.random(2, 5)
    age_m = math.random(0, 11)

    if math.random(2) == 1 then
        gender = "f"
        name = "Mare"
    else
        gender = "m"
        name = "Stallion"
    end

    genes = {}
    gen_skills = {}
    cur_skills = {}

    genes = Horse:generateNewGenes()

    local skillmax = 0
    local skillmin = 0

    if newgame == false then
        for k, stable in ipairs(user_stables.stables) do
            if stable.horse ~= nil then
                if skillmax < stable.horse.gen_skills[1] then
                    skillmax = stable.horse.gen_skills[1]
                end
                if skillmax < stable.horse.gen_skills[2] then
                    skillmax = stable.horse.gen_skills[2]
                end
                if skillmax < stable.horse.gen_skills[3] then
                    skillmax = stable.horse.gen_skills[3]
                end
                if skillmax < stable.horse.gen_skills[4] then
                    skillmax = stable.horse.gen_skills[4]
                end
                if skillmin > stable.horse.gen_skills[1] then
                    skillmin = stable.horse.gen_skills[1]
                end
                if skillmin > stable.horse.gen_skills[2] then
                    skillmin = stable.horse.gen_skills[2]
                end
                if skillmin > stable.horse.gen_skills[3] then
                    skillmin = stable.horse.gen_skills[3]
                end
                if skillmin > stable.horse.gen_skills[4] then
                    skillmin = stable.horse.gen_skills[4]
                end
            end
        end
    else
        skillmin = 5
        skillmax = 10
    end

    gen_skills[1] = math.random(skillmin, skillmax)
    gen_skills[2] = math.random(skillmin, skillmax)
    gen_skills[3] = math.random(skillmin, skillmax)
    gen_skills[4] = math.random(skillmin, skillmax)
    if math.random(15) == 1 then
        gen_skills[1] = gen_skills[1] + math.random(1,5)
    end
    if math.random(15) == 1 then
        gen_skills[2] = gen_skills[2] + math.random(1,5)
    end
    if math.random(15) == 1 then
        gen_skills[3] = gen_skills[3] + math.random(1,5)
    end
    if math.random(15) == 1 then
        gen_skills[4] = gen_skills[4] + math.random(1,5)
    end

    cur_skills = Horse:generateCurSkills(gen_skills)

    coat_layers = {}

    local coatInfo = {}
    coatInfo = Horse:coatToDisplay(genes, "horse", {})

    local coat = coatInfo[1]
    local mane_data = coatInfo[2]
    local markings = coatInfo[3]

    for k, v in ipairs(coat) do
        coat_layers[#coat_layers + 1] = v
    end

    if type(markings) == "table" then
        for k, v in ipairs(markings) do
            coat_layers[#coat_layers + 1] = v
        end
    elseif type(markings) == "string" then
        coat_layers[#coat_layers + 1] = markings
    end

    coat_layers[#coat_layers + 1] = "line/horse_base.png"

    for k, v in ipairs(mane_data) do
        coat_layers[#coat_layers + 1] = v
    end

    coat_layers[#coat_layers + 1] = "line/mane_tail_wild.png"

    return Horse(name, age_y, age_m, gender, genes, 'none', false, {nil, nil, nil}, false, coat_layers, gen_skills, cur_skills,
    --health
    100,
    --energy
    100,
    --mood
    100,
    -- needs (food, water, hygiene)
    {true, true, true},
    {false},
    -1, -1, nil, "horse", {}, false)
end

function Horse:generateStudOfTheDay(newgame)
    
    age_y = 2
    age_m = 0

    gender = "m"
    name = "Day Stud"

    genes = {}
    gen_skills = {}
    cur_skills = {}

    genes = Horse:generateNewGenes()

    local skillmax = 0
    local skillmin = 0

    if newgame == false then
        for k, stable in ipairs(user_stables.stables) do
            if stable.horse ~= nil then
                if skillmax < stable.horse.gen_skills[1] then
                    skillmax = stable.horse.gen_skills[1]
                end
                if skillmax < stable.horse.gen_skills[2] then
                    skillmax = stable.horse.gen_skills[2]
                end
                if skillmax < stable.horse.gen_skills[3] then
                    skillmax = stable.horse.gen_skills[3]
                end
                if skillmax < stable.horse.gen_skills[4] then
                    skillmax = stable.horse.gen_skills[4]
                end
                if skillmin > stable.horse.gen_skills[1] then
                    skillmin = stable.horse.gen_skills[1]
                end
                if skillmin > stable.horse.gen_skills[2] then
                    skillmin = stable.horse.gen_skills[2]
                end
                if skillmin > stable.horse.gen_skills[3] then
                    skillmin = stable.horse.gen_skills[3]
                end
                if skillmin > stable.horse.gen_skills[4] then
                    skillmin = stable.horse.gen_skills[4]
                end
            end
        end
    else
        skillmin = 5
        skillmax = 10
    end

    gen_skills[1] = math.random(skillmin, skillmax)
    gen_skills[2] = math.random(skillmin, skillmax)
    gen_skills[3] = math.random(skillmin, skillmax)
    gen_skills[4] = math.random(skillmin, skillmax)
    if math.random(15) == 1 then
        gen_skills[1] = gen_skills[1] + math.random(1,5)
    end
    if math.random(15) == 1 then
        gen_skills[2] = gen_skills[2] + math.random(1,5)
    end
    if math.random(15) == 1 then
        gen_skills[3] = gen_skills[3] + math.random(1,5)
    end
    if math.random(15) == 1 then
        gen_skills[4] = gen_skills[4] + math.random(1,5)
    end

    cur_skills = Horse:generateCurSkills(gen_skills)

    coat_layers = {}

    local coatInfo = {}
    coatInfo = Horse:coatToDisplay(genes, "horse", {})

    local coat = coatInfo[1]
    local mane_data = coatInfo[2]
    local markings = coatInfo[3]

    for k, v in ipairs(coat) do
        coat_layers[#coat_layers + 1] = v
    end

    if type(markings) == "table" then
        for k, v in ipairs(markings) do
            coat_layers[#coat_layers + 1] = v
        end
    elseif type(markings) == "string" then
        coat_layers[#coat_layers + 1] = markings
    end

    coat_layers[#coat_layers + 1] = "line/horse_base.png"

    for k, v in ipairs(mane_data) do
        coat_layers[#coat_layers + 1] = v
    end

    coat_layers[#coat_layers + 1] = "line/mane_tail_wild.png"

    return Horse(name, age_y, age_m, gender, genes, 'none', false, {nil, nil, nil}, false, coat_layers, gen_skills, cur_skills,
    --health
    100,
    --energy
    100,
    --mood
    100,
    -- needs (food, water, hygiene)
    {true, true, true},
    {false},
    -1, -1, nil, "horse", {}, true)
end

function Horse:determinePrice()
    local price = self.gen_skills[1]*20 + self.gen_skills[2]*20 + self.gen_skills[3]*20 + self.gen_skills[4]*20 +
    self.cur_skills[1]*5 + self.cur_skills[2]*5 + self.cur_skills[3]*5 + self.cur_skills[4]*5 - (self.age_y - 2)*50
    if price < 50 then
        price = 100
    end
    return price
end

function Horse:determineStuddingPrice(own)
    local price = 0
    if own == true then
        price = math.floor((self.gen_skills[1]*20 + self.gen_skills[2]*20 + self.gen_skills[3]*20 + self.gen_skills[4]*20 +
        self.cur_skills[1]*5 + self.cur_skills[2]*5 + self.cur_skills[3]*5 + self.cur_skills[4]*5)/6)
    else
        price = math.floor((self.gen_skills[1]*20 + self.gen_skills[2]*20 + self.gen_skills[3]*20 + self.gen_skills[4]*20 +
        self.cur_skills[1]*5 + self.cur_skills[2]*5 + self.cur_skills[3]*5 + self.cur_skills[4]*5)/3)
    end
    if price < 50 then
        price = 50
    end
    return price
end

function Horse:generateNewGenes()

    local ag_prob = math.random(0, 30)
    if ag_prob > 15 then
        ag = 0
    elseif ag_prob > 12 then
        ag = 10
    elseif ag_prob > 9 then
        ag = 11
    elseif ag_prob > 6 then
        ag = 21
    elseif ag_prob > 3 then
        ag = 20
    else
        ag = 22
    end

    local ext_prob = math.random(0, 3)
    if ext_prob == 1 then
        ext = 11
    elseif ext_prob == 2 then
        ext = 10
    else
        ext = 0
    end

    local lwo_prob = math.random(0, 100)
    if lwo_prob > 2 then
        lwo = 0
    else
        lwo = 10
    end

    local to_prob = math.random(0, 100)
    if to_prob > 4 then
        to = 0
    elseif to_prob > 2 then
        to = 10
    else
        to = 11
    end

    if math.random(10) > 2 then
        gr = 0
    elseif math.random(6) == 2 then
        gr = 10
    else
        gr = 11
    end

    local ch_prob = math.random(30)
    if ch_prob > 6 then
        ch = 0
    elseif ch_prob > 3 then
        ch = 10
    else
        ch = 11
    end

    local crprl_prob = math.random(50)
    if crprl_prob > 15 then
        crprl = 0
    elseif crprl_prob > 12 then
        crprl = 10
    elseif crprl_prob > 9 then
        crprl = 11
    elseif crprl_prob > 6 then
        crprl = 21
    elseif crprl_prob > 3 then
        crprl = 20
    else
        crprl = 22
    end

    local sab_prob = math.random(0, 100)
    if sab_prob > 3 then
        sab = 0
    elseif sab_prob > 2 then
        sab = 10
    else
        sab = 11
    end

    local spl_prob = math.random(0, 100)
    if spl_prob > 3 then
        spl = 0
    elseif spl_prob > 2 then
        spl = 10
    else
        spl = 11
    end

    local sil_prob = math.random(0, 50)
    if sil_prob > 3 then
        sil = 0
    elseif sil_prob > 2 then
        sil = 10
    else
        sil = 11
    end

    local dun_prob = math.random(0, 50)
    if dun_prob > 5 then
        dun = 0
    elseif dun_prob > 2 then
        dun = 10
    else
        dun = 11
    end

    local lp_prob = math.random(0, 200)
    if lp_prob > 3 then
        lp = 0
    elseif lp_prob > 2 then
        lp = 10
    else
        lp = 11
    end

    local fl_prob = math.random(0, 80)
    if fl_prob > 3 then
        fl = 11
    elseif fl_prob > 3 then
        fl = 10
    else
        fl = 0
    end

    local sty_prob = math.random(50)
    if sty_prob > 3 then
        sty = 0
    elseif sty_prob > 2 then
        sty = 10
    else
        sty = 11
    end

    local rab_prob = math.random(200)
    if rab_prob > 3 then
        rab = 0
    elseif rab_prob > 2 then
        rab = 10
    else
        rab = 11
    end

    local rn_prob = math.random(200)
    if rn_prob > 5 then
        rn = 0
    elseif rn_prob > 2 then
        rn = 10
    else
        rn = 11
    end

    local patn1_prob = math.random(10)
    local patn2_prob = math.random(10)
    if lp ~= 0 then
        if patn1_prob > 5 then
            patn1 = 0
            if patn2_prob > 5 then
                patn2 = 0
            elseif patn2_prob > 2 then
                patn2 = 10
            else
                patn2 = 11
            end
        elseif patn1_prob > 2 then
            patn1 = 10
        else
            patn1 = 11
        end
    end

    local dw_prob = math.random(0, 10)
    if dw_prob > 95 and sab == 0 and rn == 0 and to == 0 and lp == 0 then
        dw = 10
    else
        dw = 0
    end

    lm = {}

    if math.random(10) == 1 then
        local choice = math.random(3)
        if choice == 1 then
            lm[#lm + 1] = "short"
        elseif choice == 2 then
            lm[#lm + 1] = "medium"
        else
            lm[#lm + 1] = "long"
        end
    else
        lm[#lm + 1] = "none"
    end
    if math.random(10) == 1 then
        local choice = math.random(3)
        if choice == 1 then
            lm[#lm + 1] = "short"
        elseif choice == 2 then
            lm[#lm + 1] = "medium"
        else
            lm[#lm + 1] = "long"
        end
    else
        lm[#lm + 1] = "none"
    end
    if math.random(10) == 1 then
        local choice = math.random(3)
        if choice == 1 then
            lm[#lm + 1] = "short"
        elseif choice == 2 then
            lm[#lm + 1] = "medium"
        else
            lm[#lm + 1] = "long"
        end
    else
        lm[#lm + 1] = "none"
    end
    if math.random(10) == 1 then
        local choice = math.random(3)
        if choice == 1 then
            lm[#lm + 1] = "short"
        elseif choice == 2 then
            lm[#lm + 1] = "medium"
        else
            lm[#lm + 1] = "long"
        end
    else
        lm[#lm + 1] = "none"
    end

    if math.random(10) == 1 then
        local choice = math.random(10)
        if choice == 1 then
            fm = "full"
        elseif choice > 1 and choice < 5 then
            fm = "muzzle"
        elseif choice > 4 and choice < 8 then
            fm = "stripe"
        else
            fm = "star"
        end
    else
        fm = "none"
    end

    genes = {ag, ext, dw, lwo, to, gr, ch, crprl, sab, spl, sil, dun, lp, fl, sty, rab, rn, patn1, patn2, lm, fm}

    return genes
end

function Horse:turnToKelpie(color1)
    self.age_y = 2
    self.age_m = 0

    self.life_state = "kelpie"

    self.cur_skills[1] = self.gen_skills[1]
    self.cur_skills[2] = self.gen_skills[2]
    self.cur_skills[3] = self.gen_skills[3]
    self.cur_skills[4] = self.gen_skills[4]

    local kel1, kel2, kel3

    if color1 == "random" then
        local kColor = math.random(1,8)
        if kColor == 1 then
            kel1 = "red"
            kel2 = "red"
            kel3 = "red"
        elseif kColor == 2 then
            kel1 = "orange"
            kel2 = "orange"
            kel3 = "orange"
        elseif kColor == 3 then
            kel1 = "yellow"
            kel2 = "yellow"
            kel3 = "yellow"
        elseif kColor == 4 then
            kel1 = "green"
            kel2 = "green"
            kel3 = "green"
        elseif kColor == 5 then
            kel1 = "turquoise"
            kel2 = "turquoise"
            kel3 = "turquoise"
        elseif kColor == 6 then
            kel1 = "blue"
            kel2 = "blue"
            kel3 = "blue"
        elseif kColor == 7 then
            kel1 = "purple"
            kel2 = "purple"
            kel3 = "purple"
        else
            kel1 = "rainbow"
            local maneColor = math.random(1,7)
            if maneColor == 1 then
                kel2 = "red"
            elseif maneColor == 2 then
                kel2 = "orange"
            elseif maneColor == 3 then
                kel2 = "yellow"
            elseif maneColor == 4 then
                kel2 = "green"
            elseif maneColor == 5 then
                kel2 = "turquoise"
            elseif maneColor == 6 then
                kel2 = "blue"
            else
                kel2 = "purple"
            end
            local eyeColor = math.random(1,7)
            if eyeColor == 1 then
                kel3 = "red"
            elseif eyeColor == 2 then
                kel3 = "orange"
            elseif eyeColor == 3 then
                kel3 = "yellow"
            elseif eyeColor == 4 then
                kel3 = "green"
            elseif eyeColor == 5 then
                kel3 = "turquoise"
            elseif eyeColor == 6 then
                kel3 = "blue"
            else
                kel3 = "purple"
            end
        end
    else
        if math.random(10) < 10 then
            kel1 = color1
            kel2 = color1
            kel3 = color1
        else
            kel1 = "rainbow"
            local maneColor = math.random(1,7)
            if maneColor == 1 then
                kel2 = "red"
            elseif maneColor == 2 then
                kel2 = "orange"
            elseif maneColor == 3 then
                kel2 = "yellow"
            elseif maneColor == 4 then
                kel2 = "green"
            elseif maneColor == 5 then
                kel2 = "turquoise"
            elseif maneColor == 6 then
                kel2 = "blue"
            else
                kel2 = "purple"
            end
            local eyeColor = math.random(1,7)
            if eyeColor == 1 then
                kel3 = "red"
            elseif eyeColor == 2 then
                kel3 = "orange"
            elseif eyeColor == 3 then
                kel3 = "yellow"
            elseif eyeColor == 4 then
                kel3 = "green"
            elseif eyeColor == 5 then
                kel3 = "turquoise"
            elseif eyeColor == 6 then
                kel3 = "blue"
            else
                kel3 = "purple"
            end
        end
    end

    self.kelpie_traits[1] = kel1
    self.kelpie_traits[2] = kel2
    self.kelpie_traits[3] = kel3
    
    self.coat_layers = {}

    self.coat_layers[#self.coat_layers + 1] = "eyes/kelpie/" .. kel3 .. ".png"
    self.coat_layers[#self.coat_layers + 1] = "coat_colors/kelpie/" .. kel1 .. ".png"
    self.coat_layers[#self.coat_layers + 1] = "line/kelpie_base.png"
    self.coat_layers[#self.coat_layers + 1] = "line/kelpie_scales.png"
    self.coat_layers[#self.coat_layers + 1] = "mane_tail_colors/kelpie/" .. kel2 .. ".png"
    self.coat_layers[#self.coat_layers + 1] = "line/kelpie_mane_tail.png"
end

function Horse:coatToDisplay(genes, life_state, kelpie_traits)
    modifiers = {}
    markings = {}

    local mane_mod

    if life_state == "horse" then
        if age_y < 2 then
            path_col = "coat_colors/foal/"
            path_mtcol = "mane_tail_colors/foal/"
            path_com = "coat_modifiers/foal/"
            path_mam = "mane_modifiers/foal/"
            path_eyes = "eyes/foal/"
            path_hmark = "head_markings/foal/"
            path_lmark = "leg_markings/foal/"
        else
            path_col = "coat_colors/"
            path_mtcol = "mane_tail_colors/"
            path_com = "coat_modifiers/"
            path_mam = "mane_modifiers/"
            path_eyes = "eyes/"
            path_hmark = "head_markings/"
            path_lmark = "leg_markings/"
        end
    elseif life_state == "hybrid" and kelpie_traits[4] == "normal" then
        if age_y < 2 then
            path_col = "coat_colors/foal/"
            path_mtcol = "mane_tail_colors/foal/hybrid/"
            path_com = "coat_modifiers/foal/"
            path_mam = "mane_modifiers/foal/hybrid/"
            path_eyes = "eyes/foal/"
            path_hmark = "head_markings/foal/"
            path_lmark = "leg_markings/foal/"
        else
            path_col = "coat_colors/hybrid/"
            path_mtcol = "mane_tail_colors/hybrid/"
            path_com = "coat_modifiers/hybrid/"
            path_mam = "mane_modifiers/hybrid/"
            path_eyes = "eyes/hybrid/"
            path_hmark = "head_markings/hybrid/"
            path_lmark = "leg_markings/hybrid/"
        end
    else
        if age_y < 2 then
            path_col = "coat_colors/foal/kelpie/"
            path_mtcol = "mane_tail_colors/foal/kelpie/"
            path_eyes = "eyes/foal/kelpie/"
        else
            path_col = "coat_colors/kelpie/"
            path_mtcol = "mane_tail_colors/kelpie/"
            path_eyes = "eyes/kelpie/"
        end
    end

    if life_state == "horse" or (life_state == "hybrid" and kelpie_traits[4] == "normal") then
        -- COAT + EYES
        -- eumelanin
        if genes[EXTENSION] == 11 or genes[EXTENSION] == 10 then
            if genes[AGOUTI] == 0 then
                if genes[CREAM_PEARL] == 10 or genes[CREAM_PEARL] == 0 then
                    eyes = path_eyes .. "brown.png"
                    if genes[DUN] == 0 then
                        if genes[SILVER] == 0 then
                            if genes[CHAMPAGNE] ~= 0 then
                                base = path_col .. "classic_champagne.png"
                                mane = path_mtcol .. "liver.png"
                                if math.random(2) == 1 then
                                    eyes = path_eyes .. "amber.png"
                                else
                                    eyes = path_eyes .. "hazel.png"
                                end
                            else
                                base = path_col .. "black.png"
                                mane = path_mtcol .. "black.png"
                            end
                        else
                            if genes[CHAMPAGNE] ~= 0 then
                                base = path_col .. "classic_silver.png"
                                mane = path_mtcol .. "classic_silver.png"
                                if math.random(2) == 1 then
                                    eyes = path_eyes .. "amber.png"
                                else
                                    eyes = path_eyes .. "hazel.png"
                                end
                            else
                                if math.random(4) == 1 then
                                    base = path_col .. "chocolate_silver.png"
                                    mane = path_mtcol .. "blonde.png"
                                elseif math.random(4) == 2 then
                                    base = path_col .. "chocolate_silver.png"
                                    mane = path_mtcol .. "white.png"
                                else
                                    base = path_col .. "silver_dapple.png"
                                    mane = path_mtcol .. "blonde.png"
                                end
                            end
                        end
                    else
                        if genes[SILVER] == 0 then
                            if genes[CHAMPAGNE] ~= 0 then
                                base = path_col .. "champagne_dun.png"
                                mane = path_mtcol .. "liver.png"
                                if math.random(2) == 1 then
                                    eyes = path_eyes .. "amber.png"
                                else
                                    eyes = path_eyes .. "hazel.png"
                                end
                            else
                                if math.random(3) == 1 then
                                    base = path_col .. "grulla1.png"
                                elseif math.random(3) == 2 then
                                    base = path_col .. "grulla2.png"
                                else
                                    base = path_col .. "grulla3.png"
                                end
                                mane = path_mtcol .. "grulla.png"
                            end
                        else
                            if genes[CHAMPAGNE] ~= 0 then
                                base = path_col .. "champagne_dun.png"
                                mane = path_mtcol .. "liver.png"
                                if math.random(2) == 1 then
                                    eyes = path_eyes .. "amber.png"
                                else
                                    eyes = path_eyes .. "hazel.png"
                                end
                            else
                                base = path_col .. "silver_dapple_grulla.png"
                                mane = path_mtcol .. "grulla.png"
                            end
                            mane_mod = path_mam .. "silver.png"
                        end
                    end
                elseif genes[CREAM_PEARL] == 11 then
                    eyes = path_eyes .. "brown.png"
                    if genes[DUN] == 0 then
                        if genes[CHAMPAGNE] ~= 0 then
                            base = path_col .. "champagne_pearl.png"
                            if math.random(2) == 1 then
                                eyes = path_eyes .. "amber.png"
                            else
                                eyes = path_eyes .. "hazel.png"
                            end
                        else
                            base = path_col .. "pearl.png"
                        end
                        mane = path_mtcol .. "pearl.png"
                        if genes[SILVER] ~= 0 then
                            mane_mod = path_mam .. "silver.png"
                        end
                    else
                        if genes[CHAMPAGNE] ~= 0 then
                            base = path_col .. "double_cream_champagne.png"
                            mane = path_mtcol .. "dun_cremello.png"
                            if math.random(2) == 1 then
                                eyes = path_eyes .. "amber.png"
                            else
                                eyes = path_eyes .. "hazel.png"
                            end
                        else
                            base = path_col .. "dun_pearl.png"
                            mane = path_mtcol .. "pearl.png"
                            if genes[SILVER] ~= 0 then
                                mane_mod = path_mam .. "silver.png"
                            end
                        end
                    end
                elseif genes[CREAM_PEARL] == 20 then
                    eyes = path_eyes .. "amber.png"
                    if genes[DUN] == 0 then
                        if genes[CHAMPAGNE] ~= 0 then
                            if math.random(2) == 1 then
                                eyes = path_eyes .. "hazel.png"
                            end
                            if math.random(2) == 1 then
                                base = path_col .. "classic_ivory_champagne.png"
                                mane = path_mtcol .. "classic_ivory_champagne.png"
                            else
                                base = path_col .. "double_cream_champagne.png"
                                mane = path_mtcol .. "palomino.png"
                            end
                        else
                            base = path_col .. "smoky_black.png"
                            mane = path_mtcol .. "black.png"
                            if genes[SILVER] ~= 0 then
                                if math.random(4) == 1 then
                                    base = path_col .. "chocolate_silver.png"
                                    mane = path_mtcol .. "blonde.png"
                                elseif math.random(4) == 2 then
                                    base = path_col .. "chocolate_silver.png"
                                    mane = path_mtcol .. "white.png"
                                else
                                    base = path_col .. "silver_dapple.png"
                                    mane = path_mtcol .. "blonde.png"
                                end
                            end
                        end
                    else
                        if genes[CHAMPAGNE] ~= 0 then
                            if math.random(2) == 1 then
                                eyes = path_eyes .. "hazel.png"
                            end
                            if math.random(2) == 1 then
                                base = path_col .. "classic_ivory_champagne.png"
                                mane = path_mtcol .. "classic_ivory_champagne.png"
                            else
                                base = path_col .. "double_cream_champagne.png"
                                mane = path_mtcol .. "palomino.png"
                            end
                        else
                            base = path_col .. "smokey_grulla.png"
                            mane = path_mtcol .. "smoky_black_grulla.png"
                            if genes[SILVER] ~= 0 then
                                base = path_col .. "silver_dapple_smoky_grulla.png"
                                mane = path_mtcol .. "blonde.png"
                                mane_mod = path_mam .. "silver.png"
                            end
                        end
                    end
                elseif genes[CREAM_PEARL] == 21 or genes[CREAM_PEARL] == 22 then
                    eyes = path_eyes .. "blue.png"
                    if genes[DUN] == 0 then
                        if genes[CHAMPAGNE] ~= 0 then
                            if math.random(2) == 1 then
                                base = path_col .. "classic_ivory_champagne.png"
                                mane = path_mtcol .. "classic_ivory_champagne.png"
                            else
                                base = path_col .. "double_cream_champagne.png"
                                mane = path_mtcol .. "palomino.png"
                            end
                        else
                            base = path_col .. "smoky_cream.png"
                            mane = path_mtcol .. "smoky_cream.png"
                            if genes[SILVER] ~= 0 then
                                mane_mod = path_mam .. "silver.png"
                            end
                        end
                    else
                        if genes[CHAMPAGNE] ~= 0 then
                            if math.random(2) == 1 then
                                base = path_col .. "classic_ivory_champagne.png"
                                mane = path_mtcol .. "classic_ivory_champagne.png"
                            else
                                base = path_col .. "double_cream_champagne.png"
                                mane = path_mtcol .. "palomino.png"
                            end
                        else
                            base = path_col .. "perlino.png"
                            mane = path_mtcol .. "amber_dun.png"
                            if genes[SILVER] ~= 0 then
                                mane_mod = path_mam .. "silver.png"
                            end
                        end
                    end
                end
            elseif genes[AGOUTI] == 10 or genes[AGOUTI] == 11 then
                if genes[CREAM_PEARL] == 10 or genes[CREAM_PEARL] == 0 then
                    eyes = path_eyes .. "brown.png"
                    if genes[DUN] == 0 then
                        if genes[SILVER] == 0 then
                            if genes[CHAMPAGNE] ~= 0 then
                                base = path_col .. "sable_champagne.png"
                                mane = path_mtcol .. "brown.png"
                                if math.random(2) == 1 then
                                    eyes = path_eyes .. "hazel.png"
                                end
                            else
                                base = path_col .. "seal_brown.png"
                                mane = path_mtcol .. "black.png"
                            end
                        else
                            if genes[CHAMPAGNE] ~= 0 then
                                base = path_col .. "silver_sable_champagne.png"
                                mane = path_mtcol .. "pearl.png"
                                if math.random(2) == 1 then
                                    eyes = path_eyes .. "hazel.png"
                                end
                            else
                                base = path_col .. "seal_brown_cream.png"
                                mane = path_mtcol .. "brown.png"
                            end
                            mane_mod = path_mam .. "silver.png"
                        end
                    else
                        if genes[SILVER] == 0 then
                            if genes[CHAMPAGNE] ~= 0 then
                                base = path_col .. "sable_dun.png"
                                mane = path_mtcol .. "sable_dun.png"
                                if math.random(2) == 1 then
                                    eyes = path_eyes .. "hazel.png"
                                end
                            else
                                if math.random(2) == 1 then
                                    base = path_col .. "mouse_dun.png"
                                    mane = path_mtcol .. "grulla.png"
                                else
                                    base = path_col .. "olive_dun.png"
                                    mane = path_mtcol .. "grulla.png"
                                end
                            end
                        else
                            if genes[CHAMPAGNE] ~= 0 then
                                base = path_col .. "sable_dun.png"
                                mane = path_mtcol .. "sable_dun.png"
                                if math.random(2) == 1 then
                                    eyes = path_eyes .. "hazel.png"
                                end
                            else
                                base = path_col .. "silver_dapple_dun.png"
                                mane = path_mtcol .. "black.png"
                            end
                            mane_mod = path_mam .. "silver.png"
                        end
                    end
                elseif genes[CREAM_PEARL] == 11 then
                    eyes = path_eyes .. "brown.png"
                    if genes[DUN] == 0 then
                        if genes[CHAMPAGNE] ~= 0 then
                            base = path_col .. "champagne_pearl3.png"
                            if math.random(2) == 1 then
                                eyes = path_eyes .. "amber.png"
                            else
                                eyes = path_eyes .. "hazel.png"
                            end
                        else
                            base = path_col .. "pearl2.png"
                        end
                        mane = path_mtcol .. "pearl.png"
                        if genes[SILVER] ~= 0 then
                            mane_mod = path_mam .. "silver.png"
                        end
                    else
                        if genes[CHAMPAGNE] ~= 0 then
                            base = path_col .. "sable_dun_pearl.png"
                            mane = path_mtcol .. "dun_cremello.png"
                            if math.random(2) == 1 then
                                eyes = path_eyes .. "amber.png"
                            else
                                eyes = path_eyes .. "hazel.png"
                            end
                        else
                            base = path_col .. "dun_pearl2.png"
                            mane = path_mtcol .. "pearl.png"
                            if genes[SILVER] ~= 0 then
                                mane_mod = path_mam .. "silver.png"
                            end
                        end
                    end
                elseif genes[CREAM_PEARL] == 20 then
                    eyes = path_eyes .. "amber.png"
                    if genes[DUN] == 0 then
                        if genes[CHAMPAGNE] ~= 0 then
                            base = path_col .. "sable_cream2.png"
                            mane = path_mtcol .. "dun_cremello.png"
                            if math.random(2) == 1 then
                                eyes = path_eyes .. "hazel.png"
                            end
                        else
                            base = path_col .. "seal_brown_cream.png"
                            mane = path_mtcol .. "black.png"
                            if genes[SILVER] ~= 0 then
                                base = path_col .. "silver_dapple_brown.png"
                                mane = path_mtcol .. "brown.png"
                                mane_mod = path_mam .. "silver.png"
                            end
                        end
                    else
                        if genes[CHAMPAGNE] ~= 0 then
                            base = path_col .. "sable_cream2.png"
                            mane = path_mtcol .. "dun_cremello.png"
                            if math.random(2) == 1 then
                                eyes = path_eyes .. "hazel.png"
                            end
                        else
                            base = path_col .. "brown_dunskin.png"
                            mane = path_mtcol .. "liver.png"
                            if genes[SILVER] ~= 0 then
                                base = path_col .. "silver_dapple_dun.png"
                                mane = path_mtcol .. "black.png"
                                mane_mod = path_mam .. "silver.png"
                            end
                        end
                    end
                elseif genes[CREAM_PEARL] == 21 or genes[CREAM_PEARL] == 22 then
                    eyes = path_eyes .. "blue.png"
                    if genes[DUN] == 0 then
                        if genes[CHAMPAGNE] ~= 0 then
                            base = path_col .. "sable_cream2.png"
                            mane = path_mtcol .. "dun_cremello.png"
                        else
                            base = path_col .. "seal_brown_cream2.png"
                            mane = path_mtcol .. "amber_dun.png"
                            if genes[SILVER] ~= 0 then
                                mane_mod = path_mam .. "silver.png"
                            end
                        end
                    else
                        if genes[CHAMPAGNE] ~= 0 then
                            base = path_col .. "sable_cream2.png"
                            mane = path_mtcol .. "dun_cremello.png"
                        else
                            base = path_col .. "dun_perlino.png"
                            mane = path_mtcol .. "amber_dun.png"
                            if genes[SILVER] ~= 0 then
                                mane_mod = path_mam .. "silver.png"
                            end
                        end
                    end
                end
            else
                if genes[CREAM_PEARL] == 10 or genes[CREAM_PEARL] == 0 then
                    eyes = path_eyes .. "brown.png"
                    if genes[DUN] == 0 then
                        if genes[SILVER] == 0 then
                            if genes[CHAMPAGNE] ~= 0 then
                                base = path_col .. "amber_champagne.png"
                                mane = path_mtcol .. "brown.png"
                                if math.random(2) == 1 then
                                    eyes = path_eyes .. "amber.png"
                                else
                                    eyes = path_eyes .. "hazel.png"
                                end
                            else
                                if math.random(7) == 7 then
                                    base = path_col .. "bay1.png"
                                elseif math.random(7) == 6 then
                                    base = path_col .. "bay2.png"
                                elseif math.random(7) == 5 then
                                    base = path_col .. "bay3.png"
                                elseif math.random(7) == 4 then
                                    base = path_col .. "bay4.png"
                                elseif math.random(7) == 3 then
                                    base = path_col .. "bay5.png"
                                elseif math.random(7) == 2 then
                                    base = path_col .. "bay6.png"
                                else
                                    base = path_col .. "bay7.png"
                                end
                                mane = path_mtcol .. "black.png"
                            end
                        else
                            if genes[CHAMPAGNE] ~= 0 then
                                base = path_col .. "amber_silver.png"
                                mane = path_mtcol .. "amber_silver.png"
                                if math.random(2) == 1 then
                                    eyes = path_eyes .. "amber.png"
                                else
                                    eyes = path_eyes .. "hazel.png"
                                end
                            else
                                if math.random(4) == 1 then
                                    base = path_col .. "chocolate_silver.png"
                                    mane = path_mtcol .. "blonde.png"
                                elseif math.random(4) == 2 then
                                    base = path_col .. "chocolate_silver.png"
                                    mane = path_mtcol .. "white.png"
                                else
                                    base = path_col .. "silver_dapple.png"
                                    mane = path_mtcol .. "blonde.png"
                                end
                            end
                        end
                    else
                        if genes[SILVER] == 0 then
                            if genes[CHAMPAGNE] ~= 0 then
                                base = path_col .. "amber_dun.png"
                                mane = path_mtcol .. "amber_dun.png"
                                if math.random(2) == 1 then
                                    eyes = path_eyes .. "amber.png"
                                else
                                    eyes = path_eyes .. "hazel.png"
                                end
                            else
                                if math.random(3) == 1 then
                                    base = path_col .. "bay_dun.png"
                                elseif math.random(3) == 2 then
                                    base = path_col .. "buttermilk_dun.png"
                                else
                                    base = path_col .. "coyote_dun.png"
                                end
                                mane = path_mtcol .. "grulla.png"
                            end
                        else
                            if genes[CHAMPAGNE] ~= 0 then
                                base = path_col .. "amber_dun.png"
                                mane = path_mtcol .. "amber_dun.png"
                                if math.random(2) == 1 then
                                    eyes = path_eyes .. "amber.png"
                                else
                                    eyes = path_eyes .. "hazel.png"
                                end
                            else
                                base = path_col .. "silver_dapple_dun.png"
                                mane = path_mtcol .. "black.png"
                            end
                            mane_mod = path_mam .. "silver.png"
                        end
                    end
                elseif genes[CREAM_PEARL] == 11 then
                    eyes = path_eyes .. "brown.png"
                    if genes[DUN] == 0 then
                        if genes[CHAMPAGNE] ~= 0 then
                            base = path_col .. "champagne_pearl2.png"
                            if math.random(2) == 1 then
                                eyes = path_eyes .. "amber.png"
                            else
                                eyes = path_eyes .. "hazel.png"
                            end
                        else
                            base = path_col .. "apricot.png"
                        end
                        mane = path_mtcol .. "pearl.png"
                        if genes[SILVER] ~= 0 then
                            mane_mod = path_mam .. "silver.png"
                        end
                    else
                        if genes[CHAMPAGNE] ~= 0 then
                            base = path_col .. "gold_dun_pearl.png"
                            mane = path_mtcol .. "dun_cremello.png"
                            if math.random(2) == 1 then
                                eyes = path_eyes .. "amber.png"
                            else
                                eyes = path_eyes .. "hazel.png"
                            end
                        else
                            base = path_col .. "dun_pearl.png"
                            mane = path_mtcol .. "pearl.png"
                            if genes[SILVER] ~= 0 then
                                mane_mod = path_mam .. "silver.png"
                            end
                        end
                    end
                elseif genes[CREAM_PEARL] == 20 then
                    eyes = path_eyes .. "amber.png"
                    if genes[DUN] == 0 then
                        if genes[CHAMPAGNE] ~= 0 then
                            base = path_col .. "amber_cream.png"
                            mane = path_mtcol .. "amber_dun.png"
                            if math.random(2) == 1 then
                                eyes = path_eyes .. "hazel.png"
                            end
                        else
                            if math.random(3) == 1 then
                                base = path_col .. "buckskin1.png"
                                mane = path_mtcol .. "black.png"
                            elseif math.random(3) == 2 then
                                base = path_col .. "buckskin2.png"
                                mane = path_mtcol .. "black.png"
                            else
                                base = path_col .. "buckskin3.png"
                                mane = path_mtcol .. "black.png"
                            end
                            if genes[SILVER] ~= 0 then
                                base = path_col .. "silver_buckskin.png"
                                mane = path_mtcol .. "blonde.png"
                                if math.random(2) == 1 then
                                    mane_mod = path_mam .. "silver.png"
                                end
                            end
                        end
                    else
                        if genes[CHAMPAGNE] ~= 0 then
                            base = path_col .. "amber_cream.png"
                            mane = path_mtcol .. "amber_dun.png"
                            if math.random(2) == 1 then
                                eyes = path_eyes .. "hazel.png"
                            end
                        else
                            base = path_col .. "dunskin.png"
                            mane = path_mtcol .. "black.png"
                            if genes[SILVER] ~= 0 then
                                mane_mod = path_mam .. "silver.png"
                            end
                        end
                    end
                elseif genes[CREAM_PEARL] == 21 or genes[CREAM_PEARL] == 22 then
                    eyes = path_eyes .. "blue.png"
                    if genes[DUN] == 0 then
                        if genes[CHAMPAGNE] ~= 0 then
                            base = path_col .. "amber_cream.png"
                            mane = path_mtcol .. "amber_dun.png"
                        else
                            base = path_col .. "perlino.png"
                            mane = path_mtcol .. "perlino.png"
                            if genes[SILVER] ~= 0 then
                                mane_mod = path_mam .. "silver.png"
                            end
                        end
                    else
                        if genes[CHAMPAGNE] ~= 0 then
                            base = path_col .. "amber_cream.png"
                            mane = path_mtcol .. "amber_dun.png"
                        else
                            base = path_col .. "dun_perlino.png"
                            mane = path_mtcol .. "dun_perlino.png"
                            if genes[SILVER] ~= 0 then
                                mane_mod = path_mam .. "silver.png"
                            end
                        end
                    end
                end
            end
        -- phaeomelanin
        else
            if genes[CREAM_PEARL] == 10 or genes[CREAM_PEARL] == 0 then
                eyes = path_eyes .. "brown.png"
                if genes[DUN] == 0 then
                    if genes[CHAMPAGNE] ~= 0 then
                        if math.random(2) == 1 then
                            base = path_col .. "gold_champagne.png"
                            mane = path_mtcol .. "palomino.png"
                        else
                            base = path_col .. "gold_champagne2.png"
                            mane = path_mtcol .. "dark_gold_champagne.png"
                        end
                        if math.random(2) == 1 then
                            eyes = path_eyes .. "amber.png"
                        else
                            eyes = path_eyes .. "hazel.png"
                        end
                    else
                        if math.random(7) == 1 then
                            base = path_col .. "chestnut1.png"
                            mane = path_mtcol .. "chestnut1.png"
                        elseif math.random(7) == 2 then
                            base = path_col .. "chestnut2.png"
                            mane = path_mtcol .. "chestnut2.png"
                        elseif math.random(7) == 3 then
                            base = path_col .. "chestnut3.png"
                            mane = path_mtcol .. "chestnut3.png"
                        elseif math.random(7) == 4 then
                            base = path_col .. "chestnut4.png"
                            mane = path_mtcol .. "chestnut4.png"
                        elseif math.random(7) == 5 then
                            base = path_col .. "chestnut5.png"
                            mane = path_mtcol .. "chestnut5.png"
                        elseif math.random(7) == 6 then
                            base = path_col .. "chestnut6.png"
                            mane = path_mtcol .. "chestnut6.png"
                        else
                            base = path_col .. "chestnut7.png"
                            mane = path_mtcol .. "chestnut7.png"
                        end
                    end
                else
                    if genes[CHAMPAGNE] ~= 0 then
                        base = path_col .. "gold_dun.png"
                        mane = path_mtcol .. "palomino.png"
                        if math.random(2) == 1 then
                            eyes = path_eyes .. "amber.png"
                        else
                            eyes = path_eyes .. "hazel.png"
                        end
                    else
                        if math.random(5) == 1 then
                            base = path_col .. "dun1.png"
                            mane = path_mtcol .. "peach_dun.png"
                        elseif math.random(5) == 2 then
                            base = path_col .. "dun2.png"
                            mane = path_mtcol .. "peach_dun.png"
                        elseif math.random(5) == 3 then
                            base = path_col .. "dun3.png"
                            mane = path_mtcol .. "copper_dun.png"
                        elseif math.random(5) == 4 then
                            base = path_col .. "dun4.png"
                            mane = path_mtcol .. "bronze_dun.png"
                        else
                            base = path_col .. "dun5.png"
                            mane = path_mtcol .. "liver_dun.png"
                        end
                    end
                end
            elseif genes[CREAM_PEARL] == 11 then
                eyes = path_eyes .. "brown.png"
                if genes[DUN] == 0 then
                    if genes[CHAMPAGNE] ~= 0 then
                        base = path_col .. "champagne_pearl.png"
                        mane = path_mtcol .. "perlino.png"
                        if math.random(2) == 1 then
                            eyes = path_eyes .. "amber.png"
                        else
                            eyes = path_eyes .. "hazel.png"
                        end
                    else
                        base = path_col .. "apricot.png"
                        mane = path_mtcol .. "apricot.png"
                    end
                else
                    if genes[CHAMPAGNE] ~= 0 then
                        base = path_col .. "gold_dun_pearl.png"
                        mane = path_mtcol .. "dark_gold_champagne.png"
                        if math.random(2) == 1 then
                            eyes = path_eyes .. "amber.png"
                        else
                            eyes = path_eyes .. "hazel.png"
                        end
                    else
                        base = path_col .. "apricot_dun.png"
                        mane = path_mtcol .. "apricot.png"
                    end
                end
            elseif genes[CREAM_PEARL] == 20 then
                eyes = path_eyes .. "amber.png"
                if genes[DUN] == 0 then
                    if genes[CHAMPAGNE] ~= 0 then
                        base = path_col .. "gold_cream.png"
                        mane = path_mtcol .. "palomino.png"
                        if math.random(2) == 1 then
                            eyes = path_eyes .. "hazel.png"
                        end
                    else
                        base = path_col .. "palomino1.png"
                        mane = path_mtcol .. "palomino.png"
                    end
                else
                    if genes[CHAMPAGNE] ~= 0 then
                        base = path_col .. "gold_cream.png"
                        mane = path_mtcol .. "palomino.png"
                        if math.random(2) == 1 then
                            eyes = path_eyes .. "hazel.png"
                        end
                    else
                        base = path_col .. "dunalino.png"
                        mane = path_mtcol .. "palomino.png"
                    end
                end
            elseif genes[CREAM_PEARL] == 21 or genes[CREAM_PEARL] == 22 then
                eyes = path_eyes .. "blue.png"
                if genes[DUN] == 0 then
                    if genes[CHAMPAGNE] ~= 0 then
                        base = path_col .. "gold_cream.png"
                        mane = path_mtcol .. "palomino.png"
                    else
                        base = path_col .. "cremello.png"
                        mane = path_mtcol .. "dun_cremello.png"
                    end
                else
                    if genes[CHAMPAGNE] ~= 0 then
                        base = path_col .. "gold_cream.png"
                        mane = path_mtcol .. "palomino.png"
                    else
                        base = path_col .. "dun_cremello.png"
                        mane = path_mtcol .. "dun_cremello.png"
                    end
                end
            end
        end
        -- COAT MODIFIERS
        if genes[DOMINANT_WHITE] == 10 then
            base = path_col .. "white.png"
            mane_mod = path_mtcol .. "white.png"
            eyes = path_eyes .. "unpigmented.png"
        else
            if genes[EXTENSION] == 0 and genes[FLAXEN] == 0 then
                mane_mod = path_mam .. "flaxen.png"
            end
            if genes[SOOTY] ~= 0 then
                modifiers[#modifiers + 1] = path_com .. "sooty.png"
                modifiers[#modifiers + 1] = path_mam .. "sooty.png"
            end
            if genes[RABICANO] ~= 0 then
                modifiers[#modifiers + 1] = path_com .. "rabicano.png"
            end
            if genes[ROAN] ~= 0 then
                modifiers[#modifiers + 1] = path_com .. "roan.png"
            end
            if genes[GREY] ~= 0 then
                modifiers[#modifiers + 1] = path_com .. "grey_100.png"
            end
            if genes[SABINO] == 10 then
                modifiers[#modifiers + 1] = path_com .. "sabino1.png"
            elseif genes[SABINO] == 11 then
                modifiers[#modifiers + 1] = path_com .. "sabino2.png"
            end
            if genes[TOBIANO] ~= 0 then
                modifiers[#modifiers + 1] = path_com .. "tobiano.png"
            end
            if genes[LETHAL_WHITE_OVERO] ~= 0 then
                modifiers[#modifiers + 1] = path_com .. "overo.png"
            end
            if genes[SPLASHED_WHITE] == 10 then
                modifiers[#modifiers + 1] = path_com .. "splashed1.png"
            elseif genes[SPLASHED_WHITE] == 11 then
                modifiers[#modifiers + 1] = path_com .. "splashed2.png"
            end
            if genes[LEOPARD] == 10 and genes[PATTERN_1] == 10 then
                modifiers[#modifiers + 1] = path_com .. "appaloosa1_pattern1.png"
            elseif genes[LEOPARD] == 10 and genes[PATTERN_1] == 11 then
                modifiers[#modifiers + 1] = path_com .. "appaloosa1_2xpattern1.png"
            elseif genes[LEOPARD] == 10 and genes[PATTERN_2] ~= 0 then
                modifiers[#modifiers + 1] = path_com .. "appaloosa1_pattern2.png"
            elseif genes[LEOPARD] == 10 then
                modifiers[#modifiers + 1] = path_com .. "appaloosa1.png"
            elseif genes[LEOPARD] == 11 and genes[PATTERN_1] == 10 then
                modifiers[#modifiers + 1] = path_com .. "appaloosa2_pattern1.png"
            elseif genes[LEOPARD] == 11 and genes[PATTERN_1] == 11 then
                modifiers[#modifiers + 1] = path_col .. "white.png"
            elseif genes[LEOPARD] == 11 and genes[PATTERN_2] ~= 0 then
                modifiers[#modifiers + 1] = path_com .. "appaloosa2_pattern2.png"
            end

            if genes[LEOPARD] ~= 0 then
                if eyes == path_eyes .. "amber.png" then
                    eyes = path_eyes .. "appaloosa_amber.png"
                elseif eyes == path_eyes .. "blue.png" then
                    eyes = path_eyes .. "appaloosa_blue.png"
                elseif eyes == path_eyes .. "hazel.png" then
                    eyes = path_eyes .. "appaloosa_hazel.png"
                elseif eyes == path_eyes .. "brown.png" then
                    eyes = path_eyes .. "appaloosa_brown.png"
                end
            end
        end
            -- LEG MARKINGS
        if genes[LEG_MARKINGS][1] == "short" then
            local choice = math.random(2)
            if choice == 1 then
                markings[#markings + 1] = path_lmark .. "front_left_coronet.png"
            else
                markings[#markings + 1] = path_lmark .. "front_left_pastern.png"
            end
        elseif genes[LEG_MARKINGS][1] == "medium" then
            local choice = math.random(2)
            if choice == 1 then
                markings[#markings + 1] = path_lmark .. "front_left_ankle.png"
            else
                markings[#markings + 1] = path_lmark .. "front_left_fetlock.png"
            end
        elseif genes[LEG_MARKINGS][1] == "long" then
            local choice = math.random(2)
            if choice == 1 then
                markings[#markings + 1] = path_lmark .. "front_left_fullsock.png"
            else
                markings[#markings + 1] = path_lmark .. "front_left_stocking.png"
            end
        end
        if genes[LEG_MARKINGS][2] == "short" then
            local choice = math.random(2)
            if choice == 1 then
                markings[#markings + 1] = path_lmark .. "front_right_coronet.png"
            else
                markings[#markings + 1] = path_lmark .. "front_right_pastern.png"
            end
        elseif genes[LEG_MARKINGS][2] == "medium" then
            local choice = math.random(2)
            if choice == 1 then
                markings[#markings + 1] = path_lmark .. "front_right_ankle.png"
            else
                markings[#markings + 1] = path_lmark .. "front_right_fetlock.png"
            end
        elseif genes[LEG_MARKINGS][2] == "long" then
            local choice = math.random(2)
            if choice == 1 then
                markings[#markings + 1] = path_lmark .. "front_right_fullsock.png"
            else
                markings[#markings + 1] = path_lmark .. "front_right_stocking.png"
            end
        end
        if genes[LEG_MARKINGS][3] == "short" then
            local choice = math.random(2)
            if choice == 1 then
                markings[#markings + 1] = path_lmark .. "hind_left_coronet.png"
            else
                markings[#markings + 1] = path_lmark .. "hind_left_pastern.png"
            end
        elseif genes[LEG_MARKINGS][3] == "medium" then
            local choice = math.random(2)
            if choice == 1 then
                markings[#markings + 1] = path_lmark .. "hind_left_ankle.png"
            else
                markings[#markings + 1] = path_lmark .. "hind_left_fetlock.png"
            end
        elseif genes[LEG_MARKINGS][3] == "long" then
            local choice = math.random(2)
            if choice == 1 then
                markings[#markings + 1] = path_lmark .. "hind_left_fullsock.png"
            else
                markings[#markings + 1] = path_lmark .. "hind_left_stocking.png"
            end
        end
        if genes[LEG_MARKINGS][4] == "short" then
            local choice = math.random(2)
            if choice == 1 then
                markings[#markings + 1] = path_lmark .. "hind_right_coronet.png"
            else
                markings[#markings + 1] = path_lmark .. "hind_right_pastern.png"
            end
        elseif genes[LEG_MARKINGS][4] == "medium" then
            local choice = math.random(2)
            if choice == 1 then
                markings[#markings + 1] = path_lmark .. "hind_right_ankle.png"
            else
                markings[#markings + 1] = path_lmark .. "hind_right_fetlock.png"
            end
        elseif genes[LEG_MARKINGS][4] == "long" then
            local choice = math.random(2)
            if choice == 1 then
                markings[#markings + 1] = path_lmark .. "hind_right_fullsock.png"
            else
                markings[#markings + 1] = path_lmark .. "hind_right_stocking.png"
            end
        end

        if genes[FACE_MARKINGS] == "full" then
            local choice = math.random(6)
            if choice == 1 then
                markings[#markings + 1] = path_hmark .. "war_bonnet.png"
            elseif choice == 2 then
                markings[#markings + 1] = path_hmark .. "apron_face.png"
            else
                markings[#markings + 1] = path_hmark .. "bald_face.png"
            end
        elseif genes[FACE_MARKINGS] == "muzzle" then
            local choice = math.random(7)
            if choice == 1 or choice == 2 then
                markings[#markings + 1] = path_hmark .. "chin_spot.png"
            elseif choice == 3 or choice == 4 then
                markings[#markings + 1] = path_hmark .. "snip.png"
            elseif choice == 5 or choice == 6 then
                markings[#markings + 1] = path_hmark .. "upper_lip.png"
            else
                markings[#markings + 1] = path_hmark .. "white_muzzle.png"
            end
        elseif genes[FACE_MARKINGS] == "star" then
            local choice = math.random(2)
            if choice == 1 then
                markings[#markings + 1] = path_hmark .. "star.png"
            else
                markings[#markings + 1] = path_hmark .. "star2.png"
            end
        elseif genes[FACE_MARKINGS] == "stripe" then
            local choice = math.random(4)
            if choice == 1 then
                markings[#markings + 1] = path_hmark .. "stripe.png"
            elseif choice == 2 then
                markings[#markings + 1] = path_hmark .. "race.png"
            elseif choice == 3 then
                markings[#markings + 1] = path_hmark .. "interrupted.png"
            else
                markings[#markings + 1] = path_hmark .. "blaze.png"
            end
        end
    elseif life_state == "kelpie" or (life_state == "hybrid" and kelpie_traits[4] == "colored") then
        eyes = path_eyes .. kelpie_traits[3] .. ".png"
        base = path_col .. kelpie_traits[1] .. ".png"
        mane = path_mtcol .. kelpie_traits[2] .. ".png"
    end

    coat = {base, eyes}
    mane_data = {}

    for k, mod in ipairs(modifiers) do
        coat[#coat + 1] = mod
    end

    mane_data[#mane_data + 1] = mane
    if mane_mod ~= nil and mane_mod ~= "" then
        mane_data[#mane_data + 1] = mane_mod
    end

    return {coat, mane_data, markings}
end

function Horse:ageUp()
    for k, v in ipairs(self.coat_layers) do
        if string.sub(v, 1, 11) == "coat_colors" then
            if self.life_state == "hybrid" and self.kelpie_traits[4] == "normal" then
                self.coat_layers[k] = "coat_colors/hybrid/" .. string.sub(v, 18)
            else
                self.coat_layers[k] = "coat_colors/" .. string.sub(v, 18)
            end
        elseif string.sub(v, 1, 16) == "mane_tail_colors" then
            self.coat_layers[k] = "mane_tail_colors/" .. string.sub(v, 23)
        elseif string.sub(v, 1, 14) == "coat_modifiers" then
            if self.life_state == "hybrid" and self.kelpie_traits[4] == "normal" then
                self.coat_layers[k] = "coat_modifiers/hybrid/" .. string.sub(v, 21)
            else
                self.coat_layers[k] = "coat_modifiers/" .. string.sub(v, 21)
            end
        elseif string.sub(v, 1, 14) == "mane_modifiers" then
            self.coat_layers[k] = "mane_modifiers/" .. string.sub(v, 21)
        elseif string.sub(v, 1, 4) == "eyes" then
            self.coat_layers[k] = "eyes/" .. string.sub(v, 11)
        elseif string.sub(v, 1, 13) == "head_markings" then
            self.coat_layers[k] = "head_markings/" .. string.sub(v, 20)
        elseif string.sub(v, 1, 12) == "leg_markings" then
            self.coat_layers[k] = "leg_markings/" .. string.sub(v, 19)
        elseif v == "line/foal_base.png" then
            self.coat_layers[k] = "line/horse_base.png"
        elseif v == "line/foal_kelpie_base.png" then
            self.coat_layers[k] = "line/kelpie_base.png"
        elseif v == "line/mane_tail_foal.png" then
            self.coat_layers[k] = "line/mane_tail_wild.png"
        elseif v == "line/foal_kelpie_mane_tail.png" then
            self.coat_layers[k] = "line/kelpie_mane_tail.png"
        elseif v == "line/foal_scales.png" then
            self.coat_layers[k] = "line/kelpie_scales.png"
        elseif v == "line/foal_hybrid_scales.png" then
            self.coat_layers[k] = "line/hybrid_scales.png"
        end
    end
end

function Horse:generateNewSkills()
    stm = math.random(5, 10)
    spd = math.random(5, 10)
    jmp = math.random(5, 10)
    drs = math.random(5, 10)
    
    skills = {stm, spd, jmp, drs}

    return skills
end

function Horse:generateCurSkills(gen_skills)
    stm = math.random(0, gen_skills[1])
    spd = math.random(0, gen_skills[2])
    jmp = math.random(0, gen_skills[3])
    drs = math.random(0, gen_skills[4])
    
    skills = {stm, spd, jmp, drs}

    return skills
end

function Horse:genetics(genes1, genes2)
    result = {}
    for k, v in ipairs(genes1) do
        if k < 20 then
            if v == 0 and genes2[k] == 0 then
                result[#result + 1] = 0
            elseif (v == 0 and genes2[k] == 10) or (genes2[k] == 0 and v == 10) then
                if math.random(2) == 1 then
                    result[#result + 1] = 0
                else
                    result[#result + 1] = 10
                end
            elseif (v == 0 and genes2[k] == 11) or (genes2[k] == 0 and v == 11) then
                result[#result + 1] = 10
            elseif v == 10 and genes2[k] == 10 then
                if math.random(4) == 4 then
                    result[#result + 1] = 11
                elseif math.random(4) == 1 then
                    result[#result + 1] = 00
                else
                    result[#result + 1] = 10
                end
            elseif (v == 10 and genes2[k] == 11) or (genes2[k] == 10 and v == 11) then
                if math.random(2) == 1 then
                    result[#result + 1] = 10
                else
                    result[#result + 1] = 11
                end
            elseif v == 11 and genes2[k] == 11 then
                result[#result + 1] = 11
            elseif v == 20 and genes2[k] == 0 then
                if math.random(2) == 1 then
                    result[#result + 1] = 20
                else
                    result[#result + 1] = 0
                end
            elseif (v == 10 and genes2[k] == 20) or (genes2[k] == 10 and v == 20) then
                if math.random(4) == 4 then
                    result[#result + 1] = 21
                elseif math.random(4) == 3 then
                    result[#result + 1] = 20
                elseif math.random(4) == 2 then
                    result[#result + 1] = 10
                else
                    result[#result + 1] = 00
                end
            elseif (v == 20 and genes2[k] == 11) or (genes2[k] == 20 and v == 11) then
                if math.random(2) == 1 then
                    result[#result + 1] = 21
                else
                    result[#result + 1] = 10
                end
            elseif v == 20 and genes2[k] == 20 then
                if math.random(4) == 4 then
                    result[#result + 1] = 22
                elseif math.random(4) == 1 then
                    result[#result + 1] = 00
                else
                    result[#result + 1] = 20
                end
            elseif (v == 20 and genes2[k] == 21) or (genes2[k] == 20 and v == 21) then
                if math.random(4) == 4 then
                    result[#result + 1] = 22
                elseif math.random(4) == 3 then
                    result[#result + 1] = 21
                elseif math.random(4) == 2 then
                    result[#result + 1] = 20
                else
                    result[#result + 1] = 10
                end
            elseif (v == 20 and genes2[k] == 22) or (genes2[k] == 20 and v == 22) then
                if math.random(2) == 1 then
                    result[#result + 1] = 22
                else
                    result[#result + 1] = 20
                end
            elseif (v == 0 and genes2[k] == 21) or (genes2[k] == 0 and v == 21) then
                if math.random(2) == 1 then
                    result[#result + 1] = 20
                else
                    result[#result + 1] = 10
                end
            elseif (v == 10 and genes2[k] == 21) or (genes2[k] == 10 and v == 21) then
                if math.random(4) == 4 then
                    result[#result + 1] = 21
                elseif math.random(4) == 3 then
                    result[#result + 1] = 11
                elseif math.random(4) == 2 then
                    result[#result + 1] = 20
                else
                    result[#result + 1] = 10
                end
            elseif (v == 11 and genes2[k] == 21) or (genes2[k] == 11 and v == 21) then
                if math.random(2) == 1 then
                    result[#result + 1] = 21
                else
                    result[#result + 1] = 11
                end
            elseif v == 21 and genes2[k] == 21 then
                if math.random(4) == 4 then
                    result[#result + 1] = 22
                elseif math.random(4) == 1 then
                    result[#result + 1] = 11
                else
                    result[#result + 1] = 21
                end
            elseif (v == 0 and genes2[k] == 22) or (genes2[k] == 0 and v == 22) then
                result[#result + 1] = 20
            elseif v == 10 and genes2[k] == 22 then
                if math.random(2) == 1 then
                    result[#result + 1] = 21
                else
                    result[#result + 1] = 20
                end
            elseif (v == 11 and genes2[k] == 22) or (genes2[k] == 11 and v == 22) then
                result[#result + 1] = 21
            elseif (v == 21 and genes2[k] == 22) or (genes2[k] == 21 and v == 22) then
                if math.random(2) == 1 then
                    result[#result + 1] = 22
                else
                    result[#result + 1] = 21
                end
            elseif v == 22 and genes2[k] == 22 then
                result[#result + 1] = 22
            end
        end
    end

    result[20] = {}

    if math.random(2) == 1 then
        result[20][1] = genes1[20][1]
    else
        result[20][1] = genes2[20][1]
    end
    if math.random(2) == 1 then
        result[20][2] = genes1[20][2]
    else
        result[20][2] = genes2[20][2]
    end
    if math.random(2) == 1 then
        result[20][3] = genes1[20][3]
    else
        result[20][3] = genes2[20][3]
    end
    if math.random(2) == 1 then
        result[20][4] = genes1[20][4]
    else
        result[20][4] = genes2[20][4]
    end
    if math.random(2) == 1 then
        result[21] = genes1[21]
    else
        result[21] = genes2[21]
    end

    return result
end

function Horse:renderHead(x, y, sx, sy)
    self.line = love.graphics.newArrayImage(self.coat_layers)
    local head_quad = love.graphics.newQuad(0, 0, 314, 314, 675, 609)
    local equipment_to_draw
    if self.equipped == true then
        equipment_to_draw = love.graphics.newArrayImage({"equipment/" .. self.equipment[3] .. ".png",
        "equipment/" .. self.equipment[1] .. ".png", "equipment/" .. self.equipment[2] .. ".png"})
    end
    for i = 1, #self.coat_layers do
        if self.coat_layers[i] == "coat_modifiers/grey_100.png" then
            if self.age_y >= 2 then
                if self.age_y < 8 then
                    local opacity = (self.age_y - 2)/6
                    love.graphics.setColor(1,1,1,opacity)
                    love.graphics.drawLayer(self.line, i, head_quad, x, y, 0, sx, sy)
                else
                    love.graphics.drawLayer(self.line, i, head_quad, x, y, 0, sx, sy)
                end
            end
        elseif self.coat_layers[i] == "line/horse_base.png" and self.equipped == true and self.eq_hidden == false
        and self.preg == -1 and self.foal == nil and self.effects[1] == false then
            love.graphics.setColor(1,1,1,1)
            love.graphics.drawLayer(self.line, i, head_quad, x, y, 0, sx, sy)
            love.graphics.drawLayer(equipment_to_draw, 1, head_quad, x, y, 0, sx, sy)
            love.graphics.drawLayer(equipment_to_draw, 2, head_quad, x, y, 0, sx, sy)
            love.graphics.drawLayer(equipment_to_draw, 3, head_quad, x, y, 0, sx, sy)
        else
            love.graphics.setColor(1,1,1,1)
            love.graphics.drawLayer(self.line, i, head_quad, x, y, 0, sx, sy)
        end
    end
end

function Horse:renderSmallerHead(x, y, sx, sy)
    self.line = love.graphics.newArrayImage(self.coat_layers)
    local head_quad = love.graphics.newQuad(0, 0, 212, 212, 675, 609)
    local equipment_to_draw
    if self.equipped == true then
        equipment_to_draw = love.graphics.newArrayImage({"equipment/" .. self.equipment[3] .. ".png",
        "equipment/" .. self.equipment[1] .. ".png", "equipment/" .. self.equipment[2] .. ".png"})
    end
    for i = 1, #self.coat_layers do
        if self.coat_layers[i] == "coat_modifiers/grey_100.png" then
            if self.age_y >= 2 then
                if self.age_y < 8 then
                    local opacity = (self.age_y - 2)/6
                    love.graphics.setColor(1,1,1,opacity)
                    love.graphics.drawLayer(self.line, i, head_quad, x, y, 0, sx, sy)
                else
                    love.graphics.drawLayer(self.line, i, head_quad, x, y, 0, sx, sy)
                end
            end
        elseif self.coat_layers[i] == "line/horse_base.png" and self.equipped == true and self.eq_hidden == false
        and self.preg == -1 and self.foal == nil and self.effects[1] == false then
            love.graphics.setColor(1,1,1,1)
            love.graphics.drawLayer(self.line, i, head_quad, x, y, 0, sx, sy)
            love.graphics.drawLayer(equipment_to_draw, 1, head_quad, x, y, 0, sx, sy)
            love.graphics.drawLayer(equipment_to_draw, 2, head_quad, x, y, 0, sx, sy)
            love.graphics.drawLayer(equipment_to_draw, 3, head_quad, x, y, 0, sx, sy)
        else
            love.graphics.setColor(1,1,1,1)
            love.graphics.drawLayer(self.line, i, head_quad, x, y, 0, sx, sy)
        end
    end
end

function Horse:render(x, y, sx, sy)
    self.line = love.graphics.newArrayImage(self.coat_layers)
    local equipment_to_draw
    if self.equipped == true then
        equipment_to_draw = love.graphics.newArrayImage({"equipment/" .. self.equipment[3] .. ".png",
        "equipment/" .. self.equipment[1] .. ".png", "equipment/" .. self.equipment[2] .. ".png"})
    end
    for i = 1, #self.coat_layers do
        if self.coat_layers[i] == "coat_modifiers/grey_100.png" then
            if self.age_y >= 2 then
                if self.age_y < 8 then
                    local opacity = (self.age_y - 2)/6
                    love.graphics.setColor(1,1,1,opacity)
                    love.graphics.drawLayer(self.line, i, x, y, 0, sx, sy)
                else
                    love.graphics.drawLayer(self.line, i, x, y, 0, sx, sy)
                end
            end
        elseif self.coat_layers[i] == "line/horse_base.png" and self.equipped == true and self.eq_hidden == false
        and self.preg == -1 and self.foal == nil and self.effects[1] == false then
            love.graphics.setColor(1,1,1,1)
            love.graphics.drawLayer(self.line, i, x, y, 0, sx, sy)
            love.graphics.drawLayer(equipment_to_draw, 1, x, y, 0, sx, sy)
            love.graphics.drawLayer(equipment_to_draw, 2, x, y, 0, sx, sy)
            love.graphics.drawLayer(equipment_to_draw, 3, x, y, 0, sx, sy)
        elseif self.coat_layers[i] == "line/kelpie_mane_tail.png" and self.equipped == true and self.eq_hidden == false
        and self.preg == -1 and self.foal == nil and self.effects[1] == false then
            love.graphics.setColor(1,1,1,1)
            love.graphics.drawLayer(self.line, i, x, y, 0, sx, sy)
            love.graphics.drawLayer(equipment_to_draw, 1, x, y, 0, sx, sy)
            love.graphics.drawLayer(equipment_to_draw, 2, x, y, 0, sx, sy)
            love.graphics.drawLayer(equipment_to_draw, 3, x, y, 0, sx, sy)
        else
            love.graphics.setColor(1,1,1,1)
            love.graphics.drawLayer(self.line, i, x, y, 0, sx, sy)
        end
    end
end

function Horse:getName()
    return self.name
end

function Horse:getGender()
    return self.gender
end

function Horse:setName(name)
    self.name = name
end

function Horse:showInfo()
    local game_width = love.graphics.getWidth()
    local game_height = love.graphics.getHeight()

    love.graphics.setFont(medium_font)
    love.graphics.setColor(colorChampagne)
    love.graphics.rectangle('fill', game_width - 500*sx, 30*sy, 380, 555)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.rectangle('line', game_width - 500*sx, 30*sy, 380, 555)
    love.graphics.setColor(1, 1, 1, 1)
    if self.gender == "f" then
        love.graphics.draw(female_sign, game_width - 480*sx, 65*sy, 0,sx,sy)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print(self.name, game_width - 450*sx, 60*sy)
    elseif self.gender == "m" then
        love.graphics.draw(male_sign, game_width - 480*sx, 65*sy, 0,sx,sy)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print(self.name, game_width - 440*sx, 63*sy)
    end
    love.graphics.setFont(smaller_font)
    love.graphics.print(self.age_y .. " years " .. self.age_m .. " months", game_width - 480*sx, 120*sy)

    love.graphics.print("Specialization: " .. self.specialization, game_width - 480*sx, 165*sy)
    local specText = love.graphics.newText(smaller_font, "Specialization: " .. self.specialization)
    if self.age_y > 1 then
        change_spec:render(game_width - 480*sx + specText:getWidth() + 10*sx, 165*sy, true)
    end
    love.graphics.setColor(colorGoldenrod)

    love.graphics.setFont(medium_font)
    love.graphics.print("Skills", game_width - 320*sx, 210*sy)

    love.graphics.setFont(smaller_font)
    love.graphics.print("Stamina", game_width - 480*sx, 260*sy)
    drawBar("skill", game_width - 370*sx, 260*sy, 200*sx, 40*sy, self.cur_skills[1], self.gen_skills[1])
    love.graphics.print(self.cur_skills[1] .. "/" .. self.gen_skills[1], game_width - 290*sx, 260*sy)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.print("Speed", game_width - 480*sx, 310*sy)
    drawBar("skill", game_width - 370*sx, 310*sy, 200*sx, 40*sy, self.cur_skills[2], self.gen_skills[2])
    love.graphics.print(self.cur_skills[2] .. "/" .. self.gen_skills[2], game_width - 290*sx, 310*sy)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.print("Jumping", game_width - 480*sx, 360*sy)
    drawBar("skill", game_width - 370*sx, 360*sy, 200*sx, 40*sy, self.cur_skills[3], self.gen_skills[3])
    love.graphics.print(self.cur_skills[3] .. "/" .. self.gen_skills[3], game_width - 290*sx, 360*sy)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.print("Dressage", game_width - 480*sx, 410*sy)
    drawBar("skill", game_width - 370*sx, 410*sy, 200*sx, 40*sy, self.cur_skills[4], self.gen_skills[4])
    love.graphics.print(self.cur_skills[4] .. "/" .. self.gen_skills[4], game_width - 290*sx, 410*sy)

    love.graphics.setFont(medium_font)
    love.graphics.print("Needs", game_width - 320*sx, 460*sy)

    love.graphics.setFont(smaller_font)
    love.graphics.print("Health", game_width - 480*sx, 510*sy)
    drawBar("health", game_width - 370*sx, 510*sy, 200*sx, 40*sy, self.health, 100)
    love.graphics.print(self.health .. "/100", game_width - 320*sx, 510*sy)
    if self.effects[1] == true then
        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(trauma_icon, game_width - 160*sx, 512*sy)
        love.graphics.setColor(colorGoldenrod)
    end
    love.graphics.print("Energy", game_width - 480*sx, 560*sy)
    drawBar("energy", game_width - 370*sx, 560*sy, 200*sx, 40*sy, self.energy, 100)
    love.graphics.print(self.energy .. "/100", game_width - 320*sx, 560*sy)
    love.graphics.print("Mood", game_width - 480*sx, 610*sy)
    drawBar("mood", game_width - 370*sx, 610*sy, 200*sx, 40*sy, self.mood, 100)
    love.graphics.print(self.mood .. "/100", game_width - 320*sx, 610*sy)

    love.graphics.setColor(1,1,1,1)
    if self.needs[2] == false then
        love.graphics.draw(need_water_icon, game_width - 360*sx, 665*sy, 0, 1.1*sx, 1.1*sy)
    end
    if self.needs[1] == false then
        love.graphics.draw(need_food_icon, game_width - 310*sx, 665*sy, 0, 1.1*sx, 1.1*sy)
    end
    if self.needs[3] == false then
        love.graphics.draw(need_hygiene_icon, game_width - 250*sx, 670*sy, 0, 1.2*sx, 1.2*sy)
    end

    edit_name:render(game_width - 200*sx, 60*sy, true)


    if self.foal ~= nil then
        love.graphics.setColor(colorChampagne)
        love.graphics.rectangle('fill', game_width - 500*sx, 730*sy, 380, 100)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.rectangle('line', game_width - 500*sx, 730*sy, 380, 100)
        love.graphics.setColor(1, 1, 1, 1)
        if self.foal.gender == "f" then
            love.graphics.draw(female_sign, game_width - 480*sx, 750*sy, 0,sx,sy)
            love.graphics.setColor(colorGoldenrod)
            love.graphics.print(self.foal.name, game_width - 450*sx, 750*sy)
        elseif self.foal.gender == "m" then
            love.graphics.draw(male_sign, game_width - 480*sx, 750*sy, 0,sx,sy)
            love.graphics.setColor(colorGoldenrod)
            love.graphics.print(self.foal.name, game_width - 440*sx, 748*sy)
        end
        love.graphics.setFont(smaller_font)
        love.graphics.print(self.foal.age_m .. " months", game_width - 480*sx, 790*sy)
    end
end

function Horse:showTrainingInfo(event, type, number)
    local game_width = love.graphics.getWidth()
    local game_height = love.graphics.getHeight()

    local dim11 = 0
    local dim31 = 0
    local dim12 = 0
    local dim21 = 0
    local dim22 = 0
    local dim32 = 0
    local stdim1 = 0
    local jddim1 = 0
    local stamina2 = 0
    local skill1 = 0
    local skill3 = 200*sx
    local skill4 = 40*sy
    local text1 = 0
    local spdim1 = 0
    local speed2 = 0
    local jd2 = 0
    local entext1 = 0
    local energy2 = 0

    if number == 1 then

        dim11 = 280*sx
        dim31 = dim11
        dim12 = 270*sy
        dim21 = 300*sx
        dim22 = 290*sy
        dim32 = 470*sy
        stdim1 = 520*sx
        jddim1 = stdim1
        stamina2 = 290*sy
        skill1 = 630*sx
        text1 = 700*sx
        spdim1 = 540*sx
        speed2 = 345*sy
        jd2 = 310*sy
        entext1 = 680*sx
        energy2 = 400*sy

    elseif number == 2 then

        dim11 = game_width/2 - 10*sx
        dim31 = dim11
        dim12 = 270*sy
        dim21 = game_width/2 + 10*sx
        dim22 = 290*sy
        dim32 = 470*sy
        stdim1 = game_width - 730*sx
        jddim1 = stdim1
        stamina2 = 290*sy
        skill1 = game_width - 620*sx
        text1 = game_width - 550*sx
        spdim1 = stdim1
        speed2 = 345*sy
        jd2 = 310*sy
        entext1 = game_width - 570*sx
        energy2 = 400*sy

    elseif number == 3 then

        dim11 = 280*sx
        dim31 = dim11
        dim12 = 570*sy
        dim21 = 300*sx
        dim22 = 590*sy
        dim32 = 770*sy
        stdim1 = 520*sx
        jddim1 = stdim1
        stamina2 = 590*sy
        skill1 = 630*sx
        text1 = 700*sx
        spdim1 = 540*sx
        speed2 = 645*sy
        jd2 = 610*sy
        entext1 = 680*sx
        energy2 = 700*sy

    elseif number == 4 then

        dim11 = game_width/2 - 10*sx
        dim31 = dim11
        dim12 = 570*sy
        dim21 = game_width/2 + 10*sx
        dim22 = 590*sy
        dim32 = 770*sy
        stdim1 = game_width - 730*sx
        jddim1 = stdim1
        stamina2 = 590*sy
        skill1 = game_width - 620*sx
        text1 = game_width - 550*sx
        spdim1 = stdim1
        speed2 = 645*sy
        jd2 = 610*sy
        entext1 = game_width - 570*sx
        energy2 = 700*sy
    end

    love.graphics.setColor(colorJasmine)
    love.graphics.rectangle("fill", dim11, dim12, 155, 155)
    love.graphics.setColor(1,1,1,1)
    self:renderSmallerHead(dim21, dim22, 0.65, 0.65)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.rectangle("line", dim11, dim12, 155, 155)

    love.graphics.setFont(medium_font)
    love.graphics.setColor(colorGoldenrod)
    love.graphics.print(self.name, dim31, dim32)

    if type == "cross-country" then
        love.graphics.setFont(smaller_font)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print("Stamina", stdim1, stamina2 - 30*sy)
        drawBar("skill", skill1, stamina2 - 30*sy, skill3, skill4, self.cur_skills[1], self.gen_skills[1])
        love.graphics.print(self.cur_skills[1] .. "/" .. self.gen_skills[1], text1, stamina2 - 30*sy)

        love.graphics.setColor(colorGoldenrod)
        love.graphics.print("Speed", spdim1, speed2 - 30*sy)
        drawBar("skill", skill1, speed2 - 30*sy, skill3, skill4, self.cur_skills[2], self.gen_skills[2])
        love.graphics.print(self.cur_skills[2] .. "/" .. self.gen_skills[2], text1, speed2 - 30*sy)

        love.graphics.setColor(colorGoldenrod)
        love.graphics.print("Jumping", jddim1, speed2 + 25*sy)
        drawBar("skill", skill1, speed2 + 25*sy, skill3, skill4, self.cur_skills[3], self.gen_skills[3])
        love.graphics.print(self.cur_skills[3] .. "/" .. self.gen_skills[3], text1, speed2 + 25*sy)

        drawBar("energy", skill1, energy2 + 25*sy, skill3, skill4, self.energy, 100)
        love.graphics.print(self.energy .. "/100", entext1, energy2 + 25*sy)

    elseif type == "jumping" then
        love.graphics.setFont(smaller_font)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print("Speed", stdim1, stamina2 - 30*sy)
        drawBar("skill", skill1, stamina2 - 30*sy, skill3, skill4, self.cur_skills[2], self.gen_skills[2])
        love.graphics.print(self.cur_skills[2] .. "/" .. self.gen_skills[2], text1, stamina2 - 30*sy)

        love.graphics.setColor(colorGoldenrod)
        love.graphics.print("Jumping", jddim1, speed2 - 30*sy)
        drawBar("skill", skill1, speed2 - 30*sy, skill3, skill4, self.cur_skills[3], self.gen_skills[3])
        love.graphics.print(self.cur_skills[3] .. "/" .. self.gen_skills[3], text1, speed2 - 30*sy)


        drawBar("energy", skill1, energy2, skill3, skill4, self.energy, 100)
        love.graphics.print(self.energy .. "/100", entext1, energy2)
    elseif type == "dressage" then
        love.graphics.setFont(smaller_font)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print("Dressage", jddim1, jd2)
        drawBar("skill", skill1, jd2, skill3, skill4, self.cur_skills[4], self.gen_skills[4])
        love.graphics.print(self.cur_skills[4] .. "/" .. self.gen_skills[4], text1, jd2)

        drawBar("energy", skill1, energy2, skill3, skill4, self.energy, 100)
        love.graphics.print(self.energy .. "/100", entext1, energy2)
    end

    if number == 1 or number == 5 or number == 9 or number == 13 or number == 17 then
        if type == 'cross' then
            btny = 490*sy 
        else
            btny = 470*sy 
        end
        if event == "training" then
            train_1_button:render(670*sx, btny, true)
        elseif event == "competing" then
            compete_1_button:render(670*sx, btny, true)
        end
    elseif number == 2 or number == 6 or number == 10 or number == 14 or number == 18 then
        if event == "training" then
            train_2_button:render(game_width - 580*sx, btny, true)
        elseif event == "competing" then
            compete_2_button:render(game_width - 580*sx, btny, true)
        end
    elseif number == 3 or number == 7 or number == 11 or number == 15 or number == 19 then
        if event == "training" then
            train_3_button:render(670*sx, btny + 300*sy, true)
        elseif event == "competing" then
            compete_3_button:render(670*sx, btny + 300*sy, true)
        end
    elseif number == 4 or number == 8 or number == 12 or number == 16 or number == 20 then
        if event == "training" then
            train_4_button:render(game_width - 580*sx, btny + 300*sy, true)
        elseif event == "competing" then
            compete_4_button:render(game_width - 580*sx, btny + 300*sy, true)
        end
    end

end

function Horse:train(type)
    if self.energy >= 10 then
        local moodchance = self.mood + self.health
        if type == "cross-country" then
            if self.cur_skills[1] / self.gen_skills[1] > 1 then
                success = math.random(0, 15)
            else
                success = math.random(0, 45)
            end
            if math.random(1,199) < moodchance then
                self.cur_skills[1] = self.cur_skills[1] + success*0.01
            end
            if self.cur_skills[2] / self.gen_skills[2] > 1 then
                success = math.random(0, 15)
            else
                success = math.random(0, 45)
            end
            if math.random(1,199) < moodchance then
                self.cur_skills[2] = self.cur_skills[2] + success*0.01
            end
            if self.cur_skills[3] / self.gen_skills[3] > 1 then
                success = math.random(0, 15)
            else
                success = math.random(0, 45)
            end
            if math.random(1,199) < moodchance then
                self.cur_skills[3] = self.cur_skills[3] + success*0.01
            end
        elseif type == "jumping" then
            if self.cur_skills[2] / self.gen_skills[2] > 1 then
                success = math.random(0, 15)
            else
                success = math.random(0, 45)
            end
            if math.random(1,199) < moodchance then
                self.cur_skills[2] = self.cur_skills[2] + success*0.01
            end
            if self.cur_skills[3] / self.gen_skills[3] > 1 then
                success = math.random(0, 15)
            else
                success = math.random(0, 45)
            end
            if math.random(1,199) < moodchance then
                self.cur_skills[3] = self.cur_skills[3] + success*0.01
            end
        elseif type == "dressage" then
            if self.cur_skills[4] / self.gen_skills[4] > 1 then
                success = math.random(0, 15)
            else
                success = math.random(0, 45)
            end
            if math.random(1,199) < moodchance then
                self.cur_skills[4] = self.cur_skills[4] + success*0.01
            end
        end
        self.energy = self.energy - 10
        if math.random(6) == 1 then
            self.needs[3] = false
        end
    end
end

function Horse:compete(type, tier)

    if self.energy >= 10 then
        local rivals = {}
        local place = 10
        local chance = 0
        local lowest = 0
        local highest = 0
        local bonus = 0
        prize = 0
        local stam = self.cur_skills[1]
        local spd = self.cur_skills[2]
        local jmp = self.cur_skills[3]
        local drs = self.cur_skills[4]
        local trauma_chance = 0

        if tier == 1 then
            lowest = 5
            highest = 10
            playerCoins = playerCoins - 5
        elseif tier == 2 then
            lowest = 10
            highest = 15
            playerCoins = playerCoins - 10
        elseif tier == 3 then
            lowest = 15
            highest = 20
            playerCoins = playerCoins - 25
        elseif tier == 4 then
            lowest = 20
            highest = 30
            playerCoins = playerCoins - 40
        elseif tier == 5 then
            lowest = 30
            highest = 40
            playerCoins = playerCoins - 55
        end

        self.energy = self.energy - 10

        if self.mood < 50 then
            trauma_chance = trauma_chance + 5
        end
        if self.health < 50 then
            trauma_chance = trauma_chance + 20
        end
        if self.needs[1] == false then
            trauma_chance = trauma_chance + 5
        end
        if self.needs[2] == false then
            trauma_chance = trauma_chance + 5
        end
        if self.needs[3] == false then
            trauma_chance = trauma_chance + 5
        end

        if math.random(1,100) > trauma_chance then
            if type == "cross-country" then
                for i = 1, 9 do
                    rivals[i] = {math.random(lowest, highest), math.random(lowest, highest), math.random(lowest, highest)}
                end
                for k, rival in ipairs(rivals) do
                    chance = 10
                    if rival[1] < stam then
                        chance = chance + 10
                    end
                    if rival[2] < spd then
                        chance = chance + 10
                    end
                    if rival[3] < jmp then
                        chance = chance + 10
                    end
                    if math.random(0,50) < chance then
                        place = place - 1
                    end
                end
                if self.cur_skills[1] > self.gen_skills[1] then
                    bonus = bonus + 5
                end
                if self.cur_skills[2] > self.gen_skills[2] then
                    bonus = bonus + 5
                end
                if self.cur_skills[3] > self.gen_skills[3] then
                    bonus = bonus + 5
                end
                if math.random(0,30) < bonus then
                    place = place - 1
                end 
            elseif type == "jumping" then
                for i = 1, 9 do
                    rivals[i] = {math.random(lowest, highest), math.random(lowest, highest)}
                end
                for k, rival in ipairs(rivals) do
                    chance = 10
                    if rival[1] < spd then
                        chance = chance + 15
                    end
                    if rival[2] < jmp then
                        chance = chance + 15
                    end
                    if math.random(0,50) < chance then
                        place = place - 1
                    end
                end
                if self.cur_skills[2] > self.gen_skills[2] then
                    bonus = bonus + 5
                end
                if self.cur_skills[3] > self.gen_skills[3] then
                    bonus = bonus + 5
                end
                if math.random(0,25) < bonus then
                    place = place - 1
                end 
            elseif type == "dressage" then
                for i = 1, 9 do
                    rivals[i] = math.random(lowest, highest)
                end
                for k, rival in ipairs(rivals) do
                    chance = 10
                    if rival < drs then
                        chance = chance + 30
                    end
                    if math.random(0,50) < chance then
                        place = place - 1
                    end
                end
                if self.cur_skills[4] > self.gen_skills[4] then
                    bonus = bonus + 20
                end
                if math.random(0,25) < bonus then
                    place = place - 1
                end 
            end

            if place < 1 then
                place = 1
            end

            if place == 3 then
                if tier == 1 then
                    prize = 30
                elseif tier == 2 then
                    prize = 50
                elseif tier == 3 then
                    prize = 100
                elseif tier == 4 then
                    prize = 150
                elseif tier == 5 then
                    prize = 200
                end
            elseif place == 2 then
                if tier == 1 then
                    prize = 50
                elseif tier == 2 then
                    prize = 100
                elseif tier == 3 then
                    prize = 150
                elseif tier == 4 then
                    prize = 200
                elseif tier == 5 then
                    prize = 250
                end
            elseif place == 1 then
                if tier == 1 then
                    prize = 100
                elseif tier == 2 then
                    prize = 150
                elseif tier == 3 then
                    prize = 200
                elseif tier == 4 then
                    prize = 300
                elseif tier == 5 then
                    prize = 500
                end
            elseif place == 5 or place == 4 then
                if tier == 1 then
                    prize = 15
                elseif tier == 2 then
                    prize = 25
                elseif tier == 3 then
                    prize = 50
                elseif tier == 4 then
                    prize = 75
                elseif tier == 5 then
                    prize = 100
                end
            end
        else
            self.effects[1] = true
            return -2
        end

        playerCoins = playerCoins + prize

        if math.random(6) == 1 then
            self.needs[3] = false
        end

        return place
    else
        return -1
    end
end


function Horse:showBreedingInfo(gender)
    local game_width = love.graphics.getWidth()
    local game_height = love.graphics.getHeight()

    love.graphics.setColor(1,1,1,1)
    if gender == "m" then
        self:render(720*sx, 165*sy, -0.6, 0.6)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.setFont(medium_font)
        local nametext = love.graphics.newText(medium_font, self.name)
        love.graphics.print(self.name, 450*sx - nametext:getWidth()*sx, 650*sy)

        love.graphics.setFont(smaller_font)
        love.graphics.print("Stamina", 260*sx, game_height - 360*sy)
        drawBar("skill", 370*sx, game_height - 360*sy, 200*sx, 40*sy, self.cur_skills[1], self.gen_skills[1])
        love.graphics.print(self.cur_skills[1] .. "/" .. self.gen_skills[1], 450*sx, game_height - 360*sy)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print("Speed", 260*sx, game_height - 310*sy)
        drawBar("skill",370*sx, game_height - 310*sy, 200*sx, 40*sy, self.cur_skills[2], self.gen_skills[2])
        love.graphics.print(self.cur_skills[2] .. "/" .. self.gen_skills[2], 450*sx, game_height - 310*sy)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print("Jumping", 260*sx, game_height - 260*sy)
        drawBar("skill", 370*sx, game_height - 260*sy, 200*sx, 40*sy, self.cur_skills[3], self.gen_skills[3])
        love.graphics.print(self.cur_skills[3] .. "/" .. self.gen_skills[3], 450*sx, game_height - 260*sy)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print("Dressage", 260*sx, game_height - 210*sy)
        drawBar("skill", 370*sx, game_height - 210*sy, 200*sx, 40*sy, self.cur_skills[4], self.gen_skills[4])
        love.graphics.print(self.cur_skills[4] .. "/" .. self.gen_skills[4], 450*sx, game_height - 210*sy)

        love.graphics.print("Energy", 260*sx, game_height - 150*sy)
        drawBar("energy", 370*sx, game_height - 150*sy, 200*sx, 40*sy, self.energy, 100)
        love.graphics.print(self.energy .. "/100", 420*sx, game_height - 150*sy)
    elseif gender == "f" then
        self:render(1185*sx, 165*sy, 0.6, 0.6)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.setFont(medium_font)
        local nametext = love.graphics.newText(medium_font, self.name)
        love.graphics.print(self.name, game_width - 450*sx - nametext:getWidth()*sx, 650*sy)

        love.graphics.setFont(smaller_font)
        love.graphics.print("Stamina", game_width - 640*sx, game_height - 360*sy)
        drawBar("skill", game_width - 530*sx, game_height - 360*sy, 200*sx, 40*sy, self.cur_skills[1], self.gen_skills[1])
        love.graphics.print(self.cur_skills[1] .. "/" .. self.gen_skills[1], game_width - 450*sx, game_height - 360*sy)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print("Speed", game_width - 640*sx, game_height - 310*sy)
        drawBar("skill", game_width - 530*sx, game_height - 310*sy, 200*sx, 40*sy, self.cur_skills[2], self.gen_skills[2])
        love.graphics.print(self.cur_skills[2] .. "/" .. self.gen_skills[2], game_width - 450*sx, game_height - 310*sy)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print("Jumping", game_width - 640*sx, game_height - 260*sy)
        drawBar("skill", game_width - 530*sx, game_height - 260*sy, 200*sx, 40*sy, self.cur_skills[3], self.gen_skills[3])
        love.graphics.print(self.cur_skills[3] .. "/" .. self.gen_skills[3], game_width - 450*sx, game_height - 260*sy)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print("Dressage", game_width - 640*sx, game_height - 210*sy)
        drawBar("skill", game_width - 530*sx, game_height - 210*sy, 200*sx, 40*sy, self.cur_skills[4], self.gen_skills[4])
        love.graphics.print(self.cur_skills[4] .. "/" .. self.gen_skills[4], game_width - 450*sx, game_height - 210*sy)

        love.graphics.print("Energy", game_width - 640*sx, game_height - 150*sy)
        drawBar("energy", game_width - 530*sx, game_height - 150*sy, 200*sx, 40*sy, self.energy, 100)
        love.graphics.print(self.energy .. "/100", game_width - 480*sx, game_height - 150*sy)
    end
end

function Horse:initiatePregnancy(stud)
    self.preg = 0
    self.foal_parent = {stud.genes, stud.gen_skills, stud.cur_skills, stud.life_state, stud.kelpie_traits}
end

function Horse:giveBirth()
    self.preg = -1
    self.foal = self:generateOffspring(self, self.foal_parent)
    self.foal_parent = -1
end

function Horse:showHealthInfo(i)
    local game_width = love.graphics.getWidth()
    local game_height = love.graphics.getHeight()

    if i == 1 then
        treatmentPrice1 = 0
        love.graphics.setColor(colorJasmine)
        love.graphics.rectangle("fill", game_width/2 - 320*sx, game_height/2 - 430*sy, 130, 130)
        love.graphics.setColor(1,1,1,1)
        self:renderSmallerHead(game_width/2 - 305*sx, game_height/2 - 415*sy, 0.55, 0.55)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.rectangle("line", game_width/2 - 320*sx, game_height/2 - 430*sy, 130, 130)

        love.graphics.setFont(medium_font)
        love.graphics.print(self.name, game_width/2 - 110*sx, game_height/2 - 425*sy)

        love.graphics.setFont(smaller_font)
        love.graphics.print("Health", game_width/2 - 110*sx, game_height/2 - 375*sy)
        drawBar("health", game_width/2 - 20*sx, game_height/2 - 375*sy, 200*sx, 40*sy, self.health, 100)
        love.graphics.print(self.health .. "/100", game_width/2 + 30*sx, game_height/2 - 375*sy)
        if self.effects[1] == true then
            love.graphics.setColor(1,1,1,1)
            love.graphics.draw(trauma_icon, game_width/2 - 110*sx, game_height/2 - 310*sy)
            treatmentPrice1 = treatmentPrice1 + 200
        end

        love.graphics.setColor(colorGoldenrod)
        love.graphics.print(treatmentPrice1, game_width/2 + 213*sx, game_height/2 - 320*sy)
        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(coin_icon, game_width/2 + 263*sx, game_height/2 - 320*sy, 0, 0.7, 0.7)

        love.graphics.setColor(1,1,1,1)
        if playerCoins >= treatmentPrice1 then
            treat1_button:render(game_width/2 + 210*sx, game_height/2 - 370*sy, true)
        else
            treat1_button:render(game_width/2 + 210*sx, game_height/2 - 370*sy, false)
        end
    elseif i == 2 then
        treatmentPrice2 = 0
        love.graphics.setColor(colorJasmine)
        love.graphics.rectangle("fill", game_width/2 - 320*sx, game_height/2 - 230*sy, 130, 130)
        love.graphics.setColor(1,1,1,1)
        self:renderSmallerHead(game_width/2 - 305*sx, game_height/2 - 215*sy, 0.55, 0.55)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.rectangle("line", game_width/2 - 320*sx, game_height/2 - 230*sy, 130, 130)

        love.graphics.setFont(medium_font)
        love.graphics.print(self.name, game_width/2 - 110*sx, game_height/2 - 225*sy)

        love.graphics.setFont(smaller_font)
        love.graphics.print("Health", game_width/2 - 110*sx, game_height/2 - 175*sy)
        drawBar("health", game_width/2 - 20*sx, game_height/2 - 175*sy, 200*sx, 40*sy, self.health, 100)
        love.graphics.print(self.health .. "/100", game_width/2 + 30*sx, game_height/2 - 175*sy)
        if self.effects[1] == true then
            love.graphics.setColor(1,1,1,1)
            love.graphics.draw(trauma_icon, game_width/2 - 110*sx, game_height/2 - 110*sy)
            treatmentPrice2 = treatmentPrice2 + 200
        end

        love.graphics.setColor(colorGoldenrod)
        love.graphics.print(treatmentPrice2, game_width/2 + 213*sx, game_height/2 - 120*sy)
        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(coin_icon, game_width/2 + 263*sx, game_height/2 - 120*sy, 0, 0.7, 0.7)

        love.graphics.setColor(1,1,1,1)
        if playerCoins >= treatmentPrice2 then
            treat2_button:render(game_width/2 + 210*sx, game_height/2 - 170*sy, true)
        else
            treat2_button:render(game_width/2 + 210*sx, game_height/2 - 170*sy, false)
        end
    elseif i == 3 then
        treatmentPrice3 = 0
        love.graphics.setColor(colorJasmine)
        love.graphics.rectangle("fill", game_width/2 - 320*sx, game_height/2 - 30*sy, 130, 130)
        love.graphics.setColor(1,1,1,1)
        self:renderSmallerHead(game_width/2 - 305*sx, game_height/2 - 15*sy, 0.55, 0.55)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.rectangle("line", game_width/2 - 320*sx, game_height/2 - 30*sy, 130, 130)

        love.graphics.setFont(medium_font)
        love.graphics.print(self.name, game_width/2 - 110*sx, game_height/2 - 25*sy)

        love.graphics.setFont(smaller_font)
        love.graphics.print("Health", game_width/2 - 110*sx, game_height/2 + 25*sy)
        drawBar("health", game_width/2 - 20*sx, game_height/2 + 25*sy, 200*sx, 40*sy, self.health, 100)
        love.graphics.print(self.health .. "/100", game_width/2 + 30*sx, game_height/2 + 25*sy)
        if self.effects[1] == true then
            love.graphics.setColor(1,1,1,1)
            love.graphics.draw(trauma_icon, game_width/2 - 110*sx, game_height/2 + 90*sy)
            treatmentPrice3 = treatmentPrice3 + 200
        end

        love.graphics.setColor(colorGoldenrod)
        love.graphics.print(treatmentPrice3, game_width/2 + 213*sx, game_height/2 + 80*sy)
        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(coin_icon, game_width/2 + 263*sx, game_height/2 + 80*sy, 0, 0.7, 0.7)

        love.graphics.setColor(1,1,1,1)
        if playerCoins >= treatmentPrice3 then
            treat3_button:render(game_width/2 + 210*sx, game_height/2 + 30*sy, true)
        else
            treat3_button:render(game_width/2 + 210*sx, game_height/2 + 30*sy, false)
        end
    elseif i == 4 then
        treatmentPrice4 = 0
        love.graphics.setColor(colorJasmine)
        love.graphics.rectangle("fill", game_width/2 - 320*sx, game_height/2 + 170*sy, 130, 130)
        love.graphics.setColor(1,1,1,1)
        self:renderSmallerHead(game_width/2 - 305*sx, game_height/2 + 185*sy, 0.55, 0.55)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.rectangle("line", game_width/2 - 320*sx, game_height/2 + 170*sy, 130, 130)

        love.graphics.setFont(medium_font)
        love.graphics.print(self.name, game_width/2 - 110*sx, game_height/2 + 175*sy)

        love.graphics.setFont(smaller_font)
        love.graphics.print("Health", game_width/2 - 110*sx, game_height/2 + 225*sy)
        drawBar("health", game_width/2 - 20*sx, game_height/2 + 225*sy, 200*sx, 40*sy, self.health, 100)
        love.graphics.print(self.health .. "/100", game_width/2 + 30*sx, game_height/2 + 225*sy)
        if self.effects[1] == true then
            love.graphics.setColor(1,1,1,1)
            love.graphics.draw(trauma_icon, game_width/2 - 110*sx, game_height/2 + 290*sy)
            treatmentPrice4 = treatmentPrice4 + 200
        end

        love.graphics.setColor(colorGoldenrod)
        love.graphics.print(treatmentPrice4, game_width/2 + 213*sx, game_height/2 + 280*sy)
        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(coin_icon, game_width/2 + 263*sx, game_height/2 + 280*sy, 0, 0.7, 0.7)

        love.graphics.setColor(1,1,1,1)
        if playerCoins >= treatmentPrice4 then
            treat4_button:render(game_width/2 + 210*sx, game_height/2 + 230*sy, true)
        else
            treat4_button:render(game_width/2 + 210*sx, game_height/2 + 230*sy, false)
        end
    end
end

function Horse:displayBuyingInfo(i)
    local game_width = love.graphics.getWidth()
    local game_height = love.graphics.getHeight()

    if i == 1 then
        love.graphics.setColor(colorGoldenrod)
        love.graphics.setFont(smaller_font)
        love.graphics.print(self.age_y .. " y.", 310*sx, game_height - 480*sy)
        love.graphics.print(self.age_m .. " m.", 355*sx, game_height - 480*sy)
        love.graphics.setColor(1,1,1,1)
        if self.gender == "f" then
            love.graphics.draw(female_sign, 290*sx, game_height - 475*sy, 0, 0.75*sx, 0.75*sy)
        elseif self.gender == "m" then
            love.graphics.draw(male_sign, 280*sx, game_height - 475*sy, 0, 0.7*sx, 0.7*sy)
        end
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print("Stamina", 190*sx, game_height - 430*sy)
        drawBar("skill", 300*sx, game_height - 430*sy, 200*sx, 40*sy, self.cur_skills[1], self.gen_skills[1])
        love.graphics.print(self.cur_skills[1] .. "/" .. self.gen_skills[1], 380*sx, game_height - 430*sy)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print("Speed", 190*sx, game_height - 380*sy)
        drawBar("skill", 300*sx, game_height - 380*sy, 200*sx, 40*sy, self.cur_skills[2], self.gen_skills[2])
        love.graphics.print(self.cur_skills[2] .. "/" .. self.gen_skills[2], 380*sx, game_height - 380*sy)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print("Jumping", 190*sx, game_height - 330*sy)
        drawBar("skill", 300*sx, game_height - 330*sy, 200*sx, 40*sy, self.cur_skills[3], self.gen_skills[3])
        love.graphics.print(self.cur_skills[3] .. "/" .. self.gen_skills[3], 380*sx, game_height - 330*sy)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print("Dressage", 190*sx, game_height - 280*sy)
        drawBar("skill", 300*sx, game_height - 280*sy, 200*sx, 40*sy, self.cur_skills[4], self.gen_skills[4])
        love.graphics.print(self.cur_skills[4] .. "/" .. self.gen_skills[4], 380*sx, game_height - 280*sy)

        buyingPrice1 = self:determinePrice()
        love.graphics.setFont(medium_font)
        local priceText = love.graphics.newText(medium_font, buyingPrice1)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print(buyingPrice1, 350*sx - priceText:getWidth()/2 - 20*sx, game_height - 145*sy)
        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(coin_icon, 350*sx + priceText:getWidth()/2 - 15*sx, game_height - 140*sy, 0, 0.7, 0.7)
    elseif i == 2 then
        love.graphics.setColor(colorGoldenrod)
        love.graphics.setFont(smaller_font)
        love.graphics.print(self.age_y .. " y.", 910*sx, game_height - 480*sy)
        love.graphics.print(self.age_m .. " m.", 955*sx, game_height - 480*sy)
        love.graphics.setColor(1,1,1,1)
        if self.gender == "f" then
            love.graphics.draw(female_sign, 890*sx, game_height - 475*sy, 0, 0.75*sx, 0.75*sy)
        elseif self.gender == "m" then
            love.graphics.draw(male_sign, 880*sx, game_height - 475*sy, 0, 0.7*sx, 0.7*sy)
        end
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print("Stamina", 790*sx, game_height - 430*sy)
        drawBar("skill", 900*sx, game_height - 430*sy, 200*sx, 40*sy, self.cur_skills[1], self.gen_skills[1])
        love.graphics.print(self.cur_skills[1] .. "/" .. self.gen_skills[1], 980*sx, game_height - 430*sy)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print("Speed", 790*sx, game_height - 380*sy)
        drawBar("skill", 900*sx, game_height - 380*sy, 200*sx, 40*sy, self.cur_skills[2], self.gen_skills[2])
        love.graphics.print(self.cur_skills[2] .. "/" .. self.gen_skills[2], 980*sx, game_height - 380*sy)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print("Jumping", 790*sx, game_height - 330*sy)
        drawBar("skill", 900*sx, game_height - 330*sy, 200*sx, 40*sy, self.cur_skills[3], self.gen_skills[3])
        love.graphics.print(self.cur_skills[3] .. "/" .. self.gen_skills[3], 980*sx, game_height - 330*sy)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print("Dressage", 790*sx, game_height - 280*sy)
        drawBar("skill", 900*sx, game_height - 280*sy, 200*sx, 40*sy, self.cur_skills[4], self.gen_skills[4])
        love.graphics.print(self.cur_skills[4] .. "/" .. self.gen_skills[4], 980*sx, game_height - 280*sy)

        buyingPrice2 = self:determinePrice()
        love.graphics.setFont(medium_font)
        local priceText = love.graphics.newText(medium_font, buyingPrice2)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print(buyingPrice2, 950*sx - priceText:getWidth()/2 - 20*sx, game_height - 145*sy)
        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(coin_icon, 950*sx + priceText:getWidth()/2 - 15*sx, game_height - 140*sy, 0, 0.7, 0.7)
    elseif i == 3 then
        love.graphics.setColor(colorGoldenrod)
        love.graphics.setFont(smaller_font)
        love.graphics.print(self.age_y .. " y.", 1510*sx, game_height - 480*sy)
        love.graphics.print(self.age_m .. " m.", 1555*sx, game_height - 480*sy)
        love.graphics.setColor(1,1,1,1)
        if self.gender == "f" then
            love.graphics.draw(female_sign, 1490*sx, game_height - 475*sy, 0, 0.75*sx, 0.75*sy)
        elseif self.gender == "m" then
            love.graphics.draw(male_sign, 1480*sx, game_height - 475*sy, 0, 0.7*sx, 0.7*sy)
        end
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print("Stamina", 1390*sx, game_height - 430*sy)
        drawBar("skill", 1500*sx, game_height - 430*sy, 200*sx, 40*sy, self.cur_skills[1], self.gen_skills[1])
        love.graphics.print(self.cur_skills[1] .. "/" .. self.gen_skills[1], 1580*sx, game_height - 430*sy)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print("Speed", 1390*sx, game_height - 380*sy)
        drawBar("skill", 1500*sx, game_height - 380*sy, 200*sx, 40*sy, self.cur_skills[2], self.gen_skills[2])
        love.graphics.print(self.cur_skills[2] .. "/" .. self.gen_skills[2], 1580*sx, game_height - 380*sy)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print("Jumping", 1390*sx, game_height - 330*sy)
        drawBar("skill", 1500*sx, game_height - 330*sy, 200*sx, 40*sy, self.cur_skills[3], self.gen_skills[3])
        love.graphics.print(self.cur_skills[3] .. "/" .. self.gen_skills[3], 1580*sx, game_height - 330*sy)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print("Dressage", 1390*sx, game_height - 280*sy)
        drawBar("skill", 1500*sx, game_height - 280*sy, 200*sx, 40*sy, self.cur_skills[4], self.gen_skills[4])
        love.graphics.print(self.cur_skills[4] .. "/" .. self.gen_skills[4], 1580*sx, game_height - 280*sy)

        buyingPrice3 = self:determinePrice()
        love.graphics.setFont(medium_font)
        local priceText = love.graphics.newText(medium_font, buyingPrice3)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print(buyingPrice3, 1550*sx - priceText:getWidth()/2 - 20*sx, game_height - 145*sy)
        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(coin_icon, 1550*sx + priceText:getWidth()/2 - 15*sx, game_height - 140*sy, 0, 0.7, 0.7)
    end
end

function Horse:displayStuddingInfo(own, i)
    local game_width = love.graphics.getWidth()
    local game_height = love.graphics.getHeight()

    if own == false then
        love.graphics.setFont(medium_font)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print("Skills", game_width/2 + 400*sx, 180*sy)
        love.graphics.setFont(smaller_font)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print("Stamina", game_width/2 + 280*sx, 260*sy)
        drawBar("skill", game_width/2 + 390*sx, 260*sy, 200*sx, 40*sy, self.cur_skills[1], self.gen_skills[1])
        love.graphics.print(self.cur_skills[1] .. "/" .. self.gen_skills[1], game_width/2 + 470*sx, 260*sy)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print("Speed", game_width/2 + 280*sx, 310*sy)
        drawBar("skill", game_width/2 + 390*sx, 310*sy, 200*sx, 40*sy, self.cur_skills[2], self.gen_skills[2])
        love.graphics.print(self.cur_skills[2] .. "/" .. self.gen_skills[2], game_width/2 + 470*sx, 310*sy)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print("Jumping", game_width/2 + 280*sx, 360*sy)
        drawBar("skill", game_width/2 + 390*sx, 360*sy, 200*sx, 40*sy, self.cur_skills[3], self.gen_skills[3])
        love.graphics.print(self.cur_skills[3] .. "/" .. self.gen_skills[3], game_width/2 + 470*sx, 360*sy)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print("Dressage", game_width/2 + 280*sx, 410*sy)
        drawBar("skill", game_width/2 + 390*sx, 410*sy, 200*sx, 40*sy, self.cur_skills[4], self.gen_skills[4])
        love.graphics.print(self.cur_skills[4] .. "/" .. self.gen_skills[4], game_width/2 + 470*sx, 410*sy)

        local ext, ag, gr, cr_prl, dun, ch, fl, sil, sty, rb, rn, sab, wh, to, ov, spl, lp, patn1, patn2
        if self.genes[EXTENSION] == 11 then
            ext = "E-E"
        elseif self.genes[EXTENSION] == 10 then
            ext = "E-e"
        else
            ext = "e-e"
        end
        if self.genes[AGOUTI] == 11 then
            ag = "At-At"
        elseif self.genes[AGOUTI] == 10 then
            ag = "At-a"
        elseif self.genes[AGOUTI] == 21 then
            ag = "A-At"
        elseif self.genes[AGOUTI] == 20 then
            ag = "A-a"
        elseif self.genes[AGOUTI] == 22 then
            ag = "A-A"
        else
            ag = "a-a"
        end
        if self.genes[GREY] == 11 then
            gr = "G-G"
        elseif self.genes[GREY] == 10 then
            gr = "G-g"
        else
            gr = "g-g"
        end
        if self.genes[CREAM_PEARL] == 11 then
            cr_prl = "prl-prl"
        elseif self.genes[CREAM_PEARL] == 10 then
            cr_prl = "prl-cr"
        elseif self.genes[CREAM_PEARL] == 21 then
            cr_prl = "Cr-prl"
        elseif self.genes[CREAM_PEARL] == 20 then
            cr_prl = "Cr-cr"
        elseif self.genes[CREAM_PEARL] == 22 then
            cr_prl = "Cr-Cr"
        else
            cr_prl = "cr-cr"
        end
        if self.genes[DUN] == 11 then
            dun = "D-D"
        elseif self.genes[DUN] == 10 then
            dun = "D-d"
        else
            dun = "d-d"
        end
        if self.genes[CHAMPAGNE] == 11 then
            ch = "Ch-Ch"
        elseif self.genes[CHAMPAGNE] == 10 then
            ch = "Ch-ch"
        else
            ch = "ch-ch"
        end
        if self.genes[FLAXEN] == 11 then
            fl = "F-F"
        elseif self.genes[FLAXEN] == 10 then
            fl = "F-f"
        else
            fl = "f-f"
        end
        if self.genes[SILVER] == 11 then
            sil = "Z-Z"
        elseif self.genes[SILVER] == 10 then
            sil = "Z-z"
        else
            sil = "z-z"
        end
        if self.genes[SOOTY] == 11 then
            sty = "STY-STY"
        elseif self.genes[SOOTY] == 10 then
            sty = "STY-sty"
        else
            sty = "sty-sty"
        end
        if self.genes[RABICANO] == 11 then
            rb = "Rb-Rb"
        elseif self.genes[RABICANO] == 10 then
            rb = "Rb-rb"
        else
            rb = "rb-rb"
        end
        if self.genes[ROAN] == 11 then
            rn = "Rn-Rn"
        elseif self.genes[ROAN] == 10 then
            rn = "Rn-rn"
        else
            rn = "rn-rn"
        end
        if self.genes[SABINO] == 11 then
            sab = "Sb1-Sb1"
        elseif self.genes[SABINO] == 10 then
            sab = "Sb1-sb1"
        else
            sab = "sb1-sb1"
        end
        if self.genes[DOMINANT_WHITE] == 11 then
            wh = "W-W"
        elseif self.genes[DOMINANT_WHITE] == 10 then
            wh = "W-w"
        else
            wh = "w-w"
        end
        if self.genes[TOBIANO] == 11 then
            to = "To-To"
        elseif self.genes[TOBIANO] == 10 then
            to = "To-to"
        else
            to = "to-to"
        end
        if self.genes[LETHAL_WHITE_OVERO] == 11 then
            ov = "O-O"
        elseif self.genes[LETHAL_WHITE_OVERO] == 10 then
            ov = "O-o"
        else
            ov = "o-o"
        end
        if self.genes[SPLASHED_WHITE] == 11 then
            spl = "SPL-SPL"
        elseif self.genes[SPLASHED_WHITE] == 10 then
            spl = "SPL-spl"
        else
            spl = "spl-spl"
        end
        if self.genes[LEOPARD] == 11 then
            lp = "Lp-Lp"
        elseif self.genes[LEOPARD] == 10 then
            lp = "Lp-lp"
        else
            lp = "lp-lp"
        end
        if self.genes[PATTERN_1] == 11 then
            patn1 = "PATN1-PATN1"
        elseif self.genes[PATTERN_1] == 10 then
            patn1 = "PATN1-patn1"
        else
            patn1 = "patn1-patn1"
        end
        if self.genes[PATTERN_2] == 11 then
            patn2 = "PATN2-PATN2"
        elseif self.genes[PATTERN_2] == 10 then
            patn2 = "PATN2-patn2"
        else
            patn2 = "patn2-patn2"
        end

        love.graphics.setColor(colorGoldenrod)
        love.graphics.setFont(medium_font)
        love.graphics.print("Extension (black/red): " .. ext, game_width/2 + 140*sx, 480*sy, 0, sx, sy)
        love.graphics.print("Agouti/bay: " .. ag, game_width/2 + 140*sx, 510*sy, 0, sx, sy)
        love.graphics.print("Grey: " .. gr, game_width/2 + 140*sx, 540*sy, 0, sx, sy)
        love.graphics.print("Cream/pearl: " .. cr_prl, game_width/2 + 140*sx, 570*sy, 0, sx, sy)
        love.graphics.print("Dun: " .. dun, game_width/2 + 140*sx, 600*sy, 0, sx, sy)
        love.graphics.print("Champagne: " .. ch, game_width/2 + 140*sx, 630*sy, 0, sx, sy)
        love.graphics.print("Flaxen: " .. fl, game_width/2 + 140*sx, 660*sy, 0, sx, sy)
        love.graphics.print("Silver: " .. sil, game_width/2 + 140*sx, 690*sy, 0, sx, sy)
        love.graphics.print("Sooty: " .. sty, game_width/2 + 140*sx, 720*sy, 0, sx, sy)
        love.graphics.print("Rabicano: " .. rb, game_width/2 + 140*sx, 750*sy, 0, sx, sy)
        love.graphics.print("Leopard complex spotting: " .. lp, game_width/2 + 140*sx, 780*sy, 0, sx, sy)

        love.graphics.print("Roan: " .. rn, game_width/2 + 490*sx, 480*sy, 0, sx, sy)
        love.graphics.print("Sabino: " .. sab, game_width/2 + 490*sx, 510*sy, 0, sx, sy)
        love.graphics.print("Dominant white: " .. wh, game_width/2 + 490*sx, 540*sy, 0, sx, sy)
        love.graphics.print("Tobiano: " .. to, game_width/2 + 490*sx, 570*sy, 0, sx, sy)
        love.graphics.print("Overo: " .. ov, game_width/2 + 490*sx, 600*sy, 0, sx, sy)
        love.graphics.print("Splashed white: " .. spl, game_width/2 + 490*sx, 630*sy, 0, sx, sy)
        if lp ~= "lp-lp" then
            love.graphics.print("LP pattern 1: " .. patn1, game_width/2 + 540*sx, 660*sy, 0, sx, sy)
            love.graphics.print("LP pattern 2: " .. patn2, game_width/2 + 540*sx, 690*sy, 0, sx, sy)
        end

        studPrice = self:determineStuddingPrice(false)
        love.graphics.setFont(medium_font)
        local priceText = love.graphics.newText(medium_font, studPrice)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.print(studPrice, game_width/2 + 410*sx, game_height - 150*sy)
        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(coin_icon, game_width/2 + 465*sx, game_height - 145*sy, 0, 0.7, 0.7)
    else
        if i == 1 then
            love.graphics.setColor(colorGoldenrod)
            love.graphics.setFont(smaller_font)
            love.graphics.setColor(1,1,1,1)
            love.graphics.setColor(colorGoldenrod)
            love.graphics.print("Stamina", 190*sx, game_height - 470*sy)
            drawBar("skill", 300*sx, game_height - 470*sy, 200*sx, 40*sy, self.cur_skills[1], self.gen_skills[1])
            love.graphics.print(self.cur_skills[1] .. "/" .. self.gen_skills[1], 380*sx, game_height - 470*sy)
            love.graphics.setColor(colorGoldenrod)
            love.graphics.print("Speed", 190*sx, game_height - 420*sy)
            drawBar("skill", 300*sx, game_height - 420*sy, 200*sx, 40*sy, self.cur_skills[2], self.gen_skills[2])
            love.graphics.print(self.cur_skills[2] .. "/" .. self.gen_skills[2], 380*sx, game_height - 420*sy)
            love.graphics.setColor(colorGoldenrod)
            love.graphics.print("Jumping", 190*sx, game_height - 370*sy)
            drawBar("skill", 300*sx, game_height - 370*sy, 200*sx, 40*sy, self.cur_skills[3], self.gen_skills[3])
            love.graphics.print(self.cur_skills[3] .. "/" .. self.gen_skills[3], 380*sx, game_height - 370*sy)
            love.graphics.setColor(colorGoldenrod)
            love.graphics.print("Dressage", 190*sx, game_height - 320*sy)
            drawBar("skill", 300*sx, game_height - 320*sy, 200*sx, 40*sy, self.cur_skills[4], self.gen_skills[4])
            love.graphics.print(self.cur_skills[4] .. "/" .. self.gen_skills[4], 380*sx, game_height - 320*sy)

            love.graphics.print("Energy", 190*sx, game_height - 250*sy)
            drawBar("energy", 300*sx, game_height - 250*sy, 200*sx, 40*sy, self.energy, 100)
            love.graphics.print(self.energy .. "/100", 340*sx, game_height - 250*sy)
    
            studdingPrice1 = self:determineStuddingPrice(true)
            love.graphics.setFont(medium_font)
            local priceText = love.graphics.newText(medium_font, studdingPrice1)
            love.graphics.setColor(colorGoldenrod)
            love.graphics.print(studdingPrice1, 350*sx - priceText:getWidth()/2 - 20*sx, game_height - 145*sy)
            love.graphics.setColor(1,1,1,1)
            love.graphics.draw(coin_icon, 350*sx + priceText:getWidth()/2 - 15*sx, game_height - 140*sy, 0, 0.7, 0.7)
        elseif i == 2 then
            love.graphics.setColor(colorGoldenrod)
            love.graphics.setFont(smaller_font)
            love.graphics.setColor(1,1,1,1)
            love.graphics.setColor(colorGoldenrod)
            love.graphics.print("Stamina", 790*sx, game_height - 470*sy)
            drawBar("skill", 900*sx, game_height - 470*sy, 200*sx, 40*sy, self.cur_skills[1], self.gen_skills[1])
            love.graphics.print(self.cur_skills[1] .. "/" .. self.gen_skills[1], 980*sx, game_height - 470*sy)
            love.graphics.setColor(colorGoldenrod)
            love.graphics.print("Speed", 790*sx, game_height - 420*sy)
            drawBar("skill", 900*sx, game_height - 420*sy, 200*sx, 40*sy, self.cur_skills[2], self.gen_skills[2])
            love.graphics.print(self.cur_skills[2] .. "/" .. self.gen_skills[2], 980*sx, game_height - 420*sy)
            love.graphics.setColor(colorGoldenrod)
            love.graphics.print("Jumping", 790*sx, game_height - 370*sy)
            drawBar("skill", 900*sx, game_height - 370*sy, 200*sx, 40*sy, self.cur_skills[3], self.gen_skills[3])
            love.graphics.print(self.cur_skills[3] .. "/" .. self.gen_skills[3], 980*sx, game_height - 370*sy)
            love.graphics.setColor(colorGoldenrod)
            love.graphics.print("Dressage", 790*sx, game_height - 320*sy)
            drawBar("skill", 900*sx, game_height - 320*sy, 200*sx, 40*sy, self.cur_skills[4], self.gen_skills[4])
            love.graphics.print(self.cur_skills[4] .. "/" .. self.gen_skills[4], 980*sx, game_height - 320*sy)

            love.graphics.print("Energy", 790*sx, game_height - 250*sy)
            drawBar("energy", 900*sx, game_height - 250*sy, 200*sx, 40*sy, self.energy, 100)
            love.graphics.print(self.energy .. "/100", 940*sx, game_height - 250*sy)
    
            studdingPrice2 = self:determineStuddingPrice(true)
            love.graphics.setFont(medium_font)
            local priceText = love.graphics.newText(medium_font, studdingPrice2)
            love.graphics.setColor(colorGoldenrod)
            love.graphics.print(studdingPrice2, 950*sx - priceText:getWidth()/2 - 20*sx, game_height - 145*sy)
            love.graphics.setColor(1,1,1,1)
            love.graphics.draw(coin_icon, 950*sx + priceText:getWidth()/2 - 15*sx, game_height - 140*sy, 0, 0.7, 0.7)
        elseif i == 3 then
            love.graphics.setColor(colorGoldenrod)
            love.graphics.setFont(smaller_font)
            love.graphics.setColor(1,1,1,1)
            love.graphics.setColor(colorGoldenrod)
            love.graphics.print("Stamina", 1390*sx, game_height - 470*sy)
            drawBar("skill", 1500*sx, game_height - 470*sy, 200*sx, 40*sy, self.cur_skills[1], self.gen_skills[1])
            love.graphics.print(self.cur_skills[1] .. "/" .. self.gen_skills[1], 1580*sx, game_height - 470*sy)
            love.graphics.setColor(colorGoldenrod)
            love.graphics.print("Speed", 1390*sx, game_height - 420*sy)
            drawBar("skill", 1500*sx, game_height - 420*sy, 200*sx, 40*sy, self.cur_skills[2], self.gen_skills[2])
            love.graphics.print(self.cur_skills[2] .. "/" .. self.gen_skills[2], 1580*sx, game_height - 420*sy)
            love.graphics.setColor(colorGoldenrod)
            love.graphics.print("Jumping", 1390*sx, game_height - 370*sy)
            drawBar("skill", 1500*sx, game_height - 370*sy, 200*sx, 40*sy, self.cur_skills[3], self.gen_skills[3])
            love.graphics.print(self.cur_skills[3] .. "/" .. self.gen_skills[3], 1580*sx, game_height - 370*sy)
            love.graphics.setColor(colorGoldenrod)
            love.graphics.print("Dressage", 1390*sx, game_height - 320*sy)
            drawBar("skill", 1500*sx, game_height - 320*sy, 200*sx, 40*sy, self.cur_skills[4], self.gen_skills[4])
            love.graphics.print(self.cur_skills[4] .. "/" .. self.gen_skills[4], 1580*sx, game_height - 320*sy)

            love.graphics.print("Energy", 1390*sx, game_height - 250*sy)
            drawBar("energy", 1500*sx, game_height - 250*sy, 200*sx, 40*sy, self.energy, 100)
            love.graphics.print(self.energy .. "/100", 1540*sx, game_height - 250*sy)
    
            studdingPrice3 = self:determineStuddingPrice(true)
            love.graphics.setFont(medium_font)
            local priceText = love.graphics.newText(medium_font, studdingPrice3)
            love.graphics.setColor(colorGoldenrod)
            love.graphics.print(studdingPrice3, 1550*sx - priceText:getWidth()/2 - 20*sx, game_height - 145*sy)
            love.graphics.setColor(1,1,1,1)
            love.graphics.draw(coin_icon, 1550*sx + priceText:getWidth()/2 - 15*sx, game_height - 140*sy, 0, 0.7, 0.7)
        end
    end
end

function Horse:showSubjectInfo(i)
    local game_width = love.graphics.getWidth()
    local game_height = love.graphics.getHeight()

    if i == 1 then
        love.graphics.setColor(colorJasmine)
        love.graphics.rectangle("fill", game_width/2 - 320*sx, game_height/2 - 430*sy, 130, 130)
        love.graphics.setColor(1,1,1,1)
        self:renderSmallerHead(game_width/2 - 305*sx, game_height/2 - 415*sy, 0.55, 0.55)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.rectangle("line", game_width/2 - 320*sx, game_height/2 - 430*sy, 130, 130)

        love.graphics.setFont(medium_font)
        love.graphics.print(self.name, game_width/2 - 120*sx, game_height/2 - 440*sy)

        love.graphics.setFont(smaller_font)
        love.graphics.print(self.age_y .. " y. " .. self.age_m .. "m.", game_width/2 - 280*sx, game_height/2 - 270*sy)
        love.graphics.print("Stamina: " .. self.cur_skills[1] .. "/" .. self.gen_skills[1], game_width/2 - 120*sx, game_height/2 - 380*sy)
        love.graphics.print("Speed: " .. self.cur_skills[2] .. "/" .. self.gen_skills[2], game_width/2 - 120*sx, game_height/2 - 330*sy)
        love.graphics.print("Jumping: " .. self.cur_skills[3] .. "/" .. self.gen_skills[3], game_width/2 + 60*sx, game_height/2 - 380*sy)
        love.graphics.print("Dressage: " .. self.cur_skills[4] .. "/" .. self.gen_skills[4], game_width/2 + 60*sx, game_height/2 - 330*sy)

        love.graphics.setColor(1,1,1,1)
        choose1:render(game_width/2 + 240*sx, game_height/2 - 370*sy, true)
    elseif i == 2 then
        love.graphics.setColor(colorJasmine)
        love.graphics.rectangle("fill", game_width/2 - 320*sx, game_height/2 - 230*sy, 130, 130)
        love.graphics.setColor(1,1,1,1)
        self:renderSmallerHead(game_width/2 - 305*sx, game_height/2 - 215*sy, 0.55, 0.55)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.rectangle("line", game_width/2 - 320*sx, game_height/2 - 230*sy, 130, 130)

        love.graphics.setFont(medium_font)
        love.graphics.print(self.name, game_width/2 - 120*sx, game_height/2 - 240*sy)

        love.graphics.setFont(smaller_font)
        love.graphics.print(self.age_y .. " y. " .. self.age_m .. "m.", game_width/2 - 280*sx, game_height/2 - 70*sy)
        love.graphics.print("Stamina: " .. self.cur_skills[1] .. "/" .. self.gen_skills[1], game_width/2 - 120*sx, game_height/2 - 180*sy)
        love.graphics.print("Speed: " .. self.cur_skills[2] .. "/" .. self.gen_skills[2], game_width/2 - 120*sx, game_height/2 - 130*sy)
        love.graphics.print("Jumping: " .. self.cur_skills[3] .. "/" .. self.gen_skills[3], game_width/2 + 60*sx, game_height/2 - 180*sy)
        love.graphics.print("Dressage: " .. self.cur_skills[4] .. "/" .. self.gen_skills[4], game_width/2 + 60*sx, game_height/2 - 130*sy)

        love.graphics.setColor(1,1,1,1)
        choose2:render(game_width/2 + 240*sx, game_height/2 - 170*sy, true)
    elseif i == 3 then
        love.graphics.setColor(colorJasmine)
        love.graphics.rectangle("fill", game_width/2 - 320*sx, game_height/2 - 30*sy, 130, 130)
        love.graphics.setColor(1,1,1,1)
        self:renderSmallerHead(game_width/2 - 305*sx, game_height/2 - 15*sy, 0.55, 0.55)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.rectangle("line", game_width/2 - 320*sx, game_height/2 - 30*sy, 130, 130)

        love.graphics.setFont(medium_font)
        love.graphics.print(self.name, game_width/2 - 120*sx, game_height/2 - 40*sy)

        love.graphics.setFont(smaller_font)
        love.graphics.print(self.age_y .. " y. " .. self.age_m .. "m.", game_width/2 - 280*sx, game_height/2 + 130*sy)
        love.graphics.print("Stamina: " .. self.cur_skills[1] .. "/" .. self.gen_skills[1], game_width/2 - 120*sx, game_height/2 + 20*sy)
        love.graphics.print("Speed: " .. self.cur_skills[2] .. "/" .. self.gen_skills[2], game_width/2 - 120*sx, game_height/2 + 70*sy)
        love.graphics.print("Jumping: " .. self.cur_skills[3] .. "/" .. self.gen_skills[3], game_width/2 + 60*sx, game_height/2 + 20*sy)
        love.graphics.print("Dressage: " .. self.cur_skills[4] .. "/" .. self.gen_skills[4], game_width/2 + 60*sx, game_height/2 + 70*sy)

        love.graphics.setColor(1,1,1,1)
        choose3:render(game_width/2 + 240*sx, game_height/2 + 30*sy, true)
    elseif i == 4 then
        love.graphics.setColor(colorJasmine)
        love.graphics.rectangle("fill", game_width/2 - 320*sx, game_height/2 + 170*sy, 130, 130)
        love.graphics.setColor(1,1,1,1)
        self:renderSmallerHead(game_width/2 - 305*sx, game_height/2 + 185*sy, 0.55, 0.55)
        love.graphics.setColor(colorGoldenrod)
        love.graphics.rectangle("line", game_width/2 - 320*sx, game_height/2 + 170*sy, 130, 130)

        love.graphics.setFont(medium_font)
        love.graphics.print(self.name, game_width/2 - 120*sx, game_height/2 + 160*sy)

        love.graphics.setFont(smaller_font)
        love.graphics.print(self.age_y .. " y. " .. self.age_m .. "m.", game_width/2 - 280*sx, game_height/2 + 330*sy)
        love.graphics.print("Stamina: " .. self.cur_skills[1] .. "/" .. self.gen_skills[1], game_width/2 - 120*sx, game_height/2 + 220*sy)
        love.graphics.print("Speed: " .. self.cur_skills[2] .. "/" .. self.gen_skills[2], game_width/2 - 120*sx, game_height/2 + 270*sy)
        love.graphics.print("Jumping: " .. self.cur_skills[3] .. "/" .. self.gen_skills[3], game_width/2 + 60*sx, game_height/2 + 220*sy)
        love.graphics.print("Dressage: " .. self.cur_skills[4] .. "/" .. self.gen_skills[4], game_width/2 + 60*sx, game_height/2 + 270*sy)

        love.graphics.setColor(1,1,1,1)
        choose4:render(game_width/2 + 240*sx, game_height/2 + 230*sy, true)
    end
end