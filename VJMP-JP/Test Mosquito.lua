--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Monster Zones
Debug.AddCard(42589641,0,0,LOCATION_MZONE,1,1,true)
Debug.AddCard(21200905,0,0,LOCATION_MZONE,2,1,true)
Debug.AddCard(21844576,0,0,LOCATION_MZONE,0,1,true)
Debug.AddCard(100200167,0,0,LOCATION_MZONE,3,1,true)
--Hand
Debug.AddCard(100200167,1,1,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(100200167,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--Monster Zones
Debug.AddCard(82199284,1,1,LOCATION_MZONE,2,1,true)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()