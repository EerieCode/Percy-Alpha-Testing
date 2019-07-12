--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Main Deck
Debug.AddCard(35645105,0,0,LOCATION_DECK,0,POS_FACEDOWN)
--Hand
Debug.AddCard(101010022,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--GY
Debug.AddCard(101010022,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(37752990,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(97017120,0,0,LOCATION_GRAVE,0,POS_FACEUP)
--Spell & Trap Zones
Debug.AddCard(83764718,0,0,LOCATION_SZONE,1,10)
Debug.AddCard(83764718,0,0,LOCATION_SZONE,0,10)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()