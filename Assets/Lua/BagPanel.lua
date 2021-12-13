BasePanel:subClass("BagPanel")

BagPanel.Content = nil
BagPanel.ItemName = nil
BagPanel.ItemDes = nil

BagPanel.items = {}

BagPanel.nowType = -1
BagPanel.nowId = nil
local nowItems = nil

function BagPanel:Init(name)
    self.base.Init(self,name)

    if self.isInitEvent == true then
        self.Content = self:GetControl("svBag","ScrollRect").transform:Find("Viewport"):Find("Content")
    
        --关闭界面按钮
        self:GetControl("btnClose","Button").onClick:AddListener(
            function()
                self:HideMe()
            end
        )

        --展示信息
        self:GetControl("togEquip","Toggle").onValueChanged:AddListener(
            function(value)
                if value == true    then
                    self:ChangeType(1)
                end
            end
        )    
        self:GetControl("togItem","Toggle").onValueChanged:AddListener(
            function(value)
                if value == true    then
                    self:ChangeType(2)
                end
            end
        )    
        self:GetControl("togPiece","Toggle").onValueChanged:AddListener(
            function(value)
                if value == true    then
                    self:ChangeType(3)
                end
            end
        )   
        --默认是道具界面
        self:ChangeType(2)

        --组件
        self.ItemName = self:GetControl("txtItemName","Text")  
        self.ItemDes = self:GetControl("txtItemDescribe","Text")  
        self.ItemName.text = nil
        self.ItemDes.text = nil

        --使用和丢弃功能
        self:GetControl("btnUse","Button").onClick:AddListener(
            function()                      --根据不同的道具类型进行不同的操作
                print("type" .. self.nowType);
                if self.nowType == 1 then
                    for i=1, #PlayerData.equips do
                        if self.nowId == PlayerData.equips[i].id and PlayerData.equips[i].num > 0 then
                            PlayerData.equips[i].num = PlayerData.equips[i].num - 1
                        end
                    end
                end

                if self.nowType == 2 then
                    for i=1, #PlayerData.items do
                        if self.nowId == PlayerData.items[i].id and PlayerData.items[i].num > 0 then
                            PlayerData.items[i].num = PlayerData.items[i].num - 1
                        end
                    end
                end

                if self.nowType == 3 then
                    for i=1, #PlayerData.Price do
                        if self.nowId == PlayerData.Price[i].id and PlayerData.Price[i].num > 0 then
                            if PlayerData.Price[i].num >= 30 then
                                PlayerData.Price[i].num = PlayerData.Price[i].num - 30
                                for i=1, #PlayerData.items do
                                    if PlayerData.items[i].id == 4 then
                                        PlayerData.items[i].num = PlayerData.items[i].num + 1   
                                    end
                                end
                            end
                            --PlayerData.Piece[i].num = PlayerData.Piece[i].num - 1
                        end
                    end
                end
                self:ChangeType(self.nowType)
            end
        )
        self:GetControl("btnDiscard","Button").onClick:AddListener(
            function()
                print("type" .. self.nowType);
                if self.nowType == 1 then
                    for i=1, #PlayerData.equips do
                        if self.nowId == PlayerData.equips[i].id and PlayerData.equips[i].num > 0 then
                            PlayerData.equips[i].num = PlayerData.equips[i].num - 1
                        end
                    end
                end

                if self.nowType == 2 then
                    for i=1, #PlayerData.items do
                        if self.nowId == PlayerData.items[i].id and PlayerData.items[i].num > 0 then
                            PlayerData.items[i].num = PlayerData.items[i].num - 1
                        end
                    end
                end

                if self.nowType == 3 then
                    for i=1, #PlayerData.Price do
                        if self.nowId == PlayerData.Price[i].id and PlayerData.Price[i].num > 0 then 
                            PlayerData.Price[i].num = PlayerData.Price[i].num - 1
                        end
                    end
                end
                self:ChangeType(self.nowType)
            end
        )

    end
end

function BagPanel:ChangeType(type)
    --清除格子信息
    for i =1,#self.items do
        self.items[i]:Destroy()
    end
    self.items = {}

    self.nowType = type
    if type == 1 then
        nowItems = PlayerData.equips
    elseif type == 2 then
        nowItems = PlayerData.items
    else
        nowItems = PlayerData.Price
    end
    
    --创建格子
    for i = 1, #nowItems do
        local grid = ItemGrid:new() 
        --实例化格子对象 设置位置
        grid:Init(self.Content,(i-1)%4*150, math.floor((i-1)/4)*150)
        --初始化它的信息数量和图标
        grid:InitData(nowItems[i])

        --把它存起来
        table.insert(self.items,grid)
    end

end