--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Hand
Debug.AddCard(19230407,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(5318639,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--GY
Debug.AddCard(42388271,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(101008075,0,0,LOCATION_GRAVE,0,POS_FACEUP)
--Monster Zones
Debug.AddCard(41999284,0,0,LOCATION_MZONE,1,1,true)
Debug.AddCard(68473226,0,0,LOCATION_MZONE,3,1,true)
--Spell & Trap Zones
Debug.AddCard(101008075,0,0,LOCATION_SZONE,2,10)
--Monster Zones
Debug.AddCard(2857636,1,1,LOCATION_MZONE,2,1,true)
--Spell & Trap Zones
Debug.AddCard(44095762,1,1,LOCATION_SZONE,3,10)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()