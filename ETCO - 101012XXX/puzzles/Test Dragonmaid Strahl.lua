--Dragonmaid Strahl Test
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN, 4)
Debug.SetPlayerInfo(0,4000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

Debug.AddCard(40110009,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(40110009,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(89631139,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(38699854,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(16960120,0,0,LOCATION_HAND,0,POS_FACEDOWN)

Debug.AddCard(89631139,0,0,LOCATION_GRAVE,0,POS_FACEUP)

Debug.AddCard(101012041,0,0,LOCATION_EXTRA,0,POS_FACEDOWN)
Debug.AddCard(41232647,0,0,LOCATION_EXTRA,0,POS_FACEDOWN)

Debug.AddCard(13171876,0,0,LOCATION_MZONE,2,POS_FACEUP_ATTACK)
Debug.AddCard(49575521,0,0,LOCATION_MZONE,3,POS_FACEUP_ATTACK)
Debug.AddCard(94192409,0,0,LOCATION_SZONE,3,POS_FACEDOWN)

Debug.AddCard(78700060,1,1,LOCATION_MZONE,2,POS_FACEUP_ATTACK)
Debug.AddCard(4130270,1,1,LOCATION_MZONE,3,POS_FACEDOWN)
Debug.AddCard(73356503,1,1,LOCATION_MZONE,1,POS_FACEDOWN)
Debug.AddCard(60306104,1,1,LOCATION_SZONE,2,POS_FACEDOWN)

Debug.ReloadFieldEnd()
