--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,4)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--GY
Debug.AddCard(101011080,0,0,LOCATION_GRAVE,0,POS_FACEUP)
--Spell & Trap Zones
Debug.AddCard(101011080,0,0,LOCATION_SZONE,2,10)
Debug.AddCard(101011080,0,0,LOCATION_SZONE,1,5)

--[[
--Hand
Debug.AddCard(94454495,1,1,LOCATION_HAND,0,POS_FACEDOWN)
--Monster Zones
Debug.AddCard(31061682,1,1,LOCATION_MZONE,2,1,true)

]]
--Hand
Debug.AddCard(94454495,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--Monster Zones
Debug.AddCard(31061682,0,0,LOCATION_MZONE,2,1,true)

Debug.ReloadFieldEnd()
aux.BeginPuzzle()