--Shiranui Skillsaga
--Logical Nonsense
function c(ShiranuiSkillsaga).initial_effect(c)
	--Special summon once per turn
	c:SetSPSummonOnce((ShiranuiSkillsaga))
	--Synchro summon
	aux.AddSynchroProcedure(c,nil,1,1,aux.NonTuner(nil),1,99)
	c:EnableReviveLimit()
	--Change battle position
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetTarget(c(ShiranuiSkillsaga).postg)
	e1:SetOperation(c(ShiranuiSkillsaga).posop)
	c:RegisterEffect(e1)
	--Special summon token optional trigger effect
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid((ShiranuiSkillsaga),1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_REMOVE)
	e2:SetCountLimit(1,(ShiranuiSkillsaga))
	e2:SetTarget(c(ShiranuiSkillsaga).target)
	e2:SetOperation(c(ShiranuiSkillsaga).operation)
	c:RegisterEffect(e2)
end
	--Check for monsters that can have its position changed
function c(ShiranuiSkillsaga).filter(c)
	return c:IsCanChangePosition()
end
	--Activation legality
function c(ShiranuiSkillsaga).postg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c(ShiranuiSkillsaga).filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c(ShiranuiSkillsaga).filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectTarget(tp,c(ShiranuiSkillsaga).filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
	--Performing the battle position effect
function c(ShiranuiSkillsaga).posop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.ChangePosition(tc,POS_FACEUP_DEFENSE,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK)
	end
end
	--Activation legality
function c(ShiranuiSkillsaga).target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsPlayerCanSpecialSummonMonster(tp,(ShiranuiSkillsaga_Token),0,0x4011,0,0,1,RACE_ZOMBIE,ATTRIBUTE_FIRE)end --Designing the token's stats
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
	--Performing the optional token effect
function c(ShiranuiSkillsaga).operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if Duel.IsPlayerCanSpecialSummonMonster(tp,(ShiranuiSkillsaga_Token),0,0x4011,0,0,1,RACE_ZOMBIE,ATTRIBUTE_FIRE)) then
		local token=Duel.CreateToken(tp,(ShiranuiSkillsaga_Token))
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
	end
end