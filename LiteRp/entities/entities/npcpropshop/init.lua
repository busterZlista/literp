AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize( )
	self.Entity:SetModel(  "models/Eli.mdl" )
	self.Entity:SetHullType( HULL_HUMAN )
	self.Entity:SetUseType(  SIMPLE_USE )
	self.Entity:SetHullSizeNormal( )
	self.Entity:SetSolid( SOLID_BBOX )
	self.Entity:CapabilitiesAdd( CAP_TURN_HEAD | CAP_AIM_GUN )
	self.Entity:SetMaxYawSpeed( 5000 )
   local  Phys = self.Entity.Entity:GetPhysicsObject()
   if  Phys:IsValid() then
      Phys:Wake()
   end 
end

function ENT:AcceptInput( name, activator, caller, data )
concommand.Add("SpawnPorpsInTruck", function(ply, cmd, args)
	if ply:GetPos():Distance(self.Entity:GetPos()) > 200 then
		return
	end
	ply:SpawnPropInTruck(args[1])
end)
	if caller:IsPlayer() and name == "Use" then
		umsg.Start("PropListTruck", caller)
		umsg.End()
	end
end

local function SpawnTheShityNPC()
	if game.GetMap() == "test_camion" then
		local npc = ents.Create( "npcpropshop" )
		npc:SetPos(Vector(50, -70, -7))
		npc:SetAngles(Angle(0, -180, 0))
		npc:Spawn()
	end
end

hook.Add("InitPostEntity", "SpawnTheShityNPC", SpawnTheShityNPC)

local meta = FindMetaTable("Player")

function CheckinTruck()
local FIB = ents.FindInBox( Vector(60,-60,0), Vector(251,60,120) )
	for k, v in pairs(FIB) do
		if v:GetClass() == "prop_physics" or v:IsPlayer() then
			for k, v in pairs(ents.GetAll()) do
				if v:GetClass() == "func_door_rotating" and v:GetName() == "Porte_Test_Prop" then
					v:Fire("open", "", 0)
				end
			end
			return
		end
	end
	for k, v in pairs(ents.GetAll()) do
		if v:GetClass() == "func_door_rotating" and v:GetName() == "Porte_Test_Prop" then
			v:Fire("close", "", 0)
			timer.Destroy("CheckinTruck")
			timer.Simple( 10, function() v:Fire("close", "", 0) end)
		end
	end
end

function meta:SpawnPropInTruck(model)
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
			ent:SetPos(Vector(162, 0, 72))
			ent:SetAngles(Angle(0, 0, 0))
			ent:Spawn()
			self:AddMoney(- 10)
			for k, v in pairs(ents.GetAll()) do
				if v:GetClass() == "func_door_rotating" and v:GetName() == "Porte_Test_Prop" then
					v:Fire("open", "", 0)
				end
			end
			timer.Create("CheckinTruck", 2, 0, CheckinTruck)
		end
	end
end
