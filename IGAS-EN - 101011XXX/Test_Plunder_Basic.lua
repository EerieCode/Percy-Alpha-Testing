--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Main Deck
Debug.AddCard(101011091,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(101011090,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(101011086,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(101011085,0,0,LOCATION_DECK,0,POS_FACEDOWN)
--Extra Deck
Debug.AddCard(101011089,0,0,LOCATION_EXTRA,0,8)
Debug.AddCard(101011088,0,0,LOCATION_EXTRA,0,8)
Debug.AddCard(101011087,0,0,LOCATION_EXTRA,0,8)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()