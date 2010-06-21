include("shared.lua")

function ENT:Draw()
		self.Entity:DrawModel()
end
function DermaJudgePc()
local DFrame1 = vgui.Create('DFrame')
DFrame1:SetSize(415, 210)
DFrame1:Center()
DFrame1:SetTitle('Panneau de controle des ecrants')
DFrame1:SetSizable(false)
DFrame1:MakePopup()



local DTextEntry4 = vgui.Create('DTextEntry', DFrame1)
DTextEntry4:SetSize(405, 25)
DTextEntry4:SetPos(5, 145)
DTextEntry4:SetText('Ligne 4')
DTextEntry4.OnEnter = function() end

local DTextEntry3 = vgui.Create('DTextEntry', DFrame1)
DTextEntry3:SetSize(405, 25)
DTextEntry3:SetPos(5, 115)
DTextEntry3:SetText('Ligne 3')
DTextEntry3.OnEnter = function() end

local DTextEntry2 = vgui.Create('DTextEntry', DFrame1)
DTextEntry2:SetSize(405, 25)
DTextEntry2:SetPos(5, 85)
DTextEntry2:SetText('Ligne 2')
DTextEntry2.OnEnter = function() end

local DLabel1 = vgui.Create('DLabel', DFrame1)
DLabel1:SetPos(10, 27)
DLabel1:SetText("Vous pouvez ici changer l'affichage des ecrants En ville")
DLabel1:SizeToContents()

local DPanel2 = vgui.Create('DPanel', DFrame1)
DPanel2:SetSize(405, 25)
DPanel2:SetPos(5, 25)

local DTextEntry1 = vgui.Create('DTextEntry', DFrame1)
DTextEntry1:SetSize(405, 25)
DTextEntry1:SetPos(5, 55)
DTextEntry1:SetText('Ligne 1')
DTextEntry1.OnEnter = function()
end

local DButton1 = vgui.Create('DButton', DFrame1)
DButton1:SetSize(405, 25)
DButton1:SetPos(5, 175)
DButton1:SetText('Ok')
DButton1.DoClick = function()
LocalPlayer():ConCommand("Set2D3DJudgeScreen2 " .. '"' .. DTextEntry1:GetValue() .. "#"  .. DTextEntry2:GetValue() .. "#" .. DTextEntry3:GetValue() .. "#" .. DTextEntry4:GetValue() .. '"')
end

end
usermessage.Hook("JudgeDerma", DermaJudgePc)









