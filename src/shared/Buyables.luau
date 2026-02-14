local buyables = {
	{ Part = workspace:FindFirstChild("Buy"), Price = 100 },
}

local playerPurchases = {}

function getNextBuyable(player)
	playerPurchases[player.UserId] = playerPurchases[player.UserId] or {}
	for i, item in ipairs(buyables) do
		if not playerPurchases[player.UserId][i] then
			return item
		end
	end
	return nil
end

return getNextBuyable
