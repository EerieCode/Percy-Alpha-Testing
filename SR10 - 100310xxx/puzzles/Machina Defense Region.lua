--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--GY
Debug.AddCard(42940404,0,0,LOCATION_GRAVE,0,POS_FACEUP)
--Monster Zones
Debug.AddCard(29491334,0,0,LOCATION_MZONE,2,1,true)
Debug.AddCard(42940404,0,0,LOCATION_MZONE,3,1,true)
Debug.AddCard(89631139,0,0,LOCATION_MZONE,1,1,true)
--Spell & Trap Zones
Debug.AddCard(13035077,0,0,LOCATION_SZONE,5,5)
Debug.AddCard(100310024,0,0,LOCATION_SZONE,3,5)
--Main Deck
Debug.AddCard(93302695,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(30539496,0,0,LOCATION_DECK,0,POS_FACEDOWN)
--Monster Zones
Debug.AddCard(5556499,1,1,LOCATION_MZONE,2,1,true)
Debug.AddCard(94046012,1,1,LOCATION_MZONE,1,1,true)
--Spell & Trap Zones
Debug.AddCard(100310024,1,1,LOCATION_SZONE,3,5)
Debug.ReloadFieldEnd()
