--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Hand
Debug.AddCard(100412025,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(100412014,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(100412017,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--GY
Debug.AddCard(7198399,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(100412017,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(100412014,0,0,LOCATION_GRAVE,0,POS_FACEUP)
--Monster Zones
Debug.AddCard(100412017,0,0,LOCATION_MZONE,1,1,true)

Debug.ReloadFieldEnd()
aux.BeginPuzzle()