--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Hand
Debug.AddCard(100412002,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(75944053,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--Monster Zones
Debug.AddCard(75878039,0,0,LOCATION_MZONE,1,1,true)
--Spell & Trap Zones
Debug.AddCard(69351984,0,0,LOCATION_PZONE,0,5)
Debug.AddCard(7868571,0,0,LOCATION_PZONE,1,5)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()