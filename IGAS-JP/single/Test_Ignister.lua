Debug.SetAIName("Ganbare, Roboppi!!")
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_TEST_MODE,4)

Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

Debug.AddCard(101011050,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(101011001,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(101011001,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(101011002,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(101011003,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(101011004,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(101011005,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(101011006,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(101011052,0,0,LOCATION_HAND,0,POS_FACEDOWN)

Debug.AddCard(101011050,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(101011001,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(101011001,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(101011053,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(101011054,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(101011034,0,0,LOCATION_DECK,0,POS_FACEDOWN)

Debug.AddCard(101011001,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(101011004,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(101011050,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(53413628,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(101011042,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(101011052,0,0,LOCATION_GRAVE,0,POS_FACEUP)

Debug.AddCard(101011042,0,0,LOCATION_EXTRA,0,POS_FACEDOWN)
Debug.AddCard(53413628,0,0,LOCATION_EXTRA,0,POS_FACEDOWN)
Debug.AddCard(100204008,0,0,LOCATION_EXTRA,0,POS_FACEDOWN)
Debug.AddCard(2857636,0,0,LOCATION_EXTRA,0,POS_FACEDOWN)
Debug.AddCard(1861629,0,0,LOCATION_EXTRA,0,POS_FACEDOWN)
Debug.AddCard(101011045,0,0,LOCATION_EXTRA,0,POS_FACEDOWN)

Debug.AddCard(55784832,1,1,LOCATION_MZONE,0,POS_FACEUP_ATTACK)
Debug.AddCard(38999506,1,1,LOCATION_MZONE,1,POS_FACEUP_ATTACK)
local hakai=Debug.AddCard(29479265,1,1,LOCATION_MZONE,5,POS_FACEUP_ATTACK)
Debug.PreSummon(hakai,SUMMON_TYPE_SPECIAL+SUMMON_TYPE_LINK,LOCATION_EXTRA)

Debug.AddCard(83968380,1,1,LOCATION_SZONE,0,POS_FACEDOWN)
Debug.AddCard(83968380,1,1,LOCATION_SZONE,1,POS_FACEDOWN)
Debug.AddCard(83968380,1,1,LOCATION_SZONE,2,POS_FACEDOWN)

Debug.ReloadFieldEnd()