local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local cmdr = require(ReplicatedStorage.Packages.cmdr)

cmdr:RegisterDefaultCommands()
cmdr:RegisterCommand(ReplicatedStorage.Shared.commands.testcmd, ServerScriptService.Server.commands.testcmdServer)
