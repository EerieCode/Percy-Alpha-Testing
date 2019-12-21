--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Hand
Debug.AddCard(10352095,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(49003308,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(43793530,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--Monster Zones
Debug.AddCard(49003308,0,0,LOCATION_MZONE,1,1,true)
--Spell & Trap Zones
Debug.AddCard(100229019,0,0,LOCATION_SZONE,2,10)
--Monster Zones
Debug.AddCard(43793530,1,1,LOCATION_MZONE,1,1,true)
Debug.AddCard(31897444,1,1,LOCATION_MZONE,0,1,true)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()