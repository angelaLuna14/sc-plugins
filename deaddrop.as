CScheduledFunction@ g_explosion = null;
const int e_rat = 1;

void Enable()
{
    @ents::g_entity = g_Scheduler.SetInterval( "entitys", 0.2 );
}    


/*Usage: Add #include "deaddrop" in the script header
then add Enable(); in MapInit in your main map script
Angela Luna */



void PluginInit(){
    g_Module.ScriptInfo.SetAuthor("Angela Luna");
    g_Module.ScriptInfo.SetContactInfo("Feel free to contact me on GitHub.");
}

namespace ents
{
	CScheduledFunction@ g_entity = null;
	
	void entitys(){
            
        CBaseEntity@ rat = null;
        
        while( ( @rat = g_EntityFuncs.FindEntityByClassname( rat, "monster_human_grunt" ) ) !is null )
        {
            if( rat.IsAlive() == false || rat.pev.health < -50)

            {
                array<CBaseEntity@> booms1(e_rat);				
                for (int y = 0; y < e_rat; ++y) {
                @booms1[y] = g_EntityFuncs.Create("monster_handgrenade",rat.pev.origin + Vector(Math.RandomLong(0, 0), Math.RandomLong(0, 0), 0 ), Vector(0, 0, 0), false);	  
                g_Scheduler.SetTimeout("SatchelCharge1", 0.0f, EHandle(booms1[y]));
                }


            }
        }
    }

}





void SatchelCharge(EHandle& in ent) {
  CBaseEntity@ boom = null;

  if (!ent.IsValid())
    return;

  @boom = ent.GetEntity();

  CBaseEntity@ pPlayer = g_EntityFuncs.Instance(boom.pev.owner);

  for (int y = 0; y < e_rat; ++y) {

  }

  if (boom !is null)
    boom.Use(pPlayer, pPlayer, USE_ON, 0);
}






void Timeentsboom(EHandle& in plrEnt) {
  if (!plrEnt.IsValid())
    return;

  if (g_explosion !is null)
    g_Scheduler.RemoveTimer(g_explosion);

  @g_explosion = g_Scheduler.SetInterval("entsboom", 0.0f, 15, plrEnt);
}

void entsboom(EHandle& in plrEnt) {
  if (!plrEnt.IsValid())
    return;

  CBaseEntity@ pPlayer = plrEnt.GetEntity();

  g_EntityFuncs.CreateExplosion(pPlayer.pev.origin, Vector(-90, 0, 0), g_EntityFuncs.IndexEnt(0), Math.RandomLong(25, 125), true);
  
}
