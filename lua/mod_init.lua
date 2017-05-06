_G.LobbyToolsMod = _G.LobbyToolsMod or {}
local Mod = _G.LobbyToolsMod

Mod._root_path 			= ModPath
Mod._localization_path 	= Mod._root_path .. "loc/"

Mod.actions = {
	force_ready						= {id = "215d6054-3383-4044-85c5-174b8f8cef0d", blocked = false},
	instant_restart					= {id = "e1ed66ba-d0c4-4ef5-95c3-38743938c4b5", blocked = false}
}

Mod.messages = {
	do_action						= "b1a7804d-6d0e-4a60-a034-4170287fa0e0",
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