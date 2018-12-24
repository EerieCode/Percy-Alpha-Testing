--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Monster Zones
Debug.AddCard(101008033,0,0,LOCATION_MZONE,1,1,true)
Debug.AddCard(75878039,0,0,LOCATION_MZONE,4,1,true)
Debug.AddCard(25533642,0,0,LOCATION_MZONE,3,4,true)
Debug.AddCard(52927340,0,0,LOCATION_MZONE,0,4,true)
Debug.AddCard(1508649,0,0,LOCATION_MZONE,5,1,true)
--Spell & Trap Zones
Debug.AddCard(83778600,0,0,LOCATION_SZONE,2,10)
Debug.AddCard(83778600,0,0,LOCATION_SZONE,3,10)
--Hand
Debug.AddCard(2273734,1,1,LOCATION_HAND,0,POS_FACEDOWN)
--GY
Debug.AddCard(73125233,1,1,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(26205777,1,1,LOCATION_GRAVE,0,POS_FACEUP)
--Monster Zones
Debug.AddCard(55885348,1,1,LOCATION_MZONE,1,1,true)
Debug.ReloadFieldEnd()
