--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Hand
Debug.AddCard(101012060,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(101012012,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(101012011,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(101012010,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(101012008,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(101012010,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(53129443,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--Deck
Debug.AddCard(101012012,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(101012011,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(101012010,0,0,LOCATION_DECK,0,POS_FACEDOWN)
--GY
Debug.AddCard(2971090,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(101012008,0,0,LOCATION_GRAVE,0,POS_FACEUP,true)
Debug.AddCard(101012012,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(101012011,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(101012010,0,0,LOCATION_GRAVE,0,POS_FACEUP)
--Banished
Debug.AddCard(101012012,0,0,LOCATION_REMOVED,0,POS_FACEUP)
Debug.AddCard(101012011,0,0,LOCATION_REMOVED,0,POS_FACEUP)
Debug.AddCard(101012010,0,0,LOCATION_REMOVED,0,POS_FACEUP)
--Monster Zones
Debug.AddCard(55784832,0,0,LOCATION_MZONE,0,1,true)
Debug.AddCard(86088138,0,0,LOCATION_MZONE,1,1,true)
Debug.AddCard(78780140,0,0,LOCATION_MZONE,2,1,true)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()