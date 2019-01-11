--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Hand
Debug.AddCard(101008025,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(38667773,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(75732622,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(83764718,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--GY
Debug.AddCard(78355370,0,0,LOCATION_GRAVE,0,POS_FACEUP)
--Spell & Trap Zones
Debug.AddCard(83778600,0,0,LOCATION_SZONE,1,10)
--GY
Debug.AddCard(69327790,1,1,LOCATION_GRAVE,0,POS_FACEUP)
--Spell & Trap Zones
Debug.AddCard(59919307,1,1,LOCATION_SZONE,2,10)
Debug.AddCard(83778600,1,1,LOCATION_SZONE,3,10)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()