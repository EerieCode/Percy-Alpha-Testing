Debug.SetAIName("Sink into the abyss of bottomless despair!")
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_TEST_MODE,4)

Debug.SetPlayerInfo(0,80000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

Debug.AddCard(100336041,0,0,LOCATION_MZONE,2,POS_FACEUP_ATTACK)
Debug.AddCard(26692769,0,0,LOCATION_MZONE,0,POS_FACEUP_ATTACK)
Debug.AddCard(63977008,0,0,LOCATION_MZONE,3,POS_FACEUP_ATTACK)
Debug.AddCard(9365703,0,0,LOCATION_MZONE,4,POS_FACEUP_ATTACK)

Debug.AddCard(60800381,0,0,LOCATION_EXTRA,0,POS_FACEDOWN)

Debug.ReloadFieldEnd()
