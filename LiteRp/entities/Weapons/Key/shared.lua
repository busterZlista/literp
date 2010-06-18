if SERVER then
	AddCSLuaFile("shared.lua")
end

if CLIENT then
	SWEP.PrintName = "Keys"
	SWEP.Slot = 1
	SWEP.SlotPos = 3
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

SWEP.Author = "Slay3r36"
SWEP.Instructions = "Left click to lock. Right click to unlock"
SWEP.Contact = ""
SWEP.Purpose = "modified from darkrp"

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.AnimPrefix	 = "rpg"

SWEP.Spawnable = false
SWEP.AdminSpawnable = true
SWEP.Sound = "doors/door_latch3.wav"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

function SWEP:Initialize()
	self:SetWeaponHoldType("normal")
end

function SWEP:Deploy()
	if SERVER then
		self.Owner:DrawViewModel(false)
		self.Owner:DrawWorldModel(false)
	end
end

function SWEP:PrimaryAttack()
	if SERVER then
		local trace = self.Owner:GetEyeTrace()
		if trace.Entity:IsDoor() then
			if trace.Entity:GetDoorOwner() == self.Owner then
				self.Owner:EmitSound("npc/metropolice/gear".. math.floor(math.Rand(1,7)) ..".wav")
				trace.Entity:Fire("lock", "", 0)
				timer.Simple(0.9, function(ply, sound) if ValidEntity(ply) then ply:EmitSound(sound) end end, self.Owner, self.Sound)
			end
		end
	end
end
function SWEP:SecondaryAttack()
	if SERVER then
		local trace = self.Owner:GetEyeTrace()
		if trace.Entity:IsDoor() then
			if trace.Entity:GetDoorOwner() == self.Owner then
				self.Owner:EmitSound("npc/metropolice/gear".. math.floor(math.Rand(1,7)) ..".wav")
				trace.Entity:Fire("unlock", "", 0)
				timer.Simple(0.9, function(ply, sound) if ValidEntity(ply) then ply:EmitSound(sound) end end, self.Owner, self.Sound)
			end
		end
	end
end

SWEP.OnceReload = false
function SWEP:Reload()
	if SERVER then
		local trace = self.Owner:GetEyeTrace()
		if trace.Entity:IsDoor() then
			if trace.Entity:GetDoorOwner() == self.Owner then
				self.Owner:EmitSound("npc/metropolice/gear".. math.floor(math.Rand(1,7)) ..".wav")
				trace.Entity:Fire("lock", "", 0)
				timer.Simple(0.9, function(ply, sound) if ValidEntity(ply) then ply:EmitSound(sound) end end, self.Owner, self.Sound)
				self.Owner:UnOwnDoor()
			elseif trace.Entity:GetDoorOwner() == nil then
				self.Owner:EmitSound("npc/metropolice/gear".. math.floor(math.Rand(1,7)) ..".wav")
				trace.Entity:Fire("unlock", "", 0)
				timer.Simple(0.9, function(ply, sound) if ValidEntity(ply) then ply:EmitSound(sound) end end, self.Owner, self.Sound)
				self.Owner:OwnDoor()
			end
		end
	end
end
