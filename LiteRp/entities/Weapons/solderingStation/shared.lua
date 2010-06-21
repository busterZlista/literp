--[[ //General Settings \\ 
SWEP.PrintName 		= "Killa_Pistol" // your sweps name 
 
SWEP.Author 		= "yaddablahdah" // Your name 
SWEP.Instructions 	= "SwepInstructions" // How do pepole use your swep ? 
SWEP.Contact 		= "YourMailAdress" // How Pepole chould contact you if they find bugs, errors, etc 
SWEP.Purpose 		= "WhatsThePurposeOfThisSwep" // What is the purpose with this swep ? 
 
SWEP.AdminSpawnable = true // Is the swep spawnable for admin 
SWEP.Spawnable 		= false // Can everybody spawn this swep ? - If you want only admin keep this false and adminsapwnable true. 

SWEP.Slot 	 = 1
SWEP.SlotPos = 1
 
SWEP.HoldType = "melee"
 
SWEP.FiresUnderwater = false
 
SWEP.Weight = 5
 
SWEP.DrawCrosshair = false
 
SWEP.Category = "LiteRp"
 
SWEP.DrawAmmo = false
 
SWEP.base = "weapon_base" 

SWEP.Primary.Delay = 3



function SWEP:Initialize() 
		self.Repairing = false
        self:SetWeaponHoldType( self.HoldType )
end

function SWEP:CheckLight()
	for k, v in pairs (ents.FindInSphere( self.Owner:GetShootPos() , 30 )) do
		if v:IsValid() and v:GetClass() == "light_spot" or v:GetClass() == "light" then
			return true
			else
			return false
		end
	end
end

function SWEP:PrimaryAttack()
if self.Repairing then return end
	self.StartTime = CurTime()
	self.EndTime = CurTime() + 20
	if self:CheckLight() then
			self.Repairing = true
	end
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
end 

function SWEP:Holster()
	self.IsLockPicking = false
	return true
end

function SWEP:LightIt()
	for k, v in pairs (ents.FindInSphere( self.Owner:GetShootPos() , 30 )) do
		if v:IsValid() and v:GetClass() == "light_spot" or v:GetClass() == "light" then
			v:Fire("TurnOn", "", 0)
		end
	end
end

function SWEP:SecondaryAttack()
end

function SWEP.Think()
	if self.Repairing then
		if not self:CheckLight() then
			self.Repairing = false
		end
	end
	if self.EndTime < CurTime() and self:CheckLight() then
		self:LightIt()
		self.Repairing = false
	end
end

function SWEP:DrawHUD()
	if self.Repairing then
		self.Dots = self.Dots or ""
		local w = ScrW()
		local h = ScrH()
		local x,y,width,height = w/2-w/10, h/ 2, w/5, h/15
		draw.RoundedBox(8, x, y, width, height, Color(10,10,10,120))
		
		local time = self.EndTime - self.StartTime
		local curtime = CurTime() - self.StartTime
		local status = curtime/time
		local BarWidth = status * (width - 16) + 8
		draw.RoundedBox(8, x+8, y+8, BarWidth, height - 16, Color(255-(status*255), 0+(status*255), 0, 255))
		
		draw.SimpleText("Repairing", "Trebuchet24", w/2, h/2 + height/2, Color(255,255,255,255), 1, 1)
	end
end ]]
if (SERVER) then
	AddCSLuaFile("shared.lua")
end

if (CLIENT) then
	SWEP.PrintName = "repairing Kit"
	SWEP.Slot = 5
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

SWEP.Author = "Slay3r36"
SWEP.Instructions = "Left click to Swith a light"
SWEP.Contact = ""
SWEP.Purpose = ""

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.ViewModel = Model("models/weapons/v_crowbar.mdl")
SWEP.WorldModel = Model("models/weapons/w_crowbar.mdl")

SWEP.Spawnable = false
SWEP.AdminSpawnable = true

SWEP.Sound = Sound("physics/wood/wood_box_impact_hard3.wav")

SWEP.Primary.ClipSize = -1      -- Size of a clip
SWEP.Primary.DefaultClip = 0        -- Default number of bullets in a clip
SWEP.Primary.Automatic = false      -- Automatic/Semi Auto
SWEP.Primary.Ammo = ""

SWEP.Secondary.ClipSize = -1        -- Size of a clip
SWEP.Secondary.DefaultClip = -1     -- Default number of bullets in a clip
SWEP.Secondary.Automatic = false        -- Automatic/Semi Auto
SWEP.Secondary.Ammo = ""
SWEP.LockPickTime = 10

/*---------------------------------------------------------
Name: SWEP:Initialize()
Desc: Called when the weapon is first loaded
---------------------------------------------------------*/
function SWEP:Initialize()
	self:SetWeaponHoldType("normal")
end

/*---------------------------------------------------------
Name: SWEP:PrimaryAttack()
Desc: +attack1 has been pressed
---------------------------------------------------------*/
function SWEP:CheckLight()
	for k, v in pairs (ents.FindInSphere( self.Owner:GetPos() , 100 )) do
		if v:IsValid() and v:GetClass() == "light_spot" or v:GetClass() == "light" then
		print("true")
			return true
		else
			print("false")
			return false
		end
	end
end

function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire(CurTime() + .4)
	if self.IsLockPicking then return end

	local trace = self.Owner:GetEyeTrace()
	local e = trace.Entity
	if self:CheckLight() then
		self.IsLockPicking = true
		print("islockpicking true")
		self.StartPick = CurTime()
		self.EndPick = CurTime() + self.LockPickTime
		
		self:SetWeaponHoldType("pistol")
	end
end

function SWEP:Holster()
	return true
end

function SWEP:Succeed()
	self.IsLockPicking = false
	for k, v in pairs (ents.FindInSphere( self.Owner:GetShootPos() , 30 )) do
		if v:IsValid() and v:GetClass() == "light_spot" or v:GetClass() == "light" then
			v:Fire("TurnOn", "", 0)
		end
	end
end

function SWEP:Fail()
	self.IsLockPicking = false
	self:SetWeaponHoldType("normal")
end

function SWEP:Think()
	if self.IsLockPicking then
		if not self:CheckLight() then
			self:Fail()
		end
		if self.EndPick <= CurTime() then
			self:Succeed()
		end
	end
end

function SWEP:DrawHUD()
	if self.IsLockPicking then
	print("drawhud")
		local w = ScrW()
		local h = ScrH()
		local x,y,width,height = w/2-w/10, h/ 2, w/5, h/15
		draw.RoundedBox(8, x, y, width, height, Color(10,10,10,120))
		
		local time = self.EndPick - self.StartPick
		local curtime = CurTime() - self.StartPick
		local status = curtime/time
		local BarWidth = status * (width - 16) + 8
		draw.RoundedBox(8, x+8, y+8, BarWidth, height - 16, Color(255-(status*255), 0+(status*255), 0, 255))
		
		draw.SimpleText("Picking lock", "Trebuchet24", w/2, h/2 + height/2, Color(255,255,255,255), 1, 1)
	end
end

function SWEP:SecondaryAttack()
	self:PrimaryAttack()
end