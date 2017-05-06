local Mod = _G.LobbyToolsMod

Hooks:PreHook(IngameWaitingForPlayersState, "start_game_intro", Mod.pre_hooks.IngameWaitingForPlayersState.start_game_intro, function()
	Mod.actions.force_ready.blocked = true
end )