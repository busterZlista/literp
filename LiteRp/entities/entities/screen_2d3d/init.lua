AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self.Entity:SetModel("models/props_combine/breenglobe.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_NONE)
	self.Entity:SetSolid(SOLID_VPHYSICS)
self.Entity:SetUseType( SIMPLE_USE )
self.Entity:DrawShadow( false )
--self.Entity:SetColor(255, 255, 255, 0)
end
function ENT:SpawnFunction( ply, tr )
    if ( !tr.Hit ) then return end
    local ent = ents.Create( "screen_2d3d" )
    ent:SetPos(Vector(-180, 125, 65)) 
    ent:Spawn()
    ent:Activate()
    return ent
end

function ENT:Use(ply, activator)
end

function ENT:Think()
end

function ENT:OnRemove()
end