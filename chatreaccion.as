void PluginInit(){
	g_Module.ScriptInfo.SetAuthor( "Angela Luna" );
	g_Module.ScriptInfo.SetContactInfo( "https://discord.gg/WrZJcRZvEZ" );
	
	g_Hooks.RegisterHook( Hooks::Player::ClientSay, @ClientSay );
	//g_Hooks.RegisterHook( Hooks::Player::ItemSpawned, @ItemSpawned );
	g_Hooks.RegisterHook( Hooks::Player::ClientSay, @ClientSay1 );
	g_Hooks.RegisterHook(Hooks::Player::ClientPutInServer, @ClientPutInServer);
	
}


// sonidos y sprites

const string sprite1 = "sprites/lul.spr";
const string sprite2 = "sprites/star.spr";
const string sprite3 = "sprites/lewd.spr";
const string sprite4 = "sprites/sweat.spr";
const string sprite5 = "sprites/f.spr";
const string gay_sprite = "sprites/rainbow.spr";
const string PutInServer = "sprites/hi.spr";
const string sound1 = "misc/tc/custom/go.mp3";
const string sound2 = "misc/tc/custom/ok.mp3";
const string sound3 = "misc/tc/custom/bye.mp3";
const string local = "server";

// Se debe guardar en precache
 
void MapInit() {
  g_Game.PrecacheGeneric('sound/' + sound1);
  g_Game.PrecacheGeneric('sound/' + sound2);
  g_Game.PrecacheGeneric('sound/' + sound3);
  g_Game.PrecacheGeneric(sprite1);
  g_Game.PrecacheGeneric(sprite2);
  g_Game.PrecacheGeneric(sprite3);
  g_Game.PrecacheGeneric(sprite4);
  g_Game.PrecacheGeneric(sprite5);
  g_Game.PrecacheGeneric(gay_sprite);
  g_Game.PrecacheGeneric(PutInServer);
  g_Game.PrecacheModel(sprite1);
  g_Game.PrecacheModel(sprite2);
  g_Game.PrecacheModel(sprite3);
  g_Game.PrecacheModel(sprite4);
  g_Game.PrecacheModel(sprite5);
  g_Game.PrecacheModel(gay_sprite);
  g_Game.PrecacheModel(PutInServer);


}
void sprite(CBasePlayer@  plr){
	
}
//Fraces y casos de fraces esta con letras de color naranja es un string


HookReturnCode ClientSay( SayParameters@ pParams){
	CBasePlayer@  plr = pParams.GetPlayer();
	const CCommand@ pArguments = pParams.GetArguments();
	CBasePlayer@ target;
	CBasePlayer@ pPlayer;
  	
	if( pArguments.ArgC() >= 1 )
	{
		if( pArguments[ 0 ] == ".LUL" || pArguments.Arg(0).ToLowercase() == ".lul" )
		{
			
			plr.ShowOverheadSprite(sprite1, 51.0f, 5.0f);	
		}
	}
	if( pArguments.ArgC() >= 1 )
	{
		if( pArguments[ 0 ] == ".star" || pArguments.Arg(0).ToLowercase() == ".STAR" )
		{
            plr.ShowOverheadSprite(sprite2, 51.0f, 5.0f);
			
		}
	}
	if( pArguments.ArgC() >= 1 )
	{
		if( pArguments[ 0 ] == ".lewd" || pArguments.Arg(0).ToLowercase() == ".LEWD" )
		{
            plr.ShowOverheadSprite(sprite3, 51.0f, 5.0f);
		}
	}
	if( pArguments.ArgC() >= 1 )
	{
		if( pArguments[ 0 ] == ".sweat" || pArguments.Arg(0).ToLowercase() == ".SWEAT" )
		{
            plr.ShowOverheadSprite(sprite4, 51.0f, 5.0f);
			
		}
	}
	if( pArguments.ArgC() >= 1 )
	{
		if( pArguments[ 0 ] == ".f" || pArguments.Arg(0).ToLowercase() == ".F" )
		{
            plr.ShowOverheadSprite(sprite5, 51.0f, 5.0f);

		}
	}
	if( pArguments.ArgC() >= 1 )
	{
		if( pArguments[ 0 ] == ".gay1" || pArguments.Arg(0).ToLowercase() == ".GAY1" )
		{
            plr.ShowOverheadSprite(gay_sprite, 51.0f, 5.0f);
		}
	}
	if( pArguments.ArgC() >= 1 )
	{
		if( pArguments[ 0 ] == ".hi" || pArguments.Arg(0).ToLowercase() == ".HI" )
		{
            plr.ShowOverheadSprite(PutInServer, 51.0f, 5.0f);
		}
	}
	if( pArguments.ArgC() >= 1 )
	{
		if( pArguments[ 0 ] == ".reaccionlist" || pArguments.Arg(0).ToLowercase() == ".REACCIONLIST" )
		{
			g_PlayerFuncs.ClientPrint(plr, HUD_PRINTCONSOLE, "------------------REACCIONES-------------------\n");
			g_PlayerFuncs.ClientPrint(plr, HUD_PRINTCONSOLE, " .lul | .star | .lewd | .sweat | .f | .gay | .hi\n");
			g_PlayerFuncs.ClientPrint(plr, HUD_PRINTCONSOLE, "-----------------------------------------------\n");
			NetworkMessage msg(MSG_ONE, NetworkMessages::SVC_STUFFTEXT, plr.edict());
						msg.WriteString("toggleconsole");
				msg.End();
		}
	}
	if( pArguments.ArgC() >= 1 )
	{
		if( pArguments[ 0 ] == "%stats%" || pArguments.Arg(0).ToLowercase() == "%Stats" )
		{
			plr.ShowOverheadSprite(local, 51.0f, 5.0f); // solo es un bug

		}


	}
	if( pArguments.ArgC() >= 1 )
	{
		if( pArguments[ 0 ] == "%argh%" || pArguments.Arg(0).ToLowercase() == "%Argh" )
		{
			plr.ShowOverheadSprite(local, 51.0f, 5.0f); // bug de sprite en espectador

		}


	}


	return HOOK_CONTINUE;
}

HookReturnCode ClientSay1( SayParameters@ pParams ){
	string str = pParams.GetCommand();
	const CCommand@ pArguments = pParams.GetArguments();
	str.ToUppercase();
	bool strTest = false;
	CBasePlayer@  pPlayer;
	


	strTest = (str.Find("PRUEBA2") != String::INVALID_INDEX);
	strTest = strTest;
	
	
	if (strTest) {
		g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[Server Scrit] This word is forbidden." );
		pParams.ShouldHide = true;
	}

	if (str == "PRUEBA2") {


		return HOOK_HANDLED;
	}

	return HOOK_CONTINUE;
}

HookReturnCode ClientPutInServer(CBasePlayer@ pPlayer) {

	pPlayer.ShowOverheadSprite(PutInServer, 51.0f, 7.0f);
	return HOOK_CONTINUE;

}



CClientCommand g_ReaccionList("ReaccionList", "Lista de reacciones", @ReaccionList, ConCommandFlag::AdminOnly);
CClientCommand _lul("lul", "Lista de reacciones", @g_sprite1, ConCommandFlag::AdminOnly);

void ReaccionList(const CCommand@ pArgs) {
  CBasePlayer@ pPlayer = g_ConCommandSystem.GetCurrentPlayer();

  g_PlayerFuncs.ClientPrint(pPlayer, HUD_PRINTCONSOLE, "------------------REACCIONES-------------------\n");
  g_PlayerFuncs.ClientPrint(pPlayer, HUD_PRINTCONSOLE, " .lul | .star | .lewd | .sweat | .f | .gay | .hi\n");
  g_PlayerFuncs.ClientPrint(pPlayer, HUD_PRINTCONSOLE, "-----------------------------------------------\n");
}

// cmd de sprites

void g_sprite1(const CCommand@ pArgs) {
	CBasePlayer@  plr;

	plr.ShowOverheadSprite(sprite1, 51.0f, 5.0f);	
}



string format_float(float f) {
	uint decimal = uint(((f - int(f)) * 10)) % 10;
	return "" + int(f) + "." + decimal;
	
}
void player_say(CBaseEntity@ plr, string msg){
	 NetworkMessage m(MSG_ALL, NetworkMessages::NetworkMessageType(74), null);
		 m.WriteByte(plr.entindex());
		 m.WriteByte(74); // tell the client to color the player name according to team
		 m.WriteString("" + plr.pev.netname + ": " + msg);
	 m.End();
}