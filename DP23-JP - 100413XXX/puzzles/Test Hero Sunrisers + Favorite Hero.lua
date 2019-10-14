--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Main Deck
Debug.AddCard(36484016,0,0,LOCATION_DECK,0,POS_FACEDOWN)
--Extra Deck
Debug.AddCard(100413012,0,0,LOCATION_EXTRA,0,8)
Debug.AddCard(100413012,0,0,LOCATION_EXTRA,0,8)
--Hand
Debug.AddCard(5285665,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--Monster Zones
Debug.AddCard(21844576,0,0,LOCATION_MZONE,0,1,true)
Debug.AddCard(21844576,0,0,LOCATION_MZONE,2,1,true)
Debug.AddCard(11502550,0,0,LOCATION_MZONE,4,1,true)
Debug.AddCard(58932615,0,0,LOCATION_MZONE,1,1,true)
Debug.AddCard(14799437,0,0,LOCATION_MZONE,3,1,true)
--Spell & Trap Zones
Debug.AddCard(24094653,0,0,LOCATION_SZONE,1,10)
--Hand
Debug.AddCard(81380218,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--Spell & Trap Zones
Debug.AddCard(100413015,0,0,LOCATION_SZONE,0,10)
--Monster Zones
Debug.AddCard(75878039,1,1,LOCATION_MZONE,3,4,true)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()