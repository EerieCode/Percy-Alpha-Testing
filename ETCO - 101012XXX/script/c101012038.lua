--百景戦都ゴルディロックス
--Landscaper Goldilocks
--scripted by Naim
local s,id=GetID()
function s.initial_effect(c)
	--self destroy on summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCondition(s.descon)
	e1:SetOperation(s.desop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--move
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,0))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(s.seqtg)
	e3:SetOperation(s.seqop)
	c:RegisterEffect(e3)
end
function s.descon(e)
	return e:GetHandler():GetSequence()~=2
end
function s.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
function s.seqtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
end

function s.seqop(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local at=Duel.GetAttacker()
	if not c:IsRelateToEffect(e) or c:IsControler(1-tp) or c:IsImmuneToEffect(e) or Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOZONE)
	local seq1=c:GetSequence() --register the sequence it comes from
	local dg=c:GetColumnGroup() --and the group of cards there
	local seq2=math.log(Duel.SelectDisableField(tp,1,LOCATION_MZONE,0,0),2) --where it goes to
	Duel.MoveSequence(c,seq2)
	if c:GetSequence()==seq2 and seq1~=seq2 then
		Duel.BreakEffect()
		if seq1>seq2 then
			seq1,seq2=seq2,seq1
		end
		dg:Merge(c:GetColumnGroup()) --and the group on its current column
		for i=seq1,seq2 do
			--do here the operations to get each of these sequence's column group
		end
		if #dg>0 then
			Duel.BreakEffect()
			Duel.Destroy(dg,REASON_EFFECT)
		end
	end
	--currently it only destroys cards in its current and its previous column, nothing in between
end
