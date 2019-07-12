--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Hand
Debug.AddCard(60643553,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(6203182,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(6203182,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--Monster Zones
Debug.AddCard(101010025,0,0,LOCATION_MZONE,1,1,true)
--Monster Zones
Debug.AddCard(64973287,1,1,LOCATION_MZONE,6,4,true)
Debug.AddCard(75878039,1,1,LOCATION_MZONE,5,4,true)
Debug.AddCard(64973287,1,1,LOCATION_MZONE,4,4,true)
Debug.AddCard(75878039,1,1,LOCATION_MZONE,3,4,true)
Debug.AddCard(64973287,1,1,LOCATION_MZONE,2,4,true)
Debug.AddCard(75878039,1,1,LOCATION_MZONE,1,4,true)
Debug.AddCard(64973287,1,1,LOCATION_MZONE,0,4,true)
Debug.ReloadFieldEnd()
