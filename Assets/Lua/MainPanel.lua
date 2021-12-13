--继承自BasePanel
BasePanel:subClass("MainPanel")

function MainPanel:Init(name)
    self.base.Init(self,name)
    if self.isInitEvent == true then
        self:GetControl("btnBag","Button").onClick:AddListener(
            function ()
                self:OpenBag()
            end
        )
    end
end

function MainPanel:OpenBag()
    BagPanel:ShowMe("BagPanel")
end