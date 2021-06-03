void PluginInit(){
	g_Module.ScriptInfo.SetAuthor( "Angela Luna" );
	g_Module.ScriptInfo.SetContactInfo( "https://discord.gg/WrZJcRZvEZ" );
	
    //no esta terminado, puede haber muchos bugs
	
}




void MapInit(){

    @ents::g_entity = g_Scheduler.SetInterval( "EditNpcsNames", 0.2 );
}



namespace ents{

    CScheduledFunction@ g_entity = null;
    void EditNpcsNames(){
        for( int i = 3; i < g_Engine.maxEntities; ++i ) {
            CBaseEntity@ ent = g_EntityFuncs.Instance( i );
            
            if( ent !is null ) {
                

                if ( ent.pev.classname == "monster_alien_babyvoltigore" ){
                    g_EntityFuncs.DispatchKeyValue( ent.edict(), "displayname", "bebe voltigore" );
                    

                }else if ( ent.pev.classname == "monster_alien_controller" ){

                    g_EntityFuncs.DispatchKeyValue( ent.edict(), "displayname", "alien controlador" );                    

                }else if ( ent.pev.classname == "monster_alien_grunt" ){
                
                    g_EntityFuncs.DispatchKeyValue( ent.edict(), "displayname", "Solado alien" );

                }else if ( ent.pev.classname == "monster_alien_slave" ){
                    
                    g_EntityFuncs.DispatchKeyValue( ent.edict(), "displayname", "esclavo alien" );

                }else if ( ent.pev.classname == "monster_alien_tor" ){
                    
                    g_EntityFuncs.DispatchKeyValue( ent.edict(), "displayname", "Lord tor" );

                }else if ( ent.pev.classname == "monster_alien_voltigore" ){
                    
                    g_EntityFuncs.DispatchKeyValue( ent.edict(), "displayname", "Voltigore" );

                }else if ( ent.pev.classname == "monster_apache" ){

                    g_EntityFuncs.DispatchKeyValue( ent.edict(), "displayname", "helicoptero" );

                }else if ( ent.pev.classname == "monster_assassin_repel" ){
                    

                }else if ( ent.pev.classname == "monster_babycrab" ){
                
                    g_EntityFuncs.DispatchKeyValue( ent.edict(), "displayname", "Bebe Headcrab" );

                }else if ( ent.pev.classname == "monster_babygarg" ){
                    
                    g_EntityFuncs.DispatchKeyValue( ent.edict(), "displayname", "Bebe Gargantua" );

                }else if ( ent.pev.classname == "monster_barnacle" ){
                    
                    g_EntityFuncs.DispatchKeyValue( ent.edict(), "displayname", "percebe" );

                }else if ( ent.pev.classname == "monster_barney" ){
                    
                    g_EntityFuncs.DispatchKeyValue( ent.edict(), "displayname", "serenazgo" );

                }else if ( ent.pev.classname == "monster_barney_dead" ){
                
                    

                }else if ( ent.pev.classname == "monster_bigmomma" ){
                    
                    g_EntityFuncs.DispatchKeyValue( ent.edict(), "displayname", "Gran madre" );

                }else if ( ent.pev.classname == "monster_blkop_osprey" ){
                    
                    

                }else if ( ent.pev.classname == "monster_blkop_apache" ){
                    
                }else if ( ent.pev.classname == "monster_bloater" ){
                    
                }else if ( ent.pev.classname == "monster_bodyguard" ){

                    g_EntityFuncs.DispatchKeyValue( ent.edict(), "displayname", "Guardaespaldas" );
                    
                }else if ( ent.pev.classname == "monster_bullchicken" ){

                    g_EntityFuncs.DispatchKeyValue( ent.edict(), "displayname", "Pollo toro" );
                    
                }else if ( ent.pev.classname == "monster_chumtoad" ){
                    
                }else if ( ent.pev.classname == "monster_cleansuit_scientist" ){
                    
                    g_EntityFuncs.DispatchKeyValue( ent.edict(), "displayname", "Científico de traje de limpieza" );

                }else if ( ent.pev.classname == "monster_cockroach" ){
                    
                }else if ( ent.pev.classname == "monster_flyer_flock" ){
                    
                }else if ( ent.pev.classname == "monster_furniture" ){
                    
                }else if ( ent.pev.classname == "monster_gargantua" ){
                    ent.pev.health = (16);
                }else if ( ent.pev.classname == "monster_generic" ){
                    
                }else if ( ent.pev.classname == "monster_gman" ){
                    
                }else if ( ent.pev.classname == "monster_gonome" ){
                    ent.pev.health = (103);
                }else if ( ent.pev.classname == "monster_grunt_ally_repel" ){
                    
                }else if ( ent.pev.classname == "monster_grunt_repel" ){
                    
                }else if ( ent.pev.classname == "monster_handgrenade" ){
                    
                    g_EntityFuncs.DispatchKeyValue( ent.edict(), "displayname", "handgrenade" );

                }else if ( ent.pev.classname == "monster_headcrab" ){

                    g_EntityFuncs.DispatchKeyValue( ent.edict(), "displayname", "Headcrab 2.0" );

                }else if ( ent.pev.classname == "monster_hevsuit_dead" ){
                    
                }else if ( ent.pev.classname == "monster_hgrunt_dead" ){
                    
                }else if ( ent.pev.classname == "monster_houndeye" ){
                    ent.pev.health = (27);
                }else if ( ent.pev.classname == "monster_human_assassin" ){
                    ent.pev.health = (20);
                }else if ( ent.pev.classname == "monster_human_grunt" ){
                    ent.pev.health = (23);
                }else if ( ent.pev.classname == "monster_human_grunt_ally" ){
                    
                }else if ( ent.pev.classname == "monster_human_grunt_ally_dead" ){
                    
                }else if ( ent.pev.classname == "monster_human_medic_ally" ){
                    
                }else if ( ent.pev.classname == "monster_human_torch_ally" ){
                    
                }else if ( ent.pev.classname == "monster_hwgrunt" ){
                    ent.pev.health = (91);
                }else if ( ent.pev.classname == "monster_hwgrunt_repel" ){
                    
                }else if ( ent.pev.classname == "monster_ichthyosaur" ){

                }else if ( ent.pev.classname == "monster_kingpin" ){
                    ent.pev.health = (127);
                }else if ( ent.pev.classname == "monster_leech" ){
                    g_EntityFuncs.DispatchKeyValue( ent.edict(), "displayname", "farm" );
                }else if ( ent.pev.classname == "monster_male_assassin" ){
                    ent.pev.health = (23);
                }else if ( ent.pev.classname == "monster_medic_ally_repel" ){
                    
                }else if ( ent.pev.classname == "monster_miniturret" ){
                    ent.pev.health = (51);
                }else if ( ent.pev.classname == "monster_nihilanth" ){
                    ent.pev.health = (41);
                }else if ( ent.pev.classname == "monster_osprey" ){
                    ent.pev.health = (124);
                }else if ( ent.pev.classname == "monster_otis" ){
                    ent.pev.health = (95);
                    
                }else if ( ent.pev.classname == "monster_otis_dead" ){
                    
                }else if ( ent.pev.classname == "monster_pitdrone" ){
                    ent.pev.health = (107);
                }else if ( ent.pev.classname == "monster_rat" ){
                    
                }else if ( ent.pev.classname == "monster_robogrunt" ){
                    
                }else if ( ent.pev.classname == "monster_robogrunt_repel" ){
                    
                }else if ( ent.pev.classname == "monster_satchel" ){
                    
                }else if ( ent.pev.classname == "monster_scientist" ){
                    ent.pev.health = (43);

                }else if ( ent.pev.classname == "monster_scientist_dead" ){
                    
                }else if ( ent.pev.classname == "monster_sentry" ){
                    
                    g_EntityFuncs.DispatchKeyValue( ent.edict(), "displayname", "Sentinela" );

                }else if ( ent.pev.classname == "monster_shockroach" ){
                    
                
                }else if ( ent.pev.classname == "monster_shocktrooper" ){
                    

                }else if ( ent.pev.classname == "monster_sitting_scientist" ){
                    
                    

                }else if ( ent.pev.classname == "monster_snark" ){

                    g_EntityFuncs.DispatchKeyValue( ent.edict(), "displayname", "snarks 2.0" );

                }else if ( ent.pev.classname == "monster_sqknest" ){
                    
                    g_EntityFuncs.DispatchKeyValue( ent.edict(), "displayname", "capullo" );

                }else if ( ent.pev.classname == "monster_stukabat" ){
                    

                }else if ( ent.pev.classname == "monster_tentacle" ){
                    

                }else if ( ent.pev.classname == "monster_torch_ally_repel" ){
                    

                }else if ( ent.pev.classname == "monster_tripmine" ){
                

                }else if ( ent.pev.classname == "monster_turret" ){
                    

                }else if ( ent.pev.classname == "monster_zombie" ){
                    

                }else if ( ent.pev.classname == "monster_zombie_barney" ){
                    

                }else if ( ent.pev.classname == "monster_zombie_soldier" ){
                    

                }
            }
        }
    }

}








