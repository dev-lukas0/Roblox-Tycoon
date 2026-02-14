local Players = game:GetService("Players")
local Tycoon = {}
Tycoon.__index = Tycoon

type TycoonData = {
	Model: Model,
	claimed: boolean,
	connections: RBXScriptConnection,
	player: Player,
	claimPart: BasePart,
}

export type Tycoon = typeof(setmetatable({} :: TycoonData, Tycoon))

function Tycoon.new(model: Model): Tycoon
	local self = setmetatable({}, Tycoon)

	self.Model = model
	self.claimed = false
	self.connections = nil
	self.player = nil

	local claimPart: BasePart = self.Model:FindFirstChild("Claim")
	self.claimPart = claimPart

	return self
end

-- Claim a tycoon
function Tycoon:claim(hit)
	if self.claimed == true then
		return
	end
	if not hit then
		return
	end

	local humanoid = hit.Parent:FindFirstChildWhichIsA("Humanoid")
	if not humanoid then
		return
	end

	local player = Players:GetPlayerFromCharacter(humanoid.Parent)
	if not player then
		return
	end

	-- Claim Tycoon
	self.claimed = true
	self.player = player
	self.claimPart.Transparency = 0.5
	self.claimPart.Name = "Claim"
	print(player.Name)
end

-- Unclaim a tycoon
function Tycoon:unclaim()
	if not self.claimPart then
		return
	end

	self.claimPart.Transparency = 0
	self.claimed = false
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
