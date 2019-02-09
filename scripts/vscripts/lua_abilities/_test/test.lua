test_lua = class({})
LinkLuaModifier( "modifier_test", "lua_abilities/_test/modifier_test", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
function test_lua:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- print("CBaseAnimating:ActiveSequenceDuration()", target:ActiveSequenceDuration() ) 
	-- print("CBaseAnimating:IsSequenceFinished()", target:IsSequenceFinished() ) 
	print("CBaseAnimating:GetCycle()", target:GetCycle() ) 
	print("CBaseAnimating:GetSequence()", target:GetSequence() ) 
	target:StopAnimation()
	target:ResetSequence("idle_alt_anim")
	target:SetPoseParameter( "idle_alt_anim", 1.1 )
	print("CBaseAnimating:GetCycle()", target:GetCycle() ) 
	print("CBaseAnimating:GetSequence()", target:GetSequence() ) 
	print("CBaseAnimating:SetAnimation()", target.SetAnimation )
	target:SetRenderColor( 0, 255, 0 )
	-- target:SetSequence( "attack1" )
	-- target:StopAnimation()
end