--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Extra Deck
Debug.AddCard(65170459,0,0,LOCATION_EXTRA,0,8)
Debug.AddCard(5014629,0,0,LOCATION_EXTRA,0,8)
Debug.AddCard(48739166,0,0,LOCATION_EXTRA,0,8)
Debug.AddCard(36076683,0,0,LOCATION_EXTRA,0,8)
--Hand
Debug.AddCard(101012018,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(64319467,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(47840168,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(7500772,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--Monster Zones
Debug.AddCard(64319467,0,0,LOCATION_MZONE,0,1,true)
Debug.AddCard(47840168,0,0,LOCATION_MZONE,1,1,true)
Debug.AddCard(70101178,0,0,LOCATION_MZONE,2,1,true)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()