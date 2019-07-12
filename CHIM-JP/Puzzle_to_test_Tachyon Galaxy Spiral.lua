--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Hand
Debug.AddCard(101010073,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--Monster Zones
Debug.AddCard(46659709,0,0,LOCATION_MZONE,3,1,true)
Debug.AddCard(9024367,0,0,LOCATION_MZONE,0,1,true)
Debug.AddCard(88177324,0,0,LOCATION_MZONE,2,1,true)
--Spell & Trap Zones
Debug.AddCard(101010073,0,0,LOCATION_SZONE,1,10)
--Monster Zones
Debug.AddCard(7778726,1,1,LOCATION_MZONE,3,1,true)
Debug.AddCard(23995346,1,1,LOCATION_MZONE,1,1,true)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()