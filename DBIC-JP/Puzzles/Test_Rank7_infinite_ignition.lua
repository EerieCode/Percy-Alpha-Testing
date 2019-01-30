--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Extra Deck
Debug.AddCard(100412008,0,0,LOCATION_EXTRA,0,8)
--Hand
Debug.AddCard(19230407,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--Monster Zones
Debug.AddCard(8491308,0,0,LOCATION_MZONE,5,1,true)
Debug.AddCard(30079770,0,0,LOCATION_MZONE,1,1,true)
Debug.AddCard(30079770,0,0,LOCATION_MZONE,2,1,true)
Debug.AddCard(8491308,0,0,LOCATION_MZONE,4,1,true)
Debug.AddCard(30079770,0,0,LOCATION_MZONE,3,1,true)
Debug.AddCard(69351984,1,1,LOCATION_MZONE,1,4,true)
--GY
Debug.AddCard(69351984,1,1,LOCATION_GRAVE,0,POS_FACEUP)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()