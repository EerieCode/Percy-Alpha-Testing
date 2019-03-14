--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Main Deck
Debug.AddCard(27780618,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(82697428,0,0,LOCATION_DECK,0,POS_FACEDOWN)
--Hand
Debug.AddCard(46918794,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(83764718,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--GY
Debug.AddCard(100246007,0,0,LOCATION_GRAVE,0,POS_FACEUP)
--Monster Zones
Debug.AddCard(75878039,0,0,LOCATION_MZONE,1,1,true)
Debug.AddCard(58554959,0,0,LOCATION_MZONE,2,1,true)
--Monster Zones
Debug.AddCard(69327790,1,1,LOCATION_MZONE,3,1,true)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()