
CScheduledFunction@ realist_mode = null;
const string soundx3 = "misc/tc/x-3.mp3";
const string soundx2 = "misc/tc/x-2.mp3";
const string sound3_5 = "misc/tc/3-5.mp3";
const string sound3_4 = "misc/tc/3-4.mp3";
const string sound3_3 = "misc/tc/3-3.mp3";
const string sound3_2 = "misc/tc/3-2.mp3";
const string sound3_1 = "misc/tc/3-1.mp3";
const string sound_ent_Boss = "misc/tc/boos.mp3";

void PluginInit(){
	g_Module.ScriptInfo.SetAuthor( "Angela Luna" );
	g_Module.ScriptInfo.SetContactInfo( "https://discord.gg/vZDG886" );

	g_Hooks.RegisterHook(Hooks::Player::PlayerSpawn, @proteccion);
    g_Hooks.RegisterHook(Hooks::Game::MapChange, @ResetOrChangeMap);
	g_Hooks.RegisterHook( Hooks::Player::ClientSay, @voterealist);
}

const array<string> g_RemoveEnts = {'func_healthcharger', 'func_recharge', 'item_healthkit', 'item_armorvest', 'item_battery' };
CClientCommand g_realistOn("realiston", "Turn on Hard Mode (admin only)", @RealistMode);
CClientCommand g_realistOff("realistOff", "disamble (admin only)", @RealistModeoff);


void RealistMode(const CCommand@ pArgs) {
	CBasePlayer@ pCaller = g_ConCommandSystem.GetCurrentPlayer();
	
	if (g_PlayerFuncs.AdminLevel(pCaller) < ADMIN_YES)
	   g_PlayerFuncs.ClientPrint(pCaller, HUD_PRINTCONSOLE, "You have no access to this command.\n");
	else
	   @realist_mode = g_Scheduler.SetInterval("realist_interval", 5.0);
	   @realist_mode = g_Scheduler.SetInterval("player_heal", 0.15);
		
	   g_Hooks.RegisterHook(Hooks::Player::PlayerSpawn, @weapons);
	   player_weapon();
	   player_heal();
       CfgServerOn();
	   pCaller.RemoveAllItems(false);
	   p_weapons( EHandle( pCaller ), 0 );	
	   npcsheal();
	   for( int i = 0; i < g_Engine.maxEntities; ++i ) {
		CBaseEntity@ pEntity = g_EntityFuncs.Instance( i );
		if( pEntity is null ) continue;
		while((@pEntity = g_EntityFuncs.FindEntityByClassname(pEntity, "monster_*")) !is null){
			multiplySpeed(pEntity);
			multiplyMaxSpeed(pEntity);
		}
		/*
		const uint music = pArgs.ArgC() >= 1 ? atoi( pArgs.Arg( 1 ) ) : 0;
		if( music == 1 )
			//g_SoundSystem.PlaySound( pCaller.edict(), CHAN_VOICE, soundx3 , VOL_NORM, ATTN_STATIC, 0, PITCH_NORM, 0, true, g_vecZero );
		if( music == 2 )
			//g_SoundSystem.PlaySound( pCaller.edict(), CHAN_VOICE, soundx2, VOL_NORM, ATTN_STATIC, 0, PITCH_NORM, 0, true, g_vecZero );
		if( music == 3 )
			//g_SoundSystem.PlaySound( pCaller.edict(), CHAN_VOICE, sound3_5, VOL_NORM, ATTN_STATIC, 0, PITCH_NORM, 0, true, g_vecZero );
		if( music == 4 )
			//g_SoundSystem.PlaySound( pCaller.edict(), CHAN_VOICE, sound3_4, VOL_NORM, ATTN_STATIC, 0, PITCH_NORM, 0, true, g_vecZero );
		if( music == 5 )
			//g_SoundSystem.PlaySound( pCaller.edict(), CHAN_VOICE, sound3_3, VOL_NORM, ATTN_STATIC, 0, PITCH_NORM, 0, true, g_vecZero );
		if( music == 6 )
			//g_SoundSystem.PlaySound( pCaller.edict(), CHAN_VOICE, sound3_2, VOL_NORM, ATTN_STATIC, 0, PITCH_NORM, 0, true, g_vecZero );
		if( music == 7 )
			//g_SoundSystem.PlaySound( pCaller.edict(), CHAN_VOICE, sound3_1, VOL_NORM, ATTN_STATIC, 0, PITCH_NORM, 0, true, g_vecZero );
		*/
	}
	   
}


/*void MapInit() {
	
	g_Game.PrecacheGeneric( "sound/" + soundx3 );
	g_Game.PrecacheGeneric( "sound/" + soundx2 );
	g_Game.PrecacheGeneric( "sound/" + sound3_5 );
	g_Game.PrecacheGeneric( "sound/" + sound3_4 );
	g_Game.PrecacheGeneric( "sound/" + sound3_3 );
	g_Game.PrecacheGeneric( "sound/" + sound3_2 );
	g_Game.PrecacheGeneric( "sound/" + sound3_1 );
	g_Game.PrecacheGeneric( "sound/" + sound_ent_Boss );
	g_SoundSystem.PrecacheSound(soundx3);
	g_SoundSystem.PrecacheSound(soundx2);
	g_SoundSystem.PrecacheSound(sound3_5);
	g_SoundSystem.PrecacheSound(sound3_4);
	g_SoundSystem.PrecacheSound(sound3_3);
	g_SoundSystem.PrecacheSound(sound3_2);
	g_SoundSystem.PrecacheSound(sound3_1);
	g_SoundSystem.PrecacheSound(sound_ent_Boss);

	
}
*/

void RealistModeoff(const CCommand@ pArgs) {
	CBasePlayer@ pCaller = g_ConCommandSystem.GetCurrentPlayer();
	
	if (g_PlayerFuncs.AdminLevel(pCaller) < ADMIN_YES)
	   g_PlayerFuncs.ClientPrint(pCaller, HUD_PRINTCONSOLE, "You have no access to this command.\n");
	else
		g_Scheduler.RemoveTimer(realist_mode);
	    g_Hooks.RemoveHook(Hooks::Player::PlayerSpawn, @weapons);	
	    off_heal();
		npcshealoff();
		player_weapon_disable();
		CfgServerOff();
		//g_SoundSystem.StopSound(pCaller.edict(), CHAN_VOICE, soundx3, false);
		//g_SoundSystem.StopSound(pCaller.edict(), CHAN_VOICE, soundx2, false);
		//g_SoundSystem.StopSound(pCaller.edict(), CHAN_VOICE, sound3_5, false);
		//g_SoundSystem.StopSound(pCaller.edict(), CHAN_VOICE, sound3_4, false);
		//g_SoundSystem.StopSound(pCaller.edict(), CHAN_VOICE, sound3_3, false);
		//g_SoundSystem.StopSound(pCaller.edict(), CHAN_VOICE, sound3_2, false);
		//g_SoundSystem.StopSound(pCaller.edict(), CHAN_VOICE, sound3_1, false);
}

void off_heal(){
	for( int iPlayer = 1; iPlayer <= g_Engine.maxClients; ++iPlayer ){
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayer );

		if( pPlayer is null || !pPlayer.IsConnected() )
			continue;

		if(pPlayer.IsAlive()){
			if(pPlayer.pev.health > pPlayer.pev.max_health)
				pPlayer.pev.health = pPlayer.pev.max_health;

			if(pPlayer.pev.armorvalue > pPlayer.pev.armortype)
				pPlayer.pev.armorvalue = pPlayer.pev.armortype;
		}



	}

}

void CfgServerOn(){
	g_EngineFuncs.ServerCommand("mp_respawndelay 1\n");
	g_EngineFuncs.ServerCommand("mp_weapon_droprules 0 \n");
	g_EngineFuncs.ServerCommand("weaponmode_shotgun 1 \n"); 
	g_EngineFuncs.ServerCommand("weaponmode_9mmhandgun 1 \n"); 
	g_EngineFuncs.ServerCommand("weaponmode_displacer 1 \n"); 
	 
}


void CfgServerOff(){
	g_EngineFuncs.ServerCommand("mp_respawndelay 5 \n");
	g_EngineFuncs.ServerCommand("weaponmode_shotgun 0 \n"); 
	g_EngineFuncs.ServerCommand("weaponmode_9mmhandgun 0 \n"); 
	g_EngineFuncs.ServerCommand("weaponmode_displacer 0 \n"); 
}
HookReturnCode ResetOrChangeMap(){
	g_Hooks.RemoveHook(Hooks::Player::PlayerSpawn, @weapons);	

	g_Scheduler.RemoveTimer(realist_mode);
	    
		
	off_heal();
	player_weapon_disable();

	
	g_EngineFuncs.ServerCommand("mp_respawndelay 5 \n");
		
    return HOOK_HANDLED;
}

void realist_interval(){

	for( int i = 0; i < g_Engine.maxEntities; ++i ) {
		CBaseEntity@ pEntity = g_EntityFuncs.Instance( i );
		if( pEntity is null ) continue;
		while((@pEntity = g_EntityFuncs.FindEntityByClassname(pEntity, "monster_*")) !is null){
			multiplySpeed(pEntity);
			multiplyMaxSpeed(pEntity);
		}
	}
}



	


void multiplySpeed(CBaseEntity@ pEntity){
	CustomKeyvalues@ cKeyValues = pEntity.GetCustomKeyvalues();
	
	if(!cKeyValues.HasKeyvalue("$f_originalSpeed")){
		cKeyValues.SetKeyvalue("$f_originalSpeed", pEntity.pev.speed);
		pEntity.pev.speed = 4;
	}

	else{
		pEntity.pev.speed = cKeyValues.GetKeyvalue("$f_originalSpeed").GetFloat() * 4;
	}

}

void multiplyMaxSpeed(CBaseEntity@ pEntity){
	CustomKeyvalues@ cKeyValues = pEntity.GetCustomKeyvalues();
	
	if(!cKeyValues.HasKeyvalue("$f_originalMaxSpeed")){
		cKeyValues.SetKeyvalue("$f_originalMaxSpeed", pEntity.pev.maxspeed);
		pEntity.pev.maxspeed = 4;

	}

	else{
		pEntity.pev.maxspeed = cKeyValues.GetKeyvalue("$f_originalSpeed").GetFloat() * 4;
	}
}


CCVar cvarProtectDuration( "r_proteccion", 2.5f, "Duration of spawn invulnerability", ConCommandFlag::AdminOnly );

void SpawnProtection(EHandle hPlayer, const int iTakeDamageIn)
{
    if( !hPlayer )
        return;
    
    CBasePlayer@ pPlayer = cast<CBasePlayer@>( hPlayer.GetEntity() );
    pPlayer.pev.takedamage = float( iTakeDamageIn );

    if( iTakeDamageIn == 0 )
        g_Scheduler.SetTimeout( "SpawnProtection",cvarProtectDuration.GetFloat() , hPlayer, 1 );	
}

HookReturnCode proteccion(CBasePlayer@ pPlayer)
{   
	SpawnProtection( EHandle( pPlayer ), 0 );	
    return HOOK_CONTINUE;
}

HookReturnCode weapons(CBasePlayer@ pPlayer)
{   
	pPlayer.RemoveAllItems(false);
	p_weapons( EHandle( pPlayer ), 0 );	
	
    return HOOK_CONTINUE;
}

void p_weapons(EHandle hPlayer, const int weapon)
{
    if( !hPlayer )
        return;
      
    CBasePlayer@ pPlayer = cast<CBasePlayer@>( hPlayer.GetEntity() );
    float( weapon );

    if( weapon == 0 ){
        g_Scheduler.SetTimeout( "p_weapons", 0.5 , hPlayer, 1 );
        
    }
    if( weapon == 1 ){
		g_EntityFuncs.Create("weapon_9mmhandgun", pPlayer.GetOrigin() + Vector(0, 0, 0), Vector(0, 0, 0),  false).KeyValue("m_flCustomRespawnTime", "-1");
		pPlayer.GiveNamedItem("ammo_9mmAR", 0, 0);
		pPlayer.GiveNamedItem("ammo_9mmAR", 0, 0);
		pPlayer.GiveNamedItem("ammo_9mmAR", 0, 0);
		pPlayer.GiveNamedItem("ammo_9mmAR", 0, 0);
		pPlayer.GiveNamedItem("ammo_9mmAR", 0, 0);
		
    }
        
}


void player_heal(){

	CBaseEntity@ pEnt = null;

	for( int iPlayer = 1; iPlayer <= g_Engine.maxClients; ++iPlayer ){
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayer );

		if( pPlayer is null || !pPlayer.IsConnected() )
			continue;

		if(pPlayer.IsAlive()){

			if(pPlayer.pev.health > 0.0){
				pPlayer.pev.max_health = 1;
				pPlayer.pev.armortype = 0;

				pPlayer.pev.health += 1;
				pPlayer.pev.armorvalue += 0; 
			}

			if(pPlayer.pev.health > pPlayer.pev.max_health)
				pPlayer.pev.health = pPlayer.pev.max_health;

			if(pPlayer.pev.armorvalue > pPlayer.pev.armortype)
				pPlayer.pev.armorvalue = pPlayer.pev.armortype;
            
		}
	}
	for (uint i = 0; i < g_RemoveEnts.length(); ++i) {
		while( ( @pEnt = g_EntityFuncs.FindEntityByClassname( pEnt, g_RemoveEnts[i] ) ) !is null ) {
		   g_EntityFuncs.Remove(pEnt);
		}
	}
}


void player_weapon(){

	g_EngineFuncs.CVarSetFloat("sk_plr_9mm_bullet",100);
	g_EngineFuncs.CVarSetFloat("sk_plr_357_bullet",100);
	g_EngineFuncs.CVarSetFloat("sk_plr_9mmAR_bullet", 125);
	g_EngineFuncs.CVarSetFloat("sk_plr_9mmAR_grenade", 150);
	g_EngineFuncs.CVarSetFloat("sk_plr_buckshot", 225);
	g_EngineFuncs.CVarSetFloat("sk_plr_xbow_bolt_monster", 100);
	g_EngineFuncs.CVarSetFloat("sk_plr_rpg", 1000);
	g_EngineFuncs.CVarSetFloat("sk_plr_gauss", 50);
	g_EngineFuncs.CVarSetFloat("sk_plr_egon_narrow", 25);
	g_EngineFuncs.CVarSetFloat("sk_plr_egon_wide", 25);
	g_EngineFuncs.CVarSetFloat("sk_plr_hand_grenade", 150);
	g_EngineFuncs.CVarSetFloat("sk_plr_satchel", 350);
	g_EngineFuncs.CVarSetFloat("sk_plr_tripmine", 250);
	g_EngineFuncs.CVarSetFloat("sk_plr_wrench", 150);
	g_EngineFuncs.CVarSetFloat("sk_plr_grapple", 150);
	g_EngineFuncs.CVarSetFloat("sk_plr_uzi", 50);
	g_EngineFuncs.CVarSetFloat("sk_plr_secondarygauss", 500);
	g_EngineFuncs.CVarSetFloat("sk_plr_762_bullet", 150);
	g_EngineFuncs.CVarSetFloat("sk_plr_spore",250);
	g_EngineFuncs.CVarSetFloat("sk_plr_shockrifle", 50);
	g_EngineFuncs.CVarSetFloat("sk_plr_shockrifle_beam", 50);
	g_EngineFuncs.CVarSetFloat("sk_plr_displacer_other", 1000);
	g_EngineFuncs.CVarSetFloat("sk_plr_displacer_radius", 800);
}
void player_weapon_disable(){

	g_EngineFuncs.CVarSetFloat("sk_plr_9mm_bullet",8 );
	g_EngineFuncs.CVarSetFloat("sk_plr_357_bullet",40);
	g_EngineFuncs.CVarSetFloat("sk_plr_9mmAR_bullet", 8);
	g_EngineFuncs.CVarSetFloat("sk_plr_9mmAR_grenade", 100);
	g_EngineFuncs.CVarSetFloat("sk_plr_buckshot", 7);
	g_EngineFuncs.CVarSetFloat("sk_plr_xbow_bolt_monster", 60);
	g_EngineFuncs.CVarSetFloat("sk_plr_rpg", 150);
	g_EngineFuncs.CVarSetFloat("sk_plr_gauss", 15);
	g_EngineFuncs.CVarSetFloat("sk_plr_egon_narrow", 10);
	g_EngineFuncs.CVarSetFloat("sk_plr_egon_wide", 12);
	g_EngineFuncs.CVarSetFloat("sk_plr_hand_grenade", 100);
	g_EngineFuncs.CVarSetFloat("sk_plr_satchel", 160);
	g_EngineFuncs.CVarSetFloat("sk_plr_tripmine", 150);
	g_EngineFuncs.CVarSetFloat("sk_plr_wrench", 22);
	g_EngineFuncs.CVarSetFloat("sk_plr_grapple", 40);
	g_EngineFuncs.CVarSetFloat("sk_plr_uzi", 8);
	g_EngineFuncs.CVarSetFloat("sk_plr_secondarygauss", 190);
	g_EngineFuncs.CVarSetFloat("sk_plr_762_bullet", 110);
	g_EngineFuncs.CVarSetFloat("sk_plr_spore",100);
	g_EngineFuncs.CVarSetFloat("sk_plr_shockrifle", 15);
	g_EngineFuncs.CVarSetFloat("sk_plr_shockrifle_beam", 2);
	g_EngineFuncs.CVarSetFloat("sk_plr_displacer_other", 250);
	g_EngineFuncs.CVarSetFloat("sk_plr_displacer_radius", 300);
}


void npcsheal(){

	
	for( int i = 3; i < g_Engine.maxEntities; ++i ) {
		CBaseEntity@ ent = g_EntityFuncs.Instance( i );
		if( ent !is null ) {
			if( ent.pev.health <= 0.0 || ent.pev.health >= 10000.0 || ent.Classify() == CLASS_PLAYER_ALLY ) continue;
            
			
			if ( ent.pev.classname == "monster_alien_babyvoltigore" ){		
				ent.pev.health = 800;
			}else if ( ent.pev.classname == "monster_alien_controller" ){		
				ent.pev.health = 100;
			}else if ( ent.pev.classname == "monster_alien_grunt" ){			
				ent.pev.health = 500;
			}else if ( ent.pev.classname == "monster_alien_slave" ){	
				ent.pev.health = 100;
			}else if ( ent.pev.classname == "monster_alien_tor" ){
				ent.pev.health = 25000;
			}else if ( ent.pev.classname == "monster_alien_voltigore" ){
				
				
				ent.pev.health = 15000;
			}else if ( ent.pev.classname == "monster_apache" ){
				
				
				ent.pev.health = 1500;
			}else if ( ent.pev.classname == "monster_babycrab" ){
				
				
				ent.pev.health = 100;
			}else if ( ent.pev.classname == "monster_barnacle" ){
				
				
				ent.pev.health = 5;
			}else if ( ent.pev.classname == "monster_barney" ){
				
				
				ent.pev.health = 7;
				//g_EntityFuncs.DispatchKeyValue( ent.edict(), "displayname", "xdddd" );
			}else if ( ent.pev.classname == "monster_bigmomma" ){
				
				
				ent.pev.health = 12000;
			}else if ( ent.pev.classname == "monster_blkop_osprey" ){
				
				
				ent.pev.health = 12000;
			}else if ( ent.pev.classname == "monster_blkop_apache" ){
				
				
				ent.pev.health = 1500;
			}else if ( ent.pev.classname == "monster_bodyguard" ){
				
				
				ent.pev.health = 100;
			}else if ( ent.pev.classname == "monster_bullchicken" ){
				
				
				ent.pev.health = 400;
			}else if ( ent.pev.classname == "monster_chumtoad" ){
				
				
				ent.pev.health = 100;
			}else if ( ent.pev.classname == "monster_cleansuit_scientist" ){
				
				
				ent.pev.health = 43;
			}else if ( ent.pev.classname == "monster_gargantua" ){
				
				
				ent.pev.health = 2000;
			}else if ( ent.pev.classname == "monster_gonome" ){
				
				
				ent.pev.health = 500;
			}else if ( ent.pev.classname == "monster_headcrab" ){
				
				
				ent.pev.health = 200;
				g_EntityFuncs.DispatchKeyValue( ent.edict(), "displayname", "Headcrab vidoso" );
			}else if ( ent.pev.classname == "monster_houndeye" ){
				
				
				ent.pev.health = 200;
			}else if ( ent.pev.classname == "monster_human_assassin" ){
				ent.pev.speed = 4;
				ent.pev.maxspeed = 4;
				
				ent.pev.health = 100;
			}else if ( ent.pev.classname == "monster_human_grunt" ){
				ent.pev.speed = 4;
				ent.pev.maxspeed = 4;
				
				ent.pev.health = 100;
			}else if ( ent.pev.classname == "monster_human_grunt_ally" ){
				
				
				ent.pev.health = 200;
			}else if ( ent.pev.classname == "monster_human_medic_ally" ){
				
				
				ent.pev.health = 200;
			}else if ( ent.pev.classname == "monster_human_torch_ally" ){
				
				
				ent.pev.health = 300;
			}else if ( ent.pev.classname == "monster_hwgrunt" ){
				
				
				ent.pev.health = 800;
			}else if ( ent.pev.classname == "monster_ichthyosaur" ){
				
				
				ent.pev.health = 400;
				
			}else if ( ent.pev.classname == "monster_kingpin" ){
				
				
				ent.pev.health = 3200;
			}else if ( ent.pev.classname == "monster_leech" ){
				
				
				g_EntityFuncs.DispatchKeyValue( ent.edict(), "displayname", "farm" );
			}else if ( ent.pev.classname == "monster_male_assassin" ){
				
				
				ent.pev.health = 200;
			}else if ( ent.pev.classname == "monster_miniturret" ){
				
				
				ent.pev.health = 120;
			}else if ( ent.pev.classname == "monster_nihilanth" ){
				
				
				ent.pev.health = 40000;
			}else if ( ent.pev.classname == "monster_osprey" ){
				
				
				ent.pev.health = 12000;
			}else if ( ent.pev.classname == "monster_otis" ){
				
				
				ent.pev.health = 300;
			}else if ( ent.pev.classname == "monster_pitdrone" ){
				
				
				ent.pev.health = 500;
			}else if ( ent.pev.classname == "monster_robogrunt" ){
				
				
				ent.pev.health = 800;
			}else if ( ent.pev.classname == "monster_scientist" ){
				
				
				ent.pev.health = 100;
			}else if ( ent.pev.classname == "monster_sentry" ){
				
				
				ent.pev.health = 520;
			}else if ( ent.pev.classname == "monster_shockroach" ){
				
				
				ent.pev.health = 400;
			}else if ( ent.pev.classname == "monster_shocktrooper" ){
				
				
				ent.pev.health = 200;
			}else if ( ent.pev.classname == "monster_snark" ){
				ent.pev.health = 10;
			}else if ( ent.pev.classname == "monster_sqknest" ){
				
				
				ent.pev.health = 500;
			}else if ( ent.pev.classname == "monster_stukabat" ){
				
				
				ent.pev.health = 1000;
			}else if ( ent.pev.classname == "monster_tentacle" ){
				
				
				ent.pev.health = 1200;
			}else if ( ent.pev.classname == "monster_turret" ){
				ent.pev.health = 500;
			}else if ( ent.pev.classname == "monster_zombie" ){
				ent.pev.health = 700;
			}else if ( ent.pev.classname == "monster_zombie_barney" ){
				ent.pev.health = 700;
			}else if ( ent.pev.classname == "monster_zombie_soldier" ){
				ent.pev.health = 1000;
			}
		}
	}
	
}

void npcshealoff(){

	
	for( int i = 3; i < g_Engine.maxEntities; ++i ) {
		CBaseEntity@ ent = g_EntityFuncs.Instance( i );
		if( ent !is null ) {
			if( ent.pev.health <= 0.0 || ent.pev.health >= 10000.0 || ent.Classify() == CLASS_PLAYER_ALLY ) continue;
            
			
			if ( ent.pev.classname == "monster_alien_babyvoltigore" ){		
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_alien_controller" ){		
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_alien_grunt" ){			
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_alien_slave" ){	
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_alien_tor" ){
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_alien_voltigore" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_apache" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_babycrab" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_barnacle" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_barney" ){
				
				
				ent.pev.health = ent.pev.health;
				//g_EntityFuncs.DispatchKeyValue( ent.edict(), "displayname", "xdddd" );
			}else if ( ent.pev.classname == "monster_bigmomma" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_blkop_osprey" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_blkop_apache" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_bodyguard" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_bullchicken" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_chumtoad" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_cleansuit_scientist" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_gargantua" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_gonome" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_headcrab" ){
				
				
				ent.pev.health = ent.pev.health;
				g_EntityFuncs.DispatchKeyValue( ent.edict(), "displayname", "Headcrab vidoso" );
			}else if ( ent.pev.classname == "monster_houndeye" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_human_assassin" ){
				ent.pev.speed = 4;
				ent.pev.maxspeed = 4;
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_human_grunt" ){
				ent.pev.speed = 4;
				ent.pev.maxspeed = 4;
				
				ent.pev.health = 100;
			}else if ( ent.pev.classname == "monster_human_grunt_ally" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_human_medic_ally" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_human_torch_ally" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_hwgrunt" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_ichthyosaur" ){
				
				
				ent.pev.health = ent.pev.health;
				
			}else if ( ent.pev.classname == "monster_kingpin" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_leech" ){
				
				
				g_EntityFuncs.DispatchKeyValue( ent.edict(), "displayname", "farm" );
			}else if ( ent.pev.classname == "monster_male_assassin" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_miniturret" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_nihilanth" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_osprey" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_otis" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_pitdrone" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_robogrunt" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_scientist" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_sentry" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_shockroach" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_shocktrooper" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_snark" ){
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_sqknest" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_stukabat" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_tentacle" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_turret" ){
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_zombie" ){
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_zombie_barney" ){
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_zombie_soldier" ){
				ent.pev.health = ent.pev.health;
			}
		}
	}
	
}

HookReturnCode voterealist( SayParameters@ pParams ){
    const CCommand@ pArguments = pParams.GetArguments();

    if ( pArguments.ArgC() >= 1 && pArguments.Arg(0).ToLowercase() == "voterealist" )
    {
        Vote@ ABCVote = Vote( 'ABC', 'Modo realista?', 15.0f, 600.0f );

        ABCVote.SetYesText( 'Sip :-)');
        ABCVote.SetNoText( 'No :-<' );
        ABCVote.SetVoteBlockedCallback( @ABCVoteBlocked );
        ABCVote.SetVoteEndCallback( @ABCVoteEnd );
        ABCVote.Start();

        return HOOK_CONTINUE;
    }
    return HOOK_CONTINUE;
}

void ABCVoteEnd( Vote@ pVote, bool fResult, int iVoters )
{
    if ( fResult ){
        g_PlayerFuncs.ClientPrintAll(HUD_PRINTTALK, "Modo realista activado!\n");
		RealistVote();

    }
    else
    {
        g_PlayerFuncs.ClientPrintAll(HUD_PRINTTALK, "No se obtuvo lo requerido\n");
    }
}

void ABCVoteBlocked(Vote@ pVote, float flTime)
{
    // another vote may be currently active
    g_PlayerFuncs.ClientPrintAll(HUD_PRINTTALK, "[Info] todavia no se puede votar :(.\n");
}

void RealistVote(){
	CBasePlayer@ pCaller = g_ConCommandSystem.GetCurrentPlayer();
	
	@realist_mode = g_Scheduler.SetInterval("realist_interval", 5.0);
	@realist_mode = g_Scheduler.SetInterval("player_heal", 0.15);

	player_weapon();
	player_heal();
    CfgServerOn();
	g_Hooks.RegisterHook(Hooks::Player::PlayerSpawn, @weapons);
	pCaller.RemoveAllItems(false);
	p_weapons( EHandle( pCaller ), 0 );	
	npcsheal();
	for( int i = 0; i < g_Engine.maxEntities; ++i ) {
		CBaseEntity@ pEntity = g_EntityFuncs.Instance( i );
		if( pEntity is null ) continue;
		while((@pEntity = g_EntityFuncs.FindEntityByClassname(pEntity, "monster_*")) !is null){
			multiplySpeed(pEntity);
			multiplyMaxSpeed(pEntity);
		}
	}

}

void random_music(){

}