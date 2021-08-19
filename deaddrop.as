/*Usage: Add #include "deaddrop" in the script header
then add Enable(); in MapInit in your main map script
Angela Luna */
void Enable()
{	

	g_Scheduler.ClearTimerList();
	monsterList.removeRange(0, monsterList.length());
	nameList.removeRange(0, nameList.length());
	posList.removeRange(0, posList.length());


	@refreshMonster = g_Scheduler.SetInterval("killdrop", 0.3, g_Scheduler.REPEAT_INFINITE_TIMES);
  
	
}

array<EHandle> monsterList;
array<string> nameList;
array<Vector> posList;
CScheduledFunction@ refreshMonster;




const array<string> P_ENTITIES = {FL_MONSTER};
void MapInit()
{


}


void killdrop(){
	
	for(int i=0; i<int(monsterList.length()); i++){
		CBaseEntity@ thatMonster = monsterList[i];
		if(thatMonster is null || !thatMonster.IsAlive()){
			m_position(posList[i]);
	  	}
	}
	monsterList.removeRange(0, monsterList.length());
	nameList.removeRange(0, nameList.length());
	posList.removeRange(0, posList.length());
	CBaseEntity@ thisMonster = null;
	int monsterNumber = 0;
	while((@thisMonster = g_EntityFuncs.FindEntityByClassname(thisMonster, "monster_human_*")) !is null){
	  int relationship = thisMonster.IRelationshipByClass(CLASS_PLAYER);
	  if(thisMonster.IsAlive() && relationship != R_AL && relationship != R_NO){
		EHandle thisMonsterHandle = thisMonster;
		monsterList.insertLast(thisMonsterHandle);
		nameList.insertLast(thisMonster.GetClassname());
		posList.insertLast(thisMonster.GetOrigin());
	  }
	}
  



}


void m_position( Vector position){

  for( int i = 0 ; i < g_Engine.maxEntities; ++i ) {
		CBaseEntity@ ent = g_EntityFuncs.Instance( i );
		if( ent !is null ) {
            
			if ( ent.pev.classname == "monster_human_torch_ally"  )
			{		
        g_EntityFuncs.Create("monster_handgrenade",position + Vector(Math.RandomLong(0, 0), Math.RandomLong(0, 0), 0 ), Vector(0, 0, 0), false);
      }
      else if ( ent.pev.classname == "monster_human_grunt_ally"  )
			{		
        g_EntityFuncs.Create("monster_handgrenade",position + Vector(Math.RandomLong(0, 0), Math.RandomLong(0, 0), 0 ), Vector(0, 0, 0), false);
      }
      else if ( ent.pev.classname == "monster_human_medic_ally"  )
			{		
        g_EntityFuncs.Create("monster_handgrenade",position + Vector(Math.RandomLong(0, 0), Math.RandomLong(0, 0), 0 ), Vector(0, 0, 0), false);
      }
      else if ( ent.pev.classname == "monster_human_grunt"  )
			{		
        g_EntityFuncs.Create("monster_handgrenade",position + Vector(Math.RandomLong(0, 0), Math.RandomLong(0, 0), 0 ), Vector(0, 0, 0), false);
      }
      else if ( ent.pev.classname == "monster_human_assasin"  )
			{		
        g_EntityFuncs.Create("monster_handgrenade",position + Vector(Math.RandomLong(0, 0), Math.RandomLong(0, 0), 0 ), Vector(0, 0, 0), false);
      }
    }
  }
}


