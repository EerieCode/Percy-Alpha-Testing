--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Extra Deck
Debug.AddCard(2857636,0,0,LOCATION_EXTRA,0,8)
--Monster Zones
Debug.AddCard(25533642,0,0,LOCATION_MZONE,0,1,true)
Debug.AddCard(55885348,0,0,LOCATION_MZONE,1,1,true)
Debug.AddCard(55885348,0,0,LOCATION_MZONE,2,1,true)
Debug.AddCard(25533642,0,0,LOCATION_MZONE,3,1,true)
Debug.AddCard(101010005,0,0,LOCATION_MZONE,4,1,true)
--Hand
Debug.AddCard(101010005,1,1,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(19230407,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(75878039,1,1,LOCATION_MZONE,1,1,true)
--GY
Debug.AddCard(26202165,1,1,LOCATION_GRAVE,0,POS_FACEUP)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()