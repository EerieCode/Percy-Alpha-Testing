--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Extra Deck
Debug.AddCard(12744567,0,0,LOCATION_EXTRA,0,8)
--GY
Debug.AddCard(101012075,0,0,LOCATION_GRAVE,0,POS_FACEUP,true)
Debug.AddCard(48739166,0,0,LOCATION_GRAVE,0,POS_FACEUP,true)
Debug.AddCard(12744567,0,0,LOCATION_GRAVE,0,POS_FACEUP,true)
Debug.AddCard(32530043,0,0,LOCATION_GRAVE,0,POS_FACEUP,true)
--Monster Zones
Debug.AddCard(48739166,0,0,LOCATION_MZONE,1,1,true)
Debug.AddCard(32530043,0,0,LOCATION_MZONE,0,1,true)
--Spell & Trap Zones
Debug.AddCard(101012075,0,0,LOCATION_SZONE,2,10)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()