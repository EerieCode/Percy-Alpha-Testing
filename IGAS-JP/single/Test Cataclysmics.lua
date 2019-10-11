--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Main Deck
Debug.AddCard(19420830,0,0,LOCATION_DECK,0,POS_FACEDOWN)
--Hand
Debug.AddCard(101011025,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(97017120,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(81439173,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--Spell & Trap Zones
Debug.AddCard(53582587,1,1,LOCATION_SZONE,2,10)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()