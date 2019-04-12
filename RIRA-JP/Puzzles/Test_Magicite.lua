--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--GY
Debug.AddCard(55885348,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(5043010,0,0,LOCATION_GRAVE,0,POS_FACEUP)
--Monster Zones
Debug.AddCard(75878039,0,0,LOCATION_MZONE,3,1,true)
Debug.AddCard(63259351,0,0,LOCATION_MZONE,2,1,true)
--Spell & Trap Zones
Debug.AddCard(101009079,0,0,LOCATION_SZONE,1,10)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()