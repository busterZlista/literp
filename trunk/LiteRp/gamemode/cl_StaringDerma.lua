function SetMyNameANdSkin()
	HasChooseAName = false
	HasChooseAModel = false
	
	local DFrame1 = vgui.Create('DFrame')
	DFrame1:SetSize(460, 340)
	DFrame1:Center()
	DFrame1:SetTitle('Creation de votre personnage')
	DFrame1:SetDeleteOnClose(false)
	DFrame1:ShowCloseButton(false)
	DFrame1:SetBackgroundBlur(true)
	DFrame1:MakePopup()
		
	local DPanel1 = vgui.Create('DPanel', DFrame1 )
	DPanel1:SetSize(120, 20)
	DPanel1:SetPos(100, 25)
	
	local DLabel1 = vgui.Create('DLabel' , DFrame1)
	DLabel1:SetPos(100, 28)
	DLabel1:SetText('  Choissiser votre nom')
	DLabel1:SizeToContents()
	DLabel1:SetTextColor(Color(255, 0, 0, 255))
	
	local DPanel2 = vgui.Create('DPanel', DFrame1 )
	DPanel2:SetSize(150, 20)
	DPanel2:SetPos(250, 130)
	
	local DLabel2 = vgui.Create('DLabel' , DFrame1)
	DLabel2:SetPos(250, 133)
	DLabel2:SetText('  Choissiser votre apparence')
	DLabel2:SizeToContents()
	DLabel2:SetTextColor(Color(255, 0, 0, 255))
	
	local DimageONOFF1 = vgui.Create('DImage', DFrame1)
	DimageONOFF1:SetSize(25, 25)
	DimageONOFF1:SetPos(310, 55)
	--DimageONOFF1:SetImage( "gui/silkicons/check_off" )
		
	local DTextEntry1 = vgui.Create('DTextEntry' , DFrame1)
	DTextEntry1:SetSize(290, 20)
	DTextEntry1:SetPos(15, 60)
	DTextEntry1:SetText('')
	DTextEntry1.OnEnter = function()
		if string.len(DTextEntry1:GetValue()) < 25 and string.len(DTextEntry1:GetValue()) > 3 then
			RName = DTextEntry1:GetValue()
			HasChooseAName = true
			DimageONOFF1:SetImage( "gui/silkicons/check_on" )
		else
			HasChooseAName = false
			DimageONOFF1:SetImage( "gui/silkicons/check_off" )
		end
	end
								
	local DButton1 = vgui.Create('DButton' , DFrame1)
	DButton1:SetSize(60, 25)
	DButton1:SetPos(340, 55)
	DButton1:SetText('OK')
	DButton1.DoClick = function()
		if string.len(DTextEntry1:GetValue()) < 25 and string.len(DTextEntry1:GetValue()) > 3 then
			RName = DTextEntry1:GetValue()
			HasChooseAName = true
			DimageONOFF1:SetImage( "gui/silkicons/check_on" )
		else
			HasChooseAName = false
			DimageONOFF1:SetImage( "gui/silkicons/check_off" )
		end
	end
		
	local DSysButton2 = vgui.Create('DSysButton', DFrame1)
	DSysButton2:SetSize(25, 25)
	DSysButton2:SetPos(400, 55)
	DSysButton2:SetType('question')
	DSysButton2.DoClick = function()
		ExplainDerma()
	end
		
	local DModelPanel1 = vgui.Create( "DModelPanel", DFrame1)
	DModelPanel1:SetPos(25, 100)
	DModelPanel1:SetModel( "models/player/Group01/Female_01.mdl" )
	DModelPanel1:SetSize( 200, 200 )
	DModelPanel1:SetAmbientLight( Vector( 255, 0, 0 ) )
	DModelPanel1:SetFOV(90)
	function DModelPanel1:LayoutEntity( )
		self:RunAnimation()
	end

	local DMultiChoice1 = vgui.Create('DMultiChoice', DFrame1)
	DMultiChoice1:SetSize(150, 25)
	DMultiChoice1:SetPos(250, 150)
	DMultiChoice1.OnMousePressed = function() end
	function DMultiChoice1:OnSelect(Index, Value, Data) 
		DModelPanel1:SetModel( Value )
		HasChooseAModel = true
		ChoosenModel = Value
	end
	DMultiChoice1:AddChoice("models/player/Group01/Female_01.mdl")
	DMultiChoice1:AddChoice("models/player/Group01/Female_02.mdl")
	DMultiChoice1:AddChoice("models/player/Group01/Female_03.mdl")
	DMultiChoice1:AddChoice("models/player/Group01/Female_04.mdl")
	DMultiChoice1:AddChoice("models/player/Group01/Female_06.mdl")
	DMultiChoice1:AddChoice("models/player/Group01/Female_07.mdl")
	DMultiChoice1:AddChoice("models/player/group01/male_01.mdl")
	DMultiChoice1:AddChoice("models/player/Group01/Male_02.mdl")
	DMultiChoice1:AddChoice("models/player/Group01/male_03.mdl")
	DMultiChoice1:AddChoice("models/player/Group01/Male_04.mdl")
	DMultiChoice1:AddChoice("models/player/Group01/Male_05.mdl")
	DMultiChoice1:AddChoice("models/player/Group01/Male_06.mdl")
	DMultiChoice1:AddChoice("models/player/Group01/Male_07.mdl")
	DMultiChoice1:AddChoice("models/player/Group01/Male_08.mdl")
	DMultiChoice1:AddChoice("models/player/Group01/Male_09.mdl")
	DMultiChoice1:AddChoice("models/player/Group03/Female_01.mdl")
	DMultiChoice1:AddChoice("models/player/Group03/Female_02.mdl")
	DMultiChoice1:AddChoice("models/player/Group03/Female_03.mdl")
	DMultiChoice1:AddChoice("models/player/Group03/Female_04.mdl")
	DMultiChoice1:AddChoice("models/player/Group03/Female_06.mdl")
	DMultiChoice1:AddChoice("models/player/Group03/Female_07.mdl")
	DMultiChoice1:AddChoice("models/player/group03/male_01.mdl")
	DMultiChoice1:AddChoice("models/player/Group03/Male_02.mdl")
	DMultiChoice1:AddChoice("models/player/Group03/male_03.mdl")
	DMultiChoice1:AddChoice("models/player/Group03/Male_04.mdl")
	DMultiChoice1:AddChoice("models/player/Group03/Male_05.mdl")
	DMultiChoice1:AddChoice("models/player/Group03/Male_06.mdl")
	DMultiChoice1:AddChoice("models/player/Group03/Male_07.mdl")
	DMultiChoice1:AddChoice("models/player/Group03/Male_08.mdl")
	DMultiChoice1:AddChoice("models/player/Group03/Male_09.mdl")
	
	local DSysButton7 = vgui.Create('DSysButton', DFrame1)
	DSysButton7:SetSize(25, 25)
	DSysButton7:SetPos(410, 140)
	DSysButton7:SetType('question')
	DSysButton7.DoClick = function()
		ExplainDermaModel()
	end
	
	local DButton2 = vgui.Create('DButton', DFrame1)
	DButton2:SetSize(80, 30)
	DButton2:SetPos(370, 300)
	DButton2:SetText("C'est parti ! ")
	DButton2.DoClick = function()
		if HasChooseAName  and HasChooseAModel then
			LocalPlayer():ConCommand("SetName " .. RName ) 
			LocalPlayer():ConCommand("SetFirstModel " .. ChoosenModel )
			DFrame1:Close()
		end
	end
end
usermessage.Hook("SetName_And_Wear", SetMyNameANdSkin)

function ExplainDerma()
	local DframeExplain = vgui.Create('DFrame')
	DframeExplain:SetSize(250, 140)
	DframeExplain:Center()
	DframeExplain:SetTitle('Name Help')
	DframeExplain:SetDeleteOnClose(true)
	DframeExplain:SetBackgroundBlur(false)
	DframeExplain:MakePopup()

	local DframeExplainList = vgui.Create( "DPanelList", DframeExplain )
	DframeExplainList:SetPos( 5,20 )
	DframeExplainList:SetSize( 240, 115 )
	DframeExplainList:SetSpacing( 5 )
	DframeExplainList:EnableHorizontal( false )
	DframeExplainList:EnableVerticalScrollbar( true )


	local DframeExplainLabel = vgui.Create('DLabel')
	DframeExplainLabel:SetText(" Votre nom sera utiliser pour vous reconaitre \n tout au long du jeu, il ne \n il doit etre compris entre 3 et 25 caracteres")
	DframeExplainLabel:SizeToContents()
	DframeExplainList:AddItem( DframeExplainLabel )

	local DframeExplainButton = vgui.Create('DButton', DframeExplain)
	DframeExplainButton:SetSize(70, 25)
	DframeExplainButton:SetPos(90, 120)
	DframeExplainButton:SetText('Ok')
	DframeExplainButton.DoClick = function()
		DframeExplain:Close()
	end
end

function ExplainDermaModel()
	local DframeExplain = vgui.Create('DFrame')
	DframeExplain:SetSize(250, 140)
	DframeExplain:Center()
	DframeExplain:SetTitle('Title loliolol')
	DframeExplain:SetDeleteOnClose(true)
	DframeExplain:SetBackgroundBlur(false)
	DframeExplain:MakePopup()

	local DframeExplainList = vgui.Create( "DPanelList", DframeExplain )
	DframeExplainList:SetPos( 5,20 )
	DframeExplainList:SetSize( 240, 115 )
	DframeExplainList:SetSpacing( 5 )
	DframeExplainList:EnableHorizontal( false )
	DframeExplainList:EnableVerticalScrollbar( true )


	local DframeExplainLabel = vgui.Create('DLabel')
	DframeExplainLabel:SetText("Vos vetements seron sauvegarder par le serveur\n vous pourrer bien sur en changer durant le jeu")
	DframeExplainLabel:SizeToContents()
	DframeExplainList:AddItem( DframeExplainLabel )

	local DframeExplainButton = vgui.Create('DButton', DframeExplain)
	DframeExplainButton:SetSize(70, 25)
	DframeExplainButton:SetPos(90, 110)
	DframeExplainButton:SetText('Ok')
	DframeExplainButton.DoClick = function()
		DframeExplain:Close()
	end
end