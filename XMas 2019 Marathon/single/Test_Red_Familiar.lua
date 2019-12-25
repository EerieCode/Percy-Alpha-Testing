--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--GY
Debug.AddCard(70902743,0,0,LOCATION_GRAVE,0,POS_FACEUP,true)
Debug.AddCard(50954680,0,0,LOCATION_GRAVE,0,POS_FACEUP,true)
--Monster Zones
Debug.AddCard(101012016,0,0,LOCATION_MZONE,2,1,true)
Debug.AddCard(52589809,0,0,LOCATION_MZONE,1,1,true)
Debug.AddCard(34250214,0,0,LOCATION_MZONE,3,1,true)
Debug.AddCard(50954680,0,0,LOCATION_MZONE,0,1,true)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()