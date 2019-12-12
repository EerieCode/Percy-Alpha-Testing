--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--GY
Debug.AddCard(25788011,0,0,LOCATION_DECK,0,1)
--Monster Zones
Debug.AddCard(100259045,0,0,LOCATION_MZONE,0,1,true)
Debug.AddCard(100259045,0,0,LOCATION_EXTRA,0,1)
Debug.AddCard(2857636,0,0,LOCATION_MZONE,2,1,true)
Debug.AddCard(2857636,0,0,LOCATION_MZONE,3,1,true)
Debug.AddCard(1861629,0,0,LOCATION_MZONE,5,1,true)
--Spell & Trap Zones
Debug.AddCard(67723438,0,0,LOCATION_SZONE,1,10)
Debug.AddCard(53129443,0,0,LOCATION_SZONE,2,10)
Debug.AddCard(48355999,0,0,LOCATION_GRAVE,2,10)
--Monster Zones
Debug.AddCard(75878039,1,1,LOCATION_MZONE,0,1,true)
Debug.AddCard(21844576,1,1,LOCATION_MZONE,4,1,true)
Debug.AddCard(84433295,1,1,LOCATION_MZONE,1,1,true)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()