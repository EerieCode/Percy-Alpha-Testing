--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Monster Zones
Debug.AddCard(19230407,0,0,LOCATION_HAND,1,1,true)
Debug.AddCard(100412009,0,0,LOCATION_MZONE,1,1,true)
Debug.AddCard(100412007,0,0,LOCATION_MZONE,3,4,true)
--Spell & Trap Zones
Debug.AddCard(100412013,0,0,LOCATION_SZONE,1,10)
Debug.AddCard(83133491,0,0,LOCATION_SZONE,2,10)
--Monster Zones
Debug.AddCard(75878039,1,1,LOCATION_MZONE,1,4,true)
--Spell & Trap Zones
Debug.AddCard(17626381,1,1,LOCATION_SZONE,3,5)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()