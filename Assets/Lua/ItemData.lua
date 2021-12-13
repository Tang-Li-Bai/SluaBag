--加载Json文件
local txt = LoadToLua.ABManager:LoadRes("data","ItemData",TextAsset)
print(txt.text)
local itemList = Json.decode(txt.text)
--解析出来的Json文件
print(itemList[1].id .. itemList[1].name)

ItemData = {}

for _, value in pairs(itemList) do
    ItemData[value.id] = value
end

for key, value in pairs(ItemData) do
    -- body
    print(key,value.tips)
end