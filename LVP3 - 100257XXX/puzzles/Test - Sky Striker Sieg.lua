--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Main Deck
Debug.AddCard(25533642,0,0,LOCATION_DECK,0,POS_FACEDOWN)
--Extra Deck
Debug.AddCard(100257086,0,0,LOCATION_EXTRA,0,8)
Debug.AddCard(31833038,0,0,LOCATION_EXTRA,0,8)
--Monster Zones
Debug.AddCard(37351133,0,0,LOCATION_MZONE,1,1,true)
Debug.AddCard(75878039,0,0,LOCATION_MZONE,3,1,true)
Debug.AddCard(12421694,0,0,LOCATION_MZONE,4,1,true)
Debug.AddCard(31833038,0,0,LOCATION_MZONE,2,1,true)
--Spell & Trap Zones
Debug.AddCard(10813327,0,0,LOCATION_SZONE,2,10)
Debug.AddCard(12989604 ,0,0,LOCATION_SZONE,3,10)
--Monster Zones
Debug.AddCard(75878039,1,1,LOCATION_MZONE,3,1,true)
Debug.AddCard(55885348,1,1,LOCATION_MZONE,1,4,true)
--Spell & Trap Zones
Debug.AddCard(1224927,1,1,LOCATION_SZONE,2,10)
Debug.ReloadFieldEnd()