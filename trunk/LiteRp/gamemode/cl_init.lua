include( 'shared.lua' )
include( 'cl_Hud.lua' )
include( 'cl_StaringDerma.lua' )
include( 'cl_Inventory.lua' )
include( 'cl_scoreboard.lua')
include("sh_lang.lua")

-- Disable the spawnmenu for non admin
local function SpawnMenu( )
		return LocalPlayer():IsAdmin()
end
hook.Add( "SpawnMenuOpen", "OnlyForAdmin", SpawnMenu)

-- From darkrp
-- used for the Notify function
local function DisplayNotify(msg)
	local txt = msg:ReadString()
	GAMEMODE:AddNotify(txt, msg:ReadShort(), msg:ReadLong())
	surface.PlaySound("ambient/water/drip" .. math.random(1, 4) .. ".wav")

	-- Log to client console
	print(txt)
end
usermessage.Hook("_Notify", DisplayNotify)