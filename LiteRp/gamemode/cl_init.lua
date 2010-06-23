include( 'shared.lua' )
include( 'cl_Hud.lua' )
include( 'cl_StaringDerma.lua' )
include( 'cl_Inventory.lua' )
include( 'cl_scoreboard.lua')
include("sh_lang.lua")

--[[ function Isaid( player, Text, TeamOnly, PlayerIsDead )
if string.Left(Text, 3) == "// " then
player:ConCommand("ooc " .. Text)
else
player:ConCommand("chat " .. Text)
end
--chat.PlaySound()

end
hook.Add("OnPLayerChat", "Isaid", Isaid) ]]
local function SpawnMenu( )
		return LocalPlayer():IsAdmin()
end
hook.Add( "SpawnMenuOpen", "OnlyForAdmin", SpawnMenu)
-- From darkrp
local function DisplayNotify(msg)
	local txt = msg:ReadString()
	GAMEMODE:AddNotify(txt, msg:ReadShort(), msg:ReadLong())
	surface.PlaySound("ambient/water/drip" .. math.random(1, 4) .. ".wav")

	-- Log to client console
	print(txt)
end
usermessage.Hook("_Notify", DisplayNotify)