--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,45000,0,0)

--Extra Deck
Debug.AddCard(33698022,0,0,LOCATION_EXTRA,0,8)
Debug.AddCard(4779823,0,0,LOCATION_EXTRA,0,8)
--Hand
Debug.AddCard(19230407,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--GY
Debug.AddCard(8240199,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(45452224,0,0,LOCATION_GRAVE,0,POS_FACEUP)
--Monster Zones
Debug.AddCard(82224646,0,0,LOCATION_MZONE,1,1,true)
Debug.AddCard(100200166,0,0,LOCATION_MZONE,2,1,true)
Debug.AddCard(21844576,0,0,LOCATION_MZONE,0,1,true)
Debug.AddCard(16229315,0,0,LOCATION_MZONE,3,1,true)
Debug.AddCard(50750868,0,0,LOCATION_MZONE,5,1,true)
--Monster Zones
Debug.AddCard(100200166,1,1,LOCATION_MZONE,2,4,true)
Debug.AddCard(10731333,1,1,LOCATION_MZONE,3,1,true)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()