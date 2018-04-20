--ベルキャットファイター
--
--Scripted by Eerie Code
function c100231100.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,nil,3,3,c100231100.lcheck)
end
function c100231100.lcheck(g,lc)
	return g:IsExists(Card.IsType,1,nil,TYPE_TOKEN)
end
