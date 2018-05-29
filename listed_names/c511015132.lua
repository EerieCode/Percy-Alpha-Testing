--No. 13: Cain's Doom
--No.13 ケインズ・デビル (Anime)
--Fixed By TheOnePharaoh
function c511015132.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,1,2)
	c:EnableReviveLimit()
	--summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(511015132)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(c511015132.spcon)
	e1:SetOperation(c511015132.spop)
	c:RegisterEffect(e1)
	--lp set
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511015132,0))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCondition(c511015132.lpcon)
	e2:SetOperation(c511015132.lpop)
	c:RegisterEffect(e2)
	--Destroyed Damage
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetTarget(c511015132.damtg)
	e3:SetOperation(c511015132.damop)
	c:RegisterEffect(e3)
	--battle indestructable
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e4:SetValue(c511015132.indes)
	c:RegisterEffect(e4)
	if not c511015132.global_check then
		c511015132.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_ADJUST)
		ge1:SetCondition(c511015132.lpcheckcon)
		ge1:SetOperation(c511015132.lpcheckop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511015132.numchk)
		Duel.RegisterEffect(ge2,0)
	end
end
c511015132.listed_names={95442074}
c511015132.xyz_number=13
function c511015132.lpcheckcon(e,tp,eg,ev,ep,re,r,rp)
	if c511015132.LP0 and c511015132.LP1 and c511015132.LP0==Duel.GetLP(tp) and c511015132.LP1==Duel.GetLP(1-tp) then
	return false
	end
	return true
end
function c511015132.lpcheckop(e,tp,eg,ev,ep,re,r,rp)
	if not c511015132.LP0 then
	c511015132.LP0=Duel.GetLP(tp)
	end
	if not c511015132.LP1 then
	c511015132.LP1=Duel.GetLP(1-tp)
	end
	if Duel.GetLP(tp)==c511015132.LP0/2 and Duel.GetLP(1-tp)==c511015132.LP1/2 then
	Duel.RaiseEvent(e:GetHandler(),511015132,e,0,0,0,0)
	end
	c511015132.LP0=Duel.GetLP(tp)
	c511015132.LP1=Duel.GetLP(1-tp)
end
function c511015132.spcon(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	return ft>0 and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.IsExistingMatchingCard(Card.IsCode,tp,0,LOCATION_EXTRA,1,nil,95442074)
end
function c511015132.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		local g=Duel.GetFieldGroup(tp,LOCATION_MZONE,0)
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,true,false,POS_FACEUP)
		Duel.Destroy(g,REASON_EFFECT)
	end
end
function c511015132.lpcon(e,tp,eg,ep,ev,re,r,rp)
	if not re then return false end
	if re:GetHandler()==e:GetHandler() then
	return true
	end
	 return false 
end
function c511015132.lpop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetLP(tp,1000)
end
function c511015132.filter(c)
	return c:IsFaceup() and c:IsCode(95442074)
end
function c511015132.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511015132.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
end
function c511015132.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Damage(1-tp,e:GetHandler():GetAttack(),REASON_EFFECT)
end
function c511015132.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,69058960)
	Duel.CreateToken(1-tp,69058960)
end
function c511015132.indes(e,c)
	return not c:IsSetCard(0x48)
end