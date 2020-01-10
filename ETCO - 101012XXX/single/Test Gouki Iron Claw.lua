--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Hand
Debug.AddCard(101012004,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--Monster Zones

Debug.AddCard(28470714,0,0,LOCATION_MZONE,3,1,true)
Debug.AddCard(54088068,0,0,LOCATION_MZONE,0,1,true)
Debug.AddCard(101012004,0,0,LOCATION_MZONE,1,1,true)
--Monster Zones
Debug.AddCard(3987233,1,1,LOCATION_MZONE,1,1,true)
Debug.AddCard(55885348,1,1,LOCATION_MZONE,4,1,true)

Debug.AddCard(26285557,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(101012005,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(19230407,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()