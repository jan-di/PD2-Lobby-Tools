local Mod = _G.LobbyToolsMod

Hooks:Add("LocalizationManagerPostInit", Mod.hooks.LocalizationManagerPostInit, function(loc)
	for _, filename in pairs(file.GetFiles(Mod._localization_path)) do
		local str = filename:match('^(.*).json$')
		if str and Idstring(str) and Idstring(str):key() == SystemInfo:language():key() then
			loc:load_localization_file(Mod._localization_path .. filename)
			break
		end
	end

	loc:load_localization_file(Mod._localization_path .. "english.json", false)
end)