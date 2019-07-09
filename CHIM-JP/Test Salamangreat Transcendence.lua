--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Extra Deck
Debug.AddCard(101010039,0,0,LOCATION_EXTRA,0,8)
Debug.AddCard(14812471,0,0,LOCATION_EXTRA,0,8)
--Monster Zones
Debug.AddCard(14812471,0,0,LOCATION_MZONE,5,1,true)
Debug.AddCard(14812471,0,0,LOCATION_MZONE,3,1,true)
Debug.AddCard(101010039,0,0,LOCATION_MZONE,2,1,true)
Debug.AddCard(50366775,0,0,LOCATION_MZONE,1,1,true)
--Spell & Trap Zones
Debug.AddCard(41420027,0,0,LOCATION_SZONE,1,10)
Debug.AddCard(101010052,0,0,LOCATION_SZONE,2,10)
Debug.AddCard(101010052,0,0,LOCATION_SZONE,3,10)
Debug.ReloadFieldEnd()