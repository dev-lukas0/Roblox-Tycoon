local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Tycoon = require(ReplicatedStorage.Shared.Tycoon)

for _, obj in CollectionService:GetTagged("Tycoon") do
	if obj:IsA("Model") then
		local tycoon = Tycoon.new(obj)
		tycoon.claimPart.Touched:Connect(function(hit)
			tycoon:claim(hit)
			task.delay(3, function()
				tycoon:unclaim()
			end)
		end)

		Players.PlayerRemoving:Connect(function(player)
			if player == tycoon.player then
				tycoon:unclaim()
			end
		end)
	end
end
