--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Hand
Debug.AddCard(100236109,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(100100014,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(70231910,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(5758500,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--GY
Debug.AddCard(38033121,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(38033121,1,1,LOCATION_GRAVE,0,POS_FACEUP)
--Monster Zones
Debug.AddCard(46986414,0,0,LOCATION_MZONE,1,1,true)
Debug.AddCard(38033121,0,0,LOCATION_MZONE,2,1,true)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()