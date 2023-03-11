// Created by Elfansoer
"use strict";

const BEHAVIOR_EVENT_START = 0;
const BEHAVIOR_EVENT_UPDATE = 1;
const BEHAVIOR_EVENT_END = 2;

function FireBehaviorEvent( event, state ) {
	const mousePos = GameUI.GetScreenWorldPosition( GameUI.GetCursorPosition() );
	const entities = GameUI.FindScreenEntities( GameUI.GetCursorPosition() );
	const entity = entities[0]?.entityIndex ?? undefined;

	GameEvents.SendEventClientSide( "custom_indicator", {
		"ability": state.ability,
		"behavior": state.behavior,
		"event": event,
		"unit": entity,
		"worldX": mousePos[0],
		"worldY": mousePos[1],
		"worldZ": mousePos[2],
	});
}

function ConsiderBehavior( target_behavior, last_state, current_state ) {
	if (current_state.behavior==target_behavior && last_state.behavior!=target_behavior) {
		// behavior change from something else to target behavior
		// starting behavior logic
		FireBehaviorEvent( BEHAVIOR_EVENT_START, current_state );
	}

	else if (current_state.behavior==target_behavior && last_state.ability!=current_state.ability) {
		// old ability ends, new ability starts
		// ending behavior logic for old ability, starting behavior logic for new ability
		FireBehaviorEvent( BEHAVIOR_EVENT_START, current_state );
		FireBehaviorEvent( BEHAVIOR_EVENT_END, last_state );
	}

	else if (current_state.behavior==target_behavior && last_state.ability==current_state.ability) {
		// behavior stays
		// update behavior logic
		FireBehaviorEvent( BEHAVIOR_EVENT_UPDATE, current_state );
	}

	else if (current_state.behavior!=last_state.behavior && last_state.behavior==target_behavior) {
		// behavior change from target behavior to something else
		// ending behavior logic
		FireBehaviorEvent( BEHAVIOR_EVENT_END, last_state );
	}
}

let last_state = {
	"behavior": CLICK_BEHAVIORS.DOTA_CLICK_BEHAVIOR_NONE,
	"ability": -1,
}
function UpdateMousePosition() {
	$.Schedule( 0.01, UpdateMousePosition );

	const current_state = {
		"behavior": GameUI.GetClickBehaviors(),
		"ability": Abilities.GetLocalPlayerActiveAbility(),
	}

	ConsiderBehavior( CLICK_BEHAVIORS.DOTA_CLICK_BEHAVIOR_CAST, last_state, current_state );
	ConsiderBehavior( CLICK_BEHAVIORS.DOTA_CLICK_BEHAVIOR_VECTOR_CAST, last_state, current_state );

	last_state = current_state;
}

(function() {
	$.Msg( "Hello from custom_indicator, World!" );
	UpdateMousePosition();
})();