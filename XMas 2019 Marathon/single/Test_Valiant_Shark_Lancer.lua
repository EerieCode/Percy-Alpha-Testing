--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Main Deck
Debug.AddCard(57734012,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(71541986,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(49003308,0,0,LOCATION_DECK,0,POS_FACEDOWN)
--Hand
Debug.AddCard(43793530,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--Monster Zones
Debug.AddCard(101012044,0,0,LOCATION_MZONE,1,1,true)
Debug.AddCard(43793530,0,0,LOCATION_MZONE,0,1,true)
Debug.AddCard(43793530,0,0,LOCATION_MZONE,2,1,true)
Debug.AddCard(74416224,0,0,LOCATION_MZONE,3,1,true)
--Monster Zones
Debug.AddCard(43793530,1,1,LOCATION_MZONE,1,1,true)
--Extra Deck
Debug.AddCard(101012044,0,0,LOCATION_EXTRA,0,POS_FACEDOWN)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()