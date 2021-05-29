void PluginInit() {
  g_Module.ScriptInfo.SetAuthor("Angela Luna");
  g_Module.ScriptInfo.SetContactInfo("https://discord.gg/WrZJcRZvEZ");

  g_Hooks.RegisterHook(Hooks::Player::ClientSay, @discord);
}


HookReturnCode discord( SayParameters@ pParams){
	CBasePlayer@  pPlayer = pParams.GetPlayer();
	const CCommand@ pArguments = pParams.GetArguments();
  	
	if( pArguments.ArgC() >= 1 )
	{
		if( pArguments[ 0 ] == "/discord" || pArguments.Arg(0).ToLowercase() == "/DISCORD" || pArguments.Arg(0).ToLowercase() == "!DISCORD" || pArguments.Arg(0).ToLowercase() == "!discord" ){
            
            
            g_PlayerFuncs.ClientPrint(  pPlayer, HUD_PRINTTALK, "---------------------------------------------------------------------- \n");
            g_PlayerFuncs.ClientPrint(  pPlayer, HUD_PRINTTALK, " \n");
            g_PlayerFuncs.ClientPrint(  pPlayer, HUD_PRINTTALK, "Link de nuestro discord: \n");
            g_PlayerFuncs.ClientPrint(  pPlayer, HUD_PRINTTALK, "https://discord.gg/WrZJcRZvEZ \n"); // solo es un ejemplo
            g_PlayerFuncs.ClientPrint(  pPlayer, HUD_PRINTTALK, " \n");
  			g_PlayerFuncs.ClientPrint(  pPlayer, HUD_PRINTTALK, "---------------------------------------------------------------------- \n");
                          
              NetworkMessage msg(MSG_ONE, NetworkMessages::SVC_STUFFTEXT, pPlayer.edict()); //esto es para abrir consola automaticamente
   				         msg.WriteString("toggleconsole");
 			       msg.End();
		}
	}



	return HOOK_CONTINUE;
}

