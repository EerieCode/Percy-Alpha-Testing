Debug.SetAIName("Utility Test")
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_TEST_MODE,4)

Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

Debug.AddCard(83107873,0,0,LOCATION_GRAVE,0,POS_FACEUP)
Debug.AddCard(31786629,0,0,LOCATION_GRAVE,0,POS_FACEUP)
local c=Debug.AddCard(12081875,0,0,LOCATION_MZONE,5,POS_FACEUP_ATTACK,true)
Debug.PreSummon(c,SUMMON_TYPE_LINK,LOCATION_EXTRA)

Debug.ReloadFieldEnd()
