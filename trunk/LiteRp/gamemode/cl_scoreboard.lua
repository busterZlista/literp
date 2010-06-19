--ScoreBoard
--Player Row
surface.CreateFont("coolvetica", 20, 500, true, false, "ScoreboardPlayerName")
local texGradient = surface.GetTextureID("gui/center_gradient")
local PANEL = {}
function PANEL:Paint()
	if not ValidEntity(self.Player) then return end
	
	local color = team.GetColor(self.Player:Team())
	if self.Armed then
		color = team.GetColor(self.Player:Team())
	end

	if self.Selected then
		color = team.GetColor(self.Player:Team())
	end

	if self.Player:Team() == TEAM_CONNECTING then
		color = Color(200, 120, 50, 255)
	elseif self.Player:IsAdmin() then
		color = team.GetColor(self.Player:Team())
	end

	draw.RoundedBox(4, 0, 0, self:GetWide(), 24, color)

	surface.SetTexture(texGradient)
	surface.SetDrawColor(255, 255, 255, 50)
	surface.DrawTexturedRect(0, 0, self:GetWide(), 24)

	return true
end
function PANEL:SetPlayer(ply)
	if not ValidEntity(ply) then return end
	self.Player = ply
	self:UpdatePlayerData()
end

function PANEL:UpdatePlayerData()
	if not ValidEntity(self.Player) then return end
	local Team = LocalPlayer():Team()
	self.lblName:SetText(self.Player:GetNWString("RpName"))
	self.lblName:SizeToContents()
	self.lblJob:SetText(self.Player:GetNWString("RpJob"))
	self.lblJob:SizeToContents()
	self.lblPing:SetText(self.Player:Ping())
end

function PANEL:Init()
	self.Size = 24
	self.lblName = vgui.Create("Label", self)
	self.lblJob = vgui.Create("Label", self)
	self.lblPing = vgui.Create("Label", self)
end

function PANEL:ApplySchemeSettings()
	self.lblName:SetFont("ScoreboardPlayerName")
	self.lblJob:SetFont("ScoreboardPlayerName")
	self.lblPing:SetFont("ScoreboardPlayerName")
	self.lblName:SetFGColor(color_white)
	self.lblJob:SetFGColor(color_white)
	self.lblPing:SetFGColor(color_white)
end

function PANEL:Think()
	if not self.PlayerUpdate or self.PlayerUpdate < CurTime() then
		self.PlayerUpdate = CurTime() + 0.5
		self:UpdatePlayerData()
	end
end

function PANEL:PerformLayout()
	self:SetSize(self:GetWide(), self.Size)
	self.lblName:SizeToContents()
	self.lblName:SetPos(24, 2)

	local COLUMN_SIZE = 50

	self.lblPing:SetPos(self:GetWide() - COLUMN_SIZE * 1, 0)
	self.lblJob:SetPos(self:GetWide() - COLUMN_SIZE * 7, 1)

end

function PANEL:HigherOrLower(row)
	if not ValidEntity(row.Player) or not ValidEntity(self.Player) then return false end

	if self.Player:Team() == TEAM_CONNECTING then return false end
	if row.Player:Team() == TEAM_CONNECTING then return true end

	if team.GetName(self.Player:Team()) == team.GetName(row.Player:Team()) then
		return team.GetName(self.Player:Team()) < team.GetName(row.Player:Team())
	end

	return team.GetName(self.Player:Team()) < team.GetName(row.Player:Team())
end

vgui.Register("ScorePlayerRow", PANEL, "Button")

--PlayerFrame
local PANEL = {}
function PANEL:Init()
	self.pnlCanvas 	= vgui.Create("Panel", self)
	self.YOffset = 0
end
function PANEL:GetCanvas()
	return self.pnlCanvas
end
function PANEL:OnMouseWheeled(dlta)
	local MaxOffset = self.pnlCanvas:GetTall() - self:GetTall()

	if MaxOffset > 0 then
		self.YOffset = math.Clamp(self.YOffset + dlta * -100, 0, MaxOffset)
	else
		self.YOffset = 0
	end

	self:InvalidateLayout()
end
function PANEL:PerformLayout()
	self.pnlCanvas:SetPos(0, self.YOffset * -1)
	self.pnlCanvas:SetSize(self:GetWide(), self.pnlCanvas:GetTall())
end

vgui.Register("PlayerFrame", PANEL, "Panel")
------------
SetGlobalString("servertype", "Listen")
surface.CreateFont("coolvetica", 32, 500, true, false, "ScoreboardHeader")
surface.CreateFont("coolvetica", 20, 500, true, false, "ScoreboardSubtitle")

local texGradient = surface.GetTextureID("gui/center_gradient")

local PANEL = {}

function PANEL:Init()
	SCOREBOARD = self
	
	self.Image = vgui.Create('DImage', self)
	self.Image:SetImage('LogoLiteRp')
	

	self.Description = vgui.Create("Label", self)
	self.Description:SetText(" - LiteRp - Slay3r36")

	self.PlayerFrame = vgui.Create("PlayerFrame", self)

	self.PlayerRows = {}

	self:UpdateScoreboard()

	timer.Create("ScoreboardUpdater", 1, 0, self.UpdateScoreboard, self)

	self.lblJob = vgui.Create("Label", self)
	self.lblJob:SetText("Job")

	self.lblPing = vgui.Create("Label", self)
	self.lblPing:SetText("Ping")
	
	self.lblName = vgui.Create("Label", self)
	self.lblName:SetText("Nom")
end

function PANEL:AddPlayerRow(ply)
	local button = vgui.Create("ScorePlayerRow", self.PlayerFrame:GetCanvas())
	button:SetPlayer(ply)
	self.PlayerRows[ ply ] = button
end

function PANEL:GetPlayerRow(ply)
	return self.PlayerRows[ ply ]
end

function PANEL:Paint()
	draw.RoundedBox(4, 0, 0, self:GetWide(), self:GetTall(), Color(255, 255, 255, 98))
	surface.SetTexture(texGradient)
	surface.SetDrawColor(50, 50, 50, 50)
	surface.DrawTexturedRect(0, 0, self:GetWide(), self:GetTall())

	draw.RoundedBox(4, 4, self.Description.y - 4, self:GetWide() - 8, self:GetTall() - self.Description.y - 4, Color(0, 0, 0, 98))
	surface.SetTexture(texGradient)
	surface.SetDrawColor(255, 255, 255, 50)
	surface.DrawTexturedRect(4, self.Description.y - 4, self:GetWide() - 8, self:GetTall() - self.Description.y - 4)

	draw.RoundedBox(4, 5, self.Description.y - 3, self:GetWide() - 10, self.Description:GetTall() + 5, Color(0, 0, 0, 200))
	surface.SetTexture(texGradient)
	surface.SetDrawColor(0, 0, 0, 50)
	surface.DrawTexturedRect(4, self.Description.y - 4, self:GetWide() - 8, self.Description:GetTall() + 8)
end

function PANEL:PerformLayout()
	self:SetSize(800, ScrH() * 0.95)
	self:SetPos((ScrW() - self:GetWide()) / 2, (ScrH() - self:GetTall()) / 2)
	
	self.Image:SetSize(800 - 10--[[ self:GetWide() - 10 ]], 50)
	self.Image:SetPos(5, 5)	

	self.Description:SizeToContents()
	self.Description:SetPos(16, 64)

	self.PlayerFrame:SetPos(5, self.Description.y + self.Description:GetTall() + 20)
	self.PlayerFrame:SetSize(self:GetWide() - 10, self:GetTall() - self.PlayerFrame.y - 10)

	local y = 0

	local PlayerSorted = {}

	for k, v in pairs(self.PlayerRows) do
		table.insert(PlayerSorted, v)
	end

	table.sort(PlayerSorted, function (a , b) return a:HigherOrLower(b) end)

	for k, v in ipairs(PlayerSorted) do
		v:SetPos(0, y)
		v:SetSize(self.PlayerFrame:GetWide(), v:GetTall())

		self.PlayerFrame:GetCanvas():SetSize(self.PlayerFrame:GetCanvas():GetWide(), y + v:GetTall())
		y = y + v:GetTall() + 1
	end

	self.lblPing:SizeToContents()
	self.lblJob:SizeToContents()
	self.lblName:SizeToContents()
	
	self.lblPing:SetPos(self:GetWide() - 50 - self.lblPing:GetWide()/2, self.PlayerFrame.y - self.lblPing:GetTall() - 3)
	self.lblJob:SetPos(self:GetWide() - 50*7 - self.lblJob:GetWide()/2, self.PlayerFrame.y - self.lblPing:GetTall() - 3)
	self.lblName:SetPos(self:GetWide() - 50*15.2 - self.lblName:GetWide()/2, self.PlayerFrame.y - self.lblPing:GetTall() - 3)
end

function PANEL:ApplySchemeSettings()
	self.Description:SetFont("ScoreboardSubtitle")

	self.Description:SetFGColor(color_white)

	self.lblPing:SetFont("DefaultSmall")
	self.lblJob:SetFont("DefaultSmall")
	self.lblName:SetFont("DefaultSmall")
	
	self.lblPing:SetFGColor(Color(0, 0, 0, 255))
	self.lblJob:SetFGColor(Color(0, 0, 0, 255))
	self.lblName:SetFGColor(Color(0, 0, 0, 255))
end

function PANEL:UpdateScoreboard(force)
	if not force and not self:IsVisible() then return end

	for k, v in pairs(self.PlayerRows) do
		if not ValidEntity(k) then
			v:Remove()
			self.PlayerRows[ k ] = nil
		end
	end

	local PlayerList = player.GetAll()
	for id, pl in pairs(PlayerList) do
		if not self:GetPlayerRow(pl) then
			self:AddPlayerRow(pl)
		end
	end

	self:InvalidateLayout()
end

vgui.Register("ScoreBoard", PANEL, "Panel")

------------
local pScoreBoard = nil

function GM:CreateScoreboard()
	if ScoreBoard then
		ScoreBoard:Remove()
		ScoreBoard = nil
	end

	pScoreBoard = vgui.Create("ScoreBoard")
end

function GM:ScoreboardShow()
	--return true
	--GAMEMODE.ShowScoreboard = true
	gui.EnableScreenClicker(false)

	if not pScoreBoard then
		self:CreateScoreboard()
	end

	pScoreBoard:SetVisible(true)
	pScoreBoard:UpdateScoreboard(true)
	
end

function GM:ScoreboardHide()
	--GAMEMODE.ShowScoreboard = false
	gui.EnableScreenClicker(false)
	pScoreBoard:SetVisible(false)
end
 
