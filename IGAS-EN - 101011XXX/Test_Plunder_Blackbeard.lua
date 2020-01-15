--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Extra Deck
Debug.AddCard(101011088,0,0,LOCATION_EXTRA,0,8)
Debug.AddCard(101011087,0,0,LOCATION_EXTRA,0,8)
Debug.AddCard(101011089,0,0,LOCATION_EXTRA,0,8)
--Monster Zones
Debug.AddCard(101011089,0,0,LOCATION_MZONE,2,1,true)
Debug.AddCard(55784832,0,0,LOCATION_MZONE,1,1,true)
Debug.AddCard(14536035,0,0,LOCATION_MZONE,3,1,true)
--GY
Debug.AddCard(33112041,1,1,LOCATION_GRAVE,0,POS_FACEUP)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()