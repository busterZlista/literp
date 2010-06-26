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
concommand.Add("Buy_House", function(ply, cmd, args) 
	if ply:Distance(self.Entity:GetPos()) <= 200 then
		ply:BuyHouse(args[1]) 
	end
end)
	if caller:IsPlayer() and name == "Use" then
		umsg.Start("BuyHouse", caller)
		umsg.End()
	end
end

local function SpawnTheShityNPC()
		local npc = ents.Create( "npchouse" )
		npc:SetPos(Vector(454, -60, -450))
		npc:SetAngles(Angle(0, 0, 0))
		npc:Spawn()
end

hook.Add("InitPostEntity", "SpawnTheShityhouseman", SpawnTheShityNPC)

local meta = FindMetaTable("Player")


function meta:BuyHouse(House)
	if House == "maison2" then
		for k, v in pairs (ents.FindInSphere( Vector(500, -500, -430), 300 )) do
			if v:IsDoor() and v:GetDoorOwner() == nil and self:GetRpMoney() >= 200 then
				v:OwnDoor(self)
				self:AddMoney(-200)
			end
		end
	end
	if House == "maison1" then
		for k, v in pairs (ents.FindInSphere( Vector(382, 137, -430), 65 )) do
			if v:IsDoor() and v:GetDoorOwner() == nil and self:GetRpMoney() >= 100 then
				v:OwnDoor(self)
				self:AddMoney(-100)
			end
		end
	end
	if House == "maison3" then
		for k, v in pairs (ents.FindInSphere( Vector(-114, -277, -430), 200 )) do
			if v:IsDoor() and v:GetDoorOwner() == nil and self:GetRpMoney() >= 300 then
				v:OwnDoor(self)
				self:AddMoney(-300)
			end
		end
	end
	if House == "maison4" then
		for k, v in pairs (ents.FindInSphere( Vector(-273, 95, -430), 65 )) do
			if v:IsDoor() and v:GetDoorOwner() == nil and self:GetRpMoney() >= 400 then
				v:OwnDoor(self)
				self:AddMoney(-400)
			end
		end
	end
end
