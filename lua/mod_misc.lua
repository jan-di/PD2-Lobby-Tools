local Mod = _G.LobbyToolsMod

function Mod:localize(string_id)
	if managers.localization then 
		local localized_text = managers.localization:text(string_id)
		if localized_text == "ERROR: " .. string_id then
			self:log(self.channel.warning, string.format("Could not localize string '%s'", string_id))
			localized_text = "[" .. string_id .. "]"
		end
		return localized_text
	end
end

function Mod:log(channel, data)
	if self.log_channel.level >= channel.level then
		local log_message = string.format("[%s][%s] %s", self.long_name, channel.prefix, data)
		log(log_message)
	end
end