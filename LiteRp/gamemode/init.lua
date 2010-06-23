AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_Hud.lua" )
AddCSLuaFile( "cl_StaringDerma.lua" )
AddCSLuaFile( "cl_Inventory.lua" )
AddCSLuaFile( "cl_scoreboard.lua" )
include( 'Inventory.lua' )
include( 'shared.lua' )
include( 'ent.lua' )
include("sh_lang.lua")

local voiceRadius = 500    
hook.Add( "PlayerCanHearPlayersVoice", "SomeUniqueName", function( Listener, Talker )    
     if Listener:GetPos():Distance( Talker:GetPos() ) > voiceRadius then    
        return false    
    end    
end ) 


local meta = FindMetaTable("Player")
-- from darkrp
function meta:Notify(msgtype, len, msg)
	if not ValidEntity(self) then return end
	umsg.Start("_Notify", self)
		umsg.String(msg)
		umsg.Short(msgtype)
		umsg.Long(len)
	umsg.End()
end

function meta:LiteRp_Spawn_Free(model)
	local ModelAllowed = 
		{
		"models/props_borealis/bluebarrel001.mdl",
		"models/props_building_details/Storefront_Template001a_Bars.mdl",
		"models/props_c17/canister_propane01a.mdl",
		"models/props_c17/FurnitureChair001a.mdl",
		"models/props_c17/FurnitureCouch001a.mdl",
		"models/props_c17/FurnitureShelf001a.mdl"
		}
	for k, v in ipairs(ModelAllowed) do
		if model == v then
			local ent = ents.Create("prop_physics")
			ent:SetModel(model)
			ent:SetPos(self:GetPos() + self:GetAngles():Forward() * 64 + Vector( 0, 0, 16 ))
			ent:SetAngles(Angle(0, 0, 0))
			ent:Spawn()
		else 
			self:Notify(1, 4, LANGUAGE.not_allowed_model .. " : " .. model )
		end
	end
end

function meta:LiteRp_Spawn_Cost(model)
	local ModelAllowed = 
		{
		"models/props_borealis/bluebarrel001.mdl",
		"models/props_building_details/Storefront_Template001a_Bars.mdl",
		"models/props_c17/canister_propane01a.mdl",
		"models/props_c17/FurnitureChair001a.mdl",
		"models/props_c17/FurnitureCouch001a.mdl",
		"models/props_c17/FurnitureShelf001a.mdl"
		}
	for k, v in ipairs(ModelAllowed) do
		if model == v then
			local ent = ents.Create("prop_physics")
			ent:SetModel(model)
			ent:SetPos(self:GetPos() + self:GetAngles():Forward() * 64 + Vector( 0, 0, 16 ))
			ent:SetAngles(Angle(0, 0, 0))
			ent:Spawn()
			self:AddMoney(- 10)
		else 
			self:Notify(1, 4, LANGUAGE.not_allowed_model .. " : " .. model )
		end
	end
end

function meta:GetTimeWasted()
	local SID = self:SteamID()
	local time = sql.QueryValue("SELECT timewasted FROM LiteRp_DB WHERE unique_id = '"..SID.."'")
	return time 
end
function meta:SetTimeWasted(Time)
	local SID = self:SteamID()
	sql.Query("UPDATE LiteRp_DB SET timewasted = '"..Time.."' WHERE unique_id = '"..SID.."'")
	self:ConCommand("refresh")
end
function AddTimeWasted(ply)
	local SID = ply:SteamID()
	local NewTime = ply:GetTimeWasted() + 10
	sql.Query("UPDATE LiteRp_DB SET timewasted = '"..NewTime.."' WHERE unique_id = '"..SID.."'")
	ply:ConCommand("refresh")
end

function meta:SendTimeWasted()
	umsg.Start("TimeWasted", self)
		umsg.Long(self:GetTimeWasted())
	umsg.End()
end
	
function meta:GetRpName()
	local SID = self:SteamID()
	local name = sql.QueryValue("SELECT name FROM LiteRp_DB WHERE unique_id = '"..SID.."'")
	return name 
end

function meta:GetRpModel()
	local SID = self:SteamID()
	local skin = sql.QueryValue("SELECT skin FROM LiteRp_DB WHERE unique_id = '"..SID.."'")
	local Sep = string.Explode("#", skin)
	return Sep[2]
end

function meta:GetRpType()
	local SID = self:SteamID()
	local skin = sql.QueryValue("SELECT skin FROM LiteRp_DB WHERE unique_id = '"..SID.."'")
	local Sep = string.Explode("#", skin)
	return Sep[1]
end
function meta:GetRpMoney()
	local SID = self:SteamID()
	local money = sql.QueryValue("SELECT money FROM LiteRp_DB WHERE unique_id = '"..SID.."'")
	return money
end

function meta:GetRpMoneyBank()
	local SID = self:SteamID()
	local money = sql.QueryValue("SELECT moneybank FROM LiteRp_Bank WHERE unique_id = '"..SID.."'")
	return money
end

function meta:SendDataNJM()
	self:SetNWString("RpName", self:GetRpName())
	self:SetNWString("RpJob", self:GetJob())
	umsg.Start("GetRpMoney", self)
		umsg.Long(self:GetRpMoney())
	umsg.End()
end

function meta:AddMoney( Money )
	local SID = self:SteamID()
	local NewMoney = self:GetRpMoney() + Money
	if NewMoney <= 2147483640 and NewMoney >= 0 then -- Max int size, money is a int in the DB
		sql.Query("UPDATE LiteRp_DB SET money = '"..NewMoney.."' WHERE unique_id = '"..SID.."'")
		local MoneyAdded = Money 
		umsg.Start( "MoneyAdded", self )
				umsg.Long( MoneyAdded )
		umsg.End()
		timer.Simple(5, function() 
		MoneyAdded = 0
		umsg.Start( "MoneyAdded", self )
				umsg.Long( MoneyAdded )
		umsg.End()
		self:ConCommand("refresh") 
		end)
	else
		self:Notify(1, 4, LANGUAGE.too_much_money )
	end
end

function meta:SetMoneyBank( Money )
	if Money <= 2147483640 and Money >= 0 then -- Max int size, money is a int in the DB
		local SID = self:SteamID()
		sql.Query("UPDATE LiteRp_Bank SET moneybank = '"..Money.."' WHERE unique_id = '"..SID.."'")
		self:ConCommand("refresh")
	else
		self:Notify(1, 4, LANGUAGE.too_much_money )
	end
end

function meta:SetMoney( Money )
	if Money <= 2147483640 and Money >= 0 then -- Max int size, money is a int in the DB
		local SID = self:SteamID()
		sql.Query("UPDATE LiteRp_DB SET money = '"..Money.."' WHERE unique_id = '"..SID.."'")
		self:ConCommand("refresh")
	else
		self:Notify(1, 4, LANGUAGE.too_much_money )
	end
end

function meta:GetJob()
	local SID = self:SteamID()
	local job = sql.QueryValue("SELECT job FROM LiteRp_DB WHERE unique_id = '"..SID.."'")
	return job
end

function meta:SetJob( Job )
		local SID = self:SteamID()
		sql.Query("UPDATE LiteRp_DB SET job = '"..Job.."' WHERE unique_id = '"..SID.."'")
		self:ConCommand("refresh")
end

function GM:PlayerSetModel( ply )
 util.PrecacheModel( ply:GetRpModel() )
	ply:SetModel( ply:GetRpModel()  )
end

function GM:PlayerSpawn( ply )
    self.BaseClass:PlayerSpawn( ply ) 
    ply:SetGravity( 1 )  --0.75
    ply:SetMaxHealth( 100, true )  
    ply:SetWalkSpeed( 155)  
	ply:SetRunSpeed( 230 )
	ply:ConCommand("refresh") 
end

function GM:PlayerInitialSpawn( ply )
	local SID = ply:SteamID()
	local resultBank = sql.Query("SELECT unique_id, moneybank FROM LiteRp_Bank WHERE unique_id = '"..SID.."'")
		if (!resultBank) then
			sql.Query( "INSERT INTO LiteRp_Bank ('unique_id', 'moneybank' )VALUES ('"..SID.."', '0')" )
		end
	local resultinv = sql.Query("SELECT slot1, slot2, slot3, slot4, slot5 FROM LiteRp_Inventory WHERE unique_id = '"..SID.."'")
		if (!resultinv) then
		local defaultIV = "rien#models/props_combine/combine_bridge_b.mdl" --for now, we can't see the model if its this spawnicon
			sql.Query( "INSERT INTO LiteRp_Inventory ('unique_id', 'slot1', 'slot2', 'slot3', 'slot4', 'slot5' )VALUES ('"..SID.."', '" .. defaultIV .. "', '" .. defaultIV .. "', '" .. defaultIV .. "', '" .. defaultIV .. "', '" .. defaultIV .. "')" )
		end
	local resultbdd = sql.Query("SELECT unique_id, money, name, job, skin, timewasted FROM LiteRp_DB WHERE unique_id = '"..SID.."'")
		if (!resultbdd) then
			sql.Query( "INSERT INTO LiteRp_DB ('unique_id', 'money', 'name', 'job', 'skin', 'timewasted' )VALUES ('"..SID.."', '500', 'noname', 'roturier', 'models/player/group01/male_01.mdl', '0' )" )
			umsg.Start("SetName_And_Wear", ply) -- Open the starting derma
			umsg.End()
			ply:Spawn()
		end
			ply:ConCommand("refresh")
			ply:SendDataNJM()
	if ply:GetJob() == "Policier" then
		ply:SetTeam( 2 )
	else
		ply:SetTeam( 1 )
	end
	timer.Create("SpendTime",10, 0, AddTimeWasted , ply)
end

function GM:PlayerLoadout( ply )
	if ply:IsAdmin() then
		ply:Give( "gmod_tool" )
	end
	ply:Give( "weapon_physcannon" )
	ply:Give( "weapon_physgun" )
	ply:Give( "Key" )
	if ply:Team() == 2 then
		ply:SetArmor(100)
		ply:Give( "weapon_crowbar" )
		ply:Give( "Mennottes" )
	end
end

local function CreateTables()

	if (!sql.TableExists("LiteRp_Bank")) then
		sql.Query("CREATE TABLE LiteRp_Bank (unique_id varchar(255), moneybank int UNSIGNED)")
	end
	
	if (!sql.TableExists("LiteRp_Inventory")) then
		sql.Query("CREATE TABLE LiteRp_Inventory (unique_id varchar(255), slot1 varchar(255), slot2 varchar(255), slot3 varchar(255), slot4 varchar(255), slot5 varchar(255))")
	end	
	
	if (!sql.TableExists("LiteRp_DB")) then
		sql.Query("CREATE TABLE LiteRp_DB (unique_id varchar(255), money int UNSIGNED, name varchar(255), job varchar(255), skin varchar(255), timewasted int)")
	end
end
hook.Add( "Initialize", "Initialize", CreateTables )

function meta:SetRpName( RPName )
	local SID = self:SteamID()
	sql.Query("UPDATE LiteRp_DB SET name = '"..RPName.."' WHERE unique_id = '"..SID.."'")
	self:ConCommand("refresh")
end

function meta:SetFirstRpModel( RPModel )
	local ModelType = 
	{
	"F#models/player/Group01/Female_01.mdl",
	"F#models/player/Group01/Female_02.mdl",
	"FB#models/player/Group01/Female_03.mdl",
	"F#models/player/Group01/Female_04.mdl",
	"F#models/player/Group01/Female_06.mdl",
	"FB#models/player/Group01/Female_07.mdl",
	"B#models/player/group01/male_01.mdl",
	"models/player/Group01/Male_02.mdl",
	"B#models/player/Group01/male_03.mdl",
	"C#models/player/Group01/Male_04.mdl",
	"C#models/player/Group01/Male_05.mdl",
	"C#models/player/Group01/Male_06.mdl",
	"C#models/player/Group01/Male_07.mdl",
	"C#models/player/Group01/Male_08.mdl",
	"C#models/player/Group01/Male_09.mdl",
	"F#models/player/Group03/Female_01.mdl",
	"F#models/player/Group03/Female_02.mdl",
	"FB#models/player/Group03/Female_03.mdl",
	"F#models/player/Group03/Female_04.mdl",
	"F#models/player/Group03/Female_06.mdl",
	"FB#models/player/Group03/Female_07.mdl",
	"B#models/player/group03/male_01.mdl",
	"C#models/player/Group03/Male_02.mdl",
	"B#models/player/Group03/male_03.mdl",
	"C#models/player/Group03/Male_04.mdl",
	"C#models/player/Group03/Male_05.mdl",
	"C#models/player/Group03/Male_06.mdl",
	"C#models/player/Group03/Male_07.mdl",
	"C#models/player/Group03/Male_08.mdl",
	"C#models/player/Group03/Male_09.mdl"
	}
	for k, v in ipairs(ModelType) do
		local Sep = string.Explode("#", v)
		if RPModel == Sep[2] then
			local Type = Sep[1]
			print(Type)
			local model = Sep[2]
			print(model)
			local SID = self:SteamID()
			sql.Query("UPDATE LiteRp_DB SET skin = '"..Type.."#".. model .."' WHERE unique_id = '"..SID.."'")
			self:SetModel(RPModel)
			self:ConCommand("refresh")
		end
	end
end

function meta:SetRpModel( RPModel )
	local ModelType = 
	{
	"F#models/player/Group01/Female_01.mdl",
	"F#models/player/Group01/Female_02.mdl",
	"FB#models/player/Group01/Female_03.mdl",
	"F#models/player/Group01/Female_04.mdl",
	"F#models/player/Group01/Female_06.mdl",
	"FB#models/player/Group01/Female_07.mdl",
	"B#models/player/group01/male_01.mdl",
	"models/player/Group01/Male_02.mdl",
	"B#models/player/Group01/male_03.mdl",
	"C#models/player/Group01/Male_04.mdl",
	"C#models/player/Group01/Male_05.mdl",
	"C#models/player/Group01/Male_06.mdl",
	"C#models/player/Group01/Male_07.mdl",
	"C#models/player/Group01/Male_08.mdl",
	"C#models/player/Group01/Male_09.mdl",
	"F#models/player/Group03/Female_01.mdl",
	"F#models/player/Group03/Female_02.mdl",
	"FB#models/player/Group03/Female_03.mdl",
	"F#models/player/Group03/Female_04.mdl",
	"F#models/player/Group03/Female_06.mdl",
	"FB#models/player/Group03/Female_07.mdl",
	"B#models/player/group03/male_01.mdl",
	"C#models/player/Group03/Male_02.mdl",
	"B#models/player/Group03/male_03.mdl",
	"C#models/player/Group03/Male_04.mdl",
	"C#models/player/Group03/Male_05.mdl",
	"C#models/player/Group03/Male_06.mdl",
	"C#models/player/Group03/Male_07.mdl",
	"C#models/player/Group03/Male_08.mdl",
	"C#models/player/Group03/Male_09.mdl"
	}
	for k, v in ipairs(ModelType) do
		local Sep = string.Explode("#", v)
		if RPModel == Sep[2] then
		print("lol")
		print(Sep[1])
			if self:GetRpType() == Sep[1] then
			print("lol2")
				local SID = self:SteamID()
				sql.Query("UPDATE LiteRp_DB SET skin = '"..Sep[1].."#"..RPModel.."' WHERE unique_id = '"..SID.."'")
				self:SetModel(RPModel)
				self:ConCommand("refresh")
			end
		end
	end
end

concommand.Add("SetName", function(ply, cmd, args) ply:SetRpName( args[1] ) end)
concommand.Add("SetFirstModel", function(ply, cmd, args) ply:SetFirstRpModel( args[1] ) end)
concommand.Add("SetModel", function(ply, cmd, args) ply:SetRpModel( args[1] ) end)
concommand.Add("GetModel", function(ply, cmd, args) print(ply:GetRpModel()) end)
concommand.Add("refresh", function(ply) ply:SendDataNJM() ply:ConCommand("DrawSpawnicon") ply:GetEntInSlot() ply:SendTimeWasted() end)
concommand.Add("job", function(ply, cmd, args) 
	if Job == Policier or Job == Gundealer or Job == FlicChief then
		print("NoValid")
		return
	end
	ply:SetJob( args[1] ) 
end)
concommand.Add("GetDoorOwner", function(ply) tr = ply:GetEyeTrace() tr.Entity:GetDoorOwner() end)
 -- Thanks to BusyMonkey for the chatcommand script
 
local chatcommands = {};
function AddChatCommand(name, func)
	chatcommands[name] = func;
end

hook.Add("PlayerSay", "ChatCommand", function(ply, text)
	local tab = string.Explode(" ", text);
	local cmd = table.remove(tab, 1);
	if cmd then
		for name, func in pairs(chatcommands) do
			if ("/"..name:lower()) == cmd:lower() then
				func(ply, cmd, tab);
				break;
			end
		end
		--return "";
	end
end);
function meta:DropMoney( Anmount )
	if Anmount != nil then
		local NewMoney = self:GetRpMoney() - Anmount
		if NewMoney >= 0 then
			self:AddMoney( - Anmount )
			SpawnMoney(self:GetPos() + self:GetAngles():Forward() * 64 + Vector( 0, 0, 16 ), Anmount)
			self:Notify(1, 4, LANGUAGE.drop_money .. " " .. Anmount .. " $")
		else
		self:Notify(1, 4, LANGUAGE.plz_valid_anmount )
		end
	end
end

AddChatCommand("dropmoney", function(ply, cmd, args) ply:DropMoney( args[1] ) end)

AddChatCommand("take", function(ply)
	local SID = ply:SteamID()
	local slot1 = sql.QueryValue("SELECT slot1 FROM LiteRp_Inventory WHERE unique_id = '"..SID.."'")
	local Sep1 = string.Explode("#", slot1)
	local slot2 = sql.QueryValue("SELECT slot2 FROM LiteRp_Inventory WHERE unique_id = '"..SID.."'")
	local Sep2 = string.Explode("#", slot2)
	local slot3 = sql.QueryValue("SELECT slot3 FROM LiteRp_Inventory WHERE unique_id = '"..SID.."'")
	local Sep3 = string.Explode("#", slot3)
	local slot4 = sql.QueryValue("SELECT slot4 FROM LiteRp_Inventory WHERE unique_id = '"..SID.."'")
	local Sep4 = string.Explode("#", slot4)
	local ent1 = Sep1[1]
	local ent2 = Sep2[1]
	local ent3 = Sep3[1]
	local ent4 = Sep4[1]
	if ent1 == "rien" then
		theslot = 1
	elseif ent2 == "rien" then
		theslot = 2
	elseif ent3 == "rien" then
		theslot = 3
	elseif ent4 == "rien" then
		theslot = 4
		else
		return
	end
ply:PutThingsInBag( theslot )
end)
function GM:ShowSpare2( ply )
	ply:ConCommand("refresh")
	umsg.Start("InventoryMenu", ply)
	umsg.End()

end

concommand.Add("LiteRp_Spawn", function(ply, cmd, args) ply:LiteRp_Spawn_Cost(args[1]) end)

concommand.Add("BecomeACop", function(ply)
	if ply:GetTimeWasted() >= "60" then
		ply:SetTeam(2)
		ply:SetJob("Policier")
	end
end)
concommand.Add("GetTimeWasted", function(ply) print(ply:GetTimeWasted()) end)
concommand.Add("SellDoor", function(ply)
local tr = ply:GetEyeTrace()
if tr.Entity:IsDoor() then
tr.Entity:UnownDoor(ply)
end
end)

AddChatCommand("ooc", function(ply, cmd, args)local Pos = ply:GetPos()
	for k, v in ipairs (player.GetAll()) do
		v:ChatPrint(Color(255,255,255), ply:GetRPName(), Color(255,0,0), ":[ooc]", Color(0,0,255), args[1])
	end
end)
AddChatCommand("", function(ply, cmd, args)local Pos = ply:GetPos()
	for k, v in ipairs (player.GetAll()) do
		local recevierpos = v:GetPos()
		if recevier:Distance(Pos) >= 400 then
			v:ChatPrint(Color(255,255,255), ply:GetRPName(), Color(255,0,0), ":", Color(0,0,255), args[1])
		end
	end
end)

function GM:PlayerCanSeePlayersChat( strText, bTeamOnly, pListener, pSpeaker )
if string.Left(strText, 3) == "// " then return true end
if pListener:GetPos():Distance(pSpeaker:GetPos()) >= 400 then return false end
	return true
end

function physgunPickup( ply, ent )
	local Restricted = {"money", "npcolice"}
	for k, v in pairs(Restricted) do
		if ent:GetClass() == v then
			return false 
		end
	end
	if ent:GetPos():Distance(ply:GetPos()) >= 100 then
		return false
	else
		return true
	end
end
hook.Add( "PhysgunPickup", "physgunPickup", physgunPickup );

hook.Add("GravGunPunt", "DontPunt", function(Pl, Ent)
	DropEntityIfHeld(Ent)
	return false
end)

function BlockProps(ply)
	return ply:IsAdmin()
end
hook.Add( "PlayerSpawnProp", "BlockProps", BlockProps )
