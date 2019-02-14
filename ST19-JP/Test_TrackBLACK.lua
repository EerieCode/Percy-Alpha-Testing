--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Main Deck
Debug.AddCard(75878039,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(75878039,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(75878039,0,0,LOCATION_DECK,0,POS_FACEDOWN)
--Monster Zones
Debug.AddCard(100319042,0,0,LOCATION_MZONE,5,1,true)
Debug.AddCard(75878039,0,0,LOCATION_MZONE,1,1,true)
Debug.AddCard(45002991,0,0,LOCATION_MZONE,2,1,true)
--Spell & Trap Zones
Debug.AddCard(69039982,0,0,LOCATION_SZONE,5,5)
--Monster Zones
Debug.AddCard(75878039,1,1,LOCATION_MZONE,3,1,true)
Debug.AddCard(75878039,1,1,LOCATION_MZONE,4,4,true)
Debug.AddCard(75878039,1,1,LOCATION_MZONE,2,4,true)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()