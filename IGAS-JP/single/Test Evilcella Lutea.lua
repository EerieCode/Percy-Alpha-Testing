--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Hand
Debug.AddCard(5318639,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--Monster Zones
Debug.AddCard(101011027,0,0,LOCATION_MZONE,1,1,true)
--Spell & Trap Zones
Debug.AddCard(17626381,0,0,LOCATION_SZONE,2,5)
Debug.AddCard(5318639,0,0,LOCATION_SZONE,3,10)
--Monster Zones
Debug.AddCard(75878039,1,1,LOCATION_MZONE,2,1,true)
Debug.AddCard(101011027,1,1,LOCATION_MZONE,1,1,true)
--Spell & Trap Zones
Debug.AddCard(5318639,1,1,LOCATION_SZONE,3,10)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()