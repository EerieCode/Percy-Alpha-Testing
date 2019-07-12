--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Hand
Debug.AddCard(75878039,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--GY
Debug.AddCard(75878039,0,0,LOCATION_GRAVE,0,POS_FACEUP)
--Monster Zones
Debug.AddCard(75878039,0,0,LOCATION_MZONE,1,1,true)
--Spell & Trap Zones
Debug.AddCard(101010080,0,0,LOCATION_SZONE,0,10)
Debug.AddCard(101010080,0,0,LOCATION_SZONE,2,10)
Debug.AddCard(83764718,0,0,LOCATION_SZONE,1,10)
--Monster Zones
Debug.AddCard(75878039,1,1,LOCATION_MZONE,3,1,true)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()