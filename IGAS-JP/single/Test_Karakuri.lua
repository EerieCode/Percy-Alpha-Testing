Debug.SetAIName("Clackery")
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_TEST_MODE,4)

Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

Debug.AddCard(3846170,0,0,LOCATION_MZONE,0,POS_FACEUP_ATTACK)

Debug.AddCard(101011014,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(101011058,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(101011014,0,0,LOCATION_DECK,0,POS_FACEDOWN)

Debug.AddCard(101011073,0,0,LOCATION_SZONE,0,POS_FACEDOWN)

Debug.AddCard(101011015,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(101011015,0,0,LOCATION_GRAVE,0,POS_FACEUP)

Debug.AddCard(101011043,0,0,LOCATION_EXTRA,0,POS_FACEDOWN)
Debug.AddCard(2857636,0,0,LOCATION_EXTRA,0,POS_FACEDOWN)

Debug.AddCard(12694768,1,1,LOCATION_MZONE,0,POS_FACEUP_ATTACK)
Debug.AddCard(58453942,1,1,LOCATION_MZONE,1,POS_FACEUP_ATTACK)

Debug.ReloadFieldEnd()