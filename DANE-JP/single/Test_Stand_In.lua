--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Hand
Debug.AddCard(101008066,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(5758500,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--Monster Zones
Debug.AddCard(75878039,0,0,LOCATION_MZONE,1,1,true)
Debug.AddCard(55885348,0,0,LOCATION_MZONE,2,1,true)
Debug.AddCard(33420078,0,0,LOCATION_MZONE,3,4,true)
--Spell & Trap Zones
Debug.AddCard(4064256,0,0,LOCATION_SZONE,5,10)
--GY
Debug.AddCard(2273734,1,1,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(49959355,1,1,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(64063868,1,1,LOCATION_GRAVE,0,POS_FACEUP)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()