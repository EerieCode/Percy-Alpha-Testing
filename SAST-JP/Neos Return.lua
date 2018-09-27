--Parameters:
-- c: the card that will receive the effect
-- extracat: optional, eventual extra categories for the effect. Adding CATEGORY_TODECK is not necessary
-- extrainfo: optional, eventual OperationInfo to be set in the target (see Nebula Neos)
-- extraop: optional, eventual operation to be performed if the card is returned to the ED (see Nebula Neos, NOT Magma Neos)
function Auxiliary.EnableNeosReturn(c,extracat,extrainfo,extraop)
	if not extracat then extracat=0 end
	--return
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK | extracat)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(Auxiliary.NOT(Auxiliary.NeosReturnCondition))
	e1:SetTarget(Auxiliary.NeosReturnTarget(c,extrainfo))
	e1:SetOperation(Auxiliary.NeosReturnOperation(c,extraop))
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(0)
	e2:SetCondition(Auxiliary.NeosReturnCondition)
	c:RegisterEffect(e2)
end
function Auxiliary.NeosReturnCondition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsHasEffect(42015635)
end
function Auxiliary.NeosReturnTarget(c,extrainfo)
	return function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return true end
		Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
		if extrainfo then extrainfo(e,tp,eg,ep,ev,re,r,rp,chk) end
	end
end
function Auxiliary.NeosReturnOperation(c,extraop)
	return function(e,tp,eg,ep,ev,re,r,rp)
		local c=e:GetHandler()
		if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
		local effs={Duel.GetPlayerEffect(tp,101007060)}
		local valideffs={}
		local sg=Group.CreateGroup()
		for _,te in ipairs(effs) do
			if te:GetCode()==101007060 then
				local cond=type(te:GetValue())=='function' and te:GetValue()(te,c,tp) or true
				if cond then
					sg:AddCard(te:GetHandler())
					table.insert(valideffs,te)
				end
			end
		end
		local mapresult={}
		for _,eff in ipairs(valideffs) do
			local handler = eff:GetHandler()
			if mapresult[handler] == nil then
				mapresult[handler] = {}
			end
			table.insert(mapresult[handler],eff)
		end
		local deck=true
		if #valideffs==1 then
			if Duel.SelectYesNo(tp,valideffs[1]:GetDescription()) then
				deck=false
				local tc=valideffs[1]:GetHandler()
				Duel.Hint(HINT_CARD,2,tc:GetCode())
				valideffs[1]:GetOperation()(valideffs[1],c,tp)
			end
		elseif #valideffs>1 and Duel.SelectYesNo(tp,1) then
			deck=false
			local tc
			if #sg==1 then
				tc=sg:GetFirst()
			else
				tc=sg:Select(tp,1,1,nil):GetFirst()
			end
			local opt=#mapresult[tc]>1 and Duel.SelectOption(tp,table.unpack(mapresult[tc])) or 1
			local seleff=mapresult[tc][opt]
			Duel.Hint(HINT_CARD,2,tc:GetCode())
			seleff:GetOperation()(seleff,c,tp)	
		end
		if deck then
			Duel.SendtoDeck(c,nil,2,REASON_EFFECT)
		end
		if c:IsLocation(LOCATION_EXTRA) then
			local id=c:GetCode()
			Duel.RaiseSingleEvent(c,EVENT_CUSTOM+id,e,0,0,0,0)
			if extraop then
				extraop(e,tp,eg,ep,ev,re,r,rp)
			end
		end
	end
end
