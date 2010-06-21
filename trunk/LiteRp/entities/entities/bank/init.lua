AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
function ENT:Initialize()
	self.Entity:SetModel("models/props_wasteland/gaspump001a.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_NONE)
	self.Entity:SetSolid(SOLID_VPHYSICS)
self.Entity:SetUseType( SIMPLE_USE )
Pos = self.Entity:GetPos()
end
function ENT:SpawnFunction( ply, tr )
    if ( !tr.Hit ) then return end
    local ent = ents.Create( "bank" )
    ent:SetPos( tr.HitPos + tr.HitNormal * 16 ) 
    ent:Spawn()
    ent:Activate()
    return ent
end
function ENT:Use(ply, activator)
umsg.Start("banke", ply)
	umsg.Long(ply:GetRpMoneyBank())
umsg.End()
end
concommand.Add("Bank_retirer", function(ply, cmd, args) 
if ply:GetPos():Distance(Pos) >= 200 then
print("tp loin")
	return
end
if ply:GetRpMoneyBank() >= args[1] then
print("Pas asser d'argent")
local Money = ply:GetRpMoneyBank() - args[1]
ply:SetMoneyBank(Money)
SpawnMoney(Pos + Vector(0, 0 ,40) , args[1])
end
end)

concommand.Add("Bank_deposer", function(ply, cmd, args) 
if ply:GetPos():Distance(Pos) >= 200 then
	print("tp loin")
	return
end
if ply:GetRpMoney() >= args[1] then
print("Pas asser d'argent")
ply:AddMoney(- args[1])
local Money = args[1] + ply:GetRpMoneyBank()
ply:SetMoneyBank(Money)
end
end)