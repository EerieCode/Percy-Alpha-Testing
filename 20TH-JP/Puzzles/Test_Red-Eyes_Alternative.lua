--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Hand
Debug.AddCard(100236104,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(100236104,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(89882100,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(19230407,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(30079770,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--GY
Debug.AddCard(74677422,0,0,LOCATION_GRAVE,0,POS_FACEUP)
--Monster Zones
Debug.AddCard(5186893,0,0,LOCATION_MZONE,1,1,true)
Debug.AddCard(58257569,0,0,LOCATION_MZONE,2,1,true)
Debug.AddCard(75878039,0,0,LOCATION_MZONE,3,1,true)
Debug.AddCard(44405066,0,0,LOCATION_MZONE,5,1,true)
--Monster Zones
Debug.AddCard(55885348,1,1,LOCATION_MZONE,2,1,true)
--Spell & Trap Zones
Debug.AddCard(44095762,1,1,LOCATION_SZONE,3,10)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()