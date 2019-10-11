--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Hand
Debug.AddCard(101011026,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(49959355,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(75878039,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--Spell & Trap Zones
Debug.AddCard(19230407,0,0,LOCATION_SZONE,1,10)
Debug.AddCard(19230407,0,0,LOCATION_SZONE,2,10)
Debug.AddCard(24224830,0,0,LOCATION_SZONE,3,10)
Debug.AddCard(101011026,1,1,LOCATION_GRAVE,3,10)
Debug.AddCard(92826944,1,1,LOCATION_GRAVE,3,10)
Debug.ReloadFieldEnd()
