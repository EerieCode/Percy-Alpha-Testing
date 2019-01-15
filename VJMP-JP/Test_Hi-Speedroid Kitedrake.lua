--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Main Deck
Debug.AddCard(27660735,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(511004403,0,0,LOCATION_DECK,0,POS_FACEDOWN)
--Extra Deck
Debug.AddCard(100200158,0,0,LOCATION_EXTRA,0,8)
--Hand
Debug.AddCard(89882100,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--Monster Zones
Debug.AddCard(94693857,0,0,LOCATION_MZONE,4,4,true)
Debug.AddCard(74677422,0,0,LOCATION_MZONE,3,4,true)
Debug.AddCard(70939418,0,0,LOCATION_MZONE,0,4,true)
Debug.AddCard(97588916,0,0,LOCATION_MZONE,1,4,true)
--Monster Zones
Debug.AddCard(55885348,1,1,LOCATION_MZONE,3,1,true)
--Spell & Trap Zones
Debug.AddCard(44095762,1,1,LOCATION_SZONE,2,10)
Debug.AddCard(17626381,1,1,LOCATION_SZONE,3,5)
Debug.AddCard(45778932,1,1,LOCATION_SZONE,5,5)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()