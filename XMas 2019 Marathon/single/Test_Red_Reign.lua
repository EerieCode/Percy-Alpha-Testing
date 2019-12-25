--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Extra Deck
Debug.AddCard(70902743,0,0,LOCATION_EXTRA,0,8)
--GY
Debug.AddCard(101012074,0,0,LOCATION_GRAVE,0,POS_FACEUP)
--Monster Zones
Debug.AddCard(70902743,0,0,LOCATION_MZONE,2,1,true)
Debug.AddCard(82044279,0,0,LOCATION_MZONE,3,1,true)
Debug.AddCard(74416224,0,0,LOCATION_MZONE,4,1,true)
Debug.AddCard(40975574,0,0,LOCATION_MZONE,0,1,true)
Debug.AddCard(45313993,0,0,LOCATION_MZONE,1,4,true)
--Spell & Trap Zones
Debug.AddCard(101012074,0,0,LOCATION_SZONE,2,10)
Debug.AddCard(53129443,0,0,LOCATION_SZONE,1,10)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()