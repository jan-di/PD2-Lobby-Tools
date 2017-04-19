local Mod = _G.LobbyToolsMod
local Net = _G.LuaNetworking

function Mod:send_action(action_id)
	if Network:is_server() then
		self:do_action(action_id, nil)
	else 
		Net:SendToPeer(1, self.messages.do_action, action_id)
	end
end

function Mod:check_action(action_id)
	local is_legit = false
	if action_id == self.actions.forceready and Utils:IsInGameState() and not Utils:IsInHeist() then
		is_legit = true
	elseif action_id == self.actions.instantrestart and Utils:IsInGameState() and Utils:IsInHeist() then
		is_legit = true
	end
	return is_legit
end

function Mod:do_action(action_id, peer_id)
	local chat_message, action, delay, execute_action
	execute_action = true
	if action_id == self.actions.forceready then
		local is_synched = true
		for _, peer in pairs(managers.network:session():peers()) do
			if not peer:synched() then
				chat_message = string.format(self:_localize("lobbytools_chat_forceready_not_synched"), peer:name())
				is_synched = false
			end
		end
		if is_synched then
			chat_message = self:_localize("lobbytools_chat_forceready")
			delay = 1
			action = function()
				game_state_machine:current_state():start_game_intro()
			end
		else 
			execute_action = false
		end
	elseif action_id == self.actions.instantrestart then
		chat_message = self:_localize("lobbytools_chat_instantrestart")
		delay = 1
		action = function()
			managers.game_play_central:restart_the_game()
		end
	end
	if peer_id ~= nil then 
		chat_message = string.format(self:_localize("lobbytools_chat_message_by_peer"), chat_message, Net:GetNameFromPeerID(peer_id))
	else
		chat_message = string.format(self:_localize("lobbytools_chat_message_by_host"), chat_message)
	end
	if managers.chat then managers.chat:send_message(ChatManager.GAME, managers.network.account:username(), chat_message) end
	if execute_action then DelayedCalls:Add(self.delayed_calls.do_action, delay, action) end
end

function Mod:_localize(localize_text)
	if managers.localization then 
		return managers.localization:text(localize_text)
	end
end

function Mod:_is_friend(user_id)
	local is_friend = false
	for _, friend in ipairs(Steam:friends() or {}) do
		log("friend:id = " .. friend:id())
		if friend:id() == user_id then
			is_friend = true
			break
		end
	end
	return is_friend
end
