Object:subClass("BasePanel")
BasePanel.panelObj = nil

BasePanel.controls = {}
BasePanel.isInitEvent = true

function BasePanel:Init(name)
    if self.panelObj == nil and LoadToLua.ABManager:LoadRes("panel",name,GameObject) ~= nil then
        self.panelObj = GameObject.Instantiate(LoadToLua.ABManager:LoadRes("panel",name,GameObject))
        self.panelObj.transform:SetParent(canvas)
        print("打开"..name.."面板成功")
        local allControls = self.panelObj:GetComponentsInChildren(UIBehaviour)
        

        for i = 1,allControls.Length do
            local controlName = allControls[i].name

            if string.find(controlName,"btn")~= nil  or
            string.find(controlName,"tog")~= nil or
            string.find(controlName,"img")~= nil or
            string.find(controlName,"sv")~= nil or
            string.find(controlName,"txt") ~= nil then
                
                local typeName = allControls[i]:GetType().Name

                --最终的存储形式
                --{btnRole = {Image = 控件},Button = {控件}}
                if self.controls[controlName] ~= nil then
                    self.controls[controlName][typeName] = allControls[i]
                else
                    self.controls[allControls[i].name] = {[typeName] = allControls[i]}
                end

            end
            print("面板"..name.."获得组件成功")
        end
    else
        self.isInitEvent = false
    end

end

--获得组件
function BasePanel:GetControl(name,typeName)
    if self.controls[name] ~= nil then
        local sameNameControls = self.controls[name]
        if sameNameControls[typeName] ~= nil then
            return sameNameControls[typeName]
        end
    end
end

function BasePanel:ShowMe(name)
    self:Init(name)
    if self.panelObj ~= nil then
        self.panelObj:SetActive(true)
    end
end

function BasePanel:HideMe()
    if self.panelObj ~= nil then
        self.panelObj:SetActive(false)
    end
end