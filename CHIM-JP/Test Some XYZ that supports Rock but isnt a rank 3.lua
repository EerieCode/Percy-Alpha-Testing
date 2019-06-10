--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Main Deck
Debug.AddCard(68406755,0,0,LOCATION_DECK,0,POS_FACEDOWN)
--Extra Deck
Debug.AddCard(101010036,0,0,LOCATION_EXTRA,0,8)
--Hand
Debug.AddCard(32912040,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(2273734,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--Monster Zones
Debug.AddCard(75878039,0,0,LOCATION_MZONE,1,1,true)
Debug.AddCard(75878039,0,0,LOCATION_MZONE,1,1,true)
--Spell & Trap Zones
Debug.AddCard(5851097,0,0,LOCATION_SZONE,1,10)
Debug.AddCard(59305593,0,0,LOCATION_SZONE,2,)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()