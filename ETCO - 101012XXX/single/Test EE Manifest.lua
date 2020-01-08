--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_TEST_MODE,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Hand
Debug.AddCard(52340444,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(83764718,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--GY
Debug.AddCard(81992475,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(49003308,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(52340444,0,0,LOCATION_GRAVE,0,POS_FACEUP)
--Monster Zones
Debug.AddCard(82466274,0,0,LOCATION_MZONE,2,1,true)
--Spell & Trap Zones
Debug.AddCard(44133040,0,0,LOCATION_SZONE,1,10)
Debug.AddCard(8267140,1,1,LOCATION_SZONE,4,10)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()