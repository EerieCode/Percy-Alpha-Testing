--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Hand
Debug.AddCard(24094653,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(17415895,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(19230407,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(58932615,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(21844576,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--Monster Zones
Debug.AddCard(21844576,0,0,LOCATION_MZONE,0,1,true)
Debug.AddCard(58932615,0,0,LOCATION_MZONE,4,1,true)
--Spell & Trap Zones
Debug.AddCard(17626381,0,0,LOCATION_SZONE,2,5)
--Monster Zones
Debug.AddCard(20849090,1,1,LOCATION_MZONE,2,4,true)
Debug.AddCard(100229001,0,0,LOCATION_EXTRA,2,10)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()