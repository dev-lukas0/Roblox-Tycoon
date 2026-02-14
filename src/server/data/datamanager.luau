local ProfileStore = require(game.ServerScriptService.ServerPackages.profilestore)
local Players = game:GetService("Players")

local DataManager = {}
DataManager.__index = DataManager

local Template = {
	Cash = 1000,
	Items = {},
}

function DataManager.new(Event: BindableEvent)
	local self = setmetatable({}, DataManager)

	self.PlayerStore = ProfileStore.New("PlayerStore", Template)
	self.Profiles = {}

	Event.Event:Connect(function(player, amount)
		local profile = self.Profiles[player]
		if profile and typeof(player) == "Player" and typeof(amount) == "number" then
			self:AddCash(player, amount)
			print(player.Name, "added cash:", amount, "new total:", profile.Data.Cash)
		else
			-- TODO: Profile can't be found (fix)
			warn("Profile not found for", player)
		end
	end)

	return self
end

function DataManager:StartProfile(player)
	local profile = self.PlayerStore:StartSessionAsync(tostring(player.UserId), {
		Cancel = function()
			return player.Parent ~= Players
		end,
	})

	if profile then
		profile:AddUserId(player.UserId)
		profile:Reconcile()

		profile.OnSessionEnd:Connect(function()
			self.Profiles[player] = nil
			player:Kick("Profile session ended - Please rejoin")
		end)

		if player.Parent == Players then
			self.Profiles[player] = profile
			print("Profile loaded for", player.DisplayName)
			print("Cash:", profile.Data.Cash)
		else
			profile:EndSession()
		end
	else
		player:Kick("Profile load fail - Please rejoin")
	end
end

function DataManager:GetCash(player)
	local profile = self.Profiles[player]
	return profile and profile.Data.Cash or 0
end

function DataManager:SetCash(player, amount)
	local profile = self.Profiles[player]
	if profile then
		profile.Data.Cash = amount
	end
end

function DataManager:AddCash(player, amount)
	local profile = self.Profiles[player]
	if profile then
		profile.Data.Cash += amount
	end
end

function DataManager:SubtractCash(player, amount)
	local profile = self.Profiles[player]
	if profile then
		profile.Data.Cash -= amount
	end
end

return DataManager
