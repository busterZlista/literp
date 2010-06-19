local meta = FindMetaTable("Player")

function meta:PutThingsInBag( Slot )
	local allowedlist = {"prop_physics","ballon_foot"}
	local trace = self:GetEyeTrace()
	if self:EyePos():Distance(trace.HitPos) > 65 then
		return
	end
	local phys = trace.Entity:GetPhysicsObject()
	if not phys:IsValid() then 
		return 
	end
	local mass = phys:GetMass()
	if mass > 100 then 
		return 
	end
	if trace.Entity:IsValid() and not trace.Entity:IsWorld() then
		for k,v in pairs(allowedlist) do 
			if string.find(trace.Entity:GetClass(), v) then 
				local entity = trace.Entity:GetClass()
				local model = trace.Entity:GetModel()
				trace.Entity:Remove()
				local SID = self:SteamID()
				sql.Query("UPDATE LiteRp_Inventory SET slot" .. Slot .. " = '" .. entity .. "#" .. model .. "' WHERE unique_id = '"..SID.."'")
			end
		end
	end
end

function meta:SpawnThingsInBag( Slot )
	local SID = self:SteamID()
	local entmod = sql.QueryValue("SELECT slot" .. Slot .. " FROM LiteRp_Inventory WHERE unique_id = '"..SID.."'")
	local Sep = string.Explode("#", entmod)
	local entity = Sep[1]
	local model = Sep[2]
	if entity == "rien" then
		return
	end
	if entity == "prop_physics" then
		self:LiteRp_Spawn_Free(model)
	else
		local Shit = ents.Create( entity )
		Shit:SetPos(self:GetPos() + self:GetAngles():Forward() * 64 + Vector( 0, 0, 16 ))
		Shit:SetAngles(Angle(0, 0, 0))
		Shit:Spawn()
		Shit:SetModel(model)
		Shit:Activate()
	end
	sql.Query("UPDATE LiteRp_Inventory SET slot" .. Slot .. " = 'rien#models/props_combine/combine_bridge_b.mdl' WHERE unique_id = '"..SID.."'")
end

concommand.Add("PutThingsInBag", function(ply, cmd, args) ply:PutThingsInBag( args[1] ) end)

concommand.Add("SpawnThingsInBag", function(ply, cmd, args) ply:SpawnThingsInBag( args[1] ) end)

function meta:GetEntInSlot()
	local SID = self:SteamID()
	local slot1 = sql.QueryValue("SELECT slot1 FROM LiteRp_Inventory WHERE unique_id = '"..SID.."'")
	local Sep1 = string.Explode("#", slot1)
	local slot2 = sql.QueryValue("SELECT slot2 FROM LiteRp_Inventory WHERE unique_id = '"..SID.."'")
	local Sep2 = string.Explode("#", slot2)
	local slot3 = sql.QueryValue("SELECT slot3 FROM LiteRp_Inventory WHERE unique_id = '"..SID.."'")
	local Sep3 = string.Explode("#", slot3)
	local slot4 = sql.QueryValue("SELECT slot4 FROM LiteRp_Inventory WHERE unique_id = '"..SID.."'")
	local Sep4 = string.Explode("#", slot4)
	umsg.Start("SlotInfo", self)
			umsg.String(Sep1[1])
			umsg.String(Sep1[2])
			umsg.String(Sep2[1])
			umsg.String(Sep2[2])
			umsg.String(Sep3[1])
			umsg.String(Sep3[2])
			umsg.String(Sep4[1])
			umsg.String(Sep4[2])
	umsg.End()
end