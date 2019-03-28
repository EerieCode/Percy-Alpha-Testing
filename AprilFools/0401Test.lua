Debug.SetAIName("April Fools test")
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_TEST_MODE,4)
--DUEL_SIMPLE_AI
--DUEL_TEST_MODE
Debug.SetPlayerInfo(0,80000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Dark Magician Bear - opponent can still activate stuff on summon (eg torrential)
--[[
Debug.AddCard(512000127,0,0,LOCATION_MZONE,0,POS_FACEUP_ATTACK)
Debug.AddCard(512000127,0,0,LOCATION_MZONE,1,POS_FACEUP_ATTACK)
Debug.AddCard(1637760,1,1,LOCATION_SZONE,1,POS_FACEDOWN)
Debug.AddCard(53582587,1,1,LOCATION_SZONE,2,POS_FACEDOWN)
Debug.AddCard(8487449,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(83764718,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(81439173,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--]]

--Purple-Eyes Golden Dragon - works
--[[
Debug.AddCard(89631142,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(89631142,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(74677422,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(43096270,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(24094653,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--]]

--Stardust Milk - gains more than 1 counter if stuff are chained
--[[
Debug.AddCard(512000129,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(44508094,0,0,LOCATION_MZONE,0,POS_FACEUP_ATTACK)
Debug.AddCard(73580471,0,0,LOCATION_MZONE,1,POS_FACEUP_ATTACK)
Debug.AddCard(83968380,1,1,LOCATION_SZONE,0,POS_FACEDOWN)
Debug.AddCard(83968380,1,1,LOCATION_SZONE,1,POS_FACEDOWN)
Debug.AddCard(83555666,1,1,LOCATION_SZONE,2,POS_FACEDOWN)
Debug.AddCard(83968380,1,1,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(83968380,1,1,LOCATION_DECK,0,POS_FACEDOWN)
--]]

--My Hand Is Perfect! - works
--[[
Debug.AddCard(512000130,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(65303664,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(46668237,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(28139785,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(36033786,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(65303664,1,1,LOCATION_MZONE,0,POS_FACEUP_ATTACK)
--]]

--But You Still Take The Damage! - works
--[[
Debug.AddCard(512000131,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(49003308,0,0,LOCATION_MZONE,0,POS_FACEUP_ATTACK)
Debug.AddCard(49003308,1,1,LOCATION_MZONE,0,POS_FACEUP_ATTACK)
Debug.AddCard(4035199,1,1,LOCATION_MZONE,1,POS_FACEUP_ATTACK)
--]]

--Kusanagi's Truth - needs a string placeholder
--[[
Debug.AddCard(512000132,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(512000132,1,1,LOCATION_DECK,0,POS_FACEDOWN)
--]]

--Ultimate Battle Formation of Despair - works
--[[
Debug.AddCard(512000133,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(44095762,0,0,LOCATION_SZONE,0,POS_FACEDOWN)
Debug.AddCard(44095762,0,0,LOCATION_SZONE,1,POS_FACEDOWN)
Debug.AddCard(62279055,0,0,LOCATION_SZONE,2,POS_FACEDOWN)
Debug.AddCard(61740673,0,0,LOCATION_SZONE,3,POS_FACEDOWN)
Debug.AddCard(5043010,0,0,LOCATION_MZONE,2,POS_FACEUP_ATTACK)
Debug.AddCard(5043010,0,0,LOCATION_EXTRA,0,POS_FACEDOWN)
Debug.AddCard(5043010,0,0,LOCATION_EXTRA,0,POS_FACEDOWN)
Debug.AddCard(5043010,0,0,LOCATION_EXTRA,0,POS_FACEDOWN)
Debug.AddCard(5043010,0,0,LOCATION_EXTRA,0,POS_FACEDOWN)
--]]

--Scarf-kun - works
--[[
Debug.AddCard(512000134,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(24094653,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(19230407,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(19230407,1,1,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(93332803,1,1,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(5318639,1,1,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(69247929,0,0,LOCATION_MZONE,0,POS_FACEUP_ATTACK)
Debug.AddCard(11609969,0,0,LOCATION_MZONE,1,POS_FACEUP_ATTACK)
Debug.AddCard(74069667,0,0,LOCATION_MZONE,2,POS_FACEUP_ATTACK)
Debug.AddCard(8463720,0,0,LOCATION_EXTRA,0,POS_FACEDOWN)
Debug.AddCard(89631139,1,1,LOCATION_MZONE,0,POS_FACEUP_ATTACK)
--]]

--Mischief of the Incomplete Goddess - doesn't work (tested with Glad Beasts)
--[[
Debug.AddCard(512000135,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(78868776,0,0,LOCATION_MZONE,2,POS_FACEUP_ATTACK)
Debug.AddCard(29185231,0,0,LOCATION_SZONE,2,POS_FACEDOWN)
Debug.AddCard(41470137,0,0,LOCATION_DECK,0,POS_FACEDOWN)
--]]

--Bi of alcon - works
--[[
Debug.AddCard(31557782,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(512000136,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(512000136,0,0,LOCATION_MZONE,0,POS_FACEUP_ATTACK)
Debug.AddCard(512000136,1,1,LOCATION_MZONE,0,POS_FACEUP_ATTACK)
--]]

--Banlist Predictions - needs a string placeholder
--[[
Debug.AddCard(512000137,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(70368879,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--]]

Debug.AddCard(512000119,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(512000120,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(512000121,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(512000122,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(512000123,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(512000124,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(512000124,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(512000125,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(512000126,0,0,LOCATION_EXTRA,0,POS_FACEDOWN)
Debug.AddCard(512000127,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(512000128,0,0,LOCATION_EXTRA,0,POS_FACEDOWN)
Debug.AddCard(512000129,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(512000130,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(512000131,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(512000132,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(512000133,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(512000134,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(512000135,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(512000136,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(512000137,0,0,LOCATION_DECK,0,POS_FACEDOWN)


Debug.ReloadFieldEnd()
