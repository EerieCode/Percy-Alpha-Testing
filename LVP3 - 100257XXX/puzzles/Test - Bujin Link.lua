--Created using senpaizuri's Puzzle Maker (updated by Naim)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Extra Deck
Debug.AddCard(100257056,0,0,LOCATION_EXTRA,0,8)
Debug.AddCard(58069384,0,0,LOCATION_EXTRA,0,8)
--Hand
Debug.AddCard(50400231,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(63394872,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(28279543,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--GY
Debug.AddCard(70095154,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(7241272,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(70095154,0,0,LOCATION_GRAVE,0,POS_FACEUP)
--Monster Zones
Debug.AddCard(89631139,0,0,LOCATION_MZONE,2,1,true)
Debug.AddCard(89631139,0,0,LOCATION_MZONE,3,1,true)
Debug.AddCard(70095154,0,0,LOCATION_MZONE,4,1,true)
Debug.AddCard(70095154,0,0,LOCATION_MZONE,1,1,true)
--Spell & Trap Zones
Debug.AddCard(44095762,0,0,LOCATION_SZONE,3,10)
--Spell & Trap Zones
Debug.AddCard(29649320,1,1,LOCATION_SZONE,1,5)
Debug.AddCard(29649320,1,1,LOCATION_SZONE,2,10)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()