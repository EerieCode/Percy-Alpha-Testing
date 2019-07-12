--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Monster Zones
Debug.AddCard(101010006,0,0,LOCATION_MZONE,0,1,true)
Debug.AddCard(69121954,0,0,LOCATION_MZONE,3,1,true)
Debug.AddCard(12472242,0,0,LOCATION_MZONE,1,1,true)

Debug.AddCard(12472242,1,1,LOCATION_MZONE,3,1,true)
Debug.AddCard(55885348,1,1,LOCATION_MZONE,1,1,true)
Debug.AddCard(101010006,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--Main Deck
Debug.AddCard(61764082,1,1,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(61764082,1,1,LOCATION_DECK,0,POS_FACEDOWN)
--GY
Debug.AddCard(101010006,1,1,LOCATION_GRAVE,0,POS_FACEUP)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()