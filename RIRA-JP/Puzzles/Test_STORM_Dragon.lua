--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Hand
Debug.AddCard(101009026,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(53129443,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--GY
Debug.AddCard(60666820,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(101009026,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(75878039,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(2377034,0,0,LOCATION_GRAVE,0,POS_FACEUP)
--Spell & Trap Zones
Debug.AddCard(30241314,0,0,LOCATION_SZONE,1,10)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()