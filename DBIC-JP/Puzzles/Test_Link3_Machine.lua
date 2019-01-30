--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,5000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Extra Deck
Debug.AddCard(100412011,0,0,LOCATION_EXTRA,0,8)
Debug.AddCard(90590303,0,0,LOCATION_EXTRA,0,8)
--Hand
Debug.AddCard(19230407,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--GY
Debug.AddCard(2204038,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(5133471,0,0,LOCATION_GRAVE,0,POS_FACEUP)
--Monster Zones
Debug.AddCard(74997493,0,0,LOCATION_MZONE,5,1,true)
Debug.AddCard(90590303,0,0,LOCATION_MZONE,0,1,true)
Debug.AddCard(90590303,0,0,LOCATION_MZONE,1,1,true)
Debug.AddCard(90162951,0,0,LOCATION_MZONE,2,1,true)
Debug.AddCard(3987233,0,0,LOCATION_MZONE,4,1,true)
Debug.AddCard(80335817,0,0,LOCATION_MZONE,3,4,true)
--Monster Zones
Debug.AddCard(75878039,1,1,LOCATION_MZONE,2,4,true)
Debug.AddCard(55885348,1,1,LOCATION_MZONE,3,1,true)
--Spell & Trap Zones
Debug.AddCard(17626381,1,1,LOCATION_SZONE,2,5)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()