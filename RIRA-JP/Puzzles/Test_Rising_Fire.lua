--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Hand
Debug.AddCard(101009053,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(19230407,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(5318639,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--GY
Debug.AddCard(64752646,0,0,LOCATION_GRAVE,0,POS_FACEUP)
--Monster Zones
Debug.AddCard(75878039,0,0,LOCATION_MZONE,1,1,true)
--Spell & Trap Zones
Debug.AddCard(59919307,0,0,LOCATION_SZONE,3,10)
--Monster Zones
Debug.AddCard(14851496,1,1,LOCATION_MZONE,1,1,true)
--Spell & Trap Zones
Debug.AddCard(1224927,1,1,LOCATION_SZONE,3,10)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()