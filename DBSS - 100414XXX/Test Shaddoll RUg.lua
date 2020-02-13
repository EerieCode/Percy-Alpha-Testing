--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Extra Deck
Debug.AddCard(94977269,0,0,LOCATION_EXTRA,0,8)
Debug.AddCard(20366274,0,0,LOCATION_EXTRA,0,8)
--GY
Debug.AddCard(14536035,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(95401059,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(14536035,0,0,LOCATION_GRAVE,0,POS_FACEUP)
--Monster Zones
Debug.AddCard(95401059,0,0,LOCATION_MZONE,2,1,true)
Debug.AddCard(14536035,0,0,LOCATION_MZONE,1,1,true)
--Spell & Trap Zones
Debug.AddCard(101101076,0,0,LOCATION_SZONE,1,10)
Debug.AddCard(101101076,0,0,LOCATION_SZONE,3,5)
local a=Debug.AddCard(81788994,0,0,LOCATION_SZONE,5,5)
--Monster Zones
Debug.AddCard(67696066,1,1,LOCATION_MZONE,0,4,true)
Debug.AddCard(95401059,1,1,LOCATION_MZONE,1,4,true)
Debug.AddCard(14536035,1,1,LOCATION_MZONE,2,4,true)
Debug.AddCard(95401059,1,1,LOCATION_MZONE,3,4,true)
Debug.AddCard(67696066,1,1,LOCATION_MZONE,4,4,true)
Debug.ReloadFieldEnd()

Debug.PreAddCounter(a,0x16,6)
