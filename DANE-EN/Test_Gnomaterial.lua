--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Extra Deck
Debug.AddCard(22862454,0,0,LOCATION_EXTRA,0,8)
--Hand
Debug.AddCard(53129443,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(18144506,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(73125233,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(54447022,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(75878039,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--GY
Debug.AddCard(75878039,0,0,LOCATION_GRAVE,0,POS_FACEUP)
--Monster Zones
Debug.AddCard(8062132,0,0,LOCATION_MZONE,1,4,true)
--Spell & Trap Zones
Debug.AddCard(59919307,0,0,LOCATION_SZONE,1,10)
--Hand
Debug.AddCard(101008000,1,1,LOCATION_HAND,0,POS_FACEDOWN)
--Spell & Trap Zones
Debug.AddCard(74519184,1,1,LOCATION_SZONE,1,10)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()