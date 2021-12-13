PlayerData = {}

PlayerData.equips = {}
PlayerData.items = {}
PlayerData.Price = {}

--初始化玩家拥有的物品
function PlayerData:Init()
    table.insert(self.equips,{id = 1, num = 1})
    table.insert(self.equips,{id = 2, num = 2})

    table.insert(self.items,{id = 3, num = 10})
    table.insert(self.items,{id = 4, num = 5})

    table.insert(self.Price,{id = 5, num = 9})
end

PlayerData:Init()
print("kk"..#PlayerData.equips)
print(PlayerData.equips[1].id)