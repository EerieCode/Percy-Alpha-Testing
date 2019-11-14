--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Extra Deck
Debug.AddCard(100229001,0,0,LOCATION_EXTRA,0,8)
--Hand
Debug.AddCard(45195443,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(20721928,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--Monster Zones
Debug.AddCard(21501505,0,0,LOCATION_MZONE,3,1,true)
--Spell & Trap Zones
Debug.AddCard(24094653,0,0,LOCATION_SZONE,2,10)
Debug.AddCard(19230407,0,0,LOCATION_SZONE,3,10)
--Monster Zones
Debug.AddCard(20721928,1,1,LOCATION_MZONE,2,1,true)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()