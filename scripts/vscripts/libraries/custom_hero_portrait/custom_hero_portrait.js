// Created by Elfansoer
/*
Convention: Custom heroes have HeroID with range of 200-255 so that it makes it easier to check if the hero is custom or not.
We can use other stuff like sending data from server about which are custom heroes, but that's just complicated for me.
*/

"use strict";

function IsHeroImageCustom( HeroImage ) {
	return HeroImage.heroid >=200;
}

function ReplacePortrait( HeroImage, isHorizontal ) {
	if (!IsHeroImageCustom(HeroImage)) {
		HeroImage.RemoveClass("CustomHeroImage");
		HeroImage.style.backgroundImage = null;
		return;
	}

	HeroImage.AddClass("CustomHeroImage");
	const pathModifier = isHorizontal ? '' : '/selection';
	HeroImage.style.backgroundImage = 'url("file://{images}/heroes' + pathModifier + '/npc_dota_hero_' + HeroImage.heroname + '.png")';
	HeroImage.style.backgroundSize = '100% 100%';
}

///////////////////////////////
// Selection: Grid View Manager
let HeroImages = [];
function FindGridViewCustomHeroImages() {
	return GetDotaHud().FindChildTraverse('GridCategories')
		.FindChildrenWithClassTraverse("HeroCardContents")
		.map(HeroCardContents=>HeroCardContents.FindChild("HeroImage"))
		.filter(HeroImage=>IsHeroImageCustom(HeroImage));
}

function GridViewCustomHeroManager() {
	UpdateGridViewCustomHeroManager();
}

function UpdateGridViewCustomHeroManager() {
	HeroImages = FindGridViewCustomHeroImages();
	for (const HeroImage of HeroImages) {
		ReplacePortrait(HeroImage,false);
	}

	if ( Game.GameStateIsBefore(DOTA_GameState.DOTA_GAMERULES_STATE_PRE_GAME) ) {
		$.Schedule(2, UpdateGridViewCustomHeroManager);
	}
}

///////////////////////////////
// Selection: Top Bar manager
let TopBarHeroImages = [];
function FindTopBarHeroImages() {
	return []
		.concat( GetDotaHud().FindChildTraverse('RadiantTeamPlayers').Children() )
		.concat( GetDotaHud().FindChildTraverse('DireTeamPlayers').Children() )
		.map((panel)=>panel.FindChildTraverse("HeroImage"));
}

function TopBarCustomHeroManager() {
	TopBarHeroImages = FindTopBarHeroImages();
	UpdateTopBarCustomHeroManager();
}

function UpdateTopBarCustomHeroManager() {
	for (const HeroImage of TopBarHeroImages) {
		ReplacePortrait(HeroImage,true);
	}
	if ( Game.GameStateIsBefore(DOTA_GameState.DOTA_GAMERULES_STATE_PRE_GAME) ) {
		$.Schedule(0.1, UpdateTopBarCustomHeroManager);
	}
}

///////////////////////////////
// Selection: Hero Inspect manager
let inspectMovie, tooltipMovie;

function FindInspectMovie() {
	return GetDotaHud().FindChildTraverse( "HeroInspect" ).FindChildTraverse( "HeroMovie" );
}

function FindTooltipMovie() {
	return GetDotaHud().FindChildTraverse( "HeroCardTooltip" )?.FindChildTraverse( "HeroMovie" );
}

function InspectCustomHeroManager() {
	inspectMovie = FindInspectMovie();
	tooltipMovie = FindTooltipMovie();
	UpdateInspectCustomHeroManager();
}

function UpdateInspectCustomHeroManager() {
	ReplacePortrait(inspectMovie,false);

	if (tooltipMovie==undefined || !tooltipMovie.IsValid()) {
		tooltipMovie = FindTooltipMovie();
	}	
	
	if (tooltipMovie) {
		const tooltipImage = tooltipMovie?.GetParent().FindChild( "HeroImage" );
		ReplacePortrait(tooltipMovie,false);
		ReplacePortrait(tooltipImage,false);
	}

	if ( Game.GameStateIsBefore(DOTA_GameState.DOTA_GAMERULES_STATE_PRE_GAME) ) {
		$.Schedule(0.1, UpdateInspectCustomHeroManager);
	}
}

///////////////////////////////
// In Game: Top Bar manager
let GameTopBarHeroImages = [];

function FindGameTopBarHeroImages() {
	return GetDotaHud().FindChildrenWithClassTraverse( "TopBarPlayerSlot" )
		.map( topbar=>topbar.FindChildTraverse( "HeroImage" ) );
}

function GameTopBarCustomHeroManager() {
	GameTopBarHeroImages = FindGameTopBarHeroImages();
	for (const HeroImage of GameTopBarHeroImages) {
		ReplacePortrait(HeroImage,true);
	}

	UpdateGameTopBarCustomHeroManager();
}

function UpdateGameTopBarCustomHeroManager() {
	// check dirty
	const isDirty = GameTopBarHeroImages.some(HeroImage=>!HeroImage.IsValid());
	if (isDirty) {
		GameTopBarHeroImages = FindGameTopBarHeroImages();
		for (const HeroImage of GameTopBarHeroImages) {
			ReplacePortrait(HeroImage,true);
		}	
	}

	$.Schedule(1, UpdateGameTopBarCustomHeroManager);
}

///////////////////////////////
// In Game: Scoreboard
let GameScoreboardHeroImages = [];

function FindGameScoreboardHeroImages() {
	return GetDotaHud().FindChildrenWithClassTraverse( "ScoreboardHeroImage" );
}

function GameScoreboardCustomHeroManager() {
	GameScoreboardHeroImages = FindGameScoreboardHeroImages();
	for (const HeroImage of GameScoreboardHeroImages) {
		ReplacePortrait(HeroImage,true);
	}

	UpdateGameScoreboardCustomHeroManager();
}

function UpdateGameScoreboardCustomHeroManager() {
	// check dirty
	const isDirty = GameScoreboardHeroImages.length==0 || GameScoreboardHeroImages.some(HeroImage=>!HeroImage.IsValid());
	if (isDirty) {
		GameScoreboardHeroImages = FindGameScoreboardHeroImages();
		for (const HeroImage of GameScoreboardHeroImages) {
			ReplacePortrait(HeroImage,true);
		}
	}

	$.Schedule(1, UpdateGameScoreboardCustomHeroManager);
}

///////////////////////////////
// Initialization
let HeroSelectInitialized = false;
let PreGameInitialized = false;
function UpdateCustomHeroPortrait() {
	if (
		!HeroSelectInitialized &&
		(Game.GameStateIs(DOTA_GameState.DOTA_GAMERULES_STATE_HERO_SELECTION) ||
		Game.GameStateIs(DOTA_GameState.DOTA_GAMERULES_STATE_STRATEGY_TIME))
	) {
		HeroSelectInitialized = true;
		GridViewCustomHeroManager();
		TopBarCustomHeroManager();
		InspectCustomHeroManager();
	}

	if (
		!PreGameInitialized &&
		(Game.GameStateIs(DOTA_GameState.DOTA_GAMERULES_STATE_PRE_GAME) ||
		Game.GameStateIs(DOTA_GameState.DOTA_GAMERULES_STATE_GAME_IN_PROGRESS))
	) {
		PreGameInitialized = true;
		GameTopBarCustomHeroManager();
		GameScoreboardCustomHeroManager();
	}

	if (!PreGameInitialized) {
		$.Schedule(1, UpdateCustomHeroPortrait);
	}
}

(function() {
	$.Msg( "Hello from custom_hero_portrait, World!" );
	UpdateCustomHeroPortrait();
})();

///////////////////////////////
// utils
function GetDotaHud() {
	let p = $.GetContextPanel();
	try {
		while (true) {
			if (p.id === "Hud")
				return p;
			else
				p = p.GetParent();
		}
	} catch (e) {}
}
