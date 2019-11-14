--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Main Deck
Debug.AddCard(100229008,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(73628505,0,0,LOCATION_DECK,0,POS_FACEDOWN)
--Extra Deck
Debug.AddCard(73580471,0,0,LOCATION_EXTRA,0,8)
--Hand
Debug.AddCard(100229007,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(48686504,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(100229007,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(12213463,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--Spell & Trap Zones
Debug.AddCard(19230407,0,0,LOCATION_SZONE,2,10)
--Monster Zones
Debug.AddCard(20721928,1,1,LOCATION_MZONE,2,1,true)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()
