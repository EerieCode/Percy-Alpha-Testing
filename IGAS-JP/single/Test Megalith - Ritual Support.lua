--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Main Deck
Debug.AddCard(84388461,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(101011037,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(101011036,0,0,LOCATION_DECK,0,POS_FACEDOWN)
--Hand
Debug.AddCard(52068432,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(101011037,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(101011037,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(101011036,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(101011036,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(101011035,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(101011035,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(101011038,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(101011038,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(101011039,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(101011039,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(101011040,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(101011040,0,0,LOCATION_HAND,0,POS_FACEDOWN)

--Monster Zones
Debug.AddCard(75878039,0,0,LOCATION_MZONE,1,1,true)
Debug.AddCard(101011037,0,0,LOCATION_MZONE,2,1,true)
Debug.AddCard(101011037,0,0,LOCATION_MZONE,3,1,true)
--Hand
Debug.AddCard(20529766,1,1,LOCATION_HAND,0,POS_FACEDOWN)
--GY
Debug.AddCard(40374923,1,1,LOCATION_GRAVE,0,POS_FACEUP)
--Spell & Trap Zones
Debug.AddCard(17626381,1,1,LOCATION_SZONE,3,5)
Debug.AddCard(101011071,0,0,LOCATION_SZONE,2,10)
Debug.AddCard(101011072,0,0,LOCATION_SZONE,3,10)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()