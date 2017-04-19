local Mod = _G.LobbyToolsMod

Hooks:Add("NetworkReceivedData", Mod.hooks.NetworkReceivedData, function(sender, id, data)
	if id == Mod.messages.do_action then
		local user_id = managers.network:session():peers()[sender]:user_id()
		if Mod:_is_friend(user_id) then
			Mod:do_action(data, sender)
		end
	end
end)