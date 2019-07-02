--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Hand
Debug.AddCard(101010018,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(85967160,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--Monster Zones
Debug.AddCard(75878039,0,0,LOCATION_MZONE,0,1,true)
Debug.AddCard(58569561,0,0,LOCATION_MZONE,1,1,true)
--Spell & Trap Zones
Debug.AddCard(25050038,0,0,LOCATION_SZONE,0,10)

Debug.AddCard(25050038,0,0,LOCATION_SZONE,1,10)
--GY
Debug.AddCard(17626381,1,1,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(25050038,1,1,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(69327790,1,1,LOCATION_GRAVE,0,POS_FACEUP)
--Monster Zones
Debug.AddCard(69327790,1,1,LOCATION_MZONE,2,1,true)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()