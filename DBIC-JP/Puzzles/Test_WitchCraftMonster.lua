--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Main Deck
Debug.AddCard(14824019,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(25533642,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(27541563,0,0,LOCATION_DECK,0,POS_FACEDOWN)
--Hand
Debug.AddCard(12580477,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(55277252,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--Monster Zones
Debug.AddCard(100412016,0,0,LOCATION_MZONE,1,1,true)
Debug.AddCard(100412016,0,0,LOCATION_GRAVE,1,1,true)
--Monster Zones
Debug.AddCard(75878039,1,1,LOCATION_MZONE,3,1,true)
Debug.ReloadFieldEnd()
