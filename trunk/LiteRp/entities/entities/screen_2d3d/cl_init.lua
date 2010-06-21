include("shared.lua")

function ENT:Draw()
	concommand.Add("Set2D3DJudgeScreen2", function(ply, cmd, args) 
	Sttt = args[1] or "1#2#3#4" 
	end)
	local Pos1 = self:GetPos()
	local Pos = Vector(Pos1.x, Pos1.y, Pos1.z + 45)
	local Ang = self:GetAngles()
	surface.SetFont("HUDNumber5")
	local Sep = string.Explode("#", Sttt or "1#2#3#4")
	local TextWidth  = surface.GetTextSize(Sep[1])
	local TextWidtha = surface.GetTextSize(Sep[2])
	local TextWidthb = surface.GetTextSize(Sep[3])
	local TextWidthc = surface.GetTextSize(Sep[4])
	local Lt = {
	TextWidth, 
	TextWidtha, 
	TextWidthb, 
	TextWidthc
	}
	local lol = table.GetWinningKey(Lt)
	local TextWidthRB = Lt[lol]
	print("num " ..lol)
	print("key "..Lt[lol])
	
	Ang:RotateAroundAxis(Ang:Forward(), 90)
	local TextAng = Ang
	cam.Start3D2D(Pos + Ang:Right() * -30, TextAng, 0.2)
		draw.RoundedBox( 2, -TextWidthRB*0.5 + 5, 162, TextWidthRB, 200, Color( 0, 0, 0, 150 ) )
		draw.WordBox(2, -TextWidth*0.5 + 5, 162, Sep[1], "HUDNumber5", Color(255, 200, 0, 0), Color(255,200,0,255))
		draw.WordBox(2, -TextWidtha*0.5 + 5, 210, Sep[2], "HUDNumber5", Color(255, 200, 0, 0), Color(255,200,0,255))
		draw.WordBox(2, -TextWidthb*0.5 + 5, 258, Sep[3], "HUDNumber5", Color(255, 200, 0, 0), Color(255,200,0,255))
		draw.WordBox(2, -TextWidthc*0.5 + 5, 306, Sep[4], "HUDNumber5", Color(255, 200, 0, 0), Color(255,200,0,255))
	cam.End3D2D()
end
