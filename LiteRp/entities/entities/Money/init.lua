AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self.Entity:SetModel("models/props/cs_assault/money.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	local phys = self.Entity:GetPhysicsObject()
	if phys and phys:IsValid() then phys:Wake() end
	self:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE_DEBRIS) 
end

function ENT:Use(ply)
	local Money = self.Money
	ply:AddMoney( Money )
	self:Remove()
end

function SpawnMoney(pos, Anmount)
	local MoneyBag = ents.Create("Money")
	MoneyBag:SetPos(pos)
	MoneyBag.Money = Anmount
	MoneyBag:Spawn()
	MoneyBag:Activate()
end