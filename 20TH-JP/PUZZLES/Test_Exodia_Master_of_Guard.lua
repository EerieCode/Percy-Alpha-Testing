--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Hand
Debug.AddCard(100236102,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(7672244,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--Monster Zones
Debug.AddCard(33245030,0,0,LOCATION_MZONE,4,1,true)
Debug.AddCard(75878039,0,0,LOCATION_MZONE,1,1,true)
Debug.AddCard(75878039,0,0,LOCATION_MZONE,2,1,true)
Debug.AddCard(75878039,0,0,LOCATION_MZONE,3,1,true)
Debug.AddCard(75878039,0,0,LOCATION_MZONE,5,1,true)
Debug.AddCard(75878039,0,0,LOCATION_MZONE,0,1,true)
--Monster Zones
Debug.AddCard(69181753,1,1,LOCATION_MZONE,3,1,true)
Debug.AddCard(6214884,1,1,LOCATION_MZONE,2,1,true)
Debug.AddCard(56399890,1,1,LOCATION_MZONE,1,1,true)
Debug.AddCard(75878039,1,1,LOCATION_MZONE,0,1,true)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()