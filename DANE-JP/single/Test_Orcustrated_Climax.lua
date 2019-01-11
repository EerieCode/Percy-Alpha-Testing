--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Main Deck
Debug.AddCard(94046012,0,0,LOCATION_DECK,0,POS_FACEDOWN)
--Extra Deck
Debug.AddCard(30741503,0,0,LOCATION_EXTRA,0,8)
--Hand
Debug.AddCard(19230407,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--GY
Debug.AddCard(101008074,0,0,LOCATION_GRAVE,0,POS_FACEUP)
--Banished
Debug.AddCard(3134857,0,0,LOCATION_REMOVED,0,5)
--Monster Zones
Debug.AddCard(94046012,0,0,LOCATION_MZONE,1,1,true)
Debug.AddCard(94046012,0,0,LOCATION_MZONE,2,1,true)
--Spell & Trap Zones
Debug.AddCard(101008074,0,0,LOCATION_SZONE,2,10)
--Spell & Trap Zones
Debug.AddCard(44095762,1,1,LOCATION_SZONE,3,10)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()