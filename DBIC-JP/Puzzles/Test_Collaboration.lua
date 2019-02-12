--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Hand
Debug.AddCard(100412022,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(100412022,0,0,LOCATION_GRAVE,0,POS_FACEDOWN)
--Monster Zones
Debug.AddCard(100412016,0,0,LOCATION_MZONE,1,1,true)
--Spell & Trap Zones
Debug.AddCard(44095762,1,1,LOCATION_SZONE,3,10)
Debug.ReloadFieldEnd()
