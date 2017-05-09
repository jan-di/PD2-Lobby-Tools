local Mod = _G.LobbyToolsMod

function Mod:localize(localize_text)
	if managers.localization then return managers.localization:text(localize_text) end
end

function Mod:log(channel, data)
	if self.log_channel.level >= channel.level then
		local log_message = string.format("[%s][%s] %s", self.long_name, channel.prefix, data)
		log(log_message)
	end
end