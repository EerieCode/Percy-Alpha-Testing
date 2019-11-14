--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,3000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Main Deck
Debug.AddCard(65801012,0,0,LOCATION_DECK,0,POS_FACEDOWN)
--Extra Deck
Debug.AddCard(1861629,0,0,LOCATION_EXTRA,0,8)
Debug.AddCard(63503850,0,0,LOCATION_EXTRA,0,8)
Debug.AddCard(30691817,0,0,LOCATION_EXTRA,0,8)
Debug.AddCard(100259041,0,0,LOCATION_EXTRA,0,8)
--Monster Zones
Debug.AddCard(53413628,0,0,LOCATION_MZONE,1,1,true)
Debug.AddCard(26889158,0,0,LOCATION_MZONE,2,1,true)
Debug.AddCard(16188701,0,0,LOCATION_MZONE,3,1,true)
Debug.AddCard(21830679,0,0,LOCATION_MZONE,0,1,true)
Debug.AddCard(80794697,0,0,LOCATION_MZONE,4,1,true)
--Monster Zones
Debug.AddCard(4035199,1,1,LOCATION_MZONE,3,1,true)
Debug.ReloadFieldEnd()
