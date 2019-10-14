--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Extra Deck
Debug.AddCard(41209827,0,0,LOCATION_EXTRA,0,8)
Debug.AddCard(1945387,0,0,LOCATION_EXTRA,0,8)
--Hand
Debug.AddCard(63528891,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(18789533,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--Monster Zones
Debug.AddCard(511310039,0,0,LOCATION_MZONE,5,1,true)
Debug.AddCard(511009415,0,0,LOCATION_MZONE,2,1,true)
Debug.AddCard(511009415,0,0,LOCATION_MZONE,3,1,true)
Debug.AddCard(35809262,0,0,LOCATION_MZONE,4,1,true)

Debug.AddCard(511009415,1,1,LOCATION_MZONE,2,1,true)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()