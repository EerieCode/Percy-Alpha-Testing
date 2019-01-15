--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Extra Deck
Debug.AddCard(100246006,0,0,LOCATION_EXTRA,0,8)
--Hand
Debug.AddCard(19230407,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--Monster Zones
Debug.AddCard(100412007,0,0,LOCATION_MZONE,1,1,true)
Debug.AddCard(84013237,0,0,LOCATION_MZONE,2,1,true)
Debug.AddCard(22423493,0,0,LOCATION_MZONE,5,1,true)
Debug.AddCard(100246006,0,0,LOCATION_MZONE,3,1,true)
--Spell & Trap Zones
Debug.AddCard(74701381,0,0,LOCATION_SZONE,2,10)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()