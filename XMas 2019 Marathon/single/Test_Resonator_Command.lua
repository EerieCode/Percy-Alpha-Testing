--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Hand
Debug.AddCard(101012062,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(40975574,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(52589809,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--Deck
Debug.AddCard(40975574,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(52589809,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(48355999,0,0,LOCATION_DECK,0,POS_FACEDOWN)

Debug.ReloadFieldEnd()
aux.BeginPuzzle()