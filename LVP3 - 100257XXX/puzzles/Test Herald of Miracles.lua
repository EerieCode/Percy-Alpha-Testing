--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Extra Deck
Debug.AddCard(100257021,0,0,LOCATION_EXTRA,0,8)
--Hand
Debug.AddCard(19230407,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(77235086,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(78316184,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(67316075,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--GY
Debug.AddCard(14735698,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(14735698,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(59820352,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(14735698,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(39618799,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(39618799,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(20721928,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(67316075,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(67316075,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(77235086,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(77235086,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(78316184,0,0,LOCATION_GRAVE,0,POS_FACEUP)
--Monster Zones
Debug.AddCard(78316184,0,0,LOCATION_MZONE,1,1,true)
Debug.AddCard(77235086,0,0,LOCATION_MZONE,2,1,true)
Debug.AddCard(20721928,0,0,LOCATION_MZONE,0,1,true)
Debug.AddCard(67316075,0,0,LOCATION_MZONE,3,1,true)
--Spell & Trap Zones
Debug.AddCard(53582587,1,1,LOCATION_SZONE,3,10)
Debug.AddCard(17418744,0,0,LOCATION_SZONE,3,10)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()