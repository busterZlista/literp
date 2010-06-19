if SERVER then
	AddCSLuaFile("shared.lua")
end

if CLIENT then
	SWEP.PrintName = "HandCuffs"
	SWEP.Slot = 1
	SWEP.SlotPos = 3
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

SWEP.Author = "Slay3r36"
SWEP.Instructions = ""
SWEP.Contact = ""
SWEP.Purpose = ""

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.AnimPrefix	 = ""
SWEP.NextStrike = 0
SWEP.Spawnable = false
SWEP.AdminSpawnable = true
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
		if CurTime() < self.NextStrike then
			return
		end
		local trace = self.Owner:GetEyeTrace()
		if trace.Entity:IsPlayer() then
			if trace.Entity:GetPos():Distance(self.Owner:GetPos()) >= 50 then
				trace.Entity:SetRunSpeed( 120 )
				return
			end
			trace.Entity:SetVelocity((trace.Entity:GetPos() - self.Owner:GetPos()) * 7)
			self.NextStrike = CurTime() + 0.3
		end
	end
end
function SWEP:SecondaryAttack()
	if SERVER then
		if CurTime() < self.NextStrike then
			return
		end
		local trace = self.Owner:GetEyeTrace()
		if trace.Entity:IsPlayer() then
			if trace.Entity:GetPos():Distance(self.Owner:GetPos()) >= 50 then
				return
			end
			trace.Entity:SetVelocity((trace.Entity:GetPos() - self.Owner:GetPos()) * 7)
			self.NextStrike = CurTime() + 0.3
		end
	end
end

SWEP.OnceReload = false
function SWEP:Reload()
	if SERVER then
		if CurTime() < self.NextStrike then
			return
		end
		local trace = self.Owner:GetEyeTrace()
		if trace.Entity:IsPlayer() then
			if trace.Entity:GetPos():Distance(self.Owner:GetPos()) >= 50 then 
				trace.Entity:SetRunSpeed( 230 )
				return
			end
			trace.Entity:SetVelocity((trace.Entity:GetPos() - self.Owner:GetPos()) * 7)
			self.NextStrike = CurTime() + 0.3
		end
	end
end
