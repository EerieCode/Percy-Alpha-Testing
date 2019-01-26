--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Main Deck
Debug.AddCard(15610297,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(100236117,0,0,LOCATION_GRAVE,0,POS_FACEDOWN)
Debug.AddCard(9659580,0,0,LOCATION_GRAVE,0,POS_FACEDOWN)
Debug.AddCard(15610297,0,0,LOCATION_GRAVE,0,POS_FACEDOWN)
--Hand
Debug.AddCard(100236117,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(9659580,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--Monster Zones
Debug.AddCard(15610297,0,0,LOCATION_MZONE,1,1,true)
Debug.AddCard(72664875,1,1,LOCATION_MZONE,1,1,true)
Debug.AddCard(75878039,1,1,LOCATION_MZONE,2,1,true)
Debug.AddCard(75878039,0,0,LOCATION_MZONE,2,1,true)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()