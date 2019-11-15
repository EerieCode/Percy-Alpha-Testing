--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Monster Zones
Debug.AddCard(100257096,0,0,LOCATION_EXTRA,0,10)

Debug.AddCard(19230407,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(34100324,0,0,LOCATION_HAND,0,POS_FACEDOWN)

--Debug.AddCard(100257096,1,1,LOCATION_MZONE,3,1,true)
Debug.AddCard(75878039,1,1,LOCATION_MZONE,1,1,true)
Debug.AddCard(21844576,1,1,LOCATION_MZONE,4,4,true)
Debug.AddCard(55885348,1,1,LOCATION_MZONE,2,1,true)

Debug.AddCard(100257096,0,0,LOCATION_MZONE,5,1,true)
Debug.AddCard(100257096,0,0,LOCATION_MZONE,6,1,true)
Debug.AddCard(100257096,0,0,LOCATION_MZONE,0,1,true)
Debug.AddCard(100257096,0,0,LOCATION_MZONE,3,1,true)
Debug.AddCard(75878039,0,0,LOCATION_MZONE,1,1,true)
Debug.AddCard(21844576,0,0,LOCATION_MZONE,4,4,true)
Debug.AddCard(55885348,0,0,LOCATION_MZONE,2,1,true)

Debug.ReloadFieldEnd()
aux.BeginPuzzle()