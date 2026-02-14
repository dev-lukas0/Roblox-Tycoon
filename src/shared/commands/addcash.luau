return {
	Name = "addcash",
	Aliases = { "prt" },
	Description = "Print something",
	Group = "Admin",
	Args = {
		{
			Type = "player",
			Name = "Player",
			Description = "Player to add the cash to",
		},
		{
			Type = "number",
			Name = "Amount",
			Description = "Amount to add",
		},
	},
}
