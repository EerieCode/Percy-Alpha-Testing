--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Hand
Debug.AddCard(100412027,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(100412032,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--Monster Zones
Debug.AddCard(21844576,0,0,LOCATION_MZONE,3,4,true)
--Spell & Trap Zones
Debug.AddCard(100412037,0,0,LOCATION_SZONE,2,10)
--Monster Zones
Debug.AddCard(75878039,1,1,LOCATION_MZONE,2,4,true)
Debug.AddCard(55885348,1,1,LOCATION_MZONE,1,4,true)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()