local Tycoon = {}
Tycoon.__index = Tycoon

function Tycoon.new<T>(model: Model, arg: T)
	local self = setmetatable({}, Tycoon)
	local connections

	self.Test = arg
	self.Model = model
	self.claimed = false
	self.connections = connections

	self:claim()

	return self
end

function Tycoon:claim()
	self.claimPart = self.Model:FindFirstChild("Claim")
	if self.claimPart and self.claimPart:IsA("BasePart") and self:check_if_tycoon_is_claimed() == false then
		self.connections = self.claimPart.Touched:Connect(function(hit)
			if hit then
				self.claimed = true
				self.claimPart.Transparency = 0.5
			end
		end)
	else
		print("Tycoon has already been claimed")
		return
	end
end

function Tycoon:unclaim()
	if self.claimPart and self:check_if_tycoon_is_claimed() == true then
		self.claimPart.Transparency = 0
		self.claimed = false
	end
end

function Tycoon:check_if_tycoon_is_claimed()
	if self.claimed == false then
		return false
	else
		return true
	end
end

function Tycoon:test()
	if self.player.Name ~= nil then
		print(self.player.Name)
	else
		return
	end
end

function Tycoon:destroy()
	self.connections:Disconnect()
	self:unclaim()
end

return Tycoon
