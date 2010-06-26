include ('shared.lua')

local function TalkWithNpc()
local PRICE = {}
	PRICE["maison1"] = 100
	PRICE["maison2"] = 200
	PRICE["maison3"] = 300
	PRICE["maison4"] = 400
	
	local DFrame1 = vgui.Create('DFrame', DFrame1)
	DFrame1:SetSize(330, 280)
	DFrame1:Center()
	DFrame1:SetTitle('Choix de votre maison')
	DFrame1:SetSizable(true)
	DFrame1:SetDeleteOnClose(false)
	DFrame1:MakePopup()

	local DLabel3 = vgui.Create('DLabel', DFrame1)
	DLabel3:SetPos(200, 27)
	DLabel3:SetText('Choix')
	DLabel3:SizeToContents()

	local DLabel2 = vgui.Create('DLabel', DFrame1)
	DLabel2:SetPos(30, 27)
	DLabel2:SetText('Nom de la residence')
	DLabel2:SizeToContents()

	local DLabel1 = vgui.Create('DLabel', DFrame1)
	DLabel1:SetPos(5, 247)
	DLabel1:SetText('Residence machin')
	DLabel1:SizeToContents()

	local DButton1 = vgui.Create('DButton', DFrame1)
	DButton1:SetSize(120, 20)
	DButton1:SetPos(200, 255)
	DButton1:SetText('Acheter')
	DButton1.DoClick = function()
	LocalPlayer():ConCommand("buy_house " .. CHOIX)
	end

	local DPanel3 = vgui.Create('DPanel', DFrame1)
	DPanel3:SetSize(110, 20)
	DPanel3:SetPos(200, 25)

	local DPanel2 = vgui.Create('DPanel', DFrame1)
	DPanel2:SetSize(190, 25)
	DPanel2:SetPos(5, 25)

	local DPanel1 = vgui.Create('DPanel', DFrame1)
	DPanel1:SetSize(190, 20)
	DPanel1:SetPos(5, 245)
	
	local DImageButton1 = vgui.Create('DImageButton', DFrame1)
	DImageButton1:SetSize(190, 190)
	DImageButton1:SetPos(5, 55)
	DImageButton1:SetImage('maison/maison1')
	DImageButton1:SizeToContents()
	DImageButton1.DoClick = function() end
	DImageButton1.DoRightClick = function() end
	
	local DMultiChoice1 = vgui.Create('DMultiChoice', DFrame1)
	DMultiChoice1:SetPos(200, 55)
	DMultiChoice1:SetSize(120, 20)
	DMultiChoice1.OnMousePressed = function() end
	function DMultiChoice1:OnSelect(Index, Value, Data)
		DImageButton1:SetImage("maison/" .. Value)
		DLabel2:SetText(Value)
		DButton1:SetText("Acheter " ..PRICE[Value])
		CHOIX = Value
	end
	DMultiChoice1:AddChoice("maison2")
	DMultiChoice1:AddChoice("maison3")
	DMultiChoice1:AddChoice("maison4")





end
usermessage.Hook("BuyHouse",TalkWithNpc)
