--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Extra Deck
Debug.AddCard(101007085,0,0,LOCATION_EXTRA,0,8)
--Hand
Debug.AddCard(101007086,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(89882100,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(89882100,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(4031928,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(83764718,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(19230407,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--GY
Debug.AddCard(38667773,0,0,LOCATION_GRAVE,0,POS_FACEUP)
--Monster Zones
Debug.AddCard(75878039,0,0,LOCATION_MZONE,1,1,true)

Debug.AddCard(75878039,0,0,LOCATION_MZONE,3,1,true)
--Main Deck
Debug.AddCard(12580477,1,1,LOCATION_DECK,0,POS_FACEDOWN)
--Monster Zones
Debug.AddCard(75878039,1,1,LOCATION_MZONE,2,4,true)
Debug.AddCard(15610297,1,1,LOCATION_MZONE,1,4,true)
--Spell & Trap Zones
Debug.AddCard(53582587,1,1,LOCATION_SZONE,3,10)
Debug.AddCard(62279055,1,1,LOCATION_SZONE,2,10)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()