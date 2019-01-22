--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Main Deck
Debug.AddCard(101007087,0,0,LOCATION_DECK,0,POS_FACEDOWN)
--Hand
Debug.AddCard(101007083,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--GY
Debug.AddCard(92826944,0,0,LOCATION_GRAVE,0,POS_FACEUP)
--Monster Zones
Debug.AddCard(101007085,0,0,LOCATION_MZONE,5,1,true)
Debug.AddCard(12014404,0,0,LOCATION_MZONE,4,1,true)

Debug.AddCard(19230407,0,0,LOCATION_HAND,0,POS_FACEDOWN)


--Spell & Trap Zones
Debug.AddCard(101007087,0,0,LOCATION_SZONE,1,10)
--GY
Debug.AddCard(35726888,1,1,LOCATION_GRAVE,0,POS_FACEUP)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()