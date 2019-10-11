--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Monster Zones
Debug.AddCard(101011029,0,0,LOCATION_MZONE,1,1,true)
Debug.AddCard(101011018,0,0,LOCATION_MZONE,0,1,true)
Debug.AddCard(55285840,0,0,LOCATION_MZONE,2,1,true)
Debug.AddCard(55285840,0,0,LOCATION_MZONE,2,1,true)
Debug.AddCard(6983839,0,0,LOCATION_MZONE,3,1,true)
Debug.AddCard(6983839,0,0,LOCATION_MZONE,2,1,true)
--Spell & Trap Zones
Debug.AddCard(19230407,0,0,LOCATION_SZONE,1,10)
Debug.AddCard(19230407,0,0,LOCATION_SZONE,2,10)
--Monster Zones
Debug.AddCard(26096328,1,1,LOCATION_MZONE,4,1,true)
Debug.AddCard(26096328,1,1,LOCATION_MZONE,3,1,true)
Debug.AddCard(26096328,1,1,LOCATION_MZONE,3,1,true)

Debug.AddCard(101011029,0,0,LOCATION_GRAVE,3,1,true)
Debug.ReloadFieldEnd()
