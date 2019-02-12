--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Hand
Debug.AddCard(100412021,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(100412016,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--GY
Debug.AddCard(100412015,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(7198399,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.ReloadFieldEnd()
