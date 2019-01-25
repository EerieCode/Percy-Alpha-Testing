--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Main Deck
Debug.AddCard(74509280,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(74509280,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(100236106,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(100236106,0,0,LOCATION_DECK,0,POS_FACEDOWN)
--Hand
Debug.AddCard(19230407,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--GY
Debug.AddCard(100236108,0,0,LOCATION_GRAVE,0,POS_FACEUP)
--Monster Zones
Debug.AddCard(36521459,0,0,LOCATION_MZONE,1,1,true)
--Spell & Trap Zones
Debug.AddCard(100236108,0,0,LOCATION_SZONE,1,10)
Debug.AddCard(54631665,0,0,LOCATION_SZONE,5,5)
--Monster Zones
Debug.AddCard(23064604,1,1,LOCATION_MZONE,2,1,true)
--Spell & Trap Zones
Debug.AddCard(44095762,1,1,LOCATION_SZONE,3,10)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()