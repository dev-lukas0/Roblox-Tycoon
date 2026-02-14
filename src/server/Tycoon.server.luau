local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local datamanager = require(ServerScriptService.Server.data.datamanager)
local Buyables = require(ReplicatedStorage.Shared.Buyables)
local Tycoon = require(ReplicatedStorage.Shared.Tycoon)
local Event: BindableEvent = game.ReplicatedStorage:WaitForChild("Events"):WaitForChild("Cash")

local datamanager = datamanager.new(Event)

Players.PlayerAdded:Connect(function(player)
	datamanager:StartProfile(player)
end)

for _, tycoonObj in CollectionService:GetTagged("Tycoon") do
	if tycoonObj:IsA("Model") then
		local tycoon = Tycoon.new(tycoonObj)

		tycoon.claimPart.Touched:Connect(function(hit)
			tycoon:claim(hit)
		end)

		for _, buyPart in CollectionService:GetTagged("Buy") do
			if buyPart:IsA("BasePart") then
				buyPart.Touched:Connect(function(hit)
					local player = Players:GetPlayerFromCharacter(hit.Parent)
					if player == tycoon.player then
						if datamanager:GetCash(player) >= 100 then
							datamanager:SubtractCash(player, 100)
							Buyables.PlayerPurchases[player.UserId] = Buyables.PlayerPurchases[player.UserId] or {}
							table.insert(Buyables.PlayerPurchases[player.UserId], true)

							buyPart.CanTouch = false
							buyPart.CanCollide = false
							buyPart.Transparency = 1
						else
							warn("Not enough cash")
						end
					end
				end)
			end
		end

		Players.PlayerRemoving:Connect(function(player)
			if player == tycoon.player then
				tycoon:unclaim()
			end
		end)
	end
end
