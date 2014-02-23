E_SELECTIONPOINT_LEFT  = 0
E_SELECTIONPOINT_RIGHT = 1

E_DIRECTION_NORTH1 = 0
E_DIRECTION_NORTH2 = 4
E_DIRECTION_EAST = 1
E_DIRECTION_SOUTH = 2
E_DIRECTION_WEST = 3

PLUGIN = nil

function Initialize(Plugin)
	-- Load the InfoReg shared library:
	dofile(cPluginManager:GetPluginsPath() .. "/InfoReg.lua")
	
	PLUGIN = Plugin
	PLUGIN:SetName(g_PluginInfo.Name)
	PLUGIN:SetVersion(g_PluginInfo.Version)
		
	cPluginManager.AddHook(cPluginManager.HOOK_PLAYER_BREAKING_BLOCK, SelectFirstPointHook);
	
	cPluginManager.AddHook(cPluginManager.HOOK_PLAYER_RIGHT_CLICK,    SelectSecondPointHook);
	cPluginManager.AddHook(cPluginManager.HOOK_PLAYER_RIGHT_CLICK,    RightClickCompassHook);
	cPluginManager.AddHook(cPluginManager.HOOK_PLAYER_RIGHT_CLICK,    ToolsHook);
	
	cPluginManager.AddHook(cPluginManager.HOOK_PLAYER_LEFT_CLICK,     LeftClickCompassHook);
	cPluginManager.AddHook(cPluginManager.HOOK_PLAYER_LEFT_CLICK,     SuperPickaxeHook);
	cPluginManager.AddHook(cPluginManager.HOOK_PLAYER_JOINED,         OnPlayerJoined);
	cPluginManager.AddHook(cPluginManager.HOOK_PLAYER_ANIMATION,      OnPlayerAnimation);
	
	cPluginManager:AddHook(cPluginManager.HOOK_PLUGIN_MESSAGE,        OnPluginMessage);
	
	--Bind all the commands:
	RegisterPluginInfoCommands();
	
	CreateTables() -- create all the tables
	LoadOnlinePlayers() -- Load all the online players
	LoadSettings(PLUGIN:GetLocalDirectory() .. "/Config.ini") -- load all the settings
	
	cFile:CreateFolder("Schematics")
	
	LOG("[WorldEdit] Enabling WorldEdit v" .. PLUGIN:GetVersion())
	return true
end





function OnDisable()
	if (DisablePlugin) then -- if the plugin has to be reloaded then load the plugin again ;)
		LOGINFO("Worldedit is reloading")
		PluginManager:LoadPlugin(PLUGIN:GetName())
	else
		LOG("[WorldEdit] Disabling WorldEdit v" .. PLUGIN:GetVersion())
	end
end
