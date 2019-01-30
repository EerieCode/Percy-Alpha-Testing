--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Main Deck
Debug.AddCard(12580477,0,0,LOCATION_DECK,0,POS_FACEDOWN)
--Hand
Debug.AddCard(100412003,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--GY
Debug.AddCard(94693857,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(24573625,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(97017120,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(38988538,0,0,LOCATION_GRAVE,0,POS_FACEUP)
--Monster Zones
Debug.AddCard(97017120,0,0,LOCATION_MZONE,1,1,true)
Debug.AddCard(24573625,0,0,LOCATION_MZONE,2,1,true)
Debug.AddCard(38988538,0,0,LOCATION_MZONE,3,1,true)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()