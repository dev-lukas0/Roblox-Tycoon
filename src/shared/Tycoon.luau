local Players = game:GetService("Players")
local Tycoon = {}
Tycoon.__index = Tycoon

type TycoonData = {
	Model: Model,
	claimed: boolean,
	connections: RBXScriptConnection,
	player: Player,
}

export type Tycoon = typeof(setmetatable({} :: TycoonData, Tycoon))

function Tycoon.new(model: Model): Tycoon
	local self = setmetatable({}, Tycoon)
	local connections
	local player

	self.Model = model
	self.claimed = false
	self.connections = connections
	self.player = player

	self:claim()

	return self
end

-- Claim a tycoon
function Tycoon:claim()
	self.claimPart = self.Model:FindFirstChild("Claim")
	if self.claimPart and self.claimPart:IsA("BasePart") then
		self.connections = self.claimPart.Touched:Connect(function(hit)
			-- Check if the tycoon is already claimed on the touched event
			if hit and self:check_if_tycoon_is_claimed() == false then
				local humanoid = hit.Parent:FindFirstChildWhichIsA("Humanoid")
				if humanoid then
					local char = humanoid.Parent
					local player = Players:GetPlayerFromCharacter(char)
					self.claimed = true
					self.claimPart.Transparency = 0.5
					self.player = player
					print(self.player.Name)
				end
			end
		end)
	else
		print("Tycoon has already been claimed")
		return
	end
end

-- Unclaim the tycoon
function Tycoon:unclaim()
	if self.claimPart and self:check_if_tycoon_is_claimed() == true then
		self.claimPart.Transparency = 0
		self.claimed = false
	end
end

-- Returns whether the tycoon has already been claimed or not
function Tycoon:check_if_tycoon_is_claimed()
	if self.claimed == false then
		return false
	else
		return true
	end
end

function Tycoon:destroy()
	self.connections:Disconnect()
	self:unclaim()
end

return Tycoon
