--COLORS
colorYRed = {249/255, 191/255, 98/255, 1}
colorChampagne = {251/255, 207/255, 137/255, 1}
colorSunray = {227/255, 177/255, 98/255, 1}
colorJasmine = {253/255, 216/255, 137/255, 1}
colorGoldenrod = {196/255, 136/255, 39/255, 1}

-- genes
AGOUTI = 1
EXTENSION = 2
DOMINANT_WHITE = 3
LETHAL_WHITE_OVERO = 4
TOBIANO = 5
GREY = 6
CHAMPAGNE = 7
CREAM_PEARL = 8
SABINO = 9
SPLASHED_WHITE = 10
SILVER = 11
DUN = 12
LEOPARD = 13
FLAXEN = 14
SOOTY = 15
RABICANO = 16
ROAN = 17
PATTERN_1 = 18
PATTERN_2 = 19
LEG_MARKINGS = 20
FACE_MARKINGS = 21

-- modes and windows
modes = {'main_menu', 'tutorial', 'map', 'stables', 'view_stable',
'medical_centre', 'shop/market', 'event_menu', 'training/competing', 'lake_mini_game',
'breeding', 'testing', 'treatment', 'buying_market', 'selling_market',
'studding', 'shop'}
windows = {'none', 'death_notif', 'birth_notif', 'foal_aging_notif'}
shop_tabs = {'food', 'equipment', 'bonus'}

-- BUTTONS
new_game_button = Button(300, 70, "buttons/newgame.png", "buttons/newgame_p.png", nil)
load_game_button = Button(300, 70, "buttons/loadgame.png", "buttons/loadgame_p.png", nil)
save_game_button = Button(300, 70, "buttons/savegame.png", "buttons/savegame_p.png", "buttons/savegame_inactive.png")
resume_game_button = Button(300, 70, "buttons/resumegame.png", "buttons/resumegame_p.png", "buttons/resumegame_inactive.png")
exit_button = Button(300, 70, "buttons/exit.png", "buttons/exit_p.png", nil)
cross_training_button = Button(300, 70, "buttons/cross.png", "buttons/cross_p.png", nil)
jumping_training_button = Button(300, 70, "buttons/jumpingtr.png", "buttons/jumpingtr_p.png", nil)
dressage_training_button = Button(300, 70, "buttons/dressagetr.png", "buttons/dressagetr_p.png", nil)

breeding_button = Button(300, 70, "buttons/breeding.png", "buttons/breeding_p.png", nil)
medical_test_button = Button(300, 70, "buttons/medicaltest.png", "buttons/medicaltest_p.png", nil)
treatment_button = Button(300, 70, "buttons/treatment.png", "buttons/treatment_p.png", nil)
treat1_button = Button(92, 45, "buttons/treat.png", "buttons/treat_p.png", "buttons/treat_inactive.png")
treat2_button = Button(92, 45, "buttons/treat.png", "buttons/treat_p.png", "buttons/treat_inactive.png")
treat3_button = Button(92, 45, "buttons/treat.png", "buttons/treat_p.png", "buttons/treat_inactive.png")
treat4_button = Button(92, 45, "buttons/treat.png", "buttons/treat_p.png", "buttons/treat_inactive.png")

next_stables_button = Button(80, 45, "buttons/next.png", "buttons/next_p.png", nil)
previous_stables_button = Button(120, 45, "buttons/previous.png", "buttons/previous_p.png", nil)
confirm_edit_name = Button(80, 50, "buttons/ok.png", "buttons/ok_p.png", nil)
confirm_place = Button(80, 50, "buttons/ok.png", "buttons/ok_p.png", nil)
exit_to_map = Button(100, 50, "buttons/map.png", "buttons/map_p.png", nil)
exit_stable = Button(120, 50, "buttons/stables.png", "buttons/stables_p.png", nil)

train_1_button = Button(80, 45, "buttons/train.png", "buttons/train_p.png", nil)
train_2_button = Button(80, 45, "buttons/train.png", "buttons/train_p.png", nil)
train_3_button = Button(80, 45, "buttons/train.png", "buttons/train_p.png", nil)
train_4_button = Button(80, 45, "buttons/train.png", "buttons/train_p.png", nil)

next_button = Button(80, 45, "buttons/next.png", "buttons/next_p.png", nil)
nextMaleButton = Button(80, 45, "buttons/next.png", "buttons/next_p.png", nil)
nextFemaleButton = Button(80, 45, "buttons/next.png", "buttons/next_p.png", nil)
previous_button = Button(120, 45, "buttons/previous.png", "buttons/previous_p.png", nil)
previousMaleButton = Button(120, 45, "buttons/previous.png", "buttons/previous_p.png", nil)
previousFemaleButton = Button(120, 45, "buttons/previous.png", "buttons/previous_p.png", nil)

nextSickHorses = Button(80, 45, "buttons/next.png", "buttons/next_p.png", nil)
previousSickHorses = Button(120, 45, "buttons/previous.png", "buttons/previous_p.png", nil)

nextTestSubjects = Button(80, 45, "buttons/next.png", "buttons/next_p.png", nil)
previousTestSubjects = Button(120, 45, "buttons/previous.png", "buttons/previous_p.png", nil)

compete_1_button = Button(120, 45, "buttons/compete.png", "buttons/compete_p.png", nil)
compete_2_button = Button(120, 45, "buttons/compete.png", "buttons/compete_p.png", nil)
compete_3_button = Button(120, 45, "buttons/compete.png", "buttons/compete_p.png", nil)
compete_4_button = Button(120, 45, "buttons/compete.png", "buttons/compete_p.png", nil)

cc_tier1 = Button(174, 70, "buttons/tier1.png", "buttons/tier1_p.png", nil)
cc_tier2 = Button(174, 70, "buttons/tier2.png", "buttons/tier2_p.png", nil)
cc_tier3 = Button(174, 70, "buttons/tier3.png", "buttons/tier3_p.png", nil)
cc_tier4 = Button(174, 70, "buttons/tier4.png", "buttons/tier4_p.png", nil)
cc_tier5 = Button(174, 70, "buttons/tier5.png", "buttons/tier5_p.png", nil)
cc_extra = Button(174, 70, "buttons/extra.png", "buttons/extra_p.png", nil)

d_tier1 = Button(174, 70, "buttons/tier1.png", "buttons/tier1_p.png", nil)
d_tier2 = Button(174, 70, "buttons/tier2.png", "buttons/tier2_p.png", nil)
d_tier3 = Button(174, 70, "buttons/tier3.png", "buttons/tier3_p.png", nil)
d_tier4 = Button(174, 70, "buttons/tier4.png", "buttons/tier4_p.png", nil)
d_tier5 = Button(174, 70, "buttons/tier5.png", "buttons/tier5_p.png", nil)
d_extra = Button(174, 70, "buttons/extra.png", "buttons/extra_p.png", nil)

j_tier1 = Button(174, 70, "buttons/tier1.png", "buttons/tier1_p.png", nil)
j_tier2 = Button(174, 70, "buttons/tier2.png", "buttons/tier2_p.png", nil)
j_tier3 = Button(174, 70, "buttons/tier3.png", "buttons/tier3_p.png", nil)
j_tier4 = Button(174, 70, "buttons/tier4.png", "buttons/tier4_p.png", nil)
j_tier5 = Button(174, 70, "buttons/tier5.png", "buttons/tier5_p.png", nil)
j_extra = Button(174, 70, "buttons/extra.png", "buttons/extra_p.png", nil)

breedButton = Button(200, 70, "buttons/breed.png", "buttons/breed_p.png", "buttons/breed_inactive.png")
edit_name = Button(130, 45, "buttons/editname.png", "buttons/editname_p.png", nil)
change_day = Button(160, 50, "buttons/nextday.png", "buttons/nextday_p.png", nil)
magic = Button(160, 50, "buttons/magic.png", "buttons/magic_p.png", nil)
musicBtn1 = Button(50, 50, "buttons/music1.png", "buttons/music1_p.png", nil)
musicBtn2 = Button(50, 50, "buttons/music2.png", "buttons/music2_p.png", nil)
confirm_notif = Button(80, 50, "buttons/ok.png", "buttons/ok_p.png", nil)

sell_foal = Button(80, 45, "buttons/sell.png", "buttons/sell_p.png", nil)
keep_foal = Button(80, 45, "buttons/keep.png", "buttons/keep_p.png", nil)
yes = Button(80, 45, "buttons/yes.png", "buttons/yes_p.png", nil)
no = Button(80, 45, "buttons/no.png", "buttons/no_p.png", nil)

change_spec = Button(100, 40, "buttons/change.png", "buttons/change_p.png", nil)

change_spec_none = Button(92, 45, "buttons/specnone.png", "buttons/specnone_p.png", nil)
change_spec_jump = Button(150, 45, "buttons/specjump.png", "buttons/specjump_p.png", "buttons/specjump_inactive.png")
change_spec_dres = Button(150, 45, "buttons/specdres.png", "buttons/specdres_p.png", "buttons/specdres_inactive.png")
change_spec_cc = Button(216, 45, "buttons/speccross.png", "buttons/speccross_p.png", "buttons/speccross_inactive.png")

clean_horse_action = Button(100, 100, "buttons/clean_horse.png", "buttons/clean_horse_p.png", nil)
clean_stable_action = Button(100, 100, "buttons/clean_stable.png", "buttons/clean_stable_p.png", nil)
give_water_action = Button(100, 100, "buttons/give_water.png", "buttons/give_water_p.png", nil)
give_food_action = Button(100, 100, "buttons/give_food.png", "buttons/give_food_p.png", "buttons/give_food_inactive.png")
give_kelp_action = Button(100, 100, "buttons/give_kelp.png", "buttons/give_kelp_p.png", "buttons/give_kelp_inactive.png")
give_carrot_action = Button(100, 100, "buttons/give_carrot.png", "buttons/give_carrot_p.png", "buttons/give_carrot_inactive.png")
give_apple_action = Button(100, 100, "buttons/give_apple.png", "buttons/give_apple_p.png", "buttons/give_apple_inactive.png")

inv_next_button = Button(80, 45, "buttons/next.png", "buttons/next_p.png", nil)
inv_previous_button = Button(120, 45, "buttons/previous.png", "buttons/previous_p.png", nil)
close_inventory = Button(108, 45, "buttons/close.png", "buttons/close_p.png", nil)

show_equip_button = Button(254, 52, "buttons/show_equip.png", "buttons/show_equip_p.png", nil)
hide_equip_button = Button(254, 52, "buttons/hide_equip.png", "buttons/hide_equip_p.png", nil)

myStudsBtn = Button(350, 80, "buttons/mystuds.png", "buttons/mystuds_p.png", nil)
paidStudsBtn = Button(350, 80, "buttons/paidstuds.png", "buttons/paidstuds_p.png", "buttons/paidstuds_inactive.png")

buyHorsesBtn = Button(300, 100, "buttons/buy_horses.png", "buttons/buy_horses_p.png", nil)
sellHorsesBtn = Button(300, 100, "buttons/sell_horses.png", "buttons/sell_horses_p.png", nil)
studdingBtn = Button(300, 100, "buttons/studding.png", "buttons/studding_p.png", nil)
enterShopBtn = Button(366, 100, "buttons/enter_shop.png", "buttons/enter_shop_p.png", nil)

buyHorse1 = Button(120, 70, "buttons/buyhorse.png", "buttons/buyhorse_p.png", "buttons/buyhorse_inactive.png")
buyHorse2 = Button(120, 70, "buttons/buyhorse.png", "buttons/buyhorse_p.png", "buttons/buyhorse_inactive.png")
buyHorse3 = Button(120, 70, "buttons/buyhorse.png", "buttons/buyhorse_p.png", "buttons/buyhorse_inactive.png")

sellHorse1 = Button(120, 70, "buttons/sellhorse.png", "buttons/sellhorse_p.png", nil)
sellHorse2 = Button(120, 70, "buttons/sellhorse.png", "buttons/sellhorse_p.png", nil)
sellHorse3 = Button(120, 70, "buttons/sellhorse.png", "buttons/sellhorse_p.png", nil)

studHorse1 = Button(300, 50, "buttons/offerstud.png", "buttons/offerstud_p.png", "buttons/offerstud_inactive.png")
studHorse2 = Button(300, 50, "buttons/offerstud.png", "buttons/offerstud_p.png", "buttons/offerstud_inactive.png")
studHorse3 = Button(300, 50, "buttons/offerstud.png", "buttons/offerstud_p.png", "buttons/offerstud_inactive.png")

buyStudding = Button(300, 50, "buttons/buystud.png", "buttons/buystud_p.png", "buttons/buystud_inactive.png")
orderTest = Button(300, 50, "buttons/ordertest.png", "buttons/ordertest_p.png", "buttons/ordertest_inactive.png")

nextArrow = Button(60, 50, "buttons/nextarrow.png", "buttons/nextarrow_p.png", nil)
prevArrow = Button(60, 50, "buttons/prevarrow.png", "buttons/prevarrow_p.png", nil)

myStudsTab = Button(450, 100, "buttons/mystudstab.png", "buttons/mystudstab_p.png", nil)
sotdTab = Button(450, 100, "buttons/sotd.png", "buttons/sotd_p.png", nil)

okBtn = Button(220, 50, "buttons/ok.png", "buttons/ok_p.png", nil)
giveFishBtn = Button(220, 50, "buttons/give_fish.png", "buttons/give_fish_p.png", "buttons/give_fish_inactive.png")
chooseHorseBtn = Button(220, 50, "buttons/choose_horse.png", "buttons/choose_horse_p.png", nil)

choose1 = Button(92, 45, "buttons/choose.png", "buttons/choose_p.png", nil)
choose2 = Button(92, 45, "buttons/choose.png", "buttons/choose_p.png", nil)
choose3 = Button(92, 45, "buttons/choose.png", "buttons/choose_p.png", nil)
choose4 = Button(92, 45, "buttons/choose.png", "buttons/choose_p.png", nil)

foodTab = Button(433, 70, "buttons/food_tab.png", "buttons/food_tab_p.png", nil)
equipTab = Button(433, 70, "buttons/equip_tab.png", "buttons/equip_tab_p.png", nil)
sellTab = Button(433, 70, "buttons/sell_things.png", "buttons/sell_things_p.png", nil)

plus1 = Button(50, 50, "buttons/plus.png", "buttons/plus_p.png", "buttons/plus_inactive.png")
minus1 = Button(50, 50, "buttons/minus.png", "buttons/minus_p.png", "buttons/minus_inactive.png")
plus2 = Button(50, 50, "buttons/plus.png", "buttons/plus_p.png", "buttons/plus_inactive.png")
minus2 = Button(50, 50, "buttons/minus.png", "buttons/minus_p.png", "buttons/minus_inactive.png")
plus3 = Button(50, 50, "buttons/plus.png", "buttons/plus_p.png", "buttons/plus_inactive.png")
minus3 = Button(50, 50, "buttons/minus.png", "buttons/minus_p.png", "buttons/minus_inactive.png")
plus4 = Button(50, 50, "buttons/plus.png", "buttons/plus_p.png", "buttons/plus_inactive.png")
minus4 = Button(50, 50, "buttons/minus.png", "buttons/minus_p.png", "buttons/minus_inactive.png")
plus5 = Button(50, 50, "buttons/plus.png", "buttons/plus_p.png", "buttons/plus_inactive.png")
minus5 = Button(50, 50, "buttons/minus.png", "buttons/minus_p.png", "buttons/minus_inactive.png")
plus6 = Button(50, 50, "buttons/plus.png", "buttons/plus_p.png", "buttons/plus_inactive.png")
minus6 = Button(50, 50, "buttons/minus.png", "buttons/minus_p.png", "buttons/minus_inactive.png")
plus7 = Button(50, 50, "buttons/plus.png", "buttons/plus_p.png", "buttons/plus_inactive.png")
minus7 = Button(50, 50, "buttons/minus.png", "buttons/minus_p.png", "buttons/minus_inactive.png")
plus8 = Button(50, 50, "buttons/plus.png", "buttons/plus_p.png", "buttons/plus_inactive.png")
minus8 = Button(50, 50, "buttons/minus.png", "buttons/minus_p.png", "buttons/minus_inactive.png")

buyThings = Button(120, 70, "buttons/buyhorse.png", "buttons/buyhorse_p.png", "buttons/buyhorse_inactive.png")
sellThings = Button(120, 70, "buttons/sellhorse.png", "buttons/sellhorse_p.png", nil)

kred = Button(80, 50, "buttons/kred.png", "buttons/kred_p.png", nil)
korange = Button(132, 50, "buttons/korange.png", "buttons/korange_p.png", nil)
kyellow = Button(132, 50, "buttons/kyellow.png", "buttons/kyellow_p.png", nil)
kgreen = Button(132, 50, "buttons/kgreen.png", "buttons/kgreen_p.png", nil)
kturquoise = Button(178, 50, "buttons/kturquoise.png", "buttons/kturquoise_p.png", nil)
kblue = Button(106, 50, "buttons/kblue.png", "buttons/kblue_p.png", nil)
kpurple = Button(136, 50, "buttons/kpurple.png", "buttons/kpurple_p.png", nil)

-- FONTS
biggest_font = love.graphics.newFont('Curse Casual.ttf', 100)
bigger_font = love.graphics.newFont('Curse Casual.ttf', 40)
medium_font = love.graphics.newFont('Curse Casual.ttf', 32)
smaller_font = love.graphics.newFont('Curse Casual.ttf', 25)

-- IMAGES
dressage_train = love.graphics.newImage("images/dressage_train.png")
jumping_train = love.graphics.newImage("images/jumping_train.png")
cross_train = love.graphics.newImage("images/cross_train.png")

shop_logo = love.graphics.newImage("images/logo.png")
shopkeeper = love.graphics.newImage("images/shopg.png")

menu_background = love.graphics.newImage("images/background.png")
pattern_background = love.graphics.newImage("images/pattern.png")
shop_pattern = love.graphics.newImage("images/shop_pattern.png")
market_sign = love.graphics.newImage("images/horsemarket.png")
med_background = love.graphics.newImage("images/medcentre.png")
training_background = love.graphics.newImage("images/training_background.png")
female_sign = love.graphics.newImage("images/gender_f.png")
male_sign = love.graphics.newImage("images/gender_m.png")
coin_icon = love.graphics.newImage("images/coin.png")
need_water_icon = love.graphics.newImage("images/need_water.png")
need_hygiene_icon = love.graphics.newImage("images/need_hygiene.png")
need_food_icon = love.graphics.newImage("images/need_food.png")

trauma_icon = love.graphics.newImage("images/trauma.png")

confirm_equipment = Button(80, 50, "buttons/ok.png", "buttons/ok_p.png", "buttons/ok_inactive.png")

quest_ind1 = love.graphics.newImage("images/quest_indicator.png")
-- food - 1
-- water - 2
-- hygiene - 3