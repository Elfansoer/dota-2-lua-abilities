// Created by Elfansoer
"use strict";

var init_pos = null;
var isTargeting = false;
function StartVectorTarget( location, ability ) {
	// Get Data
	var particle_cast = "particles/ui_mouseactions/range_finder_cone.vpcf";
	var caster = Abilities.GetCaster( ability );

	// Create Range Finder
	var effect_cast = Particles.CreateParticle( particle_cast, ParticleAttachment_t.PATTACH_WORLDORIGIN, caster );
	Particles.SetParticleControl( effect_cast, 0, Entities.GetAbsOrigin( caster ) );
	Particles.SetParticleControl( effect_cast, 1, location );
	Particles.SetParticleControl( effect_cast, 2, [0,0,0] );
	Particles.SetParticleControl( effect_cast, 3, [125, 125, 125] );
	Particles.SetParticleControl( effect_cast, 4, [0, 255, 0] );
	Particles.SetParticleControl( effect_cast, 6, [1, 0, 0] );

	// Loop
	$.Schedule( 0.01, function() {
		LoopVectorTarget( effect_cast, ability, location );
	});
}

function LoopVectorTarget( effect_cast, ability, location ) {
	// Get positions
	var end_pos = GameUI.GetScreenWorldPosition( GameUI.GetCursorPosition() )
	var direction = VectorMin( end_pos, location );
	direction = Game.Normalized( direction );
	var dist = Game.Length2D( end_pos, location );

	// Calculate init direction
	if (dist<0.05) {
		var caster = Abilities.GetCaster( ability );
		direction = VectorMin( location, Entities.GetAbsOrigin( caster ) );
		direction = Game.Normalized( direction );
	}
	
	// set minimum position
	if (dist<100) {
		end_pos = VectorAdd( location, VectorScale( direction, 100 ) );
	}

	// set particle
	Particles.SetParticleControl( effect_cast, 2, end_pos );

	// check if should continue
	var current_ability = Abilities.GetLocalPlayerActiveAbility();
	if (isTargeting && current_ability==ability ) {
		$.Schedule( 0.01, function() {
			LoopVectorTarget( effect_cast, ability, location );
		});
		return;
	}

	// cast finished
	Particles.DestroyParticleEffect( effect_cast, true );
	Particles.ReleaseParticleIndex( effect_cast );
}

function Init() {
	GameUI.SetMouseCallback( function( eventName, arg ) {
		var CONSUME_EVENT = true;
		var CONTINUE_PROCESSING_EVENT = false;

		// only for casting
		if ( GameUI.GetClickBehaviors()!==CLICK_BEHAVIORS.DOTA_CLICK_BEHAVIOR_CAST ) return CONTINUE_PROCESSING_EVENT;
		if ( arg !== 0 ) return CONTINUE_PROCESSING_EVENT;

		// filter ability
		var ability = Abilities.GetLocalPlayerActiveAbility()
		var isVectorTarget = Abilities.GetSpecialValueFor( ability, "vector_target" )
		if ( isVectorTarget!=1 ) return CONTINUE_PROCESSING_EVENT;

		// on press
		if ( eventName == "pressed") {
			// store point
			init_pos = GameUI.GetScreenWorldPosition( GameUI.GetCursorPosition() );

			// start drawing
			isTargeting = true
			StartVectorTarget( init_pos, ability );

			return CONSUME_EVENT;
		}

		// on release
		else if ( eventName == "released" ) {
			// stop casting
			Abilities.ExecuteAbility( ability, Players.GetLocalPlayerPortraitUnit(), true );

			// obtain final position
			var end_pos = GameUI.GetScreenWorldPosition( GameUI.GetCursorPosition() );

			// check if both start and end is close
			var direction;
			if ( Game.Length2D( end_pos, init_pos )<0.05 ) {
				var caster = Abilities.GetCaster( ability );
				direction = VectorMin( init_pos, Entities.GetAbsOrigin( caster ) );
				end_pos = init_pos;
			} else {
				direction = VectorMin( end_pos, init_pos );
			}
			direction[2] = 0;
			direction = Game.Normalized( direction );

			// send data
			var data = {};
			data.init_pos = init_pos;
			data.end_pos = end_pos;
			data.direction = direction;
			data.ability = ability;
			GameEvents.SendCustomGameEventToServer( "vector_target", data );

			// create order
			var order = {};
			order.AbilityIndex = ability;
			order.OrderType = dotaunitorder_t.DOTA_UNIT_ORDER_CAST_POSITION;
			order.Position = init_pos;
			order.Queue = false;
			order.ShowEffects = false;
			Game.PrepareUnitOrders( order );

			// reset
			init_pos = null;

			// stop drawing
			isTargeting = false;

			return CONTINUE_PROCESSING_EVENT;
		}
		return CONTINUE_PROCESSING_EVENT;
	} );
}

// Helper
function VectorAdd( v1, v2 ) {
	return [ v1[0]+v2[0], v1[1]+v2[1], 0 ];
}
function VectorMin( v1, v2 ) {
	return [ v1[0]-v2[0], v1[1]-v2[1], 0 ];
}
function VectorScale( v1, c ) {
	return [ v1[0]*c, v1[1]*c, 0 ];
}

(function() {
	$.Msg( "Hello from vector_target, World!" );
	Init();
})();