--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Main Deck
Debug.AddCard(100412035,0,0,LOCATION_DECK,0,POS_FACEDOWN)
--Hand
Debug.AddCard(100412030,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(100412030,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(100412030,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(100412035,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()