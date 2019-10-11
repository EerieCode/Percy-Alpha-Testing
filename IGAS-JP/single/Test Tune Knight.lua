--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Main Deck
Debug.AddCard(67441435,0,0,LOCATION_DECK,0,POS_FACEDOWN)
--Extra Deck
Debug.AddCard(41999284,0,0,LOCATION_EXTRA,0,8)
Debug.AddCard(41999284,0,0,LOCATION_EXTRA,0,8)
Debug.AddCard(41999284,0,0,LOCATION_EXTRA,0,8)
Debug.AddCard(50588353,0,0,LOCATION_EXTRA,0,8)
Debug.AddCard(50588353,0,0,LOCATION_EXTRA,0,8)
Debug.AddCard(50588353,0,0,LOCATION_EXTRA,0,8)
--Hand
Debug.AddCard(83764718,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(101011031,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(83764718,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--GY
Debug.AddCard(101011031,0,0,LOCATION_GRAVE,0,POS_FACEUP)
--Monster Zones
local m_1=Debug.AddCard(101011031,0,0,LOCATION_MZONE,2,1,true)
local eq_1_1=Debug.AddCard(101011031,0,0,LOCATION_SZONE,2,5)
--Monster Zones
Debug.AddCard(68473226,1,1,LOCATION_MZONE,3,1,true)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()
Debug.PreEquip(eq_1_1,m_1)