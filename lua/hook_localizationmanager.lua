local Mod = _G.LobbyToolsMod

Hooks:Add("LocalizationManagerPostInit", Mod.hooks.LocalizationManagerPostInit, function(loc)
	local load_default_language = true
	local load_language_file = function(path, file, default)
		loc:load_localization_file(path .. file)
		Mod:log(Mod.channel.info, string.format("Loaded language file '%s' %s", file, default and "(Default)" or ""))
	end

	for _, filename in pairs(file.GetFiles(Mod.loc_path)) do
		local str = filename:match('^(.*).json$')
		if str and Idstring(str) and Idstring(str):key() == SystemInfo:language():key() then
			load_default_language = false
			load_language_file(Mod.loc_path, filename, load_default_language)
			break
		end
	end
	
	if load_default_language then load_language_file(Mod.loc_path, "english.json", load_default_language) end
end)