cfg = {
    esxLegacy = true,

    blip = {
        ['blipjobcords'] = vector3(-170.0944, 6168.9351, 31.2064),
        ['blipjobname'] = "Perdirbimo Centras",
    },

    job = {
        ['job'] = "recycler"
    },

    item = { -- If you want more items or few items go to server.lua on line 31.
    ["item0"] = "plastic",
    ["item1"] = "iron",
    ["item2"] = "copper",
    ["item3"] = "gunpowder",
    ["item4"] = "broken_components",

},

prices = {
    ['plastic'] = {2, 4},
    ['iron'] = {5, 12},
    ['copper'] = {5, 9},
    ['gunpowder'] = {2, 9},
    ['broken_components'] = {20, 25}
},

translation = {
    ['jobisnotdone'] = "Pirma Nuneškite Deže Prieš Imdami Nauja Deže",
    ['darvisispakuojama'] = "Tu Dar Vis Išpakuoji Deže",
    ['neturidezes'] = "Eik Pirma Pasimk Deže",
    ['sold_for'] = 'Jus Pardavete %sx %s Už $%s',
    ['darturideze'] = 'Prieš Imdamas Nauja Deže Išpakuok Dabar Pajimta Deže',
},

npc = {
    {
        pos = {x = -172.8054, y = 6174.5166, z = 30.2064, h = 220.7724}, -- -172.8054, 6174.5166, 31.2064, 220.7724
        model = 'a_m_m_eastsa_02',
        spawned = false,
    },
},


}

Notify = function(msg)
    --exports.bulletin:SendInfo(msg)
    ESX.ShowNotification(msg)
end