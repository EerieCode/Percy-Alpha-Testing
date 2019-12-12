--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Main Deck
Debug.AddCard(53388413,0,0,LOCATION_DECK,0,POS_FACEDOWN)
--Extra Deck
Debug.AddCard(100259021,0,0,LOCATION_EXTRA,0,8)
--Monster Zones
Debug.AddCard(42110604,0,0,LOCATION_MZONE,0,1,true)
Debug.AddCard(87979586,0,0,LOCATION_MZONE,1,4,true)
Debug.AddCard(40975574,0,0,LOCATION_MZONE,2,4,true)
Debug.AddCard(67441435,0,0,LOCATION_MZONE,3,4,true)
Debug.AddCard(15310033,0,0,LOCATION_MZONE,4,1,true)
--Monster Zones
Debug.AddCard(85802526,1,1,LOCATION_MZONE,3,4,true)
Debug.AddCard(85802526,1,1,LOCATION_MZONE,2,4,true)
Debug.AddCard(85802526,1,1,LOCATION_MZONE,1,4,true)
Debug.AddCard(40975574,1,1,LOCATION_MZONE,0,4,true)
Debug.AddCard(25533642,1,1,LOCATION_MZONE,4,1,true)
--Spell & Trap Zones
Debug.AddCard(44095762,1,1,LOCATION_SZONE,2,10)
Debug.AddCard(17626381,1,1,LOCATION_SZONE,3,5)
Debug.ReloadFieldEnd()
