Object:subClass("ItemGrid")

ItemGrid.Obj = nil
ItemGrid.imgIcon = nil
ItemGrid.Text = nil

function ItemGrid:Init(father,posX,posY)
    self.obj = GameObject.Instantiate(LoadToLua.ABManager:LoadRes("itemgrid","itemGrid",GameObject))
    self.obj.transform:SetParent(father,false)
    self.obj.transform.localPosition = Vector3(posX,posY,0)
    self.imgIcon = self.obj.transform:Find("btnGrid"):GetComponent(Image)
    self.Text = self.obj.transform:Find("txtNumber"):GetComponent(Text)
    self.btn = self.obj.transform:Find("btnGrid"):GetComponent(Button)
end

--格子信息
function ItemGrid:InitData(data)
    local itemData = ItemData[data.id]
    local strs = string.split(itemData.icon,"_")
    local spriteAtlas = LoadToLua.ABManager:LoadRes("imgs","Img",SpriteAtlas)
    self.imgIcon.sprite = LoadToLua.ABManager:LoadRes("imgs","Img",SpriteAtlas):GetSprite(strs[2])
    self.Text.text = data.num

    self.btn.onClick:AddListener(
        
        function()
            BagPanel.nowId = data.id
            local nameAndTips = ItemData[data.id]
            BagPanel.ItemName.text = nameAndTips.name
            BagPanel.ItemDes.text = nameAndTips.tips
        end

    )
end


--销毁格子
function ItemGrid:Destroy()
    GameObject.Destroy(self.obj)
    self.obj = nil
end
