--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Main Deck
Debug.AddCard(59368956,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(37752990,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(97017120,0,0,LOCATION_DECK,0,POS_FACEDOWN)
--Extra Deck
Debug.AddCard(100412007,0,0,LOCATION_EXTRA,0,8)
--Hand
Debug.AddCard(19230407,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(1118137,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--Monster Zones
Debug.AddCard(83629030,0,0,LOCATION_MZONE,1,4,true)
Debug.AddCard(70095154,0,0,LOCATION_MZONE,3,4,true)
Debug.AddCard(83629030,0,0,LOCATION_MZONE,2,1,true)
Debug.AddCard(22423493,0,0,LOCATION_MZONE,0,1,true)
--Monster Zones
Debug.AddCard(7868571,1,1,LOCATION_MZONE,2,4,true)
Debug.AddCard(5560911,1,1,LOCATION_GRAVE,2,4,true)
Debug.AddCard(40737112,1,1,LOCATION_MZONE,1,4,true)
Debug.AddCard(2273734,1,1,LOCATION_MZONE,3,4,true)
Debug.ReloadFieldEnd()
