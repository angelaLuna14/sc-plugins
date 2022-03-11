
int heal_player = 100;

int armor_player = 100;

CScheduledFunction@ g_cvar;
CScheduledFunction@ heal_pplayer;

void PluginInit()
{
	g_Module.ScriptInfo.SetAuthor( "Angela Luna" );
	g_Module.ScriptInfo.SetContactInfo( "ya no xd" );


	g_PlayerDiffData_LastIsAlive.resize( g_Engine.maxClients );
	
	
	for( int iPlayer = 0; iPlayer < g_Engine.maxClients; ++iPlayer ){
		g_PlayerDiffData_LastIsAlive[ iPlayer ] = true;
	}

	@g_cvar = g_Scheduler.SetInterval("heal", 0.2);
}


CClientCommand g_health( "server_health", "Spawn any entity where you point", @cvar_heal, ConCommandFlag::AdminOnly );
CClientCommand g_armor( "server_armor", "Spawn any entity where you point", @cvar_armor, ConCommandFlag::AdminOnly );
CClientCommand effects_off( "server_off", "Spawn any entity where you point", @cvar_off, ConCommandFlag::AdminOnly );
CClientCommand refresh( "g_refresh", "Spawn any entity where you point", @g_refresh, ConCommandFlag::AdminOnly );

void g_refresh(const CCommand@ args )
{
	CBasePlayer@ pPlayer;

	for( int iPlayer = 1; iPlayer <= g_Engine.maxClients; ++iPlayer )
	{
		@pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayer );

		if( pPlayer is null || !pPlayer.IsConnected() )
			continue;

		if(pPlayer.IsAlive())
		{
			pPlayer.pev.health = pPlayer.pev.max_health;
			pPlayer.pev.armorvalue = pPlayer.pev.armortype;
		}
	}

}


void cvar_off(const CCommand@ args )
{

	g_Scheduler.RemoveTimer(g_cvar);
	heal_player = 100;
	armor_player = 100;

	CBasePlayer@ pPlayer;

	for( int iPlayer = 1; iPlayer <= g_Engine.maxClients; ++iPlayer )
	{
		@pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayer );

		if( pPlayer is null || !pPlayer.IsConnected() )
			continue;

		if(pPlayer.IsAlive())
		{
			pPlayer.pev.health = pPlayer.pev.max_health;
			pPlayer.pev.armorvalue = pPlayer.pev.armortype;
		}
	}
}



void cvar_heal(const CCommand@ args )
{

	const uint int_heal = args.ArgC() >= 1 ? atoi( args.Arg( 1 ) ) : 0;
	heal_player = int_heal;


	
}

void cvar_armor(const CCommand@ args )
{

	const uint int_armor = args.ArgC() >= 1 ? atoi( args.Arg( 1 ) ) : 0;
	armor_player = int_armor;
	const string a_Off = args.Arg( 1 );
	




}


void heal()
{

	CBasePlayer@ pPlayer;

	for( int iPlayer = 1; iPlayer <= g_Engine.maxClients; ++iPlayer )
	{
		@pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayer );

		if( pPlayer is null || !pPlayer.IsConnected() )
			continue;

		if(pPlayer.IsAlive())
		{

			if(pPlayer.pev.health > 0.0){
				pPlayer.pev.max_health = heal_player;
				pPlayer.pev.armortype = armor_player;
			}

			if(pPlayer.pev.health > pPlayer.pev.max_health)
				pPlayer.pev.health = pPlayer.pev.max_health;

			if(pPlayer.pev.armorvalue > pPlayer.pev.armortype)
				pPlayer.pev.armorvalue = pPlayer.pev.armortype;
				

			g_PlayerDiffData_LastIsAlive[ iPlayer-1 ] = true;
		}else
		{
			if(g_PlayerDiffData_LastIsAlive[ iPlayer-1 ]){
				g_PlayerDiffData_LastIsAlive[ iPlayer-1 ] = false;
					
			}
		}

	}
}

array<bool> g_PlayerDiffData_LastIsAlive;