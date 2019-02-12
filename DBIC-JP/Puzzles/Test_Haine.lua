--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Hand
Debug.AddCard(100412021,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--Monster Zones
Debug.AddCard(100412018,0,0,LOCATION_MZONE,1,1,true)
Debug.AddCard(7198399,0,0,LOCATION_MZONE,2,1,true)
--Spell & Trap Zones
Debug.AddCard(100412025,0,0,LOCATION_SZONE,1,5)
--Spell & Trap Zones
Debug.AddCard(19230407,1,1,LOCATION_SZONE,3,10)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()