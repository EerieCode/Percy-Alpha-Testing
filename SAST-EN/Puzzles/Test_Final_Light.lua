--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Main Deck
Debug.AddCard(31061682,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(31061682,0,0,LOCATION_DECK,0,POS_FACEDOWN)
--Hand
Debug.AddCard(5758500,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(67723438,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(67723438,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--GY
Debug.AddCard(2204038,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(2204038,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(3026686,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(3026686,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(3026686,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(3026686,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(3026686,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(66809920,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(66809920,0,0,LOCATION_GRAVE,0,POS_FACEUP)
--Spell & Trap Zones
Debug.AddCard(101007090,0,0,LOCATION_SZONE,1,10)
Debug.AddCard(3026686,0,0,LOCATION_MZONE,1,10)
--GY
Debug.AddCard(75878039,1,1,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(75878039,1,1,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(75878039,1,1,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(73125233,1,1,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(73125233,1,1,LOCATION_GRAVE,0,POS_FACEUP)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()