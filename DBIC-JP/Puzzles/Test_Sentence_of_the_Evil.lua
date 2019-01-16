--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Hand
Debug.AddCard(12580477,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(100412032,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(100412027,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--Spell & Trap Zones
Debug.AddCard(100412039,0,0,LOCATION_SZONE,2,10)
Debug.AddCard(41420027,0,0,LOCATION_SZONE,3,10)
--Monster Zones
Debug.AddCard(75878039,1,1,LOCATION_MZONE,2,4,true)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()