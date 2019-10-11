--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--GY
Debug.AddCard(39564736,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(39564736,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(39564736,0,0,LOCATION_GRAVE,0,POS_FACEUP)
--Monster Zones
Debug.AddCard(101011033,0,0,LOCATION_MZONE,1,1,true)
--Monster Zones
Debug.AddCard(47297616,1,1,LOCATION_MZONE,3,1,true)
Debug.AddCard(3987233,1,1,LOCATION_MZONE,4,1,true)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()