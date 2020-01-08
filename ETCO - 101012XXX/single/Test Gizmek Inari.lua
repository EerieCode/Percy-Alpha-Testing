--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Main Deck
Debug.AddCard(49003308,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(63633694,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(57835716,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(71197066,0,0,LOCATION_DECK,0,POS_FACEDOWN)
--Hand
Debug.AddCard(101012031,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(911883,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--Monster Zones
Debug.AddCard(55784832,1,1,LOCATION_MZONE,2,1,true)
Debug.AddCard(101012031,1,1,LOCATION_MZONE,3,1,true)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()