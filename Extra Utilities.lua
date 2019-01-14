REGISTER_FLAG_DETACH_XMAT=1
REGISTER_FLAG_CARDIAN=2
REGISTER_FLAG_THUNDRA=4

function Card.IsOriginalCode(c,cd)
	return c:GetOriginalCode()==cd
end
function Card.IsOriginalCodeRule(c,cd)
    local c1,c2=c:GetOriginalCodeRule()
    return c1==cd or c2==cd
end
function Card.IsSummonPlayer(c,tp)
	return c:GetSummonPlayer()==tp
end
function Card.IsPreviousControler(c,tp)
	return c:GetPreviousControler()==tp
end
function Card.IsHasLevel(c)
	return c:GetLevel()>0
end
function aux.FilterFaceupFunction(f,...)
	local params={...}
	return function(c)
		return c:IsFaceup() and f(c,params)
	end
end
