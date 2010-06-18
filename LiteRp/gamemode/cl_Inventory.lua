local function ReadSlotName( um )
	slot1ent = um:ReadString()
	slot1model = um:ReadString()
	slot2ent = um:ReadString()
	slot2model = um:ReadString()
	slot3ent = um:ReadString()
	slot3model = um:ReadString()
	slot4ent = um:ReadString()
	slot4model = um:ReadString()
end
usermessage.Hook("SlotInfo", ReadSlotName)

function InventoryMenu()
--Should have the same item as Allowed Table
	local Descriptions = {}
	Descriptions["prop_physics"] = " Description :\n c'est un prop "
	Descriptions["ballon_foot"] = " Description :\n c'est Ballon de Foot "
	Descriptions["rien"] = " Description : \n Slot Vide"

	local IV_DFrame = vgui.Create('DFrame')
	IV_DFrame:SetSize(380, 330)
	IV_DFrame:SetPos(130, 30)
	IV_DFrame:SetTitle('Menu')
	IV_DFrame:SetSizable(false)
	IV_DFrame:SetDeleteOnClose(false)
	IV_DFrame:MakePopup()

	local IV_PersoPannel = vgui.Create('DPanel',IV_DFrame )
	IV_PersoPannel:SetSize(100, 20)
	IV_PersoPannel:SetPos(5, 25)

	local IV_HatIcon
	IV_HatIcon = vgui.Create('SpawnIcon',IV_DFrame)
	IV_HatIcon:SetPos(25, 50)
	IV_HatIcon:SetModel("models/props_borealis/bluebarrel001.mdl")
	
	local IV_SlotPan1el = vgui.Create('DPanel',IV_DFrame)
	IV_SlotPan1el:SetSize(95, 195)
	IV_SlotPan1el:SetPos(7, 125)
	
	local IV_PersoModel = vgui.Create('DModelPanel',IV_DFrame)
	IV_PersoModel:SetSize(195, 195)
	IV_PersoModel:SetModel( LocalPlayer():GetModel() )
	IV_PersoModel:SetAmbientLight( Vector( 255, 0, 0 ) )
	IV_PersoModel:SetPos(7,125)
	IV_PersoModel:SetCamPos( Vector( 50, 50, 80 ) )
	IV_PersoModel:SetLookAt( Vector( -60, -10, 0 ) )
		function IV_PersoModel:LayoutEntity()
			self:RunAnimation()
		end
	
	local IV_PersoLabel = vgui.Create('DLabel',IV_DFrame)
	IV_PersoLabel:SetPos(25, 27)
	IV_PersoLabel:SetText('Personnage')

	local IV_SlotPanel = vgui.Create('DPanel',IV_DFrame)
	IV_SlotPanel:SetSize(260, 20)
	IV_SlotPanel:SetPos(110, 25)

	local IV_SlotTitre = vgui.Create('DLabel',IV_DFrame)
	IV_SlotTitre:SetPos(200, 27)
	IV_SlotTitre:SetText('Inventaire')

	local IV_SlotModel = vgui.Create('DModelPanel',IV_DFrame)
	IV_SlotModel:SetSize(255, 125)
	IV_SlotModel:SetPos(110, 50)
	IV_SlotModel:SetAmbientLight( Vector( 255, 0, 0 ) )
	IV_SlotModel:SetFOV(90)
	IV_SlotModel:SetLookAt(Vector(40, 30, 30))

	local IV_DescriPannel = vgui.Create('DPanel',IV_DFrame)
	IV_DescriPannel:SetSize(110, 20)
	IV_DescriPannel:SetPos(110, 175)

	local IV_DescriList = vgui.Create('DPanelList',IV_DFrame)
	IV_DescriList:SetSize(110, 120)
	IV_DescriList:SetPos(110, 200)
	IV_DescriList:SetSpacing( 5 )
	IV_DescriList:EnableHorizontal( false )
	IV_DescriList:EnableVerticalScrollbar( true )

	local IV_Description = vgui.Create('DLabel')
	IV_Description:SetText(Descriptions["rien"])
	IV_Description:SizeToContents()
	IV_DescriList:AddItem( IV_Description )
		
	local IV_SlotPannel = vgui.Create("DPanel",IV_DFrame)
	IV_SlotPannel:SetSize(145, 145)
	IV_SlotPannel:SetPos(225, 175)

	local IV_DescriTitre = vgui.Create('DLabel',IV_DFrame)
	IV_DescriTitre:SetPos(130, 177)
	IV_DescriTitre:SetText('Nom :')

	local IV_SlotIcon1 = vgui.Create('SpawnIcon',IV_DFrame)
	IV_SlotIcon1:SetPos(230, 180)
	IV_SlotIcon1:SetModel(slot1model)
	IV_SlotIcon1.OnCursorEntered  = function()
		IV_DescriTitre:SetText("Nom : "..slot1ent) 
		IV_SlotModel:SetModel(slot1model)
		local Desc = Descriptions[slot1ent]
		IV_Description:SetText(Descriptions[slot1ent])
	end
	IV_SlotIcon1.DoClick = function()
		LocalPlayer():ConCommand("SpawnThingsInBag 1") 
		IV_DFrame:Close()
	end
	
	local IV_SlotIcon2 = vgui.Create('SpawnIcon',IV_DFrame)
	IV_SlotIcon2:SetPos(300, 180)
	IV_SlotIcon2:SetModel(slot2model)
	IV_SlotIcon2.OnCursorEntered  = function()
		IV_DescriTitre:SetText("Nom : "..slot2ent) 
		IV_SlotModel:SetModel(slot2model)
		local Desc = Descriptions[slot2ent]
		IV_Description:SetText(Descriptions[slot2ent])
	end
	IV_SlotIcon2.DoClick = function()
		LocalPlayer():ConCommand("SpawnThingsInBag 2")
		IV_DFrame:Close()
	end  
	
	local IV_SlotIcon4 = vgui.Create('SpawnIcon',IV_DFrame)
	IV_SlotIcon4:SetPos(230, 250)
	IV_SlotIcon4:SetModel(slot4model)
	IV_SlotIcon4.OnCursorEntered  = function()
		IV_DescriTitre:SetText("Nom : "..slot4ent)
		IV_SlotModel:SetModel(slot4model)
		local Desc = Descriptions[slot4ent]
		IV_Description:SetText(Descriptions[slot4ent])
	end
	IV_SlotIcon4.DoClick = function()
		LocalPlayer():ConCommand("SpawnThingsInBag 4")
		IV_DFrame:Close()
	end
	
	local IV_SlotIcon3 = vgui.Create('SpawnIcon',IV_DFrame)
	IV_SlotIcon3:SetPos(300, 250)
	IV_SlotIcon3:SetModel(slot3model)
	IV_SlotIcon3.OnCursorEntered  = function()
		IV_PersoModel:SetModel( LocalPlayer():GetModel() )
		IV_DescriTitre:SetText("Nom : "..slot3ent)
		IV_SlotModel:SetModel(slot3model)
		local Desc = Descriptions[slot3ent]
		IV_Description:SetText(Descriptions[slot3ent])
	end
	IV_SlotIcon3.DoClick = function()
		LocalPlayer():ConCommand("SpawnThingsInBag 3")
		IV_DFrame:Close()
	end 
end
usermessage.Hook( "InventoryMenu", InventoryMenu )