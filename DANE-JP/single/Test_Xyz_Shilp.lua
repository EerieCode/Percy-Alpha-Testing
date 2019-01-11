--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Extra Deck
Debug.AddCard(37649320,0,0,LOCATION_EXTRA,0,8)
Debug.AddCard(90809975,0,0,LOCATION_EXTRA,0,8)
--Hand
Debug.AddCard(101008023,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(19230407,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--GY
Debug.AddCard(101008023,0,0,LOCATION_GRAVE,0,POS_FACEUP)
--Monster Zones
Debug.AddCard(9126351,0,0,LOCATION_MZONE,1,1,true)
Debug.AddCard(9126351,0,0,LOCATION_MZONE,2,1,true)
--Spell & Trap Zones
Debug.AddCard(26708437,0,0,LOCATION_SZONE,2,10)
Debug.AddCard(83778600,0,0,LOCATION_SZONE,1,10)
--Monster Zones
Debug.AddCard(6983839,1,1,LOCATION_MZONE,2,4,true)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()