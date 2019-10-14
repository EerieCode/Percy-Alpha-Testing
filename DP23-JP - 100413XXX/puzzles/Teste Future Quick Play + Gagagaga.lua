--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Hand
Debug.AddCard(100413038,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(100413038,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--Monster Zones
local m_1=Debug.AddCard(43490025,0,0,LOCATION_MZONE,4,1,true)
local eq_1_1=Debug.AddCard(1118137,0,0,LOCATION_SZONE,1,5)
--Spell & Trap Zones
Debug.AddCard(83778600,0,0,LOCATION_SZONE,2,10)
--Monster Zones
Debug.AddCard(12472242,1,1,LOCATION_MZONE,3,1,true)
Debug.AddCard(67629977,1,1,LOCATION_MZONE,2,1,true)
Debug.AddCard(67629977,1,1,LOCATION_MZONE,0,1,true)
Debug.AddCard(67629977,1,1,LOCATION_MZONE,1,1,true)

--Hand
Debug.AddCard(19230407,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(27068117,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--GY
Debug.AddCard(31829185,0,0,LOCATION_GRAVE,0,POS_FACEUP)
--Monster Zones
Debug.AddCard(100413034,0,0,LOCATION_MZONE,1,1,true)
Debug.AddCard(100413034,0,0,LOCATION_MZONE,1,1,true)
Debug.AddCard(43490025,0,0,LOCATION_MZONE,3,1,true)
Debug.AddCard(100413034,0,0,LOCATION_MZONE,3,1,true)
Debug.AddCard(6983839,0,0,LOCATION_MZONE,2,1,true)

Debug.ReloadFieldEnd()
aux.BeginPuzzle()
Debug.PreEquip(eq_1_1,m_1)