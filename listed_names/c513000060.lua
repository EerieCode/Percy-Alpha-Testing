--No.39 希望皇ビヨンド・ザ・ホープ
--Fixed and Cleaned By:TheOnePharaoh
function c513000060.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,6,2)
	c:EnableReviveLimit()
	--Immune
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_ONFIELD,0)
	e1:SetValue(c513000060.efilter)
	c:RegisterEffect(e1)
	--Rank Up Check
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c513000060.rankupregcon)
	e2:SetOperation(c513000060.rankupregop)
	c:RegisterEffect(e2)
	-- --Setcode
	-- local e4=Effect.CreateEffect(c)
	-- e4:SetType(EFFECT_TYPE_SINGLE)
	-- e4:SetCode(EFFECT_REMOVE_SETCODE)
	-- e4:SetValue(0x107f)
	-- c:RegisterEffect(e4)
	-- local e5=Effect.CreateEffect(c)
	-- e5:SetType(EFFECT_TYPE_SINGLE)
	-- e5:SetCode(EFFECT_ADD_SETCODE)
	-- e5:SetValue(0x7f)
	-- c:RegisterEffect(e5)
	--battle indestructable
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e6:SetValue(c513000060.indes)
	c:RegisterEffect(e6)
	if not c513000060.global_check then
		c513000060.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c513000060.numchk)
		Duel.RegisterEffect(ge2,0)
	end
end
c513000060.listed_names={84013237,100000581,111011002,511000580,511002068,511002164,93238626,84013237}
c513000060.xyz_number=39
function c513000060.efilter(e,re)
	return re:GetOwnerPlayer()~=e:GetHandlerPlayer()
end
function c513000060.rumfilter(c)
	return c:IsCode(84013237) and not c:IsPreviousLocation(LOCATION_OVERLAY)
end
function c513000060.rankupregcon(e,tp,eg,ep,ev,re,r,rp)
	if not re then return false end
	local rc=re:GetHandler()
	return e:GetHandler():IsSummonType(SUMMON_TYPE_XYZ) and rc 
		and (rc:IsSetCard(0x95) or rc:IsCode(100000581) or rc:IsCode(111011002) or rc:IsCode(511000580) or rc:IsCode(511002068) or rc:IsCode(511002164) or rc:IsCode(93238626)) 
		and e:GetHandler():GetMaterial():IsExists(c513000060.rumfilter,1,nil)
end
function c513000060.rankupregop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--atk down
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SET_ATTACK_FINAL)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetCondition(c513000060.atkcon)
	e2:SetValue(0)
	e2:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(21521304,1))
	e3:SetCategory(CATEGORY_REMOVE+CATEGORY_SPECIAL_SUMMON+CATEGORY_RECOVER)
	e3:SetProperty(0,EFFECT_FLAG2_XMDETACH)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c513000060.spcon)
	e3:SetCost(c513000060.spcost)
	e3:SetTarget(c513000060.sptg)
	e3:SetOperation(c513000060.spop)
	e3:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e3)
end
function c513000060.atkcon(e)
	local ph=Duel.GetCurrentPhase()
	return Duel.GetTurnPlayer()==e:GetHandlerPlayer() and ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE
end
function c513000060.spcon(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE
end
function c513000060.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c513000060.rmfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsAbleToRemove()
end
function c513000060.spfilter(c,e,tp)
	return c:IsCode(84013237) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c513000060.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c513000060.rmfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,0,0)
end
function c513000060.spop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g1=Duel.SelectMatchingCard(tp,c513000060.rmfilter,tp,LOCATION_MZONE,0,1,1,nil)
	if g1:GetCount()>0 then
		Duel.HintSelection(g1)
		if Duel.Remove(g1,POS_FACEUP,REASON_EFFECT)==0 then return end
		Duel.BreakEffect()
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g2=Duel.SelectMatchingCard(tp,c513000060.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
		Duel.HintSelection(g2)
		if Duel.SpecialSummon(g2,0,tp,tp,false,false,POS_FACEUP)==0 then return end
		Duel.BreakEffect()
		Duel.Recover(tp,g2:GetFirst():GetAttack()/2,REASON_EFFECT)
	end
end
function c513000060.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,21521304)
	Duel.CreateToken(1-tp,21521304)
end
function c513000060.indes(e,c)
	return not c:IsSetCard(0x48)
end
