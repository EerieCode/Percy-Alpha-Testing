--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,4000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Hand
Debug.AddCard(45311864,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(45311864,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(45311864,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(45311864,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(19230407,0,0,LOCATION_HAND,0,POS_FACEDOWN)

--Monster Zones
Debug.AddCard(101008026,0,0,LOCATION_MZONE,1,1,true)
--Monster Zones
Debug.AddCard(75878039,1,1,LOCATION_MZONE,3,1,true)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()