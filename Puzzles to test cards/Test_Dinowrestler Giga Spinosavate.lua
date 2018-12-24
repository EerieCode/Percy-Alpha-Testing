--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Extra Deck
Debug.AddCard(101008034,0,0,LOCATION_EXTRA,0,8)
--Monster Zones
Debug.AddCard(75878039,0,0,LOCATION_MZONE,4,1,true)
Debug.AddCard(80727721,0,0,LOCATION_MZONE,0,4,true)
Debug.AddCard(5186893,0,0,LOCATION_MZONE,1,1,true)
Debug.AddCard(67441435,0,0,LOCATION_MZONE,2,4,true)
Debug.AddCard(44689688,0,0,LOCATION_MZONE,3,1,true)
--Monster Zones
Debug.AddCard(55885348,1,1,LOCATION_MZONE,4,1,true)
Debug.AddCard(80727721,1,1,LOCATION_MZONE,0,4,true)
Debug.AddCard(5186893,1,1,LOCATION_MZONE,1,1,true)
Debug.AddCard(67441435,1,1,LOCATION_MZONE,2,4,true)
Debug.AddCard(44689688,1,1,LOCATION_MZONE,3,1,true)
--Spell & Trap Zones
Debug.AddCard(44095762,1,1,LOCATION_SZONE,3,10)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()