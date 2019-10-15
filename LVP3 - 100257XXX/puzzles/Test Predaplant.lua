--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Main Deck
Debug.AddCard(24094653,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(48130397,0,0,LOCATION_DECK,0,POS_FACEDOWN)
--Extra Deck
Debug.AddCard(6602300,0,0,LOCATION_EXTRA,0,8)
Debug.AddCard(41209827,0,0,LOCATION_EXTRA,0,8)
--Monster Zones
Debug.AddCard(100257071,0,0,LOCATION_MZONE,1,1,true)
Debug.AddCard(78243409,0,0,LOCATION_MZONE,4,1,true)
Debug.AddCard(14536035,0,0,LOCATION_MZONE,0,4,true)
Debug.AddCard(94046012,0,0,LOCATION_MZONE,3,4,true)
--Monster Zones
Debug.AddCard(75878039,1,1,LOCATION_MZONE,0,4,true)
Debug.AddCard(4055337,1,1,LOCATION_MZONE,1,4,true)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()