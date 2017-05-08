local Mod = _G.LobbyToolsMod

Hooks:Add("NetworkReceivedData", Mod.hooks.NetworkReceivedData, function(sender, id, data)
	if id == Mod.messages.do_action then
		local action 
		for _, action in pairs(Mod.actions) do
			if data == action.id then 
				local user_id = managers.network:session():peers()[sender]:user_id()
				if Mod:_is_my_friend(user_id) then
					Mod:do_action(action, sender)
				end
				break
			end
		end
	elseif id == Mod.messages.show_hint then
		if managers.hud and data ~= nil then managers.hud:show_hint({text = Mod:_localize(data)}) end
	end
end)