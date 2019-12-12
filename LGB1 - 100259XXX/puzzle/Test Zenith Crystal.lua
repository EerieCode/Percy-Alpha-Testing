--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Main Deck
Debug.AddCard(68215963,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(36328300,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(79856792,0,0,LOCATION_DECK,0,POS_FACEDOWN)
--Hand
Debug.AddCard(100259013,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--Monster Zones
Debug.AddCard(21698716,0,0,LOCATION_MZONE,1,1,true)
Debug.AddCard(75878039,0,0,LOCATION_MZONE,2,1,true)
--Monster Zones
Debug.AddCard(84433295,1,1,LOCATION_MZONE,2,1,true)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()