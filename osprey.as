// ospreyfix.as - hackish fix for ospreys crashing servers with 5.24
// By Aperture

void PluginInit()
{	
	g_Module.ScriptInfo.SetAuthor( "Aperture" );
	g_Module.ScriptInfo.SetContactInfo("ChenZen Discord");
}

void MapInit()
{
	if( ap_ospreyfix::g_pOspreys !is null ) 
		g_Scheduler.RemoveTimer( ap_ospreyfix::g_pOspreys );
	  
	// search every quarter of a second
	@ap_ospreyfix::g_pOspreys = g_Scheduler.SetInterval( "OspreySearch", 0.25f );
}

namespace ap_ospreyfix
{
	CScheduledFunction@ g_pOspreys = null;
	
	void OspreySearch()
	{
		CBaseEntity@ pOsprey = null;
	
		while( ( @pOsprey = g_EntityFuncs.FindEntityByClassname( pOsprey, "monster_osprey" ) ) !is null )
		{
			if( pOsprey.IsAlive() == false )
			{
				g_Game.AlertMessage( at_console, "Osprey destroyed, removing from world.\n" );
				g_EntityFuncs.Remove( pOsprey );
			}
		}
		
		CBaseEntity@ pBlkOsprey = null;
	
		while( ( @pBlkOsprey = g_EntityFuncs.FindEntityByClassname( pBlkOsprey, "monster_blkop_osprey" ) ) !is null )
		{
			if( pBlkOsprey.IsAlive() == false  )
			{
				g_Game.AlertMessage( at_console, "Blk Osprey destroyed, removing from world.\n" );
				g_EntityFuncs.Remove( pBlkOsprey );
			}
		}
	}
}