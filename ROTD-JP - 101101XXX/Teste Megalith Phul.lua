--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Main Deck
Debug.AddCard(63233638,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(69003792,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(101101036,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(25726386,0,0,LOCATION_DECK,0,POS_FACEDOWN)
--Hand
Debug.AddCard(69003792,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(101101036,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(25726386,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(25726386,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--GY
Debug.AddCard(63056220,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(69003792,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(25726386,0,0,LOCATION_GRAVE,0,POS_FACEUP)
--Monster Zones
Debug.AddCard(36849933,0,0,LOCATION_MZONE,1,1,true)
Debug.AddCard(25726386,0,0,LOCATION_MZONE,2,1,true)
Debug.AddCard(101101036,0,0,LOCATION_MZONE,4,1,true)
Debug.AddCard(101101036,0,0,LOCATION_MZONE,0,1,true)
--Debug.AddCard(101101036,0,0,LOCATION_MZONE,3,1,true)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()