AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize( )
	self.Entity:SetModel(  "models/Combine_Soldier_PrisonGuard.mdl" )
	self.Entity:SetHullType( HULL_HUMAN )
	self.Entity:SetUseType(  SIMPLE_USE )
	self.Entity:SetHullSizeNormal( )
	self.Entity:SetSolid(  SOLID_BBOX )
	self.Entity:CapabilitiesAdd( CAP_TURN_HEAD | CAP_AIM_GUN )
	self.Entity:SetMaxYawSpeed( 5000 )
	self.Entity:Give("weapon_m4")
   local  Phys = self.Entity.Entity:GetPhysicsObject()
   if  Phys:IsValid() then
      Phys:Wake()
   end 
end

function ENT:AcceptInput( name, activator, caller, data )
	if caller:IsPlayer() and name == "Use" then
		umsg.Start("wantobecomepoliceman", caller)
		umsg.End()
	end
end

local function SpawnTheShityNPC()
	local npc = ents.Create( "NPCPolice" )
	npc:SetPos(Vector(-15, -1500, -143.9))
	npc:SetAngles(Angle(0, 0, 0))
 	npc:Spawn() 
end
hook.Add("InitPostEntity", "SpawnTheShitypoliceman", SpawnTheShityNPC)