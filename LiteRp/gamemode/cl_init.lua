include( 'shared.lua' )
include( 'cl_Hud.lua' )
include( 'cl_StaringDerma.lua' )
include( 'cl_Inventory.lua' )
include( 'cl_scoreboard.lua')

--[[ function Isaid( player, Text, TeamOnly, PlayerIsDead )
if string.Left(Text, 3) == "// " then
player:ConCommand("ooc " .. Text)
else
player:ConCommand("chat " .. Text)
end
--chat.PlaySound()

end
hook.Add("OnPLayerChat", "Isaid", Isaid) ]]
