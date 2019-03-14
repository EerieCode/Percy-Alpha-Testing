--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Extra Deck
Debug.AddCard(100246038 ,0,0,LOCATION_EXTRA,0,8)
--GY
Debug.AddCard(100246038 ,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(100246038 ,0,0,LOCATION_GRAVE,0,POS_FACEUP)
--Monster Zones
Debug.AddCard(50091196,0,0,LOCATION_MZONE,1,4,true)
Debug.AddCard(40975574,0,0,LOCATION_MZONE,3,4,true)
Debug.AddCard(9411399,0,0,LOCATION_MZONE,2,4,true)

--Monster Zones
Debug.AddCard(75878039,1,1,LOCATION_MZONE,3,1,true)
Debug.AddCard(75878039,1,1,LOCATION_MZONE,1,1,true)
Debug.AddCard(75878039,1,1,LOCATION_MZONE,0,1,true)
Debug.ReloadFieldEnd()
