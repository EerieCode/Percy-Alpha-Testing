--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Hand
Debug.AddCard(100412023,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(53129443,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--Monster Zones
Debug.AddCard(100412016,1,1,LOCATION_MZONE,1,1,true)
Debug.AddCard(100412016,0,0,LOCATION_MZONE,1,1,true)
Debug.AddCard(100412016,0,0,LOCATION_MZONE,2,1,true)
Debug.AddCard(100412016,0,0,LOCATION_MZONE,3,1,true)
--Spell & Trap Zones
Debug.AddCard(17626381,0,0,LOCATION_SZONE,3,5)
Debug.AddCard(17626381,1,1,LOCATION_SZONE,3,5)
Debug.AddCard(17626381,0,0,LOCATION_SZONE,1,10)
Debug.AddCard(17626381,1,1,LOCATION_SZONE,1,10)
Debug.AddCard(17626381,1,1,LOCATION_SZONE,2,10)
Debug.AddCard(17626381,1,1,LOCATION_SZONE,4,10)
Debug.ReloadFieldEnd()
