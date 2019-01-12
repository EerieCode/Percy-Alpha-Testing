--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Extra Deck
Debug.AddCard(71791814,0,0,LOCATION_EXTRA,0,8)
--Hand
Debug.AddCard(94418111,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(94418111,0,0,LOCATION_GRAVE,0,POS_FACEDOWN)
Debug.AddCard(94418111,1,1,LOCATION_GRAVE,0,POS_FACEDOWN)
--Monster Zones
Debug.AddCard(2857636,0,0,LOCATION_MZONE,1,1,true)
Debug.AddCard(32841045,0,0,LOCATION_MZONE,4,1,true)
Debug.AddCard(2857636,1,1,LOCATION_MZONE,1,1,true)
Debug.AddCard(32841045,1,1,LOCATION_MZONE,4,1,true)
--Spell & Trap Zones
Debug.AddCard(101008076,0,0,LOCATION_SZONE,2,10)
Debug.AddCard(12989604,0,0,LOCATION_SZONE,1,10)
Debug.ReloadFieldEnd()
