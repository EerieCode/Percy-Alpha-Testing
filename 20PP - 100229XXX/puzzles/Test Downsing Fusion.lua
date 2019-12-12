--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Extra Deck
Debug.AddCard(65029288,0,0,LOCATION_EXTRA,0,8)
Debug.AddCard(41209827,0,0,LOCATION_EXTRA,0,8)
Debug.AddCard(22070401,0,0,LOCATION_EXTRA,0,8)
--GY
Debug.AddCard(16178681,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(16178681,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(64450427,0,0,LOCATION_GRAVE,0,POS_FACEUP)
--Monster Zones
Debug.AddCard(64450427,0,0,LOCATION_MZONE,2,4,true)
--Spell & Trap Zones
Debug.AddCard(100229017,0,0,LOCATION_SZONE,1,10)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()