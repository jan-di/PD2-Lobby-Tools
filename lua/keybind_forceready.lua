local Mod = _G.LobbyToolsMod

if Mod:check_action(Mod.actions.forceready) then
	Mod:send_action(Mod.actions.forceready)
end
