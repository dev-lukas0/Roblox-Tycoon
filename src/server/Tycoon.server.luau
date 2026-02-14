local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Tycoon = require(ReplicatedStorage.Shared.Tycoon)

for _, obj in CollectionService:GetTagged("Tycoon") do
	if obj:IsA("Model") then
		local tycoon = Tycoon.new(obj, 1)
		task.delay(10, function()
			tycoon:unclaim()
		end)
	end
end
