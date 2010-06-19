function DrawDerma()
	local Icon = vgui.Create( "SpawnIcon" )
	Icon:SetPos( 5, 5 )
	Icon:SetModel( LocalPlayer():GetModel() )
end
concommand.Add("drawspawnicon", DrawDerma)

function ReadRpName( um )
	money = um:ReadLong()
	AddedMoney = 0
end
usermessage.Hook("GetRpMoney", ReadRpName)

function ReadAddedMoney( um )
	AddedMoney = um:ReadLong()
end
usermessage.Hook("MoneyAdded", ReadAddedMoney)

function ReadDoorOwner( um )
	DoorOwner = um:ReadString()
end
usermessage.Hook("DoorOwner", ReadDoorOwner)

function myHud()
	local name = LocalPlayer():GetNWString("RpName")
	local job = LocalPlayer():GetNWString("RpJob")	
-- Name
	local	NameIcon = {}
	NameIcon.texture = surface.GetTextureID( "gui/silkicons/user" )
	NameIcon.color	= Color( 255, 255, 255, 255 ) 
	NameIcon.x = 70
	NameIcon.y = 5
	NameIcon.w = 20
	NameIcon.h = 20
	draw.TexturedQuad( NameIcon )
	draw.RoundedBox( 6, 90, 5, 100, 15, Color( 255, 255, 255, 50 ) )
	draw.WordBox( 4, 90, 3, name, "default", Color(0,255,0,0), Color(0,0,0,255) )
-- Money
	if AddedMoney  != 0 and AddedMoney != nil then
		if AddedMoney < 0 then 
			PrintedAddedMoney = AddedMoney 
		else 
			PrintedAddedMoney = "+"..AddedMoney 
		end
		draw.WordBox( 4, 200, 20, PrintedAddedMoney, "default", Color(0,0,0,150), Color(255,255,255,255) )
	end
	local 	MoneyIcon = {} 
	MoneyIcon.texture = surface.GetTextureID( "gui/silkicons/star" )
	MoneyIcon.color	= Color( 255, 255, 255, 255 ) 
	MoneyIcon.x = 70
	MoneyIcon.y = 25
	MoneyIcon.w = 20
	MoneyIcon.h = 20
	draw.TexturedQuad( MoneyIcon )
	draw.RoundedBox( 6, 90, 25, 100, 15, Color( 255, 255, 255, 50 ) )
	draw.WordBox( 4, 90, 22, money, "default", Color(0,255,0,0), Color(0,0,0,255) )
-- Job
	local FPJobIcon = {} 
	FPJobIcon.texture = surface.GetTextureID( "gui/silkicons/wrench" )
	FPJobIcon.color	= Color( 255, 255, 255, 255 ) 
	FPJobIcon.x = 70
	FPJobIcon.y = 45
	FPJobIcon.w = 20
	FPJobIcon.h = 20
	draw.TexturedQuad( FPJobIcon )
	draw.RoundedBox( 6, 90, 45, 100, 15, Color( 255, 255, 255, 50 ) )
	draw.WordBox( 4, 90, 42, job, "default", Color(0,255,0,0), Color(0,0,0,255) )
-- Health
	local HealthIcon = {}
	HealthIcon.color	= Color( 255, 255, 255, 255 ) 
	HealthIcon.x = 5
	HealthIcon.y = 75
	HealthIcon.w = 20
	HealthIcon.h = 20
	if LocalPlayer():Health() <=  20 then
		HealthIcon.texture = surface.GetTextureID( "gui/silkicons/exclamation" )
	else
		HealthIcon.texture = surface.GetTextureID( "gui/silkicons/heart" )
	end
	draw.TexturedQuad( HealthIcon )
	draw.RoundedBox( 6, 30, 75, 160, 15, Color( 255, 255, 255, 50 ) )
	draw.RoundedBox( 6, 30, 75, 1.6 * (LocalPlayer():Health()), 15, Color( 255, 0, 0, 150 ) )
	draw.WordBox( 4, 90, 72, LocalPlayer():Health(), "default", Color(0,255,0,0), Color(255,255,255,255) )
-- Armor
	if LocalPlayer():Armor() >0 then 
	local ArmorIcon = {} 
	ArmorIcon.texture = surface.GetTextureID( "gui/silkicons/shield" )
	ArmorIcon.color	= Color( 255, 255, 255, 255 ) 
	ArmorIcon.x = 5
	ArmorIcon.y = 95
	ArmorIcon.w = 20
	ArmorIcon.h = 20
	draw.TexturedQuad( ArmorIcon )
	draw.RoundedBox( 6, 30, 95, 160, 15, Color( 255, 255, 255, 50 ) )
	draw.RoundedBox( 6, 30, 95, 1.6 * (LocalPlayer():Armor()), 15, Color( 255, 150, 0, 150 ) )
	draw.WordBox( 4, 90, 92, LocalPlayer():Armor(), "default", Color(0,255,0,0), Color(255,255,255,255) )
	end
	local tr = LocalPlayer():GetEyeTrace()
	if tr.Entity:IsPlayer() then
		local Fppos = tr.Entity:GetPos()
		local Pos = LocalPlayer():GetPos()
		if Pos:Distance(Fppos) <= 400 then
			local FrontPlayername = tr.Entity:GetNWString("RpName")
			local FrontPlayerJob = tr.Entity:GetNWString("RpJob")
			local FrontPlayerHealth = tr.Entity:Health()
-- Name
			local FPNameIcon = {}
			FPNameIcon.texture = surface.GetTextureID( "gui/silkicons/user" )
			FPNameIcon.color	= Color( 255, 255, 255, 255 ) 
			FPNameIcon.x = 1185
			FPNameIcon.y = 5
			FPNameIcon.w = 20
			FPNameIcon.h = 20
			draw.TexturedQuad( FPNameIcon )
			draw.RoundedBox( 6, 1085, 5, 100, 15, Color( 255, 255, 255, 50 ) )
			draw.WordBox( 4, 1085, 3,FrontPlayername or "unknown", "default", Color(0,255,0,0), Color(0,0,0,255) )
-- Job
			local FPJobIcon = {} 
			FPJobIcon.texture = surface.GetTextureID( "gui/silkicons/wrench" )
			FPJobIcon.color	= Color( 255, 255, 255, 255 ) 
			FPJobIcon.x = 1185
			FPJobIcon.y = 25
			FPJobIcon.w = 20
			FPJobIcon.h = 20
			draw.TexturedQuad( FPJobIcon )
			draw.RoundedBox( 6, 1085, 25, 100, 15, Color( 255, 255, 255, 50 ) )
			draw.WordBox( 4, 1085, 22, FrontPlayerJob or "unknown", "default", Color(0,255,0,0), Color(0,0,0,255) )
-- Health
			if FrontPlayerHealth >= 100 then
				DrawedFPHealth = "Indemne"
			elseif FrontPlayerHealth <= 70 then
				DrawedFPHealth = "Blesser"
			elseif FrontPlayerHealth <= 40 then
				DrawedFPHealth = "Gravement Blesser"
			elseif FrontPlayerHealth <= 20 then
				DrawedFPHealth = "Agonisant"
			end
			local FPHealthIcon = {}
			FPHealthIcon.color	= Color( 255, 255, 255, 255 ) 
			FPHealthIcon.x = 1185
			FPHealthIcon.y = 45
			FPHealthIcon.w = 20
			FPHealthIcon.h = 20
			if FrontPlayerHealth <=  20 then
				FPHealthIcon.texture = surface.GetTextureID( "gui/silkicons/exclamation" )
			else
				FPHealthIcon.texture = surface.GetTextureID( "gui/silkicons/heart" )
			end
			draw.TexturedQuad( FPHealthIcon )
			draw.RoundedBox( 6, 1085, 45, 100, 15, Color( 255, 255, 255, 50 ) )
			draw.WordBox( 4, 1100, 42, DrawedFPHealth, "default", Color(0,255,0,0), Color(255,255,255,255) )
-- Face
			local FPIcon = {} 
			FPIcon.texture = surface.GetTextureID( "gui/silkicons/user" )
			FPIcon.color = Color( 255, 255, 255, 255 ) 
			FPIcon.x = 1215
			FPIcon.y = 5
			FPIcon.w = 65
			FPIcon.h = 65
			draw.TexturedQuad( FPIcon )
		end
	elseif tr.Entity:GetClass() == "npcpolice" then
		local Fppos  = tr.Entity:GetPos()
		local Pos = LocalPlayer():GetPos()
		if Pos:Distance(Fppos) <= 400 then
-- Name
			local FPNameIcon = {}
			FPNameIcon.texture = surface.GetTextureID( "gui/silkicons/user" )
			FPNameIcon.color	= Color( 255, 255, 255, 255 ) 
			FPNameIcon.x = 1185
			FPNameIcon.y = 5
			FPNameIcon.w = 20
			FPNameIcon.h = 20
			draw.TexturedQuad( FPNameIcon )
			draw.RoundedBox( 6, 1085, 5, 100, 15, Color( 255, 255, 255, 50 ) )
			draw.WordBox( 4, 1085, 3,"Sgt McTvish", "default", Color(0,255,0,0), Color(0,0,0,255) )
-- Job
			local FPJobIcon = {} 
			FPJobIcon.texture = surface.GetTextureID( "gui/silkicons/wrench" )
			FPJobIcon.color	= Color( 255, 255, 255, 255 ) 
			FPJobIcon.x = 1185
			FPJobIcon.y = 25
			FPJobIcon.w = 20
			FPJobIcon.h = 20
			draw.TexturedQuad( FPJobIcon )
			draw.RoundedBox( 6, 1085, 25, 100, 15, Color( 255, 255, 255, 50 ) )
			draw.WordBox( 4, 1085, 22, "Recruteur de policers", "default", Color(0,255,0,0), Color(0,0,0,255) )
-- Health
			local FPHealthIcon = {}
			FPHealthIcon.color	= Color( 255, 255, 255, 255 ) 
			FPHealthIcon.x = 1185
			FPHealthIcon.y = 45
			FPHealthIcon.w = 20
			FPHealthIcon.h = 20
			FPHealthIcon.texture = surface.GetTextureID( "gui/silkicons/exclamation" )
			draw.TexturedQuad( FPHealthIcon )
			draw.RoundedBox( 6, 1085, 45, 100, 15, Color( 255, 255, 255, 50 ) )
			draw.WordBox( 4, 1100, 42, "Invulnerable", "default", Color(0,255,0,0), Color(255,255,255,255) )
-- Face
			local FPIcon = {} 
			FPIcon.texture = surface.GetTextureID( "gui/silkicons/user" )
			FPIcon.color = Color( 255, 255, 255, 255 ) 
			FPIcon.x = 1215
			FPIcon.y = 5
			FPIcon.w = 65
			FPIcon.h = 65
			draw.TexturedQuad( FPIcon )
		end
	end
end
hook.Add("HUDPaint", "DrawBox", myHud);


