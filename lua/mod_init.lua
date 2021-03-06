_G.LobbyToolsMod = _G.LobbyToolsMod or {}
local Mod = _G.LobbyToolsMod

Mod.long_name	= "LobbyTools"
Mod.short_name	= "LT"
Mod.root_path 	= ModPath
Mod.loc_path 	= Mod.root_path .. "loc/"

Mod.channel = {
	info 		= {	level = 3, 	prefix = "Info"		},
	warning 	= {	level = 2, 	prefix = "Warning"	},
	error 		= {	level = 1, 	prefix = "Error"	}
}
Mod.log_channel = Mod.channel.info

Mod.actions = {
	force_ready						= {id = "215d6054-3383-4044-85c5-174b8f8cef0d", blocked = false},
	instant_restart					= {id = "e1ed66ba-d0c4-4ef5-95c3-38743938c4b5", blocked = false}
}

Mod.messages = {
	do_action						= "b1a7804d-6d0e-4a60-a034-4170287fa0e0",
	show_hint						= "60fa37df-1cf0-4d45-aa49-4e7ae8d691f6"
}

Mod.delayed_calls = {
	do_action 						= "cfe5fb99-e6b1-41c6-95fa-6f7506afc2de"
}

Mod.hooks = {
	LocalizationManagerPostInit		= "6894e37d-c15d-421e-985e-db6b85073296",
	NetworkReceivedData				= "0e1e0c5a-a07f-4412-acde-25f0614fc35c"
}

Mod.pre_hooks = {
	IngameWaitingForPlayersState = {
		start_game_intro 			= "ef96e408-544a-437d-85d1-1ea7d3c091db"
	}
}