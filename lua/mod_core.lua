local Mod = _G.LobbyToolsMod
local Net = _G.LuaNetworking

function Mod:request_action(action)
	if not self:check_action(action) then return false end
	
	if Network:is_server() then
		self:do_action(action, nil)
	else 
		Net:SendToPeer(1, self.messages.do_action, action.id)
	end
end

function Mod:check_action(action)
	if action.blocked then return false end
	
	if action.id == self.actions.force_ready.id and Utils:IsInGameState() and not Utils:IsInHeist() then 
		return true
	elseif action.id == self.actions.instant_restart.id and Utils:IsInGameState() and Utils:IsInHeist() then 
		return true 
	end
	
	return false
end

function Mod:do_action(action, peer_id)
	local chat_message, hint_id, execute_action, action_code, action_delay
	if peer_id ~= nil and not self:check_action(action) then return false end
	execute_action = true
	
	if action.id == self.actions.force_ready.id then
		local is_synched = true
		for _, peer in pairs(managers.network:session():peers()) do
			if not peer:synched() then
				chat_message = string.format(self:_localize("lobbytools_chat_forceready_notsynched"), peer:name())
				is_synched = false
			end
		end
		if is_synched then
			chat_message = self:_localize("lobbytools_chat_forceready")
			action_delay = 1
			action_code = function()
				game_state_machine:current_state():start_game_intro()
			end
		else 
			execute_action = false
		end
	elseif action.id == self.actions.instant_restart.id then
		chat_message = self:_localize("lobbytools_chat_instantrestart")
		hint_id = "lobbytools_hint_instantrestart"
		action_delay = 1
		action_code = function()
			managers.game_play_central:restart_the_game()
		end
	end

	if peer_id ~= nil then 
		chat_message = string.format(self:_localize("lobbytools_chat_message_by_peer"), chat_message, Net:GetNameFromPeerID(peer_id))
	else
		chat_message = string.format(self:_localize("lobbytools_chat_message_by_host"), chat_message)
	end
	
	if hint_id ~= nil then
		Net:SendToPeers(self.messages.show_hint, hint_id)
		if managers.hud then managers.hud:show_hint({text = self:_localize(hint_id)}) end
	end
	
	if managers.chat then managers.chat:send_message(ChatManager.GAME, managers.network.account:username(), chat_message) end
	
	if execute_action then 
		action.blocked = true
		DelayedCalls:Add(self.delayed_calls.do_action, action_delay, action_code) 
	end
end

function Mod:_localize(localize_text)
	if managers.localization then return managers.localization:text(localize_text) end
end

function Mod:_is_my_friend(user_id)
	for _, friend in ipairs(Steam:friends() or {}) do
		if friend:id() == user_id then return true end
	end
	
	return false
end
