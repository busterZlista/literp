--Idea from darkrp
local meta = FindMetaTable("Entity")

function meta:IsDoor()
	local class = self:GetClass()

	if class == "func_door" or
		class == "func_door_rotating" or
		class == "prop_door_rotating" or
		class == "prop_dynamic" then
		return true
	end
	return false
end

function meta:GetDoorOwner()
local class = self:GetClass()
	if class == "func_door" or class == "func_door_rotating" or class == "prop_door_rotating" or class == "prop_dynamic" then
		self.DoorData = self.DoorData or {}
		return self.DoorData.Owner
	end
end

function meta:OwnDoor(ply)
	if not self.Entity:IsDoor() then return end
	self.DoorData = self.DoorData or {}
		if self:GetDoorOwner() != nil then
		return
	end
		self.DoorData.Owner = ply
end

function meta:UnownDoor(ply)
if not self.Entity:IsDoor() then return end
	self.DoorData = self.DoorData or {}
		if self:GetDoorOwner() == ply then
		self.DoorData.Owner = nil
		end
end

