--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Extra Deck
Debug.AddCard(44508094,0,0,LOCATION_EXTRA,0,8)
Debug.AddCard(50588353,0,0,LOCATION_EXTRA,0,8)
Debug.AddCard(33158448,0,0,LOCATION_EXTRA,0,8)
--Hand
Debug.AddCard(101008011,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(77036039,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(77336644,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--Monster Zones
Debug.AddCard(40975574,0,0,LOCATION_MZONE,4,4,true)
Debug.AddCard(9411399,0,0,LOCATION_MZONE,1,4,true)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()