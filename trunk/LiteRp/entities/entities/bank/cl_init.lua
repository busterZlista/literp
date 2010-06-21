include("shared.lua")
function ENT:Draw()
self.Entity:DrawModel()
end
function Bank_Derma(um)
	local DFrame1 = vgui.Create('DFrame')
	DFrame1:SetSize(350, 100)
	DFrame1:Center()
	DFrame1:SetTitle('Banque')
	DFrame1:MakePopup()

	local DLabel3 = vgui.Create('DLabel', DFrame1)
	DLabel3:SetPos(245, 27)
	DLabel3:SetText('Mode')
	DLabel3:SizeToContents()

	local DLabel2 = vgui.Create('DLabel', DFrame1)
	DLabel2:SetPos(160, 27)
	DLabel2:SetText("Solde : " .. um:ReadLong())
	DLabel2:SizeToContents()

	local DLabel1 = vgui.Create('DLabel', DFrame1)
	DLabel1:SetPos(10, 27)
	DLabel1:SetText("Nom :" .. LocalPlayer():GetNWString("RpName"))
	DLabel1:SizeToContents()

	local DButton2 = vgui.Create('DButton', DFrame1)
	DButton2:SetSize(170, 20)
	DButton2:SetPos(5, 75)
	DButton2:SetText('Annuler')
	DButton2.DoClick = function() 
	DFrame1:Close()
	end

	local DPanel3 = vgui.Create('DPanel', DFrame1)
	DPanel3:SetSize(90, 20)
	DPanel3:SetPos(240, 25)

	local DPanel2 = vgui.Create('DPanel', DFrame1)
	DPanel2:SetSize(60, 20)
	DPanel2:SetPos(160, 25)

	local DMultiChoice1 = vgui.Create('DMultiChoice', DFrame1)
	DMultiChoice1:SetPos(240, 50)
	DMultiChoice1:SetSize(100, 20)
	DMultiChoice1.OnMousePressed = function() end
	function DMultiChoice1:OnSelect(Index, Value, Data) 
	MODE = Value
	end
	
	DMultiChoice1:AddChoice("Retirer")
	DMultiChoice1:AddChoice("Deposer")

	local DPanel1 = vgui.Create('DPanel', DFrame1)
	DPanel1:SetSize(150, 20)
	DPanel1:SetPos(5, 25)

	local DTextEntry1 = vgui.Create('DTextEntry', DFrame1)
	DTextEntry1:SetSize(230, 20)
	DTextEntry1:SetPos(5, 50)
	DTextEntry1:SetText('Montant')
	DTextEntry1.OnEnter = function()
	end
	local DButton1 = vgui.Create('DButton', DFrame1)
	DButton1:SetSize(165, 20)
	DButton1:SetPos(180, 75)
	DButton1:SetText('Ok')
	DButton1.DoClick = function() 
	LocalPlayer():ConCommand("Bank_" .. MODE .. " " .. DTextEntry1:GetValue())
	DFrame1:Close()
	end
end
usermessage.Hook("banke", Bank_Derma)