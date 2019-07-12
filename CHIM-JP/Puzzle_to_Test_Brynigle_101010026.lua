--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Main Deck
Debug.AddCard(101010026,0,0,LOCATION_DECK,0,POS_FACEDOWN)
--Hand
Debug.AddCard(101010026,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(81439173,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(83764718,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--Monster Zones
Debug.AddCard(101010001,0,0,LOCATION_MZONE,1,1,true)
Debug.AddCard(57839750,0,0,LOCATION_MZONE,3,1,true)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()