include ('shared.lua')

local function TalkWithNpc()

	local DFrame1 = vgui.Create('DFrame')
	DFrame1:SetSize(190, 260)
	DFrame1:SetPos(5, 25)
	DFrame1:SetTitle("")
	DFrame1:SetSizable(true)
	DFrame1:SetDeleteOnClose(false)
	DFrame1:MakePopup()

	local SpawnIcon1 = vgui.Create("SpawnIcon", DFrame1)
	SpawnIcon1:SetPos(5, 20)
	SpawnIcon1:SetModel( "models/Eli.mdl" )

	local DPanel1 = vgui.Create("DPanel", DFrame1)
	DPanel1:SetSize(116, 60)
	DPanel1:SetPos(70, 20)

	local DLabel1 = vgui.Create('DLabel', DFrame1)
	DLabel1:SetPos(80, 22)
	DLabel1:SetText('Jean Mich Much')
	DLabel1:SizeToContents()
	DLabel1:SetTextColor(Color(255, 0, 0, 255))

	local DLabel2 = vgui.Create('DLabel', DFrame1)
	DLabel2:SetPos(75, 38)
	DLabel2:SetText('Vendeur chez IKEA')
	DLabel2:SizeToContents()
	DLabel2:SetTextColor(Color(127, 255, 0, 255))

	local DLabel3 = vgui.Create('DLabel', DFrame1)
	DLabel3:SetPos(75, 50)
	DLabel3:SetText('56 ans \n 1 m 70')
	DLabel3:SizeToContents()
	DLabel3:SetTextColor(Color(47, 79, 79, 255))

	local DframeExplainList = vgui.Create( "DPanelList", DFrame1 )
	DframeExplainList:SetPos( 5,85 )
	DframeExplainList:SetSize( 180, 130 )
	DframeExplainList:SetSpacing( 5 )
	DframeExplainList:EnableHorizontal( false )
	DframeExplainList:EnableVerticalScrollbar( true )

	local DframeExplainLabel = vgui.Create('DLabel')
	DframeExplainLabel:SetText("Hey, salut, tu veu des props?")
	DframeExplainLabel:SizeToContents()
	DframeExplainList:AddItem( DframeExplainLabel )

	local DButton1 = vgui.Create('DButton', DFrame1)
	DButton1:SetSize(80, 30)
	DButton1:SetPos(10, 220)
	DButton1:SetText('Non')
	DButton1.DoClick = function()
	DFrame1:Close()
	end

	local DButton2 = vgui.Create('DButton', DFrame1)
	DButton2:SetSize(80, 30)
	DButton2:SetPos(100, 220)
	DButton2:SetText('Oui')
	DButton2.DoClick = function()
			DFrame1:Close()
			SpawnMenuIkea()
	end
end
usermessage.Hook("PropListTruck",TalkWithNpc)

function SpawnMenuIkea()

	local ModelAllowed = 
		{
		"models/props_borealis/bluebarrel001.mdl",
		"models/props_building_details/Storefront_Template001a_Bars.mdl",
		"models/props_c17/canister_propane01a.mdl",
		"models/props_c17/FurnitureChair001a.mdl",
		"models/props_c17/FurnitureCouch001a.mdl",
		"models/props_c17/FurnitureShelf001a.mdl"
		}
	local DFrameShop = vgui.Create('DFrame')
	DFrameShop:SetSize(355, 260)
	DFrameShop:Center()
	DFrameShop:SetTitle('IKEA Shop')
	DFrameShop:MakePopup()
	
	local DPanel1 = vgui.Create('DPanelList', DFrameShop)
	DPanel1:SetSize(335, 130)
	DPanel1:SetPos(5, 125)
	DPanel1:EnableVerticalScrollbar( true ) 
 	DPanel1:EnableHorizontal( true ) 

	for k,v in pairs(ModelAllowed) do
		local icon = vgui.Create( "SpawnIcon", DPanel1 ) 
		icon:SetModel( v )
		DPanel1:AddItem( icon )
		icon.DoClick = function( icon ) 
			surface.PlaySound( "ui/buttonclickrelease.wav" ) 
			LocalPlayer():ConCommand("SpawnPorpsInTruck ".. v)
			DFrameShop:SetVisible(false)
			DFrameShop:Close()
		end 
	end 
	
	local DPanel3 = vgui.Create('DPanel', DFrameShop)
	DPanel3:SetSize(330, 20)
	DPanel3:SetPos(5, 95)
	
	local DLabel1 = vgui.Create('DLabel', DFrameShop)
	DLabel1:SetPos(10, 97)
	DLabel1:SetText('Clique sur un prop pour le spawner ! cout:10$')
	DLabel1:SizeToContents()
	DLabel1:SetTextColor(Color(0, 0, 0, 255))
	
	local DImage1 = vgui.Create('DImage', DFrameShop)
	DImage1:SetSize(340, 60)
	DImage1:SetPos(5, 25)
	DImage1:SetImage('IKEA')
	DImage1:SizeToContents()
end
