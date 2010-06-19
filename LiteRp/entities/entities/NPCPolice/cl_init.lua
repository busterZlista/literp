include ('shared.lua')

function TimeWasted(um)
	timeW = um:ReadLong()
end
usermessage.Hook("TimeWasted", TimeWasted)

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
	SpawnIcon1:SetModel( "models/Combine_Soldier.mdl" )

	local DPanel1 = vgui.Create("DPanel", DFrame1)
	DPanel1:SetSize(116, 60)
	DPanel1:SetPos(70, 20)

	local DLabel1 = vgui.Create('DLabel', DFrame1)
	DLabel1:SetPos(80, 22)
	DLabel1:SetText('Sg Mc.Tavish')
	DLabel1:SizeToContents()
	DLabel1:SetTextColor(Color(255, 0, 0, 255))

	local DLabel2 = vgui.Create('DLabel', DFrame1)
	DLabel2:SetPos(75, 38)
	DLabel2:SetText('Recruteur de Policiers')
	DLabel2:SizeToContents()
	DLabel2:SetTextColor(Color(127, 255, 0, 255))

	local DLabel3 = vgui.Create('DLabel', DFrame1)
	DLabel3:SetPos(75, 50)
	DLabel3:SetText('43 ans \n 1 m 78')
	DLabel3:SizeToContents()
	DLabel3:SetTextColor(Color(47, 79, 79, 255))

	local DframeExplainList = vgui.Create( "DPanelList", DFrame1 )
	DframeExplainList:SetPos( 5,85 )
	DframeExplainList:SetSize( 180, 130 )
	DframeExplainList:SetSpacing( 5 )
	DframeExplainList:EnableHorizontal( false )
	DframeExplainList:EnableVerticalScrollbar( true )

	local DframeExplainLabel = vgui.Create('DLabel')
	if LocalPlayer():Team() == 2 then
		DframeExplainLabel:SetText("Salut, Cammarade")
	elseif LocalPlayer():Team() == 3 then
		DframeExplainLabel:SetText("Salut, Chef")
	else
		DframeExplainLabel:SetText("Salut, je suis le sergeant McTavish\n Je cherche des raclures dans ton genre\n Pour maintenir l'ordre dans cette ville\n S'a t'interresse ?")
	end
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
		if LocalPlayer():Team() == 2 or LocalPlayer():Team() == 3 then
			DFrame1:Close()
		else
		LocalPlayer():ConCommand("BecomeACop")
			DFrame1:Close()
		end
	end
end
usermessage.Hook("wantobecomepoliceman",TalkWithNpc)