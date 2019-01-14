--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,80000,0,0)

--Monster Zones
Debug.AddCard(72664875,0,0,LOCATION_MZONE,5,1,true)
Debug.AddCard(3775068,0,0,LOCATION_MZONE,0,1,true)
Debug.AddCard(3775068,0,0,LOCATION_MZONE,1,1,true)
Debug.AddCard(3775068,0,0,LOCATION_MZONE,2,1,true)
Debug.AddCard(3775068,0,0,LOCATION_MZONE,3,1,true)
Debug.AddCard(75878039,0,0,LOCATION_MZONE,4,4,true)
--Spell & Trap Zones
Debug.AddCard(100236118,0,0,LOCATION_SZONE,1,10)
Debug.AddCard(100236118,0,0,LOCATION_GRAVE,1,10)
--Monster Zones
Debug.AddCard(3987233,1,1,LOCATION_MZONE,4,1,true)
Debug.AddCard(55885348,1,1,LOCATION_MZONE,1,1,true)
Debug.AddCard(55885348,1,1,LOCATION_MZONE,2,1,true)
Debug.AddCard(55885348,1,1,LOCATION_MZONE,3,1,true)
Debug.AddCard(55885348,1,1,LOCATION_MZONE,0,1,true)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()