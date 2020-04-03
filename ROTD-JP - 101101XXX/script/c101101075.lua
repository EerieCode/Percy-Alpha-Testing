--叛逆の堕天使
--Rebellious Darklord
--Scripted by edo9300
local s,id=GetID()
function s.initial_effect(c)
	local e1=Fusion.CreateSummonEff({handler=c,fusfilter=aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_DARK),extrafil=s.extrafil,stage2=s.stage2})
	local tg=e1:GetTarget()
	e1:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
					if chk==0 then return true end
					return tg(e,tp,eg,ep,ev,re,r,rp,chk)
				end)
	e1:SetCost(s.cost(tg))
	e1:SetCountLimit(1,id,EFFECT_COUNT_CODE_OATH)
	c:RegisterEffect(e1)
end
s.listed_series={0x9d}
function s.check(e)
	return function(tp,sg,fc)
		return not e:GetLabelObject() or not sg:IsContains(e:GetLabelObject())
	end
end
function s.extrafil(e,tp,mg1)
	return nil,s.check(e)
end
function s.costfilter(c,target,e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabelObject(c)
	local res = c:IsSetCard(0x9d) and c:IsType(TYPE_MONSTER) and (c:IsLocation(LOCATION_HAND) or c:IsFaceup())
				and c:IsAbleToGraveAsCost() and target(e,tp,eg,ep,ev,re,r,rp,0)
	e:SetLabelObject(nil)
	return res
end
function s.cost(target)
	return function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return Duel.IsExistingMatchingCard(s.costfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil,target,e,tp,eg,ep,ev,re,r,rp,chk) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local g=Duel.SelectMatchingCard(tp,s.costfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil,target,e,tp,eg,ep,ev,re,r,rp,chk)
		Duel.SendtoGrave(g,REASON_COST)
		e:SetLabel(g:GetFirst():GetAttack())
	end
end
function s.stage2(e,tc,tp,sg,chk)
	if chk==1 and e:IsHasType(EFFECT_TYPE_ACTIVATE) then
		local lp=e:GetLabel()
		if lp>0 and Duel.SelectYesNo(tp,aux.Stringid(id,0)) then
			Duel.BreakEffect()
			Duel.Recover(tp,lp,REASON_EFFECT)
		end
	end
end
