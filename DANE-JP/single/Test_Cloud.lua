--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Hand
Debug.AddCard(101008022,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--GY
Debug.AddCard(21844576,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(21844576,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(58932615,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(75878039,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(58932615,0,0,LOCATION_GRAVE,0,POS_FACEUP)
--Monster Zones
Debug.AddCard(75878039,0,0,LOCATION_MZONE,3,1,true)
Debug.AddCard(58932615,0,0,LOCATION_MZONE,2,1,true)
Debug.AddCard(21844576,0,0,LOCATION_MZONE,1,1,true)
--Spell & Trap Zones
Debug.AddCard(17626381,0,0,LOCATION_SZONE,1,5)
--Monster Zones
Debug.AddCard(75878039,1,1,LOCATION_MZONE,1,1,true)
Debug.AddCard(60222213,1,1,LOCATION_MZONE,2,1,true)

Debug.AddCard(92435533,1,1,LOCATION_MZONE,3,1,true)
--Spell & Trap Zones
Debug.AddCard(17626381,1,1,LOCATION_SZONE,3,5)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()