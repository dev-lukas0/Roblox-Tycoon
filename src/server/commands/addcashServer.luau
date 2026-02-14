return function(context, player: Player, amount: number)
	local Event: BindableEvent = game.ReplicatedStorage:WaitForChild("Events"):WaitForChild("Cash")
	Event:Fire(player, amount)

	return "Added " .. amount
end
