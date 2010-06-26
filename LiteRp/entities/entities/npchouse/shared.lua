ENT.Base = "base_ai"
ENT.Type = "ai"
ENT.AutomaticFrameAdvance = true
 
ENT.PrintName =  "" 
ENT.Author = ""ENT.Contact = ""
ENT.Purpose =  ""
ENT.Instructions = ""
 
function ENT:SetAutomaticFrameAdvance( bUsingAnim )
	self.AutomaticFrameAdvance = bUsingAnim
end
