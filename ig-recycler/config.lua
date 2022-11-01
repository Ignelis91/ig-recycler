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

chanceitemcount = { -- count of chance items
["item0"] = 5,
["item1"] = 2,
["item2"] = 8,
["item3"] = 4,
},

translation = {
    ['jobisnotdone'] = "Pirma Nuneškite Deže Prieš Imdami Nauja Deže",
    ['darvisispakuojama'] = "Tu Dar Vis Išpakuoji Deže",
    ['neturidezes'] = "Eik Pirma Pasimk Deže",
    ['darturideze'] = 'Prieš Imdamas Nauja Deže Išpakuok Dabar Pajimta Deže',
},


}

Notify = function(msg)
    --exports.bulletin:SendInfo(msg)
    ESX.ShowNotification(msg)
end