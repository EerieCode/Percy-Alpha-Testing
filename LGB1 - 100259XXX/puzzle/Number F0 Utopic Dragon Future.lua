--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Extra Deck
Debug.AddCard(65305468,0,0,LOCATION_EXTRA,0,8)
Debug.AddCard(43490025,0,0,LOCATION_EXTRA,0,8)
Debug.AddCard(100259025,0,0,LOCATION_EXTRA,0,8)
--Hand
Debug.AddCard(53129443,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(44330098,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--Monster Zones
Debug.AddCard(12014404,0,0,LOCATION_MZONE,0,4,true)
Debug.AddCard(91499077,0,0,LOCATION_MZONE,1,1,true)
Debug.AddCard(48905153,0,0,LOCATION_MZONE,2,1,true)
Debug.AddCard(84013237,0,0,LOCATION_MZONE,3,1,true)
Debug.AddCard(95992081,0,0,LOCATION_MZONE,4,1,true)
--Hand
Debug.AddCard(98777036,1,1,LOCATION_HAND,0,POS_FACEDOWN)
--Monster Zones
Debug.AddCard(55410871,1,1,LOCATION_MZONE,2,1,true)
Debug.AddCard(29417188,1,1,LOCATION_MZONE,1,1,true)
--Spell & Trap Zones
Debug.AddCard(44095762,1,1,LOCATION_SZONE,3,10)
Debug.ReloadFieldEnd()
