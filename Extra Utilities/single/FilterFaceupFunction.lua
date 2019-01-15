Debug.SetAIName("Utility Test")
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_TEST_MODE,4)

Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

Debug.AddCard(53129443,0,0,LOCATION_SZONE,0,POS_FACEDOWN)
Debug.AddCard(22510667,0,0,LOCATION_MZONE,0,POS_FACEUP)
Debug.AddCard(22510667,0,0,LOCATION_MZONE,1,POS_FACEUP)

Debug.ReloadFieldEnd()
