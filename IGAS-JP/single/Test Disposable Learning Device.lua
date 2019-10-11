--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Monster Zones
Debug.AddCard(75878039,0,0,LOCATION_GRAVE,2,1,true)
Debug.AddCard(75878039,0,0,LOCATION_GRAVE,2,1,true)
--Debug.AddCard(75878039,1,1,LOCATION_GRAVE,2,1,true)
Debug.AddCard(75878039,1,1,LOCATION_GRAVE,2,1,true)


Debug.AddCard(75878039,0,0,LOCATION_MZONE,2,1,true)
Debug.AddCard(38667773,0,0,LOCATION_MZONE,0,1,true)
--Spell & Trap Zones
Debug.AddCard(101011065,0,0,LOCATION_SZONE,1,10)
Debug.AddCard(5318639,0,0,LOCATION_HAND,2,10)
Debug.AddCard(5318639,0,0,LOCATION_HAND,3,10)
--Monster Zones
Debug.AddCard(2273734,1,1,LOCATION_MZONE,3,1,true)
Debug.AddCard(23995346,1,1,LOCATION_MZONE,1,1,true)
Debug.ReloadFieldEnd()
