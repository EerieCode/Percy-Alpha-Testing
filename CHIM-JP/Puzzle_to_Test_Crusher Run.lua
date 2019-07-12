--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Main Deck
Debug.AddCard(96462121,0,0,LOCATION_DECK,0,POS_FACEDOWN)
--Hand
Debug.AddCard(19230407,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--GY
Debug.AddCard(101010076,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(101010076,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(22866836,0,0,LOCATION_GRAVE,0,POS_FACEUP)
--Monster Zones
Debug.AddCard(59368956,0,0,LOCATION_MZONE,0,1,true)
Debug.AddCard(97017120,0,0,LOCATION_MZONE,3,1,true)
--Spell & Trap Zones
Debug.AddCard(101010076,0,0,LOCATION_SZONE,1,10)
Debug.AddCard(74701381,0,0,LOCATION_SZONE,2,10)
--Monster Zones
Debug.AddCard(55885348,1,1,LOCATION_MZONE,2,1,true)
--Spell & Trap Zones
Debug.AddCard(17626381,1,1,LOCATION_SZONE,3,5)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()