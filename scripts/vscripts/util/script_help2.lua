return [[---[[ AddFOWViewer  Add temporary vision for a given team, returns a ViewerID ( nTeamID, vLocation, flRadius, flDuration, bObstructedVision) ])
-- @return int
-- @param int_1 int
-- @param Vector_2 Vector
-- @param float_3 float
-- @param float_4 float
-- @param bool_5 bool
function AddFOWViewer( int_1, Vector_2, float_3, float_4, bool_5 ) end

---[[ AngleDiff  Returns the number of degrees difference between two yaw angles ])
-- @return float
-- @param float_1 float
-- @param float_2 float
function AngleDiff( float_1, float_2 ) end

---[[ AnglesToVector  Generate a vector given a QAngles ])
-- @return Vector
-- @param QAngle_1 QAngle
function AnglesToVector( QAngle_1 ) end

---[[ AppendToLogFile  AppendToLogFile is deprecated. Print to the console for logging instead. ])
-- @return void
-- @param string_1 string
-- @param string_2 string
function AppendToLogFile( string_1, string_2 ) end

---[[ ApplyDamage  Damage an npc. ])
-- @return float
-- @param handle_1 handle
function ApplyDamage( handle_1 ) end

---[[ AxisAngleToQuaternion  (vector,float) constructs a quaternion representing a rotation by angle around the specified vector axis ])
-- @return Quaternion
-- @param Vector_1 Vector
-- @param float_2 float
function AxisAngleToQuaternion( Vector_1, float_2 ) end

---[[ CalcClosestPointOnEntityOBB  Compute the closest point on the OBB of an entity. ])
-- @return Vector
-- @param handle_1 handle
-- @param Vector_2 Vector
function CalcClosestPointOnEntityOBB( handle_1, Vector_2 ) end

---[[ CalcDistanceBetweenEntityOBB  Compute the distance between two entity OBB. A negative return value indicates an input error. A return value of zero indicates that the OBBs are overlapping. ])
-- @return float
-- @param handle_1 handle
-- @param handle_2 handle
function CalcDistanceBetweenEntityOBB( handle_1, handle_2 ) end

---[[ CalcDistanceToLineSegment2D   ])
-- @return float
-- @param Vector_1 Vector
-- @param Vector_2 Vector
-- @param Vector_3 Vector
function CalcDistanceToLineSegment2D( Vector_1, Vector_2, Vector_3 ) end

---[[ CancelEntityIOEvents  Create all I/O events for a particular entity ])
-- @return void
-- @param ehandle_1 ehandle
function CancelEntityIOEvents( ehandle_1 ) end

---[[ CenterCameraOnUnit  CenterCameraOnUnit( nPlayerId, hUnit ): Centers each players' camera on a unit. ])
-- @return void
-- @param int_1 int
-- @param handle_2 handle
function CenterCameraOnUnit( int_1, handle_2 ) end

---[[ ClearTeamCustomHealthbarColor  ( teamNumber ) ])
-- @return void
-- @param int_1 int
function ClearTeamCustomHealthbarColor( int_1 ) end

---[[ CreateDamageInfo  (hInflictor, hAttacker, flDamage) - Allocate a damageinfo object, used as an argument to TakeDamage(). Call DestroyDamageInfo( hInfo ) to free the object. ])
-- @return handle
-- @param handle_1 handle
-- @param handle_2 handle
-- @param Vector_3 Vector
-- @param Vector_4 Vector
-- @param float_5 float
-- @param int_6 int
function CreateDamageInfo( handle_1, handle_2, Vector_3, Vector_4, float_5, int_6 ) end

---[[ CreateEffect  Pass table - Inputs: entity, effect ])
-- @return bool
-- @param handle_1 handle
function CreateEffect( handle_1 ) end

---[[ CreateHTTPRequest  Create an HTTP request. ])
-- @return handle
-- @param string_1 string
-- @param string_2 string
function CreateHTTPRequest( string_1, string_2 ) end

---[[ CreateHTTPRequestScriptVM  Create an HTTP request. ])
-- @return handle
-- @param string_1 string
-- @param string_2 string
function CreateHTTPRequestScriptVM( string_1, string_2 ) end

---[[ CreateHeroForPlayer  Creates a DOTA hero by its dota_npc_units.txt name and sets it as the given player's controlled hero ])
-- @return handle
-- @param string_1 string
-- @param handle_2 handle
function CreateHeroForPlayer( string_1, handle_2 ) end

---[[ CreateIllusions  Create illusions of the passed hero that belong to passed unit using passed modifier data. ( hOwner, hHeroToCopy, hModiiferKeys, nNumIllusions, nPadding, bScramblePosition, bFindClearSpace ) 
Supported keys: 
outgoing_damage
incoming_damage
bounty_base
bounty_growth
outgoing_damage_structure
outgoing_damage_roshan ])
-- @return table
-- @param handle_1 handle
-- @param handle_2 handle
-- @param handle_3 handle
-- @param int_4 int
-- @param int_5 int
-- @param bool_6 bool
-- @param bool_7 bool
function CreateIllusions( handle_1, handle_2, handle_3, int_4, int_5, bool_6, bool_7 ) end

---[[ CreateItem  Create a DOTA item ])
-- @return handle
-- @param string_1 string
-- @param handle_2 handle
-- @param handle_3 handle
function CreateItem( string_1, handle_2, handle_3 ) end

---[[ CreateItemOnPositionForLaunch  Create a physical item at a given location, can start in air (but doesn't clear a space) ])
-- @return handle
-- @param Vector_1 Vector
-- @param handle_2 handle
function CreateItemOnPositionForLaunch( Vector_1, handle_2 ) end

---[[ CreateItemOnPositionSync  Create a physical item at a given location ])
-- @return handle
-- @param Vector_1 Vector
-- @param handle_2 handle
function CreateItemOnPositionSync( Vector_1, handle_2 ) end

---[[ CreateModifierThinker  Create a modifier not associated with an NPC. ( hCaster, hAbility, modifierName, paramTable, vOrigin, nTeamNumber, bPhantomBlocker ) ])
-- @return handle
-- @param handle_1 handle
-- @param handle_2 handle
-- @param string_3 string
-- @param handle_4 handle
-- @param Vector_5 Vector
-- @param int_6 int
-- @param bool_7 bool
function CreateModifierThinker( handle_1, handle_2, string_3, handle_4, Vector_5, int_6, bool_7 ) end

---[[ CreateRune  Create a rune of the specified type (vLocation, iRuneType). ])
-- @return handle
-- @param Vector_1 Vector
-- @param int_2 int
function CreateRune( Vector_1, int_2 ) end

---[[ CreateSceneEntity  Create a scene entity to play the specified scene. ])
-- @return handle
-- @param string_1 string
function CreateSceneEntity( string_1 ) end

---[[ CreateTempTree  Create a temporary tree, uses a default tree model. (vLocation, flDuration). ])
-- @return handle
-- @param Vector_1 Vector
-- @param float_2 float
function CreateTempTree( Vector_1, float_2 ) end

---[[ CreateTempTreeWithModel  Create a temporary tree, specifying the tree model name. (vLocation, flDuration, szModelName). ])
-- @return handle
-- @param Vector_1 Vector
-- @param float_2 float
-- @param string_3 string
function CreateTempTreeWithModel( Vector_1, float_2, string_3 ) end

---[[ CreateTrigger  CreateTrigger( vecMin, vecMax ) : Creates and returns an AABB trigger ])
-- @return handle
-- @param Vector_1 Vector
-- @param Vector_2 Vector
-- @param Vector_3 Vector
function CreateTrigger( Vector_1, Vector_2, Vector_3 ) end

---[[ CreateTriggerRadiusApproximate  CreateTriggerRadiusApproximate( vecOrigin, flRadius ) : Creates and returns an AABB trigger thats bigger than the radius provided ])
-- @return handle
-- @param Vector_1 Vector
-- @param float_2 float
function CreateTriggerRadiusApproximate( Vector_1, float_2 ) end

---[[ CreateUniformRandomStream  ( iSeed ) - Creates a separate random number stream. ])
-- @return handle
-- @param int_1 int
function CreateUniformRandomStream( int_1 ) end

---[[ CreateUnitByName  Creates a DOTA unit by its dota_npc_units.txt name ])
-- @return handle
-- @param string_1 string
-- @param Vector_2 Vector
-- @param bool_3 bool
-- @param handle_4 handle
-- @param handle_5 handle
-- @param int_6 int
function CreateUnitByName( string_1, Vector_2, bool_3, handle_4, handle_5, int_6 ) end

---[[ CreateUnitByNameAsync  Creates a DOTA unit by its dota_npc_units.txt name ])
-- @return int
-- @param string_1 string
-- @param Vector_2 Vector
-- @param bool_3 bool
-- @param handle_4 handle
-- @param handle_5 handle
-- @param int_6 int
-- @param handle_7 handle
function CreateUnitByNameAsync( string_1, Vector_2, bool_3, handle_4, handle_5, int_6, handle_7 ) end

---[[ CreateUnitFromTable  Creates a DOTA unit by its dota_npc_units.txt name from a table of entity key values and a position to spawn at. ])
-- @return handle
-- @param handle_1 handle
-- @param Vector_2 Vector
function CreateUnitFromTable( handle_1, Vector_2 ) end

---[[ CrossVectors  (vector,vector) cross product between two vectors ])
-- @return Vector
-- @param Vector_1 Vector
-- @param Vector_2 Vector
function CrossVectors( Vector_1, Vector_2 ) end

---[[ DOTA_SpawnMapAtPosition  Spawn a .vmap at the target location. ])
-- @return int
-- @param string_1 string
-- @param Vector_2 Vector
-- @param bool_3 bool
-- @param handle_4 handle
-- @param handle_5 handle
-- @param handle_6 handle
function DOTA_SpawnMapAtPosition( string_1, Vector_2, bool_3, handle_4, handle_5, handle_6 ) end

---[[ DebugBreak  Breaks in the debugger ])
-- @return void
function DebugBreak(  ) end

---[[ DebugCreateUnit  Creates a test unit controllable by the specified player. ])
-- @return int
-- @param handle_1 handle
-- @param string_2 string
-- @param int_3 int
-- @param bool_4 bool
-- @param handle_5 handle
function DebugCreateUnit( handle_1, string_2, int_3, bool_4, handle_5 ) end

---[[ DebugDrawBox  Draw a debug overlay box (origin, mins, maxs, forward, r, g, b, a, duration ) ])
-- @return void
-- @param Vector_1 Vector
-- @param Vector_2 Vector
-- @param Vector_3 Vector
-- @param int_4 int
-- @param int_5 int
-- @param int_6 int
-- @param int_7 int
-- @param float_8 float
function DebugDrawBox( Vector_1, Vector_2, Vector_3, int_4, int_5, int_6, int_7, float_8 ) end

---[[ DebugDrawBoxDirection  Draw a debug forward box (cent, min, max, forward, vRgb, a, duration) ])
-- @return void
-- @param Vector_1 Vector
-- @param Vector_2 Vector
-- @param Vector_3 Vector
-- @param Vector_4 Vector
-- @param Vector_5 Vector
-- @param float_6 float
-- @param float_7 float
function DebugDrawBoxDirection( Vector_1, Vector_2, Vector_3, Vector_4, Vector_5, float_6, float_7 ) end

---[[ DebugDrawCircle  Draw a debug circle (center, vRgb, a, rad, ztest, duration) ])
-- @return void
-- @param Vector_1 Vector
-- @param Vector_2 Vector
-- @param float_3 float
-- @param float_4 float
-- @param bool_5 bool
-- @param float_6 float
function DebugDrawCircle( Vector_1, Vector_2, float_3, float_4, bool_5, float_6 ) end

---[[ DebugDrawClear  Try to clear all the debug overlay info ])
-- @return void
function DebugDrawClear(  ) end

---[[ DebugDrawLine  Draw a debug overlay line (origin, target, r, g, b, ztest, duration) ])
-- @return void
-- @param Vector_1 Vector
-- @param Vector_2 Vector
-- @param int_3 int
-- @param int_4 int
-- @param int_5 int
-- @param bool_6 bool
-- @param float_7 float
function DebugDrawLine( Vector_1, Vector_2, int_3, int_4, int_5, bool_6, float_7 ) end

---[[ DebugDrawLine_vCol  Draw a debug line using color vec (start, end, vRgb, a, ztest, duration) ])
-- @return void
-- @param Vector_1 Vector
-- @param Vector_2 Vector
-- @param Vector_3 Vector
-- @param bool_4 bool
-- @param float_5 float
function DebugDrawLine_vCol( Vector_1, Vector_2, Vector_3, bool_4, float_5 ) end

---[[ DebugDrawScreenTextLine  Draw text with a line offset (x, y, lineOffset, text, r, g, b, a, duration) ])
-- @return void
-- @param float_1 float
-- @param float_2 float
-- @param int_3 int
-- @param string_4 string
-- @param int_5 int
-- @param int_6 int
-- @param int_7 int
-- @param int_8 int
-- @param float_9 float
function DebugDrawScreenTextLine( float_1, float_2, int_3, string_4, int_5, int_6, int_7, int_8, float_9 ) end

---[[ DebugDrawSphere  Draw a debug sphere (center, vRgb, a, rad, ztest, duration) ])
-- @return void
-- @param Vector_1 Vector
-- @param Vector_2 Vector
-- @param float_3 float
-- @param float_4 float
-- @param bool_5 bool
-- @param float_6 float
function DebugDrawSphere( Vector_1, Vector_2, float_3, float_4, bool_5, float_6 ) end

---[[ DebugDrawText  Draw text in 3d (origin, text, bViewCheck, duration) ])
-- @return void
-- @param Vector_1 Vector
-- @param string_2 string
-- @param bool_3 bool
-- @param float_4 float
function DebugDrawText( Vector_1, string_2, bool_3, float_4 ) end

---[[ DebugScreenTextPretty  Draw pretty debug text (x, y, lineOffset, text, r, g, b, a, duration, font, size, bBold) ])
-- @return void
-- @param float_1 float
-- @param float_2 float
-- @param int_3 int
-- @param string_4 string
-- @param int_5 int
-- @param int_6 int
-- @param int_7 int
-- @param int_8 int
-- @param float_9 float
-- @param string_10 string
-- @param int_11 int
-- @param bool_12 bool
function DebugScreenTextPretty( float_1, float_2, int_3, string_4, int_5, int_6, int_7, int_8, float_9, string_10, int_11, bool_12 ) end

---[[ DestroyDamageInfo  Free a damageinfo object that was created with CreateDamageInfo(). ])
-- @return void
-- @param handle_1 handle
function DestroyDamageInfo( handle_1 ) end

---[[ DoCleaveAttack  (hAttacker, hTarget, hAbility, fDamage, fRadius, effectName) ])
-- @return int
-- @param handle_1 handle
-- @param handle_2 handle
-- @param handle_3 handle
-- @param float_4 float
-- @param float_5 float
-- @param float_6 float
-- @param float_7 float
-- @param string_8 string
function DoCleaveAttack( handle_1, handle_2, handle_3, float_4, float_5, float_6, float_7, string_8 ) end

---[[ DoEntFire  #EntFire:Generate and entity i/o event ])
-- @return void
-- @param string_1 string
-- @param string_2 string
-- @param string_3 string
-- @param float_4 float
-- @param handle_5 handle
-- @param handle_6 handle
function DoEntFire( string_1, string_2, string_3, float_4, handle_5, handle_6 ) end

---[[ DoEntFireByInstanceHandle  #EntFireByHandle:Generate and entity i/o event ])
-- @return void
-- @param handle_1 handle
-- @param string_2 string
-- @param string_3 string
-- @param float_4 float
-- @param handle_5 handle
-- @param handle_6 handle
function DoEntFireByInstanceHandle( handle_1, string_2, string_3, float_4, handle_5, handle_6 ) end

---[[ DoIncludeScript  Execute a script (internal) ])
-- @return bool
-- @param string_1 string
-- @param handle_2 handle
function DoIncludeScript( string_1, handle_2 ) end

---[[ DoScriptAssert  #ScriptAssert:Asserts the passed in value. Prints out a message and brings up the assert dialog. ])
-- @return void
-- @param bool_1 bool
-- @param string_2 string
function DoScriptAssert( bool_1, string_2 ) end

---[[ DoUniqueString  #UniqueString:Generate a string guaranteed to be unique across the life of the script VM, with an optional root string. Useful for adding data to tables when not sure what keys are already in use in that table. ])
-- @return string
-- @param string_1 string
function DoUniqueString( string_1 ) end

---[[ DotProduct   ])
-- @return float
-- @param Vector_1 Vector
-- @param Vector_2 Vector
function DotProduct( Vector_1, Vector_2 ) end

---[[ DropNeutralItemAtPositionForHero  Drop a neutral item for the team of the hero at the given tier. ])
-- @return handle
-- @param string_1 string
-- @param Vector_2 Vector
-- @param handle_3 handle
-- @param int_4 int
-- @param bool_5 bool
function DropNeutralItemAtPositionForHero( string_1, Vector_2, handle_3, int_4, bool_5 ) end

---[[ EmitAnnouncerSound  Emit an announcer sound for all players. ])
-- @return void
-- @param string_1 string
function EmitAnnouncerSound( string_1 ) end

---[[ EmitAnnouncerSoundForPlayer  Emit an announcer sound for a player. ])
-- @return void
-- @param string_1 string
-- @param int_2 int
function EmitAnnouncerSoundForPlayer( string_1, int_2 ) end

---[[ EmitAnnouncerSoundForTeam  Emit an announcer sound for a team. ])
-- @return void
-- @param string_1 string
-- @param int_2 int
function EmitAnnouncerSoundForTeam( string_1, int_2 ) end

---[[ EmitAnnouncerSoundForTeamOnLocation  Emit an announcer sound for a team at a specific location. ])
-- @return void
-- @param string_1 string
-- @param int_2 int
-- @param Vector_3 Vector
function EmitAnnouncerSoundForTeamOnLocation( string_1, int_2, Vector_3 ) end

---[[ EmitGlobalSound  Play named sound for all players ])
-- @return void
-- @param string_1 string
function EmitGlobalSound( string_1 ) end

---[[ EmitSoundOn  Play named sound on Entity ])
-- @return void
-- @param string_1 string
-- @param handle_2 handle
function EmitSoundOn( string_1, handle_2 ) end

---[[ EmitSoundOnClient  Play named sound only on the client for the passed in player ])
-- @return void
-- @param string_1 string
-- @param handle_2 handle
function EmitSoundOnClient( string_1, handle_2 ) end

---[[ EmitSoundOnEntityForPlayer  Emit a sound on an entity for only a specific player ])
-- @return void
-- @param string_1 string
-- @param handle_2 handle
-- @param int_3 int
function EmitSoundOnEntityForPlayer( string_1, handle_2, int_3 ) end

---[[ EmitSoundOnLocationForAllies  Emit a sound on a location from a unit, only for players allied with that unit (vLocation, soundName, hCaster ])
-- @return void
-- @param Vector_1 Vector
-- @param string_2 string
-- @param handle_3 handle
function EmitSoundOnLocationForAllies( Vector_1, string_2, handle_3 ) end

---[[ EmitSoundOnLocationForPlayer  Emit a sound on a location for only a specific player ])
-- @return void
-- @param string_1 string
-- @param Vector_2 Vector
-- @param int_3 int
function EmitSoundOnLocationForPlayer( string_1, Vector_2, int_3 ) end

---[[ EmitSoundOnLocationWithCaster  Emit a sound on a location from a unit. (vLocation, soundName, hCaster). ])
-- @return void
-- @param Vector_1 Vector
-- @param string_2 string
-- @param handle_3 handle
function EmitSoundOnLocationWithCaster( Vector_1, string_2, handle_3 ) end

---[[ EntIndexToHScript  Turn an entity index integer to an HScript representing that entity's script instance. ])
-- @return handle
-- @param int_1 int
function EntIndexToHScript( int_1 ) end

---[[ ExecuteOrderFromTable  Issue an order from a script table ])
-- @return void
-- @param handle_1 handle
function ExecuteOrderFromTable( handle_1 ) end

---[[ ExponentialDecay  Smooth curve decreasing slower as it approaches zero ])
-- @return float
-- @param float_1 float
-- @param float_2 float
-- @param float_3 float
function ExponentialDecay( float_1, float_2, float_3 ) end

---[[ FindClearRandomPositionAroundUnit  Finds a clear random position around a given target unit, using the target unit's padded collision radius. ])
-- @return bool
-- @param handle_1 handle
-- @param handle_2 handle
-- @param int_3 int
function FindClearRandomPositionAroundUnit( handle_1, handle_2, int_3 ) end

---[[ FindClearSpaceForUnit  Place a unit somewhere not already occupied. ])
-- @return bool
-- @param handle_1 handle
-- @param Vector_2 Vector
-- @param bool_3 bool
function FindClearSpaceForUnit( handle_1, Vector_2, bool_3 ) end

---[[ FindSpawnEntityForTeam  Find a spawn point for the given team. ])
-- @return handle
-- @param int_1 int
function FindSpawnEntityForTeam( int_1 ) end

---[[ FindUnitsInLine  Find units that intersect the given line with the given flags. ])
-- @return table
-- @param int_1 int
-- @param Vector_2 Vector
-- @param Vector_3 Vector
-- @param handle_4 handle
-- @param float_5 float
-- @param int_6 int
-- @param int_7 int
-- @param int_8 int
function FindUnitsInLine( int_1, Vector_2, Vector_3, handle_4, float_5, int_6, int_7, int_8 ) end

---[[ FindUnitsInRadius  Finds the units in a given radius with the given flags. ])
-- @return table
-- @param int_1 int
-- @param Vector_2 Vector
-- @param handle_3 handle
-- @param float_4 float
-- @param int_5 int
-- @param int_6 int
-- @param int_7 int
-- @param int_8 int
-- @param bool_9 bool
function FindUnitsInRadius( int_1, Vector_2, handle_3, float_4, int_5, int_6, int_7, int_8, bool_9 ) end

---[[ FireEntityIOInputNameOnly  Fire Entity's Action Input w/no data ])
-- @return void
-- @param ehandle_1 ehandle
-- @param string_2 string
function FireEntityIOInputNameOnly( ehandle_1, string_2 ) end

---[[ FireEntityIOInputString  Fire Entity's Action Input with passed String - you own the memory ])
-- @return void
-- @param ehandle_1 ehandle
-- @param string_2 string
-- @param string_3 string
function FireEntityIOInputString( ehandle_1, string_2, string_3 ) end

---[[ FireEntityIOInputVec  Fire Entity's Action Input with passed Vector - you own the memory ])
-- @return void
-- @param ehandle_1 ehandle
-- @param string_2 string
-- @param Vector_3 Vector
function FireEntityIOInputVec( ehandle_1, string_2, Vector_3 ) end

---[[ FireGameEvent  Fire a game event. ])
-- @return void
-- @param string_1 string
-- @param handle_2 handle
function FireGameEvent( string_1, handle_2 ) end

---[[ FireGameEventLocal  Fire a game event without broadcasting to the client. ])
-- @return void
-- @param string_1 string
-- @param handle_2 handle
function FireGameEventLocal( string_1, handle_2 ) end

---[[ FrameTime  Get the time spent on the server in the last frame ])
-- @return float
function FrameTime(  ) end

---[[ GetAbilityKeyValuesByName  Get ability data by ability name. ])
-- @return table
-- @param string_1 string
function GetAbilityKeyValuesByName( string_1 ) end

---[[ GetAbilityTextureNameForAbility  Gets the ability texture name for an ability ])
-- @return string
-- @param string_1 string
function GetAbilityTextureNameForAbility( string_1 ) end

---[[ GetActiveSpawnGroupHandle  Returns the currently active spawn group handle ])
-- @return int
function GetActiveSpawnGroupHandle(  ) end

---[[ GetDedicatedServerKey  ( version ) ])
-- @return string
-- @param string_1 string
function GetDedicatedServerKey( string_1 ) end

---[[ GetDedicatedServerKeyV2  ( version ) ])
-- @return string
-- @param string_1 string
function GetDedicatedServerKeyV2( string_1 ) end

---[[ GetEntityIndexForTreeId  Get the enity index for a tree id specified as the entindex_target of a DOTA_UNIT_ORDER_CAST_TARGET_TREE. ])
-- @return <unknown>
-- @param unsigned_1 unsigned
function GetEntityIndexForTreeId( unsigned_1 ) end

---[[ GetFrameCount  Returns the engines current frame count ])
-- @return int
function GetFrameCount(  ) end

---[[ GetGroundHeight   ])
-- @return float
-- @param Vector_1 Vector
-- @param handle_2 handle
function GetGroundHeight( Vector_1, handle_2 ) end

---[[ GetGroundPosition  Returns the supplied position moved to the ground. Second parameter is an NPC for measuring movement collision hull offset. ])
-- @return Vector
-- @param Vector_1 Vector
-- @param handle_2 handle
function GetGroundPosition( Vector_1, handle_2 ) end

---[[ GetItemCost  Get the cost of an item by name. ])
-- @return int
-- @param string_1 string
function GetItemCost( string_1 ) end

---[[ GetItemDefOwnedCount   ])
-- @return int
-- @param int_1 int
-- @param int_2 int
function GetItemDefOwnedCount( int_1, int_2 ) end

---[[ GetItemDefQuantity   ])
-- @return int
-- @param int_1 int
-- @param int_2 int
function GetItemDefQuantity( int_1, int_2 ) end

---[[ GetListenServerHost  Get the local player on a listen server. ])
-- @return handle
function GetListenServerHost(  ) end

---[[ GetLobbyEventGameDetails  ( ) ])
-- @return table
function GetLobbyEventGameDetails(  ) end

---[[ GetMapName  Get the name of the map. ])
-- @return string
function GetMapName(  ) end

---[[ GetMaxOutputDelay  Get the longest delay for all events attached to an output ])
-- @return float
-- @param ehandle_1 ehandle
-- @param string_2 string
function GetMaxOutputDelay( ehandle_1, string_2 ) end

---[[ GetPhysAngularVelocity  Get Angular Velocity for VPHYS or normal object. Returns a vector of the axis of rotation, multiplied by the degrees of rotation per second. ])
-- @return Vector
-- @param handle_1 handle
function GetPhysAngularVelocity( handle_1 ) end

---[[ GetPhysVelocity  Get Velocity for VPHYS or normal object ])
-- @return Vector
-- @param handle_1 handle
function GetPhysVelocity( handle_1 ) end

---[[ GetPotentialNeutralItemDrop  Given the item tier and the team, roll for the name of a valid neutral item drop, considering previous drops and consumables. ])
-- @return string
-- @param int_1 int
-- @param int_2 int
function GetPotentialNeutralItemDrop( int_1, int_2 ) end

---[[ GetSystemDate  Get the current real world date ])
-- @return string
function GetSystemDate(  ) end

---[[ GetSystemTime  Get the current real world time ])
-- @return string
function GetSystemTime(  ) end

---[[ GetSystemTimeMS  Get system time in milliseconds ])
-- @return double
function GetSystemTimeMS(  ) end

---[[ GetTargetAOELocation   ])
-- @return Vector
-- @param int_1 int
-- @param int_2 int
-- @param int_3 int
-- @param Vector_4 Vector
-- @param int_5 int
-- @param int_6 int
-- @param int_7 int
function GetTargetAOELocation( int_1, int_2, int_3, Vector_4, int_5, int_6, int_7 ) end

---[[ GetTargetLinearLocation   ])
-- @return Vector
-- @param int_1 int
-- @param int_2 int
-- @param int_3 int
-- @param Vector_4 Vector
-- @param int_5 int
-- @param int_6 int
-- @param int_7 int
function GetTargetLinearLocation( int_1, int_2, int_3, Vector_4, int_5, int_6, int_7 ) end

---[[ GetTeamHeroKills  ( int teamID ) ])
-- @return int
-- @param int_1 int
function GetTeamHeroKills( int_1 ) end

---[[ GetTeamName  ( int teamID ) ])
-- @return string
-- @param int_1 int
function GetTeamName( int_1 ) end

---[[ GetTreeIdForEntityIndex  Given and entity index of a tree, get the tree id for use for use with with unit orders. ])
-- @return int
-- @param int_1 int
function GetTreeIdForEntityIndex( int_1 ) end

---[[ GetWorldMaxX  Gets the world's maximum X position. ])
-- @return float
function GetWorldMaxX(  ) end

---[[ GetWorldMaxY  Gets the world's maximum Y position. ])
-- @return float
function GetWorldMaxY(  ) end

---[[ GetWorldMinX  Gets the world's minimum X position. ])
-- @return float
function GetWorldMinX(  ) end

---[[ GetWorldMinY  Gets the world's minimum Y position. ])
-- @return float
function GetWorldMinY(  ) end

---[[ GetXPNeededToReachNextLevel  Get amount of XP required to reach the next level. ])
-- @return int
-- @param int_1 int
function GetXPNeededToReachNextLevel( int_1 ) end

---[[ InitLogFile  InitLogFile is deprecated. Print to the console for logging instead. ])
-- @return void
-- @param string_1 string
-- @param string_2 string
function InitLogFile( string_1, string_2 ) end

---[[ IsClient  Returns true if this is lua running from the client.dll. ])
-- @return bool
function IsClient(  ) end

---[[ IsDedicatedServer  Returns true if this server is a dedicated server. ])
-- @return bool
function IsDedicatedServer(  ) end

---[[ IsInToolsMode  Returns true if this is lua running within tools mode. ])
-- @return bool
function IsInToolsMode(  ) end

---[[ IsLocationVisible  Ask fog of war if a location is visible to a certain team (nTeamNumber, vLocation). ])
-- @return bool
-- @param int_1 int
-- @param Vector_2 Vector
function IsLocationVisible( int_1, Vector_2 ) end

---[[ IsMangoTree  Is this entity a mango tree? (hEntity). ])
-- @return bool
-- @param handle_1 handle
function IsMangoTree( handle_1 ) end

---[[ IsMarkedForDeletion  Returns true if the entity is valid and marked for deletion. ])
-- @return bool
-- @param handle_1 handle
function IsMarkedForDeletion( handle_1 ) end

---[[ IsServer  Returns true if this is lua running from the server.dll. ])
-- @return bool
function IsServer(  ) end

---[[ IsUnitInValidPosition  Returns true if the unit is in a valid position in the gridnav. ])
-- @return bool
-- @param handle_1 handle
function IsUnitInValidPosition( handle_1 ) end

---[[ IsValidEntity  Checks to see if the given hScript is a valid entity ])
-- @return bool
-- @param handle_1 handle
function IsValidEntity( handle_1 ) end

---[[ LerpVectors  (vector,vector,float) lerp between two vectors by a float factor returning new vector ])
-- @return Vector
-- @param Vector_1 Vector
-- @param Vector_2 Vector
-- @param float_3 float
function LerpVectors( Vector_1, Vector_2, float_3 ) end

---[[ LimitPathingSearchDepth  Set the limit on the pathfinding search space. ])
-- @return void
-- @param float_1 float
function LimitPathingSearchDepth( float_1 ) end

---[[ LinkLuaModifier  Link a lua-defined modifier with the associated class ( className, fileName, LuaModifierType). ])
-- @return void
-- @param string_1 string
-- @param string_2 string
-- @param int_3 int
function LinkLuaModifier( string_1, string_2, int_3 ) end

---[[ ListenToGameEvent  Register as a listener for a game event from script. ])
-- @return int
-- @param string_1 string
-- @param handle_2 handle
-- @param handle_3 handle
function ListenToGameEvent( string_1, handle_2, handle_3 ) end

---[[ LoadKeyValues  Creates a table from the specified keyvalues text file ])
-- @return table
-- @param string_1 string
function LoadKeyValues( string_1 ) end

---[[ LoadKeyValuesFromString  Creates a table from the specified keyvalues string ])
-- @return table
-- @param string_1 string
function LoadKeyValuesFromString( string_1 ) end

---[[ LocalTime  Get the current local time ])
-- @return table
function LocalTime(  ) end

---[[ MakeStringToken  Checks to see if the given hScript is a valid entity ])
-- @return int
-- @param string_1 string
function MakeStringToken( string_1 ) end

---[[ ManuallyTriggerSpawnGroupCompletion  Triggers the creation of entities in a manually-completed spawn group ])
-- @return void
-- @param int_1 int
function ManuallyTriggerSpawnGroupCompletion( int_1 ) end

---[[ MinimapEvent  Start a minimap event. (nTeamID, hEntity, nXCoord, nYCoord, nEventType, nEventDuration). ])
-- @return void
-- @param int_1 int
-- @param handle_2 handle
-- @param int_3 int
-- @param int_4 int
-- @param int_5 int
-- @param int_6 int
function MinimapEvent( int_1, handle_2, int_3, int_4, int_5, int_6 ) end

---[[ Msg  Print a message ])
-- @return void
-- @param string_1 string
function Msg( string_1 ) end

---[[ PauseGame  Pause or unpause the game. ])
-- @return void
-- @param bool_1 bool
function PauseGame( bool_1 ) end

---[[ PlayerInstanceFromIndex  Get a script instance of a player by index. ])
-- @return handle
-- @param int_1 int
function PlayerInstanceFromIndex( int_1 ) end

---[[ PrecacheEntityFromTable  Precache an entity from KeyValues in table ])
-- @return void
-- @param string_1 string
-- @param handle_2 handle
-- @param handle_3 handle
function PrecacheEntityFromTable( string_1, handle_2, handle_3 ) end

---[[ PrecacheEntityListFromTable  Precache a list of entity KeyValues tables ])
-- @return void
-- @param handle_1 handle
-- @param handle_2 handle
function PrecacheEntityListFromTable( handle_1, handle_2 ) end

---[[ PrecacheItemByNameAsync  Asynchronously precaches a DOTA item by its dota_npc_items.txt name, provides a callback when it's finished. ])
-- @return void
-- @param string_1 string
-- @param handle_2 handle
function PrecacheItemByNameAsync( string_1, handle_2 ) end

---[[ PrecacheItemByNameSync  Precaches a DOTA item by its dota_npc_items.txt name ])
-- @return void
-- @param string_1 string
-- @param handle_2 handle
function PrecacheItemByNameSync( string_1, handle_2 ) end

---[[ PrecacheModel  ( modelName, context ) - Manually precache a single model ])
-- @return void
-- @param string_1 string
-- @param handle_2 handle
function PrecacheModel( string_1, handle_2 ) end

---[[ PrecacheResource  Manually precache a single resource ])
-- @return void
-- @param string_1 string
-- @param string_2 string
-- @param handle_3 handle
function PrecacheResource( string_1, string_2, handle_3 ) end

---[[ PrecacheUnitByNameAsync  Asynchronously precaches a DOTA unit by its dota_npc_units.txt name, provides a callback when it's finished. ])
-- @return void
-- @param string_1 string
-- @param handle_2 handle
-- @param int_3 int
function PrecacheUnitByNameAsync( string_1, handle_2, int_3 ) end

---[[ PrecacheUnitByNameSync  Precaches a DOTA unit by its dota_npc_units.txt name ])
-- @return void
-- @param string_1 string
-- @param handle_2 handle
-- @param int_3 int
function PrecacheUnitByNameSync( string_1, handle_2, int_3 ) end

---[[ PrecacheUnitFromTableAsync  Precaches a DOTA unit from a table of entity key values. ])
-- @return void
-- @param handle_1 handle
-- @param handle_2 handle
function PrecacheUnitFromTableAsync( handle_1, handle_2 ) end

---[[ PrecacheUnitFromTableSync  Precaches a DOTA unit from a table of entity key values. ])
-- @return void
-- @param handle_1 handle
-- @param handle_2 handle
function PrecacheUnitFromTableSync( handle_1, handle_2 ) end

---[[ PrintLinkedConsoleMessage  Print a console message with a linked console command ])
-- @return void
-- @param string_1 string
-- @param string_2 string
function PrintLinkedConsoleMessage( string_1, string_2 ) end

---[[ RandomFloat  Get a random float within a range ])
-- @return float
-- @param float_1 float
-- @param float_2 float
function RandomFloat( float_1, float_2 ) end

---[[ RandomInt  Get a random int within a range ])
-- @return int
-- @param int_1 int
-- @param int_2 int
function RandomInt( int_1, int_2 ) end

---[[ RandomVector  Get a random 2D vector of the given length. ])
-- @return Vector
-- @param float_1 float
function RandomVector( float_1 ) end

---[[ RegisterCustomAnimationScriptForModel  Register a custom animation script to run when a model loads ])
-- @return void
-- @param string_1 string
-- @param string_2 string
function RegisterCustomAnimationScriptForModel( string_1, string_2 ) end

---[[ RegisterSpawnGroupFilterProxy  Create a C proxy for a script-based spawn group filter ])
-- @return void
-- @param string_1 string
function RegisterSpawnGroupFilterProxy( string_1 ) end

---[[ ReloadMOTD  Reloads the MotD file ])
-- @return void
function ReloadMOTD(  ) end

---[[ RemapValClamped   ])
-- @return float
-- @param float_1 float
-- @param float_2 float
-- @param float_3 float
-- @param float_4 float
-- @param float_5 float
function RemapValClamped( float_1, float_2, float_3, float_4, float_5 ) end

---[[ RemoveFOWViewer  Remove temporary vision for a given team ( nTeamID, nViewerID ) ])
-- @return void
-- @param int_1 int
-- @param int_2 int
function RemoveFOWViewer( int_1, int_2 ) end

---[[ RemoveSpawnGroupFilterProxy  Remove the C proxy for a script-based spawn group filter ])
-- @return void
-- @param string_1 string
function RemoveSpawnGroupFilterProxy( string_1 ) end

---[[ ResolveNPCPositions  Check and fix units that have been assigned a position inside collision radius of other NPCs. ])
-- @return void
-- @param Vector_1 Vector
-- @param float_2 float
function ResolveNPCPositions( Vector_1, float_2 ) end

---[[ RollPercentage  (int nPct) ])
-- @return bool
-- @param int_1 int
function RollPercentage( int_1 ) end

---[[ RollPseudoRandomPercentage  ( chance, pseudo random id, unit. ])
-- @return bool
-- @param unsigned_1 unsigned
-- @param int_2 int
-- @param handle_3 handle
function RollPseudoRandomPercentage( unsigned_1, int_2, handle_3 ) end

---[[ RotateOrientation  Rotate a QAngle by another QAngle. ])
-- @return QAngle
-- @param QAngle_1 QAngle
-- @param QAngle_2 QAngle
function RotateOrientation( QAngle_1, QAngle_2 ) end

---[[ RotatePosition  Rotate a Vector around a point. ])
-- @return Vector
-- @param Vector_1 Vector
-- @param QAngle_2 QAngle
-- @param Vector_3 Vector
function RotatePosition( Vector_1, QAngle_2, Vector_3 ) end

---[[ RotateQuaternionByAxisAngle  (quaternion,vector,float) rotates a quaternion by the specified angle around the specified vector axis ])
-- @return Quaternion
-- @param Quaternion_1 Quaternion
-- @param Vector_2 Vector
-- @param float_3 float
function RotateQuaternionByAxisAngle( Quaternion_1, Vector_2, float_3 ) end

---[[ RotationDelta  Find the delta between two QAngles. ])
-- @return QAngle
-- @param QAngle_1 QAngle
-- @param QAngle_2 QAngle
function RotationDelta( QAngle_1, QAngle_2 ) end

---[[ RotationDeltaAsAngularVelocity  converts delta QAngle to an angular velocity Vector ])
-- @return Vector
-- @param QAngle_1 QAngle
-- @param QAngle_2 QAngle
function RotationDeltaAsAngularVelocity( QAngle_1, QAngle_2 ) end

---[[ Say  Have Entity say string, and teamOnly or not ])
-- @return void
-- @param handle_1 handle
-- @param string_2 string
-- @param bool_3 bool
function Say( handle_1, string_2, bool_3 ) end

---[[ ScreenShake  Start a screenshake with the following parameters. vecCenter, flAmplitude, flFrequency, flDuration, flRadius, eCommand( SHAKE_START = 0, SHAKE_STOP = 1 ), bAirShake ])
-- @return void
-- @param Vector_1 Vector
-- @param float_2 float
-- @param float_3 float
-- @param float_4 float
-- @param float_5 float
-- @param int_6 int
-- @param bool_7 bool
function ScreenShake( Vector_1, float_2, float_3, float_4, float_5, int_6, bool_7 ) end

---[[ SendOverheadEventMessage  ( DOTAPlayer sendToPlayer, int iMessageType, Entity targetEntity, int iValue, DOTAPlayer sourcePlayer ) - sendToPlayer and sourcePlayer can be nil - iMessageType is one of OVERHEAD_ALERT_* ])
-- @return void
-- @param handle_1 handle
-- @param int_2 int
-- @param handle_3 handle
-- @param int_4 int
-- @param handle_5 handle
function SendOverheadEventMessage( handle_1, int_2, handle_3, int_4, handle_5 ) end

---[[ SendToConsole  Send a string to the console as a client command ])
-- @return void
-- @param string_1 string
function SendToConsole( string_1 ) end

---[[ SendToServerConsole  Send a string to the console as a server command ])
-- @return void
-- @param string_1 string
function SendToServerConsole( string_1 ) end

---[[ SetOpvarFloatAll  Sets an opvar value for all players ])
-- @return void
-- @param string_1 string
-- @param string_2 string
-- @param string_3 string
-- @param float_4 float
function SetOpvarFloatAll( string_1, string_2, string_3, float_4 ) end

---[[ SetOpvarFloatPlayer  Sets an opvar value for a single player ])
-- @return void
-- @param string_1 string
-- @param string_2 string
-- @param string_3 string
-- @param float_4 float
-- @param handle_5 handle
function SetOpvarFloatPlayer( string_1, string_2, string_3, float_4, handle_5 ) end

---[[ SetPhysAngularVelocity  Set Angular Velocity for VPHYS or normal object, from a vector of the axis of rotation, multiplied by the degrees of rotation per second. ])
-- @return void
-- @param handle_1 handle
-- @param Vector_2 Vector
function SetPhysAngularVelocity( handle_1, Vector_2 ) end

---[[ SetQuestName  Set the current quest name. ])
-- @return void
-- @param string_1 string
function SetQuestName( string_1 ) end

---[[ SetQuestPhase  Set the current quest phase. ])
-- @return void
-- @param int_1 int
function SetQuestPhase( int_1 ) end

---[[ SetRenderingEnabled  Set rendering on/off for an ehandle ])
-- @return void
-- @param ehandle_1 ehandle
-- @param bool_2 bool
function SetRenderingEnabled( ehandle_1, bool_2 ) end

---[[ SetTeamCustomHealthbarColor  ( teamNumber, r, g, b ) ])
-- @return void
-- @param int_1 int
-- @param int_2 int
-- @param int_3 int
-- @param int_4 int
function SetTeamCustomHealthbarColor( int_1, int_2, int_3, int_4 ) end

---[[ ShowCustomHeaderMessage  ( const char *pszMessage, int nPlayerID, int nValue, float flTime ) - Supports localized strings - %s1 = PlayerName, %s2 = Value, %s3 = TeamName ])
-- @return void
-- @param string_1 string
-- @param int_2 int
-- @param int_3 int
-- @param float_4 float
function ShowCustomHeaderMessage( string_1, int_2, int_3, float_4 ) end

---[[ ShowGenericPopup  Show a generic popup dialog for all players. ])
-- @return void
-- @param string_1 string
-- @param string_2 string
-- @param string_3 string
-- @param string_4 string
-- @param int_5 int
function ShowGenericPopup( string_1, string_2, string_3, string_4, int_5 ) end

---[[ ShowGenericPopupToPlayer  Show a generic popup dialog to a specific player. ])
-- @return void
-- @param handle_1 handle
-- @param string_2 string
-- @param string_3 string
-- @param string_4 string
-- @param string_5 string
-- @param int_6 int
function ShowGenericPopupToPlayer( handle_1, string_2, string_3, string_4, string_5, int_6 ) end

---[[ ShowMessage  Print a hud message on all clients ])
-- @return void
-- @param string_1 string
function ShowMessage( string_1 ) end

---[[ SpawnDOTAShopTriggerRadiusApproximate  (Vector vOrigin, float flRadius ) ])
-- @return handle
-- @param Vector_1 Vector
-- @param float_2 float
function SpawnDOTAShopTriggerRadiusApproximate( Vector_1, float_2 ) end

---[[ SpawnEffigyOfUnitOrModel  Spawn an effigy of the target unit. ])
-- @return handle
-- @param string_1 string
-- @param int_2 int
-- @param Vector_3 Vector
-- @param Vector_4 Vector
-- @param float_5 float
-- @param float_6 float
-- @param int_7 int
function SpawnEffigyOfUnitOrModel( string_1, int_2, Vector_3, Vector_4, float_5, float_6, int_7 ) end

---[[ SpawnEntityFromTableAsynchronous  Asynchronously spawns a single entity from a table ])
-- @return void
-- @param string_1 string
-- @param handle_2 handle
-- @param handle_3 handle
-- @param handle_4 handle
function SpawnEntityFromTableAsynchronous( string_1, handle_2, handle_3, handle_4 ) end

---[[ SpawnEntityFromTableSynchronous  Synchronously spawns a single entity from a table ])
-- @return handle
-- @param string_1 string
-- @param handle_2 handle
function SpawnEntityFromTableSynchronous( string_1, handle_2 ) end

---[[ SpawnEntityGroupFromTable  Hierarchically spawn an entity group from a set of spawn tables. ])
-- @return bool
-- @param handle_1 handle
-- @param bool_2 bool
-- @param handle_3 handle
function SpawnEntityGroupFromTable( handle_1, bool_2, handle_3 ) end

---[[ SpawnEntityListFromTableAsynchronous  Asynchronously spawn an entity group from a list of spawn tables. A callback will be triggered when the spawning is complete ])
-- @return int
-- @param handle_1 handle
-- @param handle_2 handle
function SpawnEntityListFromTableAsynchronous( handle_1, handle_2 ) end

---[[ SpawnEntityListFromTableSynchronous  Synchronously spawn an entity group from a list of spawn tables. ])
-- @return handle
-- @param handle_1 handle
function SpawnEntityListFromTableSynchronous( handle_1 ) end

---[[ SplineQuaternions  (quaternion,quaternion,float) very basic interpolation of v0 to v1 over t on [0,1] ])
-- @return Quaternion
-- @param Quaternion_1 Quaternion
-- @param Quaternion_2 Quaternion
-- @param float_3 float
function SplineQuaternions( Quaternion_1, Quaternion_2, float_3 ) end

---[[ SplineVectors  (vector,vector,float) very basic interpolation of v0 to v1 over t on [0,1] ])
-- @return Vector
-- @param Vector_1 Vector
-- @param Vector_2 Vector
-- @param float_3 float
function SplineVectors( Vector_1, Vector_2, float_3 ) end

---[[ StartSoundEvent  Start a sound event ])
-- @return void
-- @param string_1 string
-- @param handle_2 handle
function StartSoundEvent( string_1, handle_2 ) end

---[[ StartSoundEventFromPosition  Start a sound event from position ])
-- @return void
-- @param string_1 string
-- @param Vector_2 Vector
function StartSoundEventFromPosition( string_1, Vector_2 ) end

---[[ StartSoundEventFromPositionReliable  Start a sound event from position with reliable delivery ])
-- @return void
-- @param string_1 string
-- @param Vector_2 Vector
function StartSoundEventFromPositionReliable( string_1, Vector_2 ) end

---[[ StartSoundEventFromPositionUnreliable  Start a sound event from position with optional delivery ])
-- @return void
-- @param string_1 string
-- @param Vector_2 Vector
function StartSoundEventFromPositionUnreliable( string_1, Vector_2 ) end

---[[ StartSoundEventReliable  Start a sound event with reliable delivery ])
-- @return void
-- @param string_1 string
-- @param handle_2 handle
function StartSoundEventReliable( string_1, handle_2 ) end

---[[ StartSoundEventUnreliable  Start a sound event with optional delivery ])
-- @return void
-- @param string_1 string
-- @param handle_2 handle
function StartSoundEventUnreliable( string_1, handle_2 ) end

---[[ StopEffect  Pass entity and effect name ])
-- @return void
-- @param handle_1 handle
-- @param string_2 string
function StopEffect( handle_1, string_2 ) end

---[[ StopGlobalSound  Stop named sound for all players ])
-- @return void
-- @param string_1 string
function StopGlobalSound( string_1 ) end

---[[ StopListeningToAllGameEvents  Stop listening to all game events within a specific context. ])
-- @return void
-- @param handle_1 handle
function StopListeningToAllGameEvents( handle_1 ) end

---[[ StopListeningToGameEvent  Stop listening to a particular game event. ])
-- @return bool
-- @param int_1 int
function StopListeningToGameEvent( int_1 ) end

---[[ StopSoundEvent  Stops a sound event with optional delivery ])
-- @return void
-- @param string_1 string
-- @param handle_2 handle
function StopSoundEvent( string_1, handle_2 ) end

---[[ StopSoundOn  Stop named sound on Entity ])
-- @return void
-- @param string_1 string
-- @param handle_2 handle
function StopSoundOn( string_1, handle_2 ) end

---[[ Time  Get the current server time ])
-- @return float
function Time(  ) end

---[[ TraceCollideable  Pass table - Inputs: start, end, ent, (optional mins, maxs) -- outputs: pos, fraction, hit, startsolid, normal ])
-- @return bool
-- @param handle_1 handle
function TraceCollideable( handle_1 ) end

---[[ TraceHull  Pass table - Inputs: start, end, min, max, mask, ignore  -- outputs: pos, fraction, hit, enthit, startsolid ])
-- @return bool
-- @param handle_1 handle
function TraceHull( handle_1 ) end

---[[ TraceLine  Pass table - Inputs: startpos, endpos, mask, ignore  -- outputs: pos, fraction, hit, enthit, startsolid ])
-- @return bool
-- @param handle_1 handle
function TraceLine( handle_1 ) end

---[[ UTIL_MessageText  Sends colored text to one client. ])
-- @return void
-- @param int_1 int
-- @param string_2 string
-- @param int_3 int
-- @param int_4 int
-- @param int_5 int
-- @param int_6 int
function UTIL_MessageText( int_1, string_2, int_3, int_4, int_5, int_6 ) end

---[[ UTIL_MessageTextAll  Sends colored text to all clients. ])
-- @return void
-- @param string_1 string
-- @param int_2 int
-- @param int_3 int
-- @param int_4 int
-- @param int_5 int
function UTIL_MessageTextAll( string_1, int_2, int_3, int_4, int_5 ) end

---[[ UTIL_MessageTextAll_WithContext  Sends colored text to all clients. (Valid context keys: player_id, value, team_id) ])
-- @return void
-- @param string_1 string
-- @param int_2 int
-- @param int_3 int
-- @param int_4 int
-- @param int_5 int
-- @param handle_6 handle
function UTIL_MessageTextAll_WithContext( string_1, int_2, int_3, int_4, int_5, handle_6 ) end

---[[ UTIL_MessageText_WithContext  Sends colored text to one client. (Valid context keys: player_id, value, team_id) ])
-- @return void
-- @param int_1 int
-- @param string_2 string
-- @param int_3 int
-- @param int_4 int
-- @param int_5 int
-- @param int_6 int
-- @param handle_7 handle
function UTIL_MessageText_WithContext( int_1, string_2, int_3, int_4, int_5, int_6, handle_7 ) end

---[[ UTIL_Remove  Removes the specified entity ])
-- @return void
-- @param handle_1 handle
function UTIL_Remove( handle_1 ) end

---[[ UTIL_RemoveImmediate  Immediately removes the specified entity ])
-- @return void
-- @param handle_1 handle
function UTIL_RemoveImmediate( handle_1 ) end

---[[ UTIL_ResetMessageText  Clear all message text on one client. ])
-- @return void
-- @param int_1 int
function UTIL_ResetMessageText( int_1 ) end

---[[ UTIL_ResetMessageTextAll  Clear all message text from all clients. ])
-- @return void
function UTIL_ResetMessageTextAll(  ) end

---[[ UnitFilter  Check if a unit passes a set of filters. (hNPC, nTargetTeam, nTargetType, nTargetFlags, nTeam ])
-- @return int
-- @param handle_1 handle
-- @param int_2 int
-- @param int_3 int
-- @param int_4 int
-- @param int_5 int
function UnitFilter( handle_1, int_2, int_3, int_4, int_5 ) end

---[[ UnloadSpawnGroup  Unload a spawn group by name ])
-- @return void
-- @param string_1 string
function UnloadSpawnGroup( string_1 ) end

---[[ UnloadSpawnGroupByHandle  Unload a spawn group by handle ])
-- @return void
-- @param int_1 int
function UnloadSpawnGroupByHandle( int_1 ) end

---[[ UpdateEventPoints  ( hEventPointData ) ])
-- @return void
-- @param handle_1 handle
function UpdateEventPoints( handle_1 ) end

---[[ VectorAngles   ])
-- @return QAngle
-- @param Vector_1 Vector
function VectorAngles( Vector_1 ) end

---[[ VectorToAngles  Get Qangles (with no roll) for a Vector. ])
-- @return QAngle
-- @param Vector_1 Vector
function VectorToAngles( Vector_1 ) end

---[[ Warning  Print a warning ])
-- @return void
-- @param string_1 string
function Warning( string_1 ) end

---[[ cvar_getf  Gets the value of the given cvar, as a float. ])
-- @return float
-- @param string_1 string
function cvar_getf( string_1 ) end

---[[ cvar_setf  Sets the value of the given cvar, as a float. ])
-- @return bool
-- @param string_1 string
-- @param float_2 float
function cvar_setf( string_1, float_2 ) end

---[[ rr_AddDecisionRule  Add a rule to the decision database. ])
-- @return bool
-- @param handle_1 handle
function rr_AddDecisionRule( handle_1 ) end

---[[ rr_CommitAIResponse  Commit the result of QueryBestResponse back to the given entity to play. Call with params (entity, airesponse) ])
-- @return bool
-- @param handle_1 handle
-- @param handle_2 handle
function rr_CommitAIResponse( handle_1, handle_2 ) end

---[[ rr_GetResponseTargets  Retrieve a table of all available expresser targets, in the form { name : handle, name: handle }. ])
-- @return handle
function rr_GetResponseTargets(  ) end

---[[ rr_QueryBestResponse  Params: (entity, query) : tests 'query' against entity's response system and returns the best response found (or null if none found). ])
-- @return bool
-- @param handle_1 handle
-- @param handle_2 handle
-- @param handle_3 handle
function rr_QueryBestResponse( handle_1, handle_2, handle_3 ) end


--- Enum ABILITY_TYPES
ABILITY_TYPE_ATTRIBUTES = 2
ABILITY_TYPE_BASIC = 0
ABILITY_TYPE_HIDDEN = 3
ABILITY_TYPE_ULTIMATE = 1

--- Enum AbilityLearnResult_t
ABILITY_CANNOT_BE_UPGRADED_AT_MAX = 2
ABILITY_CANNOT_BE_UPGRADED_NOT_UPGRADABLE = 1
ABILITY_CANNOT_BE_UPGRADED_REQUIRES_LEVEL = 3
ABILITY_CAN_BE_UPGRADED = 0
ABILITY_NOT_LEARNABLE = 4

--- Enum AttributeDerivedStats
DOTA_ATTRIBUTE_AGILITY_ARMOR = 4
DOTA_ATTRIBUTE_AGILITY_ATTACK_SPEED = 5
DOTA_ATTRIBUTE_AGILITY_DAMAGE = 3
DOTA_ATTRIBUTE_INTELLIGENCE_DAMAGE = 6
DOTA_ATTRIBUTE_INTELLIGENCE_MANA = 7
DOTA_ATTRIBUTE_INTELLIGENCE_MANA_REGEN = 8
DOTA_ATTRIBUTE_STRENGTH_DAMAGE = 0
DOTA_ATTRIBUTE_STRENGTH_HP = 1
DOTA_ATTRIBUTE_STRENGTH_HP_REGEN = 2

--- Enum Attributes
DOTA_ATTRIBUTE_AGILITY = 1
DOTA_ATTRIBUTE_INTELLECT = 2
DOTA_ATTRIBUTE_INVALID = -1
DOTA_ATTRIBUTE_MAX = 3
DOTA_ATTRIBUTE_STRENGTH = 0

--- Enum DAMAGE_TYPES
DAMAGE_TYPE_ALL = 7
DAMAGE_TYPE_HP_REMOVAL = 8
DAMAGE_TYPE_MAGICAL = 2
DAMAGE_TYPE_NONE = 0
DAMAGE_TYPE_PHYSICAL = 1
DAMAGE_TYPE_PURE = 4

--- Enum DOTAAbilitySpeakTrigger_t
DOTA_ABILITY_SPEAK_CAST = 1
DOTA_ABILITY_SPEAK_START_ACTION_PHASE = 0

--- Enum DOTADamageFlag_t
DOTA_DAMAGE_FLAG_BYPASSES_BLOCK = 8
DOTA_DAMAGE_FLAG_BYPASSES_INVULNERABILITY = 4
DOTA_DAMAGE_FLAG_DONT_DISPLAY_DAMAGE_IF_SOURCE_HIDDEN = 2048
DOTA_DAMAGE_FLAG_HPLOSS = 32
DOTA_DAMAGE_FLAG_IGNORES_BASE_PHYSICAL_ARMOR = 16384
DOTA_DAMAGE_FLAG_IGNORES_MAGIC_ARMOR = 1
DOTA_DAMAGE_FLAG_IGNORES_PHYSICAL_ARMOR = 2
DOTA_DAMAGE_FLAG_NONE = 0
DOTA_DAMAGE_FLAG_NON_LETHAL = 128
DOTA_DAMAGE_FLAG_NO_DAMAGE_MULTIPLIERS = 512
DOTA_DAMAGE_FLAG_NO_DIRECTOR_EVENT = 64
DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION = 1024
DOTA_DAMAGE_FLAG_NO_SPELL_LIFESTEAL = 4096
DOTA_DAMAGE_FLAG_PROPERTY_FIRE = 8192
DOTA_DAMAGE_FLAG_REFLECTION = 16
DOTA_DAMAGE_FLAG_USE_COMBAT_PROFICIENCY = 256

--- Enum DOTAHUDVisibility_t
DOTA_HUD_CUSTOMUI_BEHIND_HUD_ELEMENTS = 28
DOTA_HUD_VISIBILITY_ACTION_MINIMAP = 4
DOTA_HUD_VISIBILITY_ACTION_PANEL = 3
DOTA_HUD_VISIBILITY_COUNT = 29
DOTA_HUD_VISIBILITY_ENDGAME = 22
DOTA_HUD_VISIBILITY_ENDGAME_CHAT = 23
DOTA_HUD_VISIBILITY_HERO_SELECTION_CLOCK = 16
DOTA_HUD_VISIBILITY_HERO_SELECTION_GAME_NAME = 15
DOTA_HUD_VISIBILITY_HERO_SELECTION_TEAMS = 14
DOTA_HUD_VISIBILITY_INVALID = -1
DOTA_HUD_VISIBILITY_INVENTORY_COURIER = 9
DOTA_HUD_VISIBILITY_INVENTORY_GOLD = 11
DOTA_HUD_VISIBILITY_INVENTORY_ITEMS = 7
DOTA_HUD_VISIBILITY_INVENTORY_PANEL = 5
DOTA_HUD_VISIBILITY_INVENTORY_PROTECT = 10
DOTA_HUD_VISIBILITY_INVENTORY_QUICKBUY = 8
DOTA_HUD_VISIBILITY_INVENTORY_SHOP = 6
DOTA_HUD_VISIBILITY_KILLCAM = 26
DOTA_HUD_VISIBILITY_PREGAME_STRATEGYUI = 25
DOTA_HUD_VISIBILITY_QUICK_STATS = 24
DOTA_HUD_VISIBILITY_SHOP_COMMONITEMS = 13
DOTA_HUD_VISIBILITY_SHOP_SUGGESTEDITEMS = 12
DOTA_HUD_VISIBILITY_TOP_BAR = 27
DOTA_HUD_VISIBILITY_TOP_BAR_BACKGROUND = 18
DOTA_HUD_VISIBILITY_TOP_BAR_DIRE_TEAM = 20
DOTA_HUD_VISIBILITY_TOP_BAR_RADIANT_TEAM = 19
DOTA_HUD_VISIBILITY_TOP_BAR_SCORE = 21
DOTA_HUD_VISIBILITY_TOP_HEROES = 1
DOTA_HUD_VISIBILITY_TOP_MENU_BUTTONS = 17
DOTA_HUD_VISIBILITY_TOP_SCOREBOARD = 2
DOTA_HUD_VISIBILITY_TOP_TIMEOFDAY = 0

--- Enum DOTAInventoryFlags_t
DOTA_INVENTORY_ALLOW_DROP_AT_FOUNTAIN = 8
DOTA_INVENTORY_ALLOW_DROP_ON_GROUND = 4
DOTA_INVENTORY_ALLOW_MAIN = 1
DOTA_INVENTORY_ALLOW_NONE = 0
DOTA_INVENTORY_ALLOW_STASH = 2
DOTA_INVENTORY_ALL_ACCESS = 3
DOTA_INVENTORY_LIMIT_DROP_ON_GROUND = 16

--- Enum DOTALimits_t
DOTA_DEFAULT_MAX_TEAM = 5 -- Default number of players per team.
DOTA_DEFAULT_MAX_TEAM_PLAYERS = 10 -- Default number of non-spectator players supported.
DOTA_MAX_PLAYERS = 64 -- Max number of players connected to the server including spectators.
DOTA_MAX_PLAYER_TEAMS = 10 -- Max number of player teams supported.
DOTA_MAX_SPECTATOR_LOBBY_SIZE = 15 -- Max number of viewers in a spectator lobby.
DOTA_MAX_SPECTATOR_TEAM_SIZE = 40 -- How many spectators can watch.
DOTA_MAX_TEAM = 24 -- Max number of players per team.
DOTA_MAX_TEAM_PLAYERS = 24 -- Max number of non-spectator players supported.

--- Enum DOTAMinimapEvent_t
DOTA_MINIMAP_EVENT_ANCIENT_UNDER_ATTACK = 2
DOTA_MINIMAP_EVENT_BASE_GLYPHED = 8
DOTA_MINIMAP_EVENT_BASE_UNDER_ATTACK = 4
DOTA_MINIMAP_EVENT_CANCEL_TELEPORTING = 2048
DOTA_MINIMAP_EVENT_ENEMY_TELEPORTING = 1024
DOTA_MINIMAP_EVENT_HINT_LOCATION = 512
DOTA_MINIMAP_EVENT_MOVE_TO_TARGET = 16384
DOTA_MINIMAP_EVENT_RADAR = 4096
DOTA_MINIMAP_EVENT_RADAR_TARGET = 8192
DOTA_MINIMAP_EVENT_TEAMMATE_DIED = 64
DOTA_MINIMAP_EVENT_TEAMMATE_TELEPORTING = 32
DOTA_MINIMAP_EVENT_TEAMMATE_UNDER_ATTACK = 16
DOTA_MINIMAP_EVENT_TUTORIAL_TASK_ACTIVE = 128
DOTA_MINIMAP_EVENT_TUTORIAL_TASK_FINISHED = 256

--- Enum DOTAModifierAttribute_t
MODIFIER_ATTRIBUTE_AURA_PRIORITY = 8
MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE = 4
MODIFIER_ATTRIBUTE_MULTIPLE = 2
MODIFIER_ATTRIBUTE_NONE = 0
MODIFIER_ATTRIBUTE_PERMANENT = 1

--- Enum DOTAMusicStatus_t
DOTA_MUSIC_STATUS_BATTLE = 2
DOTA_MUSIC_STATUS_DEAD = 4
DOTA_MUSIC_STATUS_EXPLORATION = 1
DOTA_MUSIC_STATUS_LAST = 5
DOTA_MUSIC_STATUS_NONE = 0
DOTA_MUSIC_STATUS_PRE_GAME_EXPLORATION = 3

--- Enum DOTAProjectileAttachment_t
DOTA_PROJECTILE_ATTACHMENT_ATTACK_1 = 1
DOTA_PROJECTILE_ATTACHMENT_ATTACK_2 = 2
DOTA_PROJECTILE_ATTACHMENT_ATTACK_3 = 4
DOTA_PROJECTILE_ATTACHMENT_ATTACK_4 = 5
DOTA_PROJECTILE_ATTACHMENT_HITLOCATION = 3
DOTA_PROJECTILE_ATTACHMENT_LAST = 6
DOTA_PROJECTILE_ATTACHMENT_NONE = 0

--- Enum DOTAScriptInventorySlot_t
DOTA_ITEM_SLOT_1 = 0
DOTA_ITEM_SLOT_2 = 1
DOTA_ITEM_SLOT_3 = 2
DOTA_ITEM_SLOT_4 = 3
DOTA_ITEM_SLOT_5 = 4
DOTA_ITEM_SLOT_6 = 5
DOTA_ITEM_SLOT_7 = 6
DOTA_ITEM_SLOT_8 = 7
DOTA_ITEM_SLOT_9 = 8
DOTA_STASH_SLOT_1 = 9
DOTA_STASH_SLOT_2 = 10
DOTA_STASH_SLOT_3 = 11
DOTA_STASH_SLOT_4 = 12
DOTA_STASH_SLOT_5 = 13
DOTA_STASH_SLOT_6 = 14

--- Enum DOTASlotType_t
DOTA_LOADOUT_PERSONA_1_END = 56
DOTA_LOADOUT_PERSONA_1_START = 29
DOTA_LOADOUT_TYPE_ABILITY1 = 23
DOTA_LOADOUT_TYPE_ABILITY1_PERSONA_1 = 51
DOTA_LOADOUT_TYPE_ABILITY2 = 24
DOTA_LOADOUT_TYPE_ABILITY2_PERSONA_1 = 52
DOTA_LOADOUT_TYPE_ABILITY3 = 25
DOTA_LOADOUT_TYPE_ABILITY3_PERSONA_1 = 53
DOTA_LOADOUT_TYPE_ABILITY4 = 26
DOTA_LOADOUT_TYPE_ABILITY4_PERSONA_1 = 54
DOTA_LOADOUT_TYPE_ABILITY_ATTACK = 22
DOTA_LOADOUT_TYPE_ABILITY_ATTACK_PERSONA_1 = 50
DOTA_LOADOUT_TYPE_ABILITY_ULTIMATE = 27
DOTA_LOADOUT_TYPE_ABILITY_ULTIMATE_PERSONA_1 = 55
DOTA_LOADOUT_TYPE_AMBIENT_EFFECTS = 21
DOTA_LOADOUT_TYPE_AMBIENT_EFFECTS_PERSONA_1 = 49
DOTA_LOADOUT_TYPE_ANNOUNCER = 59
DOTA_LOADOUT_TYPE_ARMOR = 7
DOTA_LOADOUT_TYPE_ARMOR_PERSONA_1 = 36
DOTA_LOADOUT_TYPE_ARMS = 6
DOTA_LOADOUT_TYPE_ARMS_PERSONA_1 = 35
DOTA_LOADOUT_TYPE_BACK = 10
DOTA_LOADOUT_TYPE_BACK_PERSONA_1 = 39
DOTA_LOADOUT_TYPE_BELT = 8
DOTA_LOADOUT_TYPE_BELT_PERSONA_1 = 37
DOTA_LOADOUT_TYPE_BLINK_EFFECT = 70
DOTA_LOADOUT_TYPE_BODY_HEAD = 16
DOTA_LOADOUT_TYPE_BODY_HEAD_PERSONA_1 = 44
DOTA_LOADOUT_TYPE_COSTUME = 15
DOTA_LOADOUT_TYPE_COUNT = 85
DOTA_LOADOUT_TYPE_COURIER = 58
DOTA_LOADOUT_TYPE_COURIER_EFFECT = 83
DOTA_LOADOUT_TYPE_CURSOR_PACK = 68
DOTA_LOADOUT_TYPE_DEATH_EFFECT = 80
DOTA_LOADOUT_TYPE_DIRE_CREEPS = 74
DOTA_LOADOUT_TYPE_DIRE_TOWER = 76
DOTA_LOADOUT_TYPE_EMBLEM = 71
DOTA_LOADOUT_TYPE_GLOVES = 11
DOTA_LOADOUT_TYPE_GLOVES_PERSONA_1 = 41
DOTA_LOADOUT_TYPE_HEAD = 4
DOTA_LOADOUT_TYPE_HEAD_EFFECT = 81
DOTA_LOADOUT_TYPE_HEAD_PERSONA_1 = 33
DOTA_LOADOUT_TYPE_HEROIC_STATUE = 66
DOTA_LOADOUT_TYPE_HUD_SKIN = 63
DOTA_LOADOUT_TYPE_INVALID = -1
DOTA_LOADOUT_TYPE_KILL_EFFECT = 79
DOTA_LOADOUT_TYPE_LEGS = 12
DOTA_LOADOUT_TYPE_LEGS_PERSONA_1 = 40
DOTA_LOADOUT_TYPE_LOADING_SCREEN = 64
DOTA_LOADOUT_TYPE_MAP_EFFECT = 82
DOTA_LOADOUT_TYPE_MEGA_KILLS = 60
DOTA_LOADOUT_TYPE_MISC = 14
DOTA_LOADOUT_TYPE_MISC_PERSONA_1 = 43
DOTA_LOADOUT_TYPE_MOUNT = 17
DOTA_LOADOUT_TYPE_MOUNT_PERSONA_1 = 45
DOTA_LOADOUT_TYPE_MULTIKILL_BANNER = 67
DOTA_LOADOUT_TYPE_MUSIC = 61
DOTA_LOADOUT_TYPE_NECK = 9
DOTA_LOADOUT_TYPE_NECK_PERSONA_1 = 38
DOTA_LOADOUT_TYPE_NONE = 84
DOTA_LOADOUT_TYPE_OFFHAND_WEAPON = 1
DOTA_LOADOUT_TYPE_OFFHAND_WEAPON2 = 3
DOTA_LOADOUT_TYPE_OFFHAND_WEAPON2_PERSONA_1 = 32
DOTA_LOADOUT_TYPE_OFFHAND_WEAPON_PERSONA_1 = 30
DOTA_LOADOUT_TYPE_PERSONA_SELECTOR = 57
DOTA_LOADOUT_TYPE_RADIANT_CREEPS = 73
DOTA_LOADOUT_TYPE_RADIANT_TOWER = 75
DOTA_LOADOUT_TYPE_SHAPESHIFT = 19
DOTA_LOADOUT_TYPE_SHAPESHIFT_PERSONA_1 = 47
DOTA_LOADOUT_TYPE_SHOULDER = 5
DOTA_LOADOUT_TYPE_SHOULDER_PERSONA_1 = 34
DOTA_LOADOUT_TYPE_STREAK_EFFECT = 78
DOTA_LOADOUT_TYPE_SUMMON = 18
DOTA_LOADOUT_TYPE_SUMMON_PERSONA_1 = 46
DOTA_LOADOUT_TYPE_TAIL = 13
DOTA_LOADOUT_TYPE_TAIL_PERSONA_1 = 42
DOTA_LOADOUT_TYPE_TAUNT = 20
DOTA_LOADOUT_TYPE_TAUNT_PERSONA_1 = 48
DOTA_LOADOUT_TYPE_TELEPORT_EFFECT = 69
DOTA_LOADOUT_TYPE_TERRAIN = 72
DOTA_LOADOUT_TYPE_VERSUS_SCREEN = 77
DOTA_LOADOUT_TYPE_VOICE = 28
DOTA_LOADOUT_TYPE_VOICE_PERSONA_1 = 56
DOTA_LOADOUT_TYPE_WARD = 62
DOTA_LOADOUT_TYPE_WEAPON = 0
DOTA_LOADOUT_TYPE_WEAPON2 = 2
DOTA_LOADOUT_TYPE_WEAPON2_PERSONA_1 = 31
DOTA_LOADOUT_TYPE_WEAPON_PERSONA_1 = 29
DOTA_LOADOUT_TYPE_WEATHER = 65
DOTA_PLAYER_LOADOUT_END = 83
DOTA_PLAYER_LOADOUT_START = 58

--- Enum DOTASpeechType_t
DOTA_SPEECH_BAD_TEAM = 7
DOTA_SPEECH_GOOD_TEAM = 6
DOTA_SPEECH_RECIPIENT_TYPE_MAX = 10
DOTA_SPEECH_SPECTATOR = 8
DOTA_SPEECH_USER_ALL = 5
DOTA_SPEECH_USER_INVALID = 0
DOTA_SPEECH_USER_NEARBY = 4
DOTA_SPEECH_USER_SINGLE = 1
DOTA_SPEECH_USER_TEAM = 2
DOTA_SPEECH_USER_TEAM_NEARBY = 3
DOTA_SPEECH_USER_TEAM_NOSPECTATOR = 9

--- Enum DOTATeam_t
DOTA_TEAM_BADGUYS = 3
DOTA_TEAM_COUNT = 14
DOTA_TEAM_CUSTOM_1 = 6
DOTA_TEAM_CUSTOM_2 = 7
DOTA_TEAM_CUSTOM_3 = 8
DOTA_TEAM_CUSTOM_4 = 9
DOTA_TEAM_CUSTOM_5 = 10
DOTA_TEAM_CUSTOM_6 = 11
DOTA_TEAM_CUSTOM_7 = 12
DOTA_TEAM_CUSTOM_8 = 13
DOTA_TEAM_CUSTOM_COUNT = 8
DOTA_TEAM_CUSTOM_MAX = 13
DOTA_TEAM_CUSTOM_MIN = 6
DOTA_TEAM_FIRST = 2
DOTA_TEAM_GOODGUYS = 2
DOTA_TEAM_NEUTRALS = 4
DOTA_TEAM_NOTEAM = 5

--- Enum DOTAUnitAttackCapability_t
DOTA_UNIT_ATTACK_CAPABILITY_BIT_COUNT = 3
DOTA_UNIT_CAP_MELEE_ATTACK = 1
DOTA_UNIT_CAP_NO_ATTACK = 0
DOTA_UNIT_CAP_RANGED_ATTACK = 2
DOTA_UNIT_CAP_RANGED_ATTACK_DIRECTIONAL = 4

--- Enum DOTAUnitMoveCapability_t
DOTA_UNIT_CAP_MOVE_FLY = 2
DOTA_UNIT_CAP_MOVE_GROUND = 1
DOTA_UNIT_CAP_MOVE_NONE = 0

--- Enum DOTA_ABILITY_BEHAVIOR
DOTA_ABILITY_BEHAVIOR_AOE = 32
DOTA_ABILITY_BEHAVIOR_ATTACK = 131072
DOTA_ABILITY_BEHAVIOR_AURA = 65536
DOTA_ABILITY_BEHAVIOR_AUTOCAST = 4096
DOTA_ABILITY_BEHAVIOR_CAN_SELF_CAST = 0
DOTA_ABILITY_BEHAVIOR_CHANNELLED = 128
DOTA_ABILITY_BEHAVIOR_DIRECTIONAL = 1024
DOTA_ABILITY_BEHAVIOR_DONT_ALERT_TARGET = 16777216
DOTA_ABILITY_BEHAVIOR_DONT_CANCEL_CHANNEL = 536870912
DOTA_ABILITY_BEHAVIOR_DONT_CANCEL_MOVEMENT = 8388608
DOTA_ABILITY_BEHAVIOR_DONT_RESUME_ATTACK = 33554432
DOTA_ABILITY_BEHAVIOR_DONT_RESUME_MOVEMENT = 262144
DOTA_ABILITY_BEHAVIOR_FREE_DRAW_TARGETING = 0
DOTA_ABILITY_BEHAVIOR_HIDDEN = 1
DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING = 134217728
DOTA_ABILITY_BEHAVIOR_IGNORE_CHANNEL = 4194304
DOTA_ABILITY_BEHAVIOR_IGNORE_PSEUDO_QUEUE = 2097152
DOTA_ABILITY_BEHAVIOR_IGNORE_SILENCE = 0
DOTA_ABILITY_BEHAVIOR_IMMEDIATE = 2048
DOTA_ABILITY_BEHAVIOR_ITEM = 256
DOTA_ABILITY_BEHAVIOR_LAST_RESORT_POINT = -2147483648
DOTA_ABILITY_BEHAVIOR_NONE = 0
DOTA_ABILITY_BEHAVIOR_NORMAL_WHEN_STOLEN = 67108864
DOTA_ABILITY_BEHAVIOR_NOT_LEARNABLE = 64
DOTA_ABILITY_BEHAVIOR_NO_TARGET = 4
DOTA_ABILITY_BEHAVIOR_OPTIONAL_NO_TARGET = 32768
DOTA_ABILITY_BEHAVIOR_OPTIONAL_POINT = 16384
DOTA_ABILITY_BEHAVIOR_OPTIONAL_UNIT_TARGET = 8192
DOTA_ABILITY_BEHAVIOR_PASSIVE = 2
DOTA_ABILITY_BEHAVIOR_POINT = 16
DOTA_ABILITY_BEHAVIOR_ROOT_DISABLES = 524288
DOTA_ABILITY_BEHAVIOR_RUNE_TARGET = 268435456
DOTA_ABILITY_BEHAVIOR_SHOW_IN_GUIDES = 0
DOTA_ABILITY_BEHAVIOR_SUPPRESS_ASSOCIATED_CONSUMABLE = 0
DOTA_ABILITY_BEHAVIOR_TOGGLE = 512
DOTA_ABILITY_BEHAVIOR_UNIT_TARGET = 8
DOTA_ABILITY_BEHAVIOR_UNLOCKED_BY_EFFECT_INDEX = 0
DOTA_ABILITY_BEHAVIOR_UNRESTRICTED = 1048576
DOTA_ABILITY_BEHAVIOR_VECTOR_TARGETING = 1073741824

--- Enum DOTA_GameState
DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP = 2
DOTA_GAMERULES_STATE_DISCONNECT = 10
DOTA_GAMERULES_STATE_GAME_IN_PROGRESS = 8
DOTA_GAMERULES_STATE_HERO_SELECTION = 3
DOTA_GAMERULES_STATE_INIT = 0
DOTA_GAMERULES_STATE_POST_GAME = 9
DOTA_GAMERULES_STATE_PRE_GAME = 7
DOTA_GAMERULES_STATE_STRATEGY_TIME = 4
DOTA_GAMERULES_STATE_TEAM_SHOWCASE = 5
DOTA_GAMERULES_STATE_WAIT_FOR_MAP_TO_LOAD = 6
DOTA_GAMERULES_STATE_WAIT_FOR_PLAYERS_TO_LOAD = 1

--- Enum DOTA_HeroPickState
DOTA_HEROPICK_STATE_ALL_DRAFT_SELECT = 57
DOTA_HEROPICK_STATE_AP_SELECT = 1
DOTA_HEROPICK_STATE_AR_SELECT = 32
DOTA_HEROPICK_STATE_BD_SELECT = 54
DOTA_HEROPICK_STATE_CD_BAN1 = 37
DOTA_HEROPICK_STATE_CD_BAN2 = 38
DOTA_HEROPICK_STATE_CD_BAN3 = 39
DOTA_HEROPICK_STATE_CD_BAN4 = 40
DOTA_HEROPICK_STATE_CD_BAN5 = 41
DOTA_HEROPICK_STATE_CD_BAN6 = 42
DOTA_HEROPICK_STATE_CD_CAPTAINPICK = 36
DOTA_HEROPICK_STATE_CD_INTRO = 35
DOTA_HEROPICK_STATE_CD_PICK = 53
DOTA_HEROPICK_STATE_CD_SELECT1 = 43
DOTA_HEROPICK_STATE_CD_SELECT10 = 52
DOTA_HEROPICK_STATE_CD_SELECT2 = 44
DOTA_HEROPICK_STATE_CD_SELECT3 = 45
DOTA_HEROPICK_STATE_CD_SELECT4 = 46
DOTA_HEROPICK_STATE_CD_SELECT5 = 47
DOTA_HEROPICK_STATE_CD_SELECT6 = 48
DOTA_HEROPICK_STATE_CD_SELECT7 = 49
DOTA_HEROPICK_STATE_CD_SELECT8 = 50
DOTA_HEROPICK_STATE_CD_SELECT9 = 51
DOTA_HEROPICK_STATE_CM_BAN1 = 7
DOTA_HEROPICK_STATE_CM_BAN10 = 16
DOTA_HEROPICK_STATE_CM_BAN11 = 17
DOTA_HEROPICK_STATE_CM_BAN12 = 18
DOTA_HEROPICK_STATE_CM_BAN13 = 19
DOTA_HEROPICK_STATE_CM_BAN14 = 20
DOTA_HEROPICK_STATE_CM_BAN2 = 8
DOTA_HEROPICK_STATE_CM_BAN3 = 9
DOTA_HEROPICK_STATE_CM_BAN4 = 10
DOTA_HEROPICK_STATE_CM_BAN5 = 11
DOTA_HEROPICK_STATE_CM_BAN6 = 12
DOTA_HEROPICK_STATE_CM_BAN7 = 13
DOTA_HEROPICK_STATE_CM_BAN8 = 14
DOTA_HEROPICK_STATE_CM_BAN9 = 15
DOTA_HEROPICK_STATE_CM_CAPTAINPICK = 6
DOTA_HEROPICK_STATE_CM_INTRO = 5
DOTA_HEROPICK_STATE_CM_PICK = 31
DOTA_HEROPICK_STATE_CM_SELECT1 = 21
DOTA_HEROPICK_STATE_CM_SELECT10 = 30
DOTA_HEROPICK_STATE_CM_SELECT2 = 22
DOTA_HEROPICK_STATE_CM_SELECT3 = 23
DOTA_HEROPICK_STATE_CM_SELECT4 = 24
DOTA_HEROPICK_STATE_CM_SELECT5 = 25
DOTA_HEROPICK_STATE_CM_SELECT6 = 26
DOTA_HEROPICK_STATE_CM_SELECT7 = 27
DOTA_HEROPICK_STATE_CM_SELECT8 = 28
DOTA_HEROPICK_STATE_CM_SELECT9 = 29
DOTA_HEROPICK_STATE_COUNT = 61
DOTA_HEROPICK_STATE_CUSTOM_PICK_RULES = 60
DOTA_HEROPICK_STATE_FH_SELECT = 34
DOTA_HEROPICK_STATE_INTRO_SELECT_UNUSED = 3
DOTA_HEROPICK_STATE_MO_SELECT = 33
DOTA_HEROPICK_STATE_NONE = 0
DOTA_HEROPICK_STATE_RD_SELECT_UNUSED = 4
DOTA_HEROPICK_STATE_SD_SELECT = 2
DOTA_HEROPICK_STATE_SELECT_PENALTY = 59
DOTA_HERO_PICK_STATE_ABILITY_DRAFT_SELECT = 55
DOTA_HERO_PICK_STATE_ARDM_SELECT = 56
DOTA_HERO_PICK_STATE_CUSTOMGAME_SELECT = 58

--- Enum DOTA_MOTION_CONTROLLER_PRIORITY
DOTA_MOTION_CONTROLLER_PRIORITY_HIGH = 3
DOTA_MOTION_CONTROLLER_PRIORITY_HIGHEST = 4
DOTA_MOTION_CONTROLLER_PRIORITY_LOW = 1
DOTA_MOTION_CONTROLLER_PRIORITY_LOWEST = 0
DOTA_MOTION_CONTROLLER_PRIORITY_MEDIUM = 2

--- Enum DOTA_RUNES
DOTA_RUNE_ARCANE = 6
DOTA_RUNE_BOUNTY = 5
DOTA_RUNE_COUNT = 8
DOTA_RUNE_DOUBLEDAMAGE = 0
DOTA_RUNE_HASTE = 1
DOTA_RUNE_ILLUSION = 2
DOTA_RUNE_INVALID = -1
DOTA_RUNE_INVISIBILITY = 3
DOTA_RUNE_REGENERATION = 4
DOTA_RUNE_WATER = 7

--- Enum DOTA_SHOP_TYPE
DOTA_SHOP_CUSTOM = 6
DOTA_SHOP_GROUND = 3
DOTA_SHOP_HOME = 0
DOTA_SHOP_NEUTRALS = 7
DOTA_SHOP_NONE = 8
DOTA_SHOP_SECRET = 2
DOTA_SHOP_SECRET2 = 5
DOTA_SHOP_SIDE = 1
DOTA_SHOP_SIDE2 = 4

--- Enum DOTA_UNIT_TARGET_FLAGS
DOTA_UNIT_TARGET_FLAG_CHECK_DISABLE_HELP = 65536
DOTA_UNIT_TARGET_FLAG_DEAD = 8
DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE = 128
DOTA_UNIT_TARGET_FLAG_INVULNERABLE = 64
DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES = 16
DOTA_UNIT_TARGET_FLAG_MANA_ONLY = 32768
DOTA_UNIT_TARGET_FLAG_MELEE_ONLY = 4
DOTA_UNIT_TARGET_FLAG_NONE = 0
DOTA_UNIT_TARGET_FLAG_NOT_ANCIENTS = 512
DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE = 16384
DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO = 131072
DOTA_UNIT_TARGET_FLAG_NOT_DOMINATED = 2048
DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS = 8192
DOTA_UNIT_TARGET_FLAG_NOT_MAGIC_IMMUNE_ALLIES = 32
DOTA_UNIT_TARGET_FLAG_NOT_NIGHTMARED = 524288
DOTA_UNIT_TARGET_FLAG_NOT_SUMMONED = 4096
DOTA_UNIT_TARGET_FLAG_NO_INVIS = 256
DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD = 262144
DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED = 1024
DOTA_UNIT_TARGET_FLAG_PREFER_ENEMIES = 1048576
DOTA_UNIT_TARGET_FLAG_RANGED_ONLY = 2
DOTA_UNIT_TARGET_FLAG_RESPECT_OBSTRUCTIONS = 2097152

--- Enum DOTA_UNIT_TARGET_TEAM
DOTA_UNIT_TARGET_TEAM_BOTH = 3
DOTA_UNIT_TARGET_TEAM_CUSTOM = 4
DOTA_UNIT_TARGET_TEAM_ENEMY = 2
DOTA_UNIT_TARGET_TEAM_FRIENDLY = 1
DOTA_UNIT_TARGET_TEAM_NONE = 0

--- Enum DOTA_UNIT_TARGET_TYPE
DOTA_UNIT_TARGET_ALL = 55
DOTA_UNIT_TARGET_BASIC = 18
DOTA_UNIT_TARGET_BUILDING = 4
DOTA_UNIT_TARGET_COURIER = 16
DOTA_UNIT_TARGET_CREEP = 2
DOTA_UNIT_TARGET_CUSTOM = 128
DOTA_UNIT_TARGET_HERO = 1
DOTA_UNIT_TARGET_NONE = 0
DOTA_UNIT_TARGET_OTHER = 32
DOTA_UNIT_TARGET_TREE = 64

--- Enum DamageCategory_t
DOTA_DAMAGE_CATEGORY_ATTACK = 1
DOTA_DAMAGE_CATEGORY_SPELL = 0

--- Enum DotaDefaultUIElement_t
DOTA_DEFAULT_UI_ACTION_MINIMAP = 4
DOTA_DEFAULT_UI_ACTION_PANEL = 3
DOTA_DEFAULT_UI_CUSTOMUI_BEHIND_HUD_ELEMENTS = 28
DOTA_DEFAULT_UI_ELEMENT_COUNT = 29
DOTA_DEFAULT_UI_ENDGAME = 22
DOTA_DEFAULT_UI_ENDGAME_CHAT = 23
DOTA_DEFAULT_UI_FLYOUT_SCOREBOARD = 2
DOTA_DEFAULT_UI_HERO_SELECTION_CLOCK = 16
DOTA_DEFAULT_UI_HERO_SELECTION_GAME_NAME = 15
DOTA_DEFAULT_UI_HERO_SELECTION_TEAMS = 14
DOTA_DEFAULT_UI_INVALID = -1
DOTA_DEFAULT_UI_INVENTORY_COURIER = 9
DOTA_DEFAULT_UI_INVENTORY_GOLD = 11
DOTA_DEFAULT_UI_INVENTORY_ITEMS = 7
DOTA_DEFAULT_UI_INVENTORY_PANEL = 5
DOTA_DEFAULT_UI_INVENTORY_PROTECT = 10
DOTA_DEFAULT_UI_INVENTORY_QUICKBUY = 8
DOTA_DEFAULT_UI_INVENTORY_SHOP = 6
DOTA_DEFAULT_UI_KILLCAM = 26
DOTA_DEFAULT_UI_PREGAME_STRATEGYUI = 25
DOTA_DEFAULT_UI_QUICK_STATS = 24
DOTA_DEFAULT_UI_SHOP_COMMONITEMS = 13
DOTA_DEFAULT_UI_SHOP_SUGGESTEDITEMS = 12
DOTA_DEFAULT_UI_TOP_BAR = 27
DOTA_DEFAULT_UI_TOP_BAR_BACKGROUND = 18
DOTA_DEFAULT_UI_TOP_BAR_DIRE_TEAM = 20
DOTA_DEFAULT_UI_TOP_BAR_RADIANT_TEAM = 19
DOTA_DEFAULT_UI_TOP_BAR_SCORE = 21
DOTA_DEFAULT_UI_TOP_HEROES = 1
DOTA_DEFAULT_UI_TOP_MENU_BUTTONS = 17
DOTA_DEFAULT_UI_TOP_TIMEOFDAY = 0

--- Enum EDOTA_ModifyGold_Reason
DOTA_ModifyGold_AbandonedRedistribute = 5
DOTA_ModifyGold_AbilityCost = 7
DOTA_ModifyGold_AbilityGold = 19
DOTA_ModifyGold_BountyRune = 17
DOTA_ModifyGold_Building = 11
DOTA_ModifyGold_Buyback = 2
DOTA_ModifyGold_CheatCommand = 8
DOTA_ModifyGold_CourierKill = 16
DOTA_ModifyGold_CreepKill = 13
DOTA_ModifyGold_Death = 1
DOTA_ModifyGold_GameTick = 10
DOTA_ModifyGold_HeroKill = 12
DOTA_ModifyGold_NeutralKill = 14
DOTA_ModifyGold_PurchaseConsumable = 3
DOTA_ModifyGold_PurchaseItem = 4
DOTA_ModifyGold_RoshanKill = 15
DOTA_ModifyGold_SelectionPenalty = 9
DOTA_ModifyGold_SellItem = 6
DOTA_ModifyGold_SharedGold = 18
DOTA_ModifyGold_Unspecified = 0
DOTA_ModifyGold_WardKill = 20

--- Enum EDOTA_ModifyXP_Reason
DOTA_ModifyXP_CreepKill = 2
DOTA_ModifyXP_HeroKill = 1
DOTA_ModifyXP_MAX = 6
DOTA_ModifyXP_Outpost = 5
DOTA_ModifyXP_RoshanKill = 3
DOTA_ModifyXP_TomeOfKnowledge = 4
DOTA_ModifyXP_Unspecified = 0

--- Enum EShareAbility
ITEM_FULLY_SHAREABLE = 0
ITEM_NOT_SHAREABLE = 2
ITEM_PARTIALLY_SHAREABLE = 1

--- Enum GameActivity_t
ACT_DOTA_ALCHEMIST_CHEMICAL_RAGE_END = 1580
ACT_DOTA_ALCHEMIST_CHEMICAL_RAGE_START = 1572
ACT_DOTA_ALCHEMIST_CONCOCTION = 1573
ACT_DOTA_ALCHEMIST_CONCOCTION_THROW = 1579
ACT_DOTA_AMBUSH = 1627
ACT_DOTA_ANCESTRAL_SPIRIT = 1677
ACT_DOTA_ARCTIC_BURN_END = 1682
ACT_DOTA_AREA_DENY = 1661
ACT_DOTA_ATTACK = 1503
ACT_DOTA_ATTACK2 = 1504
ACT_DOTA_ATTACK_EVENT = 1505
ACT_DOTA_ATTACK_EVENT_BASH = 1705
ACT_DOTA_AW_MAGNETIC_FIELD = 1707
ACT_DOTA_BELLYACHE_END = 1614
ACT_DOTA_BELLYACHE_LOOP = 1613
ACT_DOTA_BELLYACHE_START = 1612
ACT_DOTA_BLINK_DAGGER = 1732
ACT_DOTA_BLINK_DAGGER_END = 1733
ACT_DOTA_BRIDGE_DESTROY = 1640
ACT_DOTA_BRIDGE_THREAT = 1650
ACT_DOTA_CAGED_CREEP_RAGE = 1644
ACT_DOTA_CAGED_CREEP_RAGE_OUT = 1645
ACT_DOTA_CAGED_CREEP_SMASH = 1646
ACT_DOTA_CAGED_CREEP_SMASH_OUT = 1647
ACT_DOTA_CANCEL_SIREN_SONG = 1599
ACT_DOTA_CAPTURE = 1533
ACT_DOTA_CAPTURE_CARD = 1717
ACT_DOTA_CAPTURE_PET = 1698
ACT_DOTA_CAPTURE_RARE = 1706
ACT_DOTA_CAST_ABILITY_1 = 1510
ACT_DOTA_CAST_ABILITY_1_END = 1540
ACT_DOTA_CAST_ABILITY_2 = 1511
ACT_DOTA_CAST_ABILITY_2_ALLY = 1748
ACT_DOTA_CAST_ABILITY_2_END = 1541
ACT_DOTA_CAST_ABILITY_2_ES_ROLL = 1653
ACT_DOTA_CAST_ABILITY_2_ES_ROLL_END = 1654
ACT_DOTA_CAST_ABILITY_2_ES_ROLL_START = 1652
ACT_DOTA_CAST_ABILITY_3 = 1512
ACT_DOTA_CAST_ABILITY_3_END = 1542
ACT_DOTA_CAST_ABILITY_4 = 1513
ACT_DOTA_CAST_ABILITY_4_END = 1543
ACT_DOTA_CAST_ABILITY_5 = 1514
ACT_DOTA_CAST_ABILITY_6 = 1515
ACT_DOTA_CAST_ABILITY_7 = 1598
ACT_DOTA_CAST_ABILITY_ROT = 1547
ACT_DOTA_CAST_ALACRITY = 1585
ACT_DOTA_CAST_ALACRITY_ORB = 1741
ACT_DOTA_CAST_BURROW_END = 1702
ACT_DOTA_CAST_CHAOS_METEOR = 1586
ACT_DOTA_CAST_CHAOS_METEOR_ORB = 1742
ACT_DOTA_CAST_COLD_SNAP = 1581
ACT_DOTA_CAST_COLD_SNAP_ORB = 1737
ACT_DOTA_CAST_DEAFENING_BLAST = 1590
ACT_DOTA_CAST_DEAFENING_BLAST_ORB = 1746
ACT_DOTA_CAST_DRAGONBREATH = 1538
ACT_DOTA_CAST_EMP = 1584
ACT_DOTA_CAST_EMP_ORB = 1740
ACT_DOTA_CAST_FORGE_SPIRIT = 1588
ACT_DOTA_CAST_FORGE_SPIRIT_ORB = 1744
ACT_DOTA_CAST_GHOST_SHIP = 1708
ACT_DOTA_CAST_GHOST_WALK = 1582
ACT_DOTA_CAST_GHOST_WALK_ORB = 1738
ACT_DOTA_CAST_ICE_WALL = 1589
ACT_DOTA_CAST_ICE_WALL_ORB = 1745
ACT_DOTA_CAST_LIFE_BREAK_END = 1564
ACT_DOTA_CAST_LIFE_BREAK_START = 1563
ACT_DOTA_CAST_REFRACTION = 1597
ACT_DOTA_CAST_SUN_STRIKE = 1587
ACT_DOTA_CAST_SUN_STRIKE_ORB = 1743
ACT_DOTA_CAST_TORNADO = 1583
ACT_DOTA_CAST_TORNADO_ORB = 1739
ACT_DOTA_CAST_WILD_AXES_END = 1562
ACT_DOTA_CENTAUR_STAMPEDE = 1611
ACT_DOTA_CHANNEL_ABILITY_1 = 1520
ACT_DOTA_CHANNEL_ABILITY_2 = 1521
ACT_DOTA_CHANNEL_ABILITY_3 = 1522
ACT_DOTA_CHANNEL_ABILITY_4 = 1523
ACT_DOTA_CHANNEL_ABILITY_5 = 1524
ACT_DOTA_CHANNEL_ABILITY_6 = 1525
ACT_DOTA_CHANNEL_ABILITY_7 = 1600
ACT_DOTA_CHANNEL_END_ABILITY_1 = 1526
ACT_DOTA_CHANNEL_END_ABILITY_2 = 1527
ACT_DOTA_CHANNEL_END_ABILITY_3 = 1528
ACT_DOTA_CHANNEL_END_ABILITY_4 = 1529
ACT_DOTA_CHANNEL_END_ABILITY_5 = 1530
ACT_DOTA_CHANNEL_END_ABILITY_6 = 1531
ACT_DOTA_CHILLING_TOUCH = 1673
ACT_DOTA_COLD_FEET = 1671
ACT_DOTA_CONSTANT_LAYER = 1532
ACT_DOTA_CUSTOM_TOWER_ATTACK = 1734
ACT_DOTA_CUSTOM_TOWER_DIE = 1736
ACT_DOTA_CUSTOM_TOWER_HIGH_FIVE = 1757
ACT_DOTA_CUSTOM_TOWER_IDLE = 1735
ACT_DOTA_CUSTOM_TOWER_IDLE_RARE = 1755
ACT_DOTA_CUSTOM_TOWER_TAUNT = 1756
ACT_DOTA_DAGON = 1651
ACT_DOTA_DEATH_BY_SNIPER = 1642
ACT_DOTA_DEFEAT = 1592
ACT_DOTA_DEFEAT_START = 1711
ACT_DOTA_DIE = 1506
ACT_DOTA_DIE_SPECIAL = 1548
ACT_DOTA_DISABLED = 1509
ACT_DOTA_DP_SPIRIT_SIPHON = 1712
ACT_DOTA_EARTHSHAKER_TOTEM_ATTACK = 1570
ACT_DOTA_ECHO_SLAM = 1539
ACT_DOTA_ENFEEBLE = 1674
ACT_DOTA_ES_STONE_CALLER = 1714
ACT_DOTA_FATAL_BONDS = 1675
ACT_DOTA_FLAIL = 1508
ACT_DOTA_FLEE = 1685
ACT_DOTA_FLINCH = 1507
ACT_DOTA_FORCESTAFF_END = 1602
ACT_DOTA_FRUSTRATION = 1630
ACT_DOTA_FXANIM = 1709
ACT_DOTA_GENERIC_CHANNEL_1 = 1728
ACT_DOTA_GENERIC_CHANNEL_1_START = 1754
ACT_DOTA_GESTURE_ACCENT = 1625
ACT_DOTA_GESTURE_POINT = 1624
ACT_DOTA_GREET = 1690
ACT_DOTA_GREEVIL_BLINK_BONE = 1621
ACT_DOTA_GREEVIL_CAST = 1617
ACT_DOTA_GREEVIL_HOOK_END = 1620
ACT_DOTA_GREEVIL_HOOK_START = 1619
ACT_DOTA_GREEVIL_OVERRIDE_ABILITY = 1618
ACT_DOTA_GS_INK_CREATURE = 1730
ACT_DOTA_GS_SOUL_CHAIN = 1729
ACT_DOTA_ICE_VORTEX = 1672
ACT_DOTA_IDLE = 1500
ACT_DOTA_IDLE_IMPATIENT = 1636
ACT_DOTA_IDLE_IMPATIENT_SWORD_TAP = 1648
ACT_DOTA_IDLE_RARE = 1501
ACT_DOTA_IDLE_SLEEPING = 1622
ACT_DOTA_IDLE_SLEEPING_END = 1639
ACT_DOTA_INTRO = 1623
ACT_DOTA_INTRO_LOOP = 1649
ACT_DOTA_ITEM_DROP = 1697
ACT_DOTA_ITEM_LOOK = 1628
ACT_DOTA_ITEM_PICKUP = 1696
ACT_DOTA_JAKIRO_LIQUIDFIRE_LOOP = 1575
ACT_DOTA_JAKIRO_LIQUIDFIRE_START = 1574
ACT_DOTA_KILLTAUNT = 1535
ACT_DOTA_KINETIC_FIELD = 1679
ACT_DOTA_LASSO_LOOP = 1578
ACT_DOTA_LEAP_STUN = 1658
ACT_DOTA_LEAP_SWIPE = 1659
ACT_DOTA_LIFESTEALER_ASSIMILATE = 1703
ACT_DOTA_LIFESTEALER_EJECT = 1704
ACT_DOTA_LIFESTEALER_INFEST = 1576
ACT_DOTA_LIFESTEALER_INFEST_END = 1577
ACT_DOTA_LIFESTEALER_OPEN_WOUNDS = 1567
ACT_DOTA_LIFESTEALER_RAGE = 1566
ACT_DOTA_LOADOUT = 1601
ACT_DOTA_LOADOUT_RARE = 1683
ACT_DOTA_LOOK_AROUND = 1643
ACT_DOTA_MAGNUS_SKEWER_END = 1606
ACT_DOTA_MAGNUS_SKEWER_START = 1605
ACT_DOTA_MEDUSA_STONE_GAZE = 1607
ACT_DOTA_MIDNIGHT_PULSE = 1676
ACT_DOTA_MINI_TAUNT = 1681
ACT_DOTA_MK_FUR_ARMY = 1722
ACT_DOTA_MK_SPRING_CAST = 1723
ACT_DOTA_MK_SPRING_END = 1719
ACT_DOTA_MK_SPRING_SOAR = 1718
ACT_DOTA_MK_STRIKE = 1715
ACT_DOTA_MK_TREE_END = 1721
ACT_DOTA_MK_TREE_SOAR = 1720
ACT_DOTA_NECRO_GHOST_SHROUD = 1724
ACT_DOTA_NIAN_INTRO_LEAP = 1660
ACT_DOTA_NIAN_PIN_END = 1657
ACT_DOTA_NIAN_PIN_LOOP = 1656
ACT_DOTA_NIAN_PIN_START = 1655
ACT_DOTA_NIAN_PIN_TO_STUN = 1662
ACT_DOTA_NIGHTSTALKER_TRANSITION = 1565
ACT_DOTA_NOTICE = 1747
ACT_DOTA_OVERRIDE_ABILITY_1 = 1516
ACT_DOTA_OVERRIDE_ABILITY_2 = 1517
ACT_DOTA_OVERRIDE_ABILITY_3 = 1518
ACT_DOTA_OVERRIDE_ABILITY_4 = 1519
ACT_DOTA_OVERRIDE_ARCANA = 1725
ACT_DOTA_OVERRIDE_LOADOUT = 1751
ACT_DOTA_PET_LEVEL = 1701
ACT_DOTA_PET_WARD_OBSERVER = 1699
ACT_DOTA_PET_WARD_SENTRY = 1700
ACT_DOTA_POOF_END = 1603
ACT_DOTA_PRESENT_ITEM = 1635
ACT_DOTA_RATTLETRAP_BATTERYASSAULT = 1549
ACT_DOTA_RATTLETRAP_HOOKSHOT_END = 1553
ACT_DOTA_RATTLETRAP_HOOKSHOT_LOOP = 1552
ACT_DOTA_RATTLETRAP_HOOKSHOT_START = 1551
ACT_DOTA_RATTLETRAP_POWERCOGS = 1550
ACT_DOTA_RAZE_1 = 1663
ACT_DOTA_RAZE_2 = 1664
ACT_DOTA_RAZE_3 = 1665
ACT_DOTA_RELAX_END = 1610
ACT_DOTA_RELAX_LOOP = 1609
ACT_DOTA_RELAX_LOOP_END = 1634
ACT_DOTA_RELAX_START = 1608
ACT_DOTA_ROQUELAIRE_LAND = 1615
ACT_DOTA_ROQUELAIRE_LAND_IDLE = 1616
ACT_DOTA_RUN = 1502
ACT_DOTA_SAND_KING_BURROW_IN = 1568
ACT_DOTA_SAND_KING_BURROW_OUT = 1569
ACT_DOTA_SHAKE = 1687
ACT_DOTA_SHALLOW_GRAVE = 1670
ACT_DOTA_SHARPEN_WEAPON = 1637
ACT_DOTA_SHARPEN_WEAPON_OUT = 1638
ACT_DOTA_SHOPKEEPER_PET_INTERACT = 1695
ACT_DOTA_SHRUG = 1633
ACT_DOTA_SHUFFLE_L = 1749
ACT_DOTA_SHUFFLE_R = 1750
ACT_DOTA_SLARK_POUNCE = 1604
ACT_DOTA_SLEEPING_END = 1626
ACT_DOTA_SLIDE = 1726
ACT_DOTA_SLIDE_LOOP = 1727
ACT_DOTA_SPAWN = 1534
ACT_DOTA_SPIRIT_BREAKER_CHARGE_END = 1594
ACT_DOTA_SPIRIT_BREAKER_CHARGE_POSE = 1593
ACT_DOTA_STARTLE = 1629
ACT_DOTA_STATIC_STORM = 1680
ACT_DOTA_SWIM = 1684
ACT_DOTA_SWIM_IDLE = 1688
ACT_DOTA_TAUNT = 1536
ACT_DOTA_TAUNT_SNIPER = 1641
ACT_DOTA_TAUNT_SPECIAL = 1752
ACT_DOTA_TELEPORT = 1595
ACT_DOTA_TELEPORT_COOP_END = 1693
ACT_DOTA_TELEPORT_COOP_EXIT = 1694
ACT_DOTA_TELEPORT_COOP_START = 1691
ACT_DOTA_TELEPORT_COOP_WAIT = 1692
ACT_DOTA_TELEPORT_END = 1596
ACT_DOTA_TELEPORT_END_REACT = 1632
ACT_DOTA_TELEPORT_REACT = 1631
ACT_DOTA_TELEPORT_START = 1753
ACT_DOTA_THIRST = 1537
ACT_DOTA_THUNDER_STRIKE = 1678
ACT_DOTA_TINKER_REARM1 = 1555
ACT_DOTA_TINKER_REARM2 = 1556
ACT_DOTA_TINKER_REARM3 = 1557
ACT_DOTA_TRANSITION = 1731
ACT_DOTA_TRICKS_END = 1713
ACT_DOTA_TROT = 1686
ACT_DOTA_UNDYING_DECAY = 1666
ACT_DOTA_UNDYING_SOUL_RIP = 1667
ACT_DOTA_UNDYING_TOMBSTONE = 1668
ACT_DOTA_VERSUS = 1716
ACT_DOTA_VICTORY = 1591
ACT_DOTA_VICTORY_START = 1710
ACT_DOTA_WAIT_IDLE = 1689
ACT_DOTA_WEAVERBUG_ATTACH = 1561
ACT_DOTA_WHEEL_LAYER = 1571
ACT_DOTA_WHIRLING_AXES_RANGED = 1669
ACT_MIRANA_LEAP_END = 1544
ACT_STORM_SPIRIT_OVERLOAD_RUN_OVERRIDE = 1554
ACT_TINY_AVALANCHE = 1558
ACT_TINY_GROWL = 1560
ACT_TINY_TOSS = 1559
ACT_WAVEFORM_END = 1546
ACT_WAVEFORM_START = 1545

--- Enum LuaModifierType
LUA_MODIFIER_INVALID = 4
LUA_MODIFIER_MOTION_BOTH = 3
LUA_MODIFIER_MOTION_HORIZONTAL = 1
LUA_MODIFIER_MOTION_NONE = 0
LUA_MODIFIER_MOTION_VERTICAL = 2

--- Enum ParticleAttachment_t
MAX_PATTACH_TYPES = 16
PATTACH_ABSORIGIN = 0
PATTACH_ABSORIGIN_FOLLOW = 1
PATTACH_CENTER_FOLLOW = 13
PATTACH_CUSTOMORIGIN = 2
PATTACH_CUSTOMORIGIN_FOLLOW = 3
PATTACH_CUSTOM_GAME_STATE_1 = 14
PATTACH_EYES_FOLLOW = 6
PATTACH_HEALTHBAR = 15
PATTACH_INVALID = -1
PATTACH_MAIN_VIEW = 11
PATTACH_OVERHEAD_FOLLOW = 7
PATTACH_POINT = 4
PATTACH_POINT_FOLLOW = 5
PATTACH_RENDERORIGIN_FOLLOW = 10
PATTACH_ROOTBONE_FOLLOW = 9
PATTACH_WATERWAKE = 12
PATTACH_WORLDORIGIN = 8

--- Enum UnitFilterResult
UF_FAIL_ANCIENT = 9
UF_FAIL_ATTACK_IMMUNE = 22
UF_FAIL_BUILDING = 6
UF_FAIL_CONSIDERED_HERO = 4
UF_FAIL_COURIER = 7
UF_FAIL_CREEP = 5
UF_FAIL_CUSTOM = 23
UF_FAIL_DEAD = 15
UF_FAIL_DISABLE_HELP = 25
UF_FAIL_DOMINATED = 12
UF_FAIL_ENEMY = 2
UF_FAIL_FRIENDLY = 1
UF_FAIL_HERO = 3
UF_FAIL_ILLUSION = 10
UF_FAIL_INVALID_LOCATION = 24
UF_FAIL_INVISIBLE = 20
UF_FAIL_INVULNERABLE = 18
UF_FAIL_IN_FOW = 19
UF_FAIL_MAGIC_IMMUNE_ALLY = 16
UF_FAIL_MAGIC_IMMUNE_ENEMY = 17
UF_FAIL_MELEE = 13
UF_FAIL_NIGHTMARED = 27
UF_FAIL_NOT_PLAYER_CONTROLLED = 21
UF_FAIL_OBSTRUCTED = 28
UF_FAIL_OTHER = 8
UF_FAIL_OUT_OF_WORLD = 26
UF_FAIL_RANGED = 14
UF_FAIL_SUMMONED = 11
UF_SUCCESS = 0

--- Enum attackfail
DOTA_ATTACK_RECORD_CANNOT_FAIL = 6
DOTA_ATTACK_RECORD_FAIL_BLOCKED_BY_OBSTRUCTION = 7
DOTA_ATTACK_RECORD_FAIL_NO = 0
DOTA_ATTACK_RECORD_FAIL_SOURCE_MISS = 2
DOTA_ATTACK_RECORD_FAIL_TARGET_EVADED = 3
DOTA_ATTACK_RECORD_FAIL_TARGET_INVULNERABLE = 4
DOTA_ATTACK_RECORD_FAIL_TARGET_OUT_OF_RANGE = 5
DOTA_ATTACK_RECORD_FAIL_TERRAIN_MISS = 1

--- Enum modifierfunction
MODIFIER_EVENT_ON_ABILITY_END_CHANNEL = 182 -- OnAbilityEndChannel
MODIFIER_EVENT_ON_ABILITY_EXECUTED = 179 -- OnAbilityExecuted
MODIFIER_EVENT_ON_ABILITY_FULLY_CAST = 180 -- OnAbilityFullyCast
MODIFIER_EVENT_ON_ABILITY_START = 178 -- OnAbilityStart
MODIFIER_EVENT_ON_ATTACK = 171 -- OnAttack
MODIFIER_EVENT_ON_ATTACKED = 191 -- OnAttacked
MODIFIER_EVENT_ON_ATTACK_ALLIED = 174 -- OnAttackAllied
MODIFIER_EVENT_ON_ATTACK_CANCELLED = 237 -- OnAttackCancelled
MODIFIER_EVENT_ON_ATTACK_FAIL = 173 -- OnAttackFail
MODIFIER_EVENT_ON_ATTACK_FINISHED = 227 -- OnAttackFinished
MODIFIER_EVENT_ON_ATTACK_LANDED = 172 -- OnAttackLanded
MODIFIER_EVENT_ON_ATTACK_RECORD = 169 -- OnAttackRecord
MODIFIER_EVENT_ON_ATTACK_RECORD_DESTROY = 234 -- OnAttackRecordDestroy
MODIFIER_EVENT_ON_ATTACK_START = 170 -- OnAttackStart
MODIFIER_EVENT_ON_ATTEMPT_PROJECTILE_DODGE = 244 -- OnAttemptProjectileDodge
MODIFIER_EVENT_ON_BREAK_INVISIBILITY = 181 -- OnBreakInvisibility
MODIFIER_EVENT_ON_BUILDING_KILLED = 203 -- OnBuildingKilled
MODIFIER_EVENT_ON_DAMAGE_CALCULATED = 190 -- OnDamageCalculated
MODIFIER_EVENT_ON_DEATH = 192 -- OnDeath
MODIFIER_EVENT_ON_DEATH_PREVENTED = 186 -- OnDamagePrevented
MODIFIER_EVENT_ON_DOMINATED = 224 -- OnDominated
MODIFIER_EVENT_ON_HEALTH_GAINED = 198 -- OnHealthGained
MODIFIER_EVENT_ON_HEAL_RECEIVED = 202 -- OnHealReceived
MODIFIER_EVENT_ON_HERO_KILLED = 201 -- OnHeroKilled
MODIFIER_EVENT_ON_MANA_GAINED = 199 -- OnManaGained
MODIFIER_EVENT_ON_MODEL_CHANGED = 204 -- OnModelChanged
MODIFIER_EVENT_ON_MODIFIER_ADDED = 205 -- OnModifierAdded
MODIFIER_EVENT_ON_ORB_EFFECT = 188 -- Unused
MODIFIER_EVENT_ON_ORDER = 176 -- OnOrder
MODIFIER_EVENT_ON_PROCESS_CLEAVE = 189 -- OnProcessCleave
MODIFIER_EVENT_ON_PROCESS_UPGRADE = 183 -- Unused
MODIFIER_EVENT_ON_PROJECTILE_DODGE = 175 -- OnProjectileDodge
MODIFIER_EVENT_ON_PROJECTILE_OBSTRUCTION_HIT = 235 -- OnProjectileObstructionHit
MODIFIER_EVENT_ON_REFRESH = 184 -- Unused
MODIFIER_EVENT_ON_RESPAWN = 193 -- OnRespawn
MODIFIER_EVENT_ON_SET_LOCATION = 197 -- OnSetLocation
MODIFIER_EVENT_ON_SPELL_TARGET_READY = 168 -- OnSpellTargetReady
MODIFIER_EVENT_ON_SPENT_MANA = 194 -- OnSpentMana
MODIFIER_EVENT_ON_STATE_CHANGED = 187 -- OnStateChanged
MODIFIER_EVENT_ON_TAKEDAMAGE = 185 -- OnTakeDamage
MODIFIER_EVENT_ON_TAKEDAMAGE_KILLCREDIT = 200 -- OnTakeDamageKillCredit
MODIFIER_EVENT_ON_TELEPORTED = 196 -- OnTeleported
MODIFIER_EVENT_ON_TELEPORTING = 195 -- OnTeleporting
MODIFIER_EVENT_ON_UNIT_MOVED = 177 -- OnUnitMoved
MODIFIER_FUNCTION_INVALID = 255
MODIFIER_FUNCTION_LAST = 245
MODIFIER_PROPERTY_ABILITY_LAYOUT = 223 -- GetModifierAbilityLayout
MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL = 144 -- GetAbsoluteNoDamageMagical
MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL = 143 -- GetAbsoluteNoDamagePhysical
MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE = 145 -- GetAbsoluteNoDamagePure
MODIFIER_PROPERTY_ABSORB_SPELL = 133 -- GetAbsorbSpell
MODIFIER_PROPERTY_ALWAYS_ALLOW_ATTACK = 155 -- GetAlwaysAllowAttack
MODIFIER_PROPERTY_ALWAYS_AUTOATTACK_WHILE_HOLD_POSITION = 167 -- GetAlwaysAutoAttackWhileHoldPosition
MODIFIER_PROPERTY_ALWAYS_ETHEREAL_ATTACK = 156 -- GetAllowEtherealAttack
MODIFIER_PROPERTY_ATTACKSPEED_BASE_OVERRIDE = 29 -- GetModifierAttackSpeedBaseOverride
MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT = 31 -- GetModifierAttackSpeedBonus_Constant
MODIFIER_PROPERTY_ATTACKSPEED_PERCENTAGE = 243 -- GetModifierAttackSpeedPercentage
MODIFIER_PROPERTY_ATTACKSPEED_REDUCTION_PERCENTAGE = 240 -- GetModifierAttackSpeedReductionPercentage
MODIFIER_PROPERTY_ATTACK_ANIM_TIME_PERCENTAGE = 117 -- GetModifierPercentageAttackAnimTime
MODIFIER_PROPERTY_ATTACK_POINT_CONSTANT = 37 -- GetModifierAttackPointConstant
MODIFIER_PROPERTY_ATTACK_RANGE_BASE_OVERRIDE = 102 -- GetModifierAttackRangeOverride
MODIFIER_PROPERTY_ATTACK_RANGE_BONUS = 103 -- GetModifierAttackRangeBonus
MODIFIER_PROPERTY_ATTACK_RANGE_BONUS_PERCENTAGE = 105 -- GetModifierAttackRangeBonusPercentage
MODIFIER_PROPERTY_ATTACK_RANGE_BONUS_UNIQUE = 104 -- GetModifierAttackRangeBonusUnique
MODIFIER_PROPERTY_ATTACK_WHILE_MOVING_TARGET = 242
MODIFIER_PROPERTY_AVOID_DAMAGE = 65 -- GetModifierAvoidDamage
MODIFIER_PROPERTY_AVOID_SPELL = 66 -- GetModifierAvoidSpell
MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE = 4 -- GetModifierBaseAttack_BonusDamage
MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE = 54 -- GetModifierBaseDamageOutgoing_Percentage
MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE_UNIQUE = 55 -- GetModifierBaseDamageOutgoing_PercentageUnique
MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT = 35 -- GetModifierBaseAttackTimeConstant
MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT_ADJUST = 36 -- GetModifierBaseAttackTimeConstant_Adjust
MODIFIER_PROPERTY_BASE_MANA_REGEN = 79 -- GetModifierBaseRegen
MODIFIER_PROPERTY_BONUSDAMAGEOUTGOING_PERCENTAGE = 38 -- GetModifierBonusDamageOutgoing_Percentage
MODIFIER_PROPERTY_BONUS_DAY_VISION = 136 -- GetBonusDayVision
MODIFIER_PROPERTY_BONUS_NIGHT_VISION = 137 -- GetBonusNightVision
MODIFIER_PROPERTY_BONUS_NIGHT_VISION_UNIQUE = 138 -- GetBonusNightVisionUnique
MODIFIER_PROPERTY_BONUS_VISION_PERCENTAGE = 139 -- GetBonusVisionPercentage
MODIFIER_PROPERTY_BOT_ATTACK_SCORE_BONUS = 239 -- BotAttackScoreBonus
MODIFIER_PROPERTY_BOUNTY_CREEP_MULTIPLIER = 159 -- Unused
MODIFIER_PROPERTY_BOUNTY_OTHER_MULTIPLIER = 160 -- Unused
MODIFIER_PROPERTY_CAN_ATTACK_TREES = 229 -- GetModifierCanAttackTrees
MODIFIER_PROPERTY_CASTTIME_PERCENTAGE = 116 -- GetModifierPercentageCasttime
MODIFIER_PROPERTY_CAST_RANGE_BONUS = 99 -- GetModifierCastRangeBonus
MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING = 101 -- GetModifierCastRangeBonusStacking
MODIFIER_PROPERTY_CAST_RANGE_BONUS_TARGET = 100 -- GetModifierCastRangeBonusTarget
MODIFIER_PROPERTY_CHANGE_ABILITY_VALUE = 220 -- GetModifierChangeAbilityValue
MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE = 114 -- GetModifierPercentageCooldown
MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE_ONGOING = 115 -- GetModifierPercentageCooldownOngoing
MODIFIER_PROPERTY_COOLDOWN_REDUCTION_CONSTANT = 33 -- GetModifierCooldownReduction_Constant
MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE = 39 -- GetModifierDamageOutgoing_Percentage
MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE_ILLUSION = 40 -- GetModifierDamageOutgoing_Percentage_Illusion
MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE_ILLUSION_AMPLIFY = 41 -- GetModifierDamageOutgoing_Percentage_Illusion_Amplify
MODIFIER_PROPERTY_DEATHGOLDCOST = 120 -- GetModifierConstantDeathGoldCost
MODIFIER_PROPERTY_DISABLE_AUTOATTACK = 135 -- GetDisableAutoAttack
MODIFIER_PROPERTY_DISABLE_HEALING = 154 -- GetDisableHealing
MODIFIER_PROPERTY_DISABLE_TURNING = 218 -- GetModifierDisableTurning
MODIFIER_PROPERTY_DODGE_PROJECTILE = 162 -- GetModifierDodgeProjectile
MODIFIER_PROPERTY_DONT_GIVE_VISION_OF_ATTACKER = 232 -- GetModifierNoVisionOfAttacker
MODIFIER_PROPERTY_EVASION_CONSTANT = 60 -- GetModifierEvasion_Constant
MODIFIER_PROPERTY_EXP_RATE_BOOST = 121 -- GetModifierPercentageExpRateBoost
MODIFIER_PROPERTY_EXTRA_HEALTH_BONUS = 89 -- GetModifierExtraHealthBonus
MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE = 91 -- GetModifierExtraHealthPercentage
MODIFIER_PROPERTY_EXTRA_MANA_BONUS = 90 -- GetModifierExtraManaBonus
MODIFIER_PROPERTY_EXTRA_MANA_PERCENTAGE = 92 -- GetModifierExtraManaPercentage
MODIFIER_PROPERTY_EXTRA_STRENGTH_BONUS = 88 -- GetModifierExtraStrengthBonus
MODIFIER_PROPERTY_FIXED_ATTACK_RATE = 30 -- GetModifierFixedAttackRate
MODIFIER_PROPERTY_FIXED_DAY_VISION = 140 -- GetFixedDayVision
MODIFIER_PROPERTY_FIXED_NIGHT_VISION = 141 -- GetFixedNightVision
MODIFIER_PROPERTY_FORCE_DRAW_MINIMAP = 217 -- GetForceDrawOnMinimap
MODIFIER_PROPERTY_GOLD_RATE_BOOST = 122 -- GetModifierPercentageGoldRateBoost
MODIFIER_PROPERTY_HEALTH_BONUS = 86 -- GetModifierHealthBonus
MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT = 83 -- GetModifierConstantHealthRegen
MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE = 84 -- GetModifierHealthRegenPercentage
MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE_UNIQUE = 85 -- GetModifierHealthRegenPercentageUnique
MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_SOURCE = 46 -- GetModifierHealAmplify_PercentageSource
MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET = 47 -- GetModifierHealAmplify_PercentageTarget
MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE = 48 -- GetModifierHPRegenAmplify_Percentage
MODIFIER_PROPERTY_IGNORE_ATTACKSPEED_LIMIT = 32 -- GetModifierAttackSpeed_Limit
MODIFIER_PROPERTY_IGNORE_CAST_ANGLE = 219 -- GetModifierIgnoreCastAngle
MODIFIER_PROPERTY_IGNORE_COOLDOWN = 228 -- GetModifierIgnoreCooldown
MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT = 27 -- GetModifierIgnoreMovespeedLimit
MODIFIER_PROPERTY_IGNORE_PHYSICAL_ARMOR = 73 -- GetModifierIgnorePhysicalArmor
MODIFIER_PROPERTY_ILLUSION_LABEL = 147 -- GetModifierIllusionLabel
MODIFIER_PROPERTY_INCOMING_DAMAGE_ILLUSION = 231
MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE = 56 -- GetModifierIncomingDamage_Percentage
MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_CONSTANT = 58 -- GetModifierIncomingPhysicalDamageConstant
MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_PERCENTAGE = 57 -- GetModifierIncomingPhysicalDamage_Percentage
MODIFIER_PROPERTY_INCOMING_SPELL_DAMAGE_CONSTANT = 59 -- GetModifierIncomingSpellDamageConstant
MODIFIER_PROPERTY_INVISIBILITY_ATTACK_BEHAVIOR_EXCEPTION = 13 -- GetModifierInvisibilityAttackBehaviorException
MODIFIER_PROPERTY_INVISIBILITY_LEVEL = 12 -- GetModifierInvisibilityLevel
MODIFIER_PROPERTY_IS_ILLUSION = 146 -- GetIsIllusion
MODIFIER_PROPERTY_IS_SCEPTER = 209 -- GetModifierScepter
MODIFIER_PROPERTY_IS_SHARD = 210 -- GetModifierShard
MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE = 49 -- GetModifierLifestealRegenAmplify_Percentage
MODIFIER_PROPERTY_LIFETIME_FRACTION = 214 -- GetUnitLifetimeFraction
MODIFIER_PROPERTY_MAGICAL_CONSTANT_BLOCK = 125 -- GetModifierMagical_ConstantBlock
MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BASE_REDUCTION = 74 -- GetModifierMagicalResistanceBaseReduction
MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS = 76 -- GetModifierMagicalResistanceBonus
MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS_ILLUSIONS = 77 -- GetModifierMagicalResistanceBonusIllusions
MODIFIER_PROPERTY_MAGICAL_RESISTANCE_DECREPIFY_UNIQUE = 78 -- GetModifierMagicalResistanceDecrepifyUnique
MODIFIER_PROPERTY_MAGICAL_RESISTANCE_DIRECT_MODIFICATION = 75 -- GetModifierMagicalResistanceDirectModification
MODIFIER_PROPERTY_MANACOST_PERCENTAGE = 118 -- GetModifierPercentageManacost
MODIFIER_PROPERTY_MANACOST_PERCENTAGE_STACKING = 119 -- GetModifierPercentageManacostStacking
MODIFIER_PROPERTY_MANACOST_REDUCTION_CONSTANT = 34 -- GetModifierManacostReduction_Constant
MODIFIER_PROPERTY_MANA_BONUS = 87 -- GetModifierManaBonus
MODIFIER_PROPERTY_MANA_DRAIN_AMPLIFY_PERCENTAGE = 52 -- GetModifierManaDrainAmplify_Percentage
MODIFIER_PROPERTY_MANA_REGEN_CONSTANT = 80 -- GetModifierConstantManaRegen
MODIFIER_PROPERTY_MANA_REGEN_CONSTANT_UNIQUE = 81 -- GetModifierConstantManaRegenUnique
MODIFIER_PROPERTY_MANA_REGEN_TOTAL_PERCENTAGE = 82 -- GetModifierTotalPercentageManaRegen
MODIFIER_PROPERTY_MAX_ATTACK_RANGE = 106 -- GetModifierMaxAttackRange
MODIFIER_PROPERTY_MAX_DEBUFF_DURATION = 164 -- GetModifierMaxDebuffDuration
MODIFIER_PROPERTY_MIN_HEALTH = 142 -- GetMinHealth
MODIFIER_PROPERTY_MISS_PERCENTAGE = 67 -- GetModifierMiss_Percentage
MODIFIER_PROPERTY_MODEL_CHANGE = 207 -- GetModifierModelChange
MODIFIER_PROPERTY_MODEL_SCALE = 208 -- GetModifierModelScale
MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE = 24 -- GetModifierMoveSpeed_Absolute
MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE_MAX = 26 -- GetModifierMoveSpeed_AbsoluteMax
MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE_MIN = 25 -- GetModifierMoveSpeed_AbsoluteMin
MODIFIER_PROPERTY_MOVESPEED_BASE_OVERRIDE = 16 -- GetModifierMoveSpeedOverride
MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT = 15 -- GetModifierMoveSpeedBonus_Constant
MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT_UNIQUE = 22 -- GetModifierMoveSpeedBonus_Constant_Unique
MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT_UNIQUE_2 = 23 -- GetModifierMoveSpeedBonus_Constant_Unique_2
MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE = 17 -- GetModifierMoveSpeedBonus_Percentage
MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE_UNIQUE = 18 -- GetModifierMoveSpeedBonus_Percentage_Unique
MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE_UNIQUE_2 = 19 -- GetModifierMoveSpeedBonus_Percentage_Unique_2
MODIFIER_PROPERTY_MOVESPEED_BONUS_UNIQUE = 20 -- GetModifierMoveSpeedBonus_Special_Boots
MODIFIER_PROPERTY_MOVESPEED_BONUS_UNIQUE_2 = 21 -- GetModifierMoveSpeedBonus_Special_Boots_2
MODIFIER_PROPERTY_MOVESPEED_LIMIT = 28 -- GetModifierMoveSpeed_Limit
MODIFIER_PROPERTY_MOVESPEED_REDUCTION_PERCENTAGE = 241 -- GetModifierMoveSpeedReductionPercentage
MODIFIER_PROPERTY_MP_REGEN_AMPLIFY_PERCENTAGE = 51 -- GetModifierMPRegenAmplify_Percentage
MODIFIER_PROPERTY_MP_RESTORE_AMPLIFY_PERCENTAGE = 53 -- GetModifierMPRestoreAmplify_Percentage
MODIFIER_PROPERTY_NEGATIVE_EVASION_CONSTANT = 61 -- GetModifierNegativeEvasion_Constant
MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL = 221 -- GetModifierOverrideAbilitySpecial
MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL_VALUE = 222 -- GetModifierOverrideAbilitySpecialValue
MODIFIER_PROPERTY_OVERRIDE_ANIMATION = 130 -- GetOverrideAnimation
MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE = 132 -- GetOverrideAnimationRate
MODIFIER_PROPERTY_OVERRIDE_ANIMATION_WEIGHT = 131 -- GetOverrideAnimationWeight
MODIFIER_PROPERTY_OVERRIDE_ATTACK_DAMAGE = 10 -- GetModifierOverrideAttackDamage
MODIFIER_PROPERTY_OVERRIDE_ATTACK_MAGICAL = 157 -- GetOverrideAttackMagical
MODIFIER_PROPERTY_PERSISTENT_INVISIBILITY = 14 -- GetModifierPersistentInvisibility
MODIFIER_PROPERTY_PHYSICAL_ARMOR_BASE_PERCENTAGE = 68 -- GetModifierPhysicalArmorBase_Percentage
MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS = 70 -- GetModifierPhysicalArmorBonus
MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS_UNIQUE = 71 -- GetModifierPhysicalArmorBonusUnique
MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS_UNIQUE_ACTIVE = 72 -- GetModifierPhysicalArmorBonusUniqueActive
MODIFIER_PROPERTY_PHYSICAL_ARMOR_TOTAL_PERCENTAGE = 69 -- GetModifierPhysicalArmorTotal_Percentage
MODIFIER_PROPERTY_PHYSICAL_CONSTANT_BLOCK = 126 -- GetModifierPhysical_ConstantBlock
MODIFIER_PROPERTY_PHYSICAL_CONSTANT_BLOCK_SPECIAL = 127 -- GetModifierPhysical_ConstantBlockSpecial
MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE = 0 -- GetModifierPreAttack_BonusDamage
MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE_POST_CRIT = 3 -- GetModifierPreAttack_BonusDamagePostCrit
MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE_PROC = 2 -- GetModifierPreAttack_BonusDamage_Proc
MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE_TARGET = 1 -- GetModifierPreAttack_BonusDamage_Target
MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE = 123 -- GetModifierPreAttack_CriticalStrike
MODIFIER_PROPERTY_PREATTACK_DEADLY_BLOW = 166 -- GetModifierPreAttack_DeadlyBlow
MODIFIER_PROPERTY_PREATTACK_TARGET_CRITICALSTRIKE = 124 -- GetModifierPreAttack_Target_CriticalStrike
MODIFIER_PROPERTY_PRESERVE_PARTICLES_ON_MODEL_CHANGE = 226 -- PreserveParticlesOnModelChanged
MODIFIER_PROPERTY_PRE_ATTACK = 11 -- GetModifierPreAttack
MODIFIER_PROPERTY_PRIMARY_STAT_DAMAGE_MULTIPLIER = 165 -- GetPrimaryStatDamageMultiplier
MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_MAGICAL = 6 -- GetModifierProcAttack_BonusDamage_Magical
MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_MAGICAL_TARGET = 8 -- GetModifierProcAttack_BonusDamage_Magical_Target
MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL = 5 -- GetModifierProcAttack_BonusDamage_Physical
MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PURE = 7 -- GetModifierProcAttack_BonusDamage_Pure
MODIFIER_PROPERTY_PROCATTACK_FEEDBACK = 9 -- GetModifierProcAttack_Feedback
MODIFIER_PROPERTY_PROJECTILE_NAME = 109 -- GetModifierProjectileName
MODIFIER_PROPERTY_PROJECTILE_SPEED_BONUS = 107 -- GetModifierProjectileSpeedBonus
MODIFIER_PROPERTY_PROJECTILE_SPEED_BONUS_PERCENTAGE = 108 -- GetModifierProjectileSpeedBonusPercentage
MODIFIER_PROPERTY_PROVIDES_FOW_POSITION = 215 -- GetModifierProvidesFOWVision
MODIFIER_PROPERTY_RADAR_COOLDOWN_REDUCTION = 211 -- GetModifierRadarCooldownReduction
MODIFIER_PROPERTY_REFLECT_SPELL = 134 -- GetReflectSpell
MODIFIER_PROPERTY_REINCARNATION = 110 -- ReincarnateTime
MODIFIER_PROPERTY_RESPAWNTIME = 111 -- GetModifierConstantRespawnTime
MODIFIER_PROPERTY_RESPAWNTIME_PERCENTAGE = 112 -- GetModifierPercentageRespawnTime
MODIFIER_PROPERTY_RESPAWNTIME_STACKING = 113 -- GetModifierStackingRespawnTime
MODIFIER_PROPERTY_SPELLS_REQUIRE_HP = 216 -- GetModifierSpellsRequireHP
MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE = 44 -- GetModifierSpellAmplify_Percentage
MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE_CREEP = 43 -- GetModifierSpellAmplify_PercentageCreep
MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE_UNIQUE = 45 -- GetModifierSpellAmplify_PercentageUnique
MODIFIER_PROPERTY_SPELL_LIFESTEAL_AMPLIFY_PERCENTAGE = 50 -- GetModifierSpellLifestealRegenAmplify_Percentage
MODIFIER_PROPERTY_STATS_AGILITY_BONUS = 94 -- GetModifierBonusStats_Agility
MODIFIER_PROPERTY_STATS_AGILITY_BONUS_PERCENTAGE = 97 -- GetModifierBonusStats_Agility_Percentage
MODIFIER_PROPERTY_STATS_INTELLECT_BONUS = 95 -- GetModifierBonusStats_Intellect
MODIFIER_PROPERTY_STATS_INTELLECT_BONUS_PERCENTAGE = 98 -- GetModifierBonusStats_Intellect_Percentage
MODIFIER_PROPERTY_STATS_STRENGTH_BONUS = 93 -- GetModifierBonusStats_Strength
MODIFIER_PROPERTY_STATS_STRENGTH_BONUS_PERCENTAGE = 96 -- GetModifierBonusStats_Strength_Percentage
MODIFIER_PROPERTY_STATUS_RESISTANCE = 62 -- GetModifierStatusResistance
MODIFIER_PROPERTY_STATUS_RESISTANCE_CASTER = 64 -- GetModifierStatusResistanceCaster
MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING = 63 -- GetModifierStatusResistanceStacking
MODIFIER_PROPERTY_STRONG_ILLUSION = 148 -- GetModifierStrongIllusion
MODIFIER_PROPERTY_SUPER_ILLUSION = 149 -- GetModifierSuperIllusion
MODIFIER_PROPERTY_SUPER_ILLUSION_WITH_ULTIMATE = 150 -- GetModifierSuperIllusionWithUltimate
MODIFIER_PROPERTY_SUPPRESS_CLEAVE = 238 -- GetSuppressCleave
MODIFIER_PROPERTY_SUPPRESS_TELEPORT = 236 -- GetSuppressTeleport
MODIFIER_PROPERTY_TEMPEST_DOUBLE = 225 -- GetModifierTempestDouble
MODIFIER_PROPERTY_TOOLTIP = 206 -- OnTooltip
MODIFIER_PROPERTY_TOOLTIP2 = 233 -- OnTooltip2
MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE = 42 -- GetModifierTotalDamageOutgoing_Percentage
MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK = 129 -- GetModifierTotal_ConstantBlock
MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK_UNAVOIDABLE_PRE_ARMOR = 128 -- GetModifierPhysical_ConstantBlockUnavoidablePreArmor
MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS = 212 -- GetActivityTranslationModifiers
MODIFIER_PROPERTY_TRANSLATE_ATTACK_SOUND = 213 -- GetAttackSound
MODIFIER_PROPERTY_TRIGGER_COSMETIC_AND_END_ATTACK = 163 -- GetTriggerCosmeticAndEndAttack
MODIFIER_PROPERTY_TURN_RATE_OVERRIDE = 153 -- GetModifierTurnRate_Override
MODIFIER_PROPERTY_TURN_RATE_PERCENTAGE = 152 -- GetModifierTurnRate_Percentage
MODIFIER_PROPERTY_UNIT_DISALLOW_UPGRADING = 161 -- GetModifierUnitDisllowUpgrading
MODIFIER_PROPERTY_UNIT_STATS_NEEDS_REFRESH = 158 -- GetModifierUnitStatsNeedsRefresh
MODIFIER_PROPERTY_VISUAL_Z_DELTA = 230 -- GetVisualZDelta
MODIFIER_PROPERTY_XP_DURING_DEATH = 151 -- GetModifierXPDuringDeath

--- Enum modifierpriority
MODIFIER_PRIORITY_HIGH = 2
MODIFIER_PRIORITY_LOW = 0
MODIFIER_PRIORITY_NORMAL = 1
MODIFIER_PRIORITY_SUPER_ULTRA = 4
MODIFIER_PRIORITY_ULTRA = 3

--- Enum modifierremove
DOTA_BUFF_REMOVE_ALL = 0
DOTA_BUFF_REMOVE_ALLY = 2
DOTA_BUFF_REMOVE_ENEMY = 1

--- Enum modifierstate
MODIFIER_STATE_ALLOW_PATHING_THROUGH_CLIFFS = 46
MODIFIER_STATE_ALLOW_PATHING_THROUGH_FISSURE = 47
MODIFIER_STATE_ALLOW_PATHING_THROUGH_TREES = 36
MODIFIER_STATE_ATTACK_ALLIES = 45
MODIFIER_STATE_ATTACK_IMMUNE = 2
MODIFIER_STATE_BLIND = 29
MODIFIER_STATE_BLOCK_DISABLED = 12
MODIFIER_STATE_CANNOT_BE_MOTION_CONTROLLED = 43
MODIFIER_STATE_CANNOT_MISS = 16
MODIFIER_STATE_CANNOT_TARGET_ENEMIES = 15
MODIFIER_STATE_COMMAND_RESTRICTED = 19
MODIFIER_STATE_DISARMED = 1
MODIFIER_STATE_DOMINATED = 28
MODIFIER_STATE_EVADE_DISABLED = 13
MODIFIER_STATE_FAKE_ALLY = 31
MODIFIER_STATE_FEARED = 41
MODIFIER_STATE_FLYING = 23
MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY = 32
MODIFIER_STATE_FORCED_FLYING_VISION = 44
MODIFIER_STATE_FROZEN = 18
MODIFIER_STATE_HEXED = 6
MODIFIER_STATE_IGNORING_MOVE_AND_ATTACK_ORDERS = 35
MODIFIER_STATE_IGNORING_STOP_ORDERS = 40
MODIFIER_STATE_INVISIBLE = 7
MODIFIER_STATE_INVULNERABLE = 8
MODIFIER_STATE_LAST = 49
MODIFIER_STATE_LOW_ATTACK_PRIORITY = 21
MODIFIER_STATE_MAGIC_IMMUNE = 9
MODIFIER_STATE_MUTED = 4
MODIFIER_STATE_NIGHTMARED = 11
MODIFIER_STATE_NOT_ON_MINIMAP = 20
MODIFIER_STATE_NOT_ON_MINIMAP_FOR_ENEMIES = 37
MODIFIER_STATE_NO_HEALTH_BAR = 22
MODIFIER_STATE_NO_TEAM_MOVE_TO = 25
MODIFIER_STATE_NO_TEAM_SELECT = 26
MODIFIER_STATE_NO_UNIT_COLLISION = 24
MODIFIER_STATE_OUT_OF_GAME = 30
MODIFIER_STATE_PASSIVES_DISABLED = 27
MODIFIER_STATE_PROVIDES_VISION = 10
MODIFIER_STATE_ROOTED = 0
MODIFIER_STATE_SILENCED = 3
MODIFIER_STATE_SPECIALLY_DENIABLE = 17
MODIFIER_STATE_SPECIALLY_UNDENIABLE = 48
MODIFIER_STATE_STUNNED = 5
MODIFIER_STATE_TAUNTED = 42
MODIFIER_STATE_TETHERED = 39
MODIFIER_STATE_TRUESIGHT_IMMUNE = 33
MODIFIER_STATE_UNSELECTABLE = 14
MODIFIER_STATE_UNSLOWABLE = 38
MODIFIER_STATE_UNTARGETABLE = 34

--- Enum quest_text_replace_values_t
QUEST_NUM_TEXT_REPLACE_VALUES = 4
QUEST_TEXT_REPLACE_VALUE_CURRENT_VALUE = 0
QUEST_TEXT_REPLACE_VALUE_REWARD = 3
QUEST_TEXT_REPLACE_VALUE_ROUND = 2
QUEST_TEXT_REPLACE_VALUE_TARGET_VALUE = 1

--- Enum subquest_text_replace_values_t
SUBQUEST_NUM_TEXT_REPLACE_VALUES = 2
SUBQUEST_TEXT_REPLACE_VALUE_CURRENT_VALUE = 0
SUBQUEST_TEXT_REPLACE_VALUE_TARGET_VALUE = 1
---[[ CBaseAnimating:ActiveSequenceDuration  Returns the duration in seconds of the active sequence. ])
-- @return float
function CBaseAnimating:ActiveSequenceDuration(  ) end

---[[ CBaseAnimating:GetCycle  Get the cycle of the animation. ])
-- @return float
function CBaseAnimating:GetCycle(  ) end

---[[ CBaseAnimating:GetGraphParameter  Get the value of the given animGraph parameter ])
-- @return table
-- @param pszParam string
function CBaseAnimating:GetGraphParameter( pszParam ) end

---[[ CBaseAnimating:GetSequence  Returns the name of the active sequence. ])
-- @return string
function CBaseAnimating:GetSequence(  ) end

---[[ CBaseAnimating:IsSequenceFinished  Ask whether the main sequence is done playing. ])
-- @return bool
function CBaseAnimating:IsSequenceFinished(  ) end

---[[ CBaseAnimating:ResetSequence  Sets the active sequence by name, resetting the current cycle. ])
-- @return void
-- @param pSequenceName string
function CBaseAnimating:ResetSequence( pSequenceName ) end

---[[ CBaseAnimating:SequenceDuration  Returns the duration in seconds of the given sequence name. ])
-- @return float
-- @param pSequenceName string
function CBaseAnimating:SequenceDuration( pSequenceName ) end

---[[ CBaseAnimating:SetCycle  Set the cycle of the animation. ])
-- @return void
-- @param flCycle float
function CBaseAnimating:SetCycle( flCycle ) end

---[[ CBaseAnimating:SetGraphLookTarget  Pass the desired look target in world space to the graph ])
-- @return void
-- @param vValue Vector
function CBaseAnimating:SetGraphLookTarget( vValue ) end

---[[ CBaseAnimating:SetGraphParameter  Set the specific param value, type is inferred from the type in script ])
-- @return void
-- @param pszParam string
-- @param svArg table
function CBaseAnimating:SetGraphParameter( pszParam, svArg ) end

---[[ CBaseAnimating:SetGraphParameterBool  Set the specific param on or off ])
-- @return void
-- @param szName string
-- @param bValue bool
function CBaseAnimating:SetGraphParameterBool( szName, bValue ) end

---[[ CBaseAnimating:SetGraphParameterEnum  Pass the enum (int) value to the specified param ])
-- @return void
-- @param szName string
-- @param nValue int
function CBaseAnimating:SetGraphParameterEnum( szName, nValue ) end

---[[ CBaseAnimating:SetGraphParameterFloat  Pass the float value to the specified param ])
-- @return void
-- @param szName string
-- @param flValue float
function CBaseAnimating:SetGraphParameterFloat( szName, flValue ) end

---[[ CBaseAnimating:SetGraphParameterInt  Pass the int value to the specified param ])
-- @return void
-- @param szName string
-- @param nValue int
function CBaseAnimating:SetGraphParameterInt( szName, nValue ) end

---[[ CBaseAnimating:SetGraphParameterVector  Pass the vector value to the specified param in the graph ])
-- @return void
-- @param szName string
-- @param vValue Vector
function CBaseAnimating:SetGraphParameterVector( szName, vValue ) end

---[[ CBaseAnimating:SetPoseParameter  Set the specified pose parameter to the specified value. ])
-- @return float
-- @param szName string
-- @param fValue float
function CBaseAnimating:SetPoseParameter( szName, fValue ) end

---[[ CBaseAnimating:SetSequence  Sets the active sequence by name, keeping the current cycle. ])
-- @return void
-- @param pSequenceName string
function CBaseAnimating:SetSequence( pSequenceName ) end

---[[ CBaseAnimating:StopAnimation  Stop the current animation by setting playback rate to 0.0. ])
-- @return void
function CBaseAnimating:StopAnimation(  ) end

---[[ CBaseEntity:AddEffects  AddEffects( int ): Adds the render effect flag. ])
-- @return void
-- @param nFlags int
function CBaseEntity:AddEffects( nFlags ) end

---[[ CBaseEntity:ApplyAbsVelocityImpulse  Apply a Velocity Impulse ])
-- @return void
-- @param vecImpulse Vector
function CBaseEntity:ApplyAbsVelocityImpulse( vecImpulse ) end

---[[ CBaseEntity:ApplyLocalAngularVelocityImpulse  Apply an Ang Velocity Impulse ])
-- @return void
-- @param angImpulse Vector
function CBaseEntity:ApplyLocalAngularVelocityImpulse( angImpulse ) end

---[[ CBaseEntity:Attribute_GetFloatValue  Get float value for an entity attribute. ])
-- @return float
-- @param pName string
-- @param flDefault float
function CBaseEntity:Attribute_GetFloatValue( pName, flDefault ) end

---[[ CBaseEntity:Attribute_GetIntValue  Get int value for an entity attribute. ])
-- @return int
-- @param pName string
-- @param nDefault int
function CBaseEntity:Attribute_GetIntValue( pName, nDefault ) end

---[[ CBaseEntity:Attribute_SetFloatValue  Set float value for an entity attribute. ])
-- @return void
-- @param pName string
-- @param flValue float
function CBaseEntity:Attribute_SetFloatValue( pName, flValue ) end

---[[ CBaseEntity:Attribute_SetIntValue  Set int value for an entity attribute. ])
-- @return void
-- @param pName string
-- @param nValue int
function CBaseEntity:Attribute_SetIntValue( pName, nValue ) end

---[[ CBaseEntity:DeleteAttribute  Delete an entity attribute. ])
-- @return void
-- @param pName string
function CBaseEntity:DeleteAttribute( pName ) end

---[[ CBaseEntity:EmitSound  Plays a sound from this entity. ])
-- @return void
-- @param soundname string
function CBaseEntity:EmitSound( soundname ) end

---[[ CBaseEntity:EmitSoundParams  Plays/modifies a sound from this entity. changes sound if nPitch and/or flVol or flSoundTime is > 0. ])
-- @return void
-- @param soundname string
-- @param nPitch int
-- @param flVolume float
-- @param flDelay float
function CBaseEntity:EmitSoundParams( soundname, nPitch, flVolume, flDelay ) end

---[[ CBaseEntity:EyeAngles  Get the qangles that this entity is looking at. ])
-- @return QAngle
function CBaseEntity:EyeAngles(  ) end

---[[ CBaseEntity:EyePosition  Get vector to eye position - absolute coords. ])
-- @return Vector
function CBaseEntity:EyePosition(  ) end

---[[ CBaseEntity:FirstMoveChild   ])
-- @return handle
function CBaseEntity:FirstMoveChild(  ) end

---[[ CBaseEntity:FollowEntity  hEntity to follow, bool bBoneMerge ])
-- @return void
-- @param hEnt handle
-- @param bBoneMerge bool
function CBaseEntity:FollowEntity( hEnt, bBoneMerge ) end

---[[ CBaseEntity:GatherCriteria  Returns a table containing the criteria that would be used for response queries on this entity. This is the same as the table that is passed to response rule script function callbacks. ])
-- @return void
-- @param hResult handle
function CBaseEntity:GatherCriteria( hResult ) end

---[[ CBaseEntity:GetAbsOrigin   ])
-- @return Vector
function CBaseEntity:GetAbsOrigin(  ) end

---[[ CBaseEntity:GetAbsScale   ])
-- @return float
function CBaseEntity:GetAbsScale(  ) end

---[[ CBaseEntity:GetAngles   ])
-- @return QAngle
function CBaseEntity:GetAngles(  ) end

---[[ CBaseEntity:GetAnglesAsVector  Get entity pitch, yaw, roll as a vector. ])
-- @return Vector
function CBaseEntity:GetAnglesAsVector(  ) end

---[[ CBaseEntity:GetAngularVelocity  Get the local angular velocity - returns a vector of pitch,yaw,roll ])
-- @return Vector
function CBaseEntity:GetAngularVelocity(  ) end

---[[ CBaseEntity:GetBaseVelocity  Get Base? velocity. ])
-- @return Vector
function CBaseEntity:GetBaseVelocity(  ) end

---[[ CBaseEntity:GetBoundingMaxs  Get a vector containing max bounds, centered on object. ])
-- @return Vector
function CBaseEntity:GetBoundingMaxs(  ) end

---[[ CBaseEntity:GetBoundingMins  Get a vector containing min bounds, centered on object. ])
-- @return Vector
function CBaseEntity:GetBoundingMins(  ) end

---[[ CBaseEntity:GetBounds  Get a table containing the 'Mins' & 'Maxs' vector bounds, centered on object. ])
-- @return table
function CBaseEntity:GetBounds(  ) end

---[[ CBaseEntity:GetCenter  Get vector to center of object - absolute coords ])
-- @return Vector
function CBaseEntity:GetCenter(  ) end

---[[ CBaseEntity:GetChildren  Get the entities parented to this entity. ])
-- @return handle
function CBaseEntity:GetChildren(  ) end

---[[ CBaseEntity:GetContext  GetContext( name ): looks up a context and returns it if available. May return string, float, or null (if the context isn't found). ])
-- @return table
-- @param name string
function CBaseEntity:GetContext( name ) end

---[[ CBaseEntity:GetForwardVector  Get the forward vector of the entity. ])
-- @return Vector
function CBaseEntity:GetForwardVector(  ) end

---[[ CBaseEntity:GetHealth  Get the health of this entity. ])
-- @return int
function CBaseEntity:GetHealth(  ) end

---[[ CBaseEntity:GetLocalAngles  Get entity local pitch, yaw, roll as a QAngle ])
-- @return QAngle
function CBaseEntity:GetLocalAngles(  ) end

---[[ CBaseEntity:GetLocalAngularVelocity  Maybe local angvel ])
-- @return QAngle
function CBaseEntity:GetLocalAngularVelocity(  ) end

---[[ CBaseEntity:GetLocalOrigin  Get entity local origin as a Vector ])
-- @return Vector
function CBaseEntity:GetLocalOrigin(  ) end

---[[ CBaseEntity:GetLocalScale   ])
-- @return float
function CBaseEntity:GetLocalScale(  ) end

---[[ CBaseEntity:GetLocalVelocity  Get Entity relative velocity. ])
-- @return Vector
function CBaseEntity:GetLocalVelocity(  ) end

---[[ CBaseEntity:GetMass  Get the mass of an entity. (returns 0 if it doesn't have a physics object) ])
-- @return float
function CBaseEntity:GetMass(  ) end

---[[ CBaseEntity:GetMaxHealth  Get the maximum health of this entity. ])
-- @return int
function CBaseEntity:GetMaxHealth(  ) end

---[[ CBaseEntity:GetModelName  Returns the name of the model. ])
-- @return string
function CBaseEntity:GetModelName(  ) end

---[[ CBaseEntity:GetMoveParent  If in hierarchy, retrieves the entity's parent. ])
-- @return handle
function CBaseEntity:GetMoveParent(  ) end

---[[ CBaseEntity:GetOrigin   ])
-- @return Vector
function CBaseEntity:GetOrigin(  ) end

---[[ CBaseEntity:GetOwner  Gets this entity's owner ])
-- @return handle
function CBaseEntity:GetOwner(  ) end

---[[ CBaseEntity:GetOwnerEntity  Get the owner entity, if there is one ])
-- @return handle
function CBaseEntity:GetOwnerEntity(  ) end

---[[ CBaseEntity:GetRightVector  Get the right vector of the entity. ])
-- @return Vector
function CBaseEntity:GetRightVector(  ) end

---[[ CBaseEntity:GetRootMoveParent  If in hierarchy, walks up the hierarchy to find the root parent. ])
-- @return handle
function CBaseEntity:GetRootMoveParent(  ) end

---[[ CBaseEntity:GetSoundDuration  Returns float duration of the sound. Takes soundname and optional actormodelname. ])
-- @return float
-- @param soundname string
-- @param actormodel string
function CBaseEntity:GetSoundDuration( soundname, actormodel ) end

---[[ CBaseEntity:GetSpawnGroupHandle  Returns the spawn group handle of this entity ])
-- @return int
function CBaseEntity:GetSpawnGroupHandle(  ) end

---[[ CBaseEntity:GetTeam  Get the team number of this entity. ])
-- @return int
function CBaseEntity:GetTeam(  ) end

---[[ CBaseEntity:GetTeamNumber  Get the team number of this entity. ])
-- @return int
function CBaseEntity:GetTeamNumber(  ) end

---[[ CBaseEntity:GetUpVector  Get the up vector of the entity. ])
-- @return Vector
function CBaseEntity:GetUpVector(  ) end

---[[ CBaseEntity:GetVelocity   ])
-- @return Vector
function CBaseEntity:GetVelocity(  ) end

---[[ CBaseEntity:HasAttribute  See if an entity has a particular attribute. ])
-- @return bool
-- @param pName string
function CBaseEntity:HasAttribute( pName ) end

---[[ CBaseEntity:IsAlive  Is this entity alive? ])
-- @return bool
function CBaseEntity:IsAlive(  ) end

---[[ CBaseEntity:IsNPC  Is this entity an CAI_BaseNPC? ])
-- @return bool
function CBaseEntity:IsNPC(  ) end

---[[ CBaseEntity:IsPlayer  Is this entity a player? ])
-- @return bool
function CBaseEntity:IsPlayer(  ) end

---[[ CBaseEntity:Kill   ])
-- @return void
function CBaseEntity:Kill(  ) end

---[[ CBaseEntity:NextMovePeer   ])
-- @return handle
function CBaseEntity:NextMovePeer(  ) end

---[[ CBaseEntity:OverrideFriction  Takes duration, value for a temporary override. ])
-- @return void
-- @param duration float
-- @param friction float
function CBaseEntity:OverrideFriction( duration, friction ) end

---[[ CBaseEntity:PrecacheScriptSound  Precache a sound for later playing. ])
-- @return void
-- @param soundname string
function CBaseEntity:PrecacheScriptSound( soundname ) end

---[[ CBaseEntity:RemoveEffects  RemoveEffects( int ): Removes the render effect flag. ])
-- @return void
-- @param nFlags int
function CBaseEntity:RemoveEffects( nFlags ) end

---[[ CBaseEntity:SetAbsAngles  Set entity pitch, yaw, roll by component. ])
-- @return void
-- @param fPitch float
-- @param fYaw float
-- @param fRoll float
function CBaseEntity:SetAbsAngles( fPitch, fYaw, fRoll ) end

---[[ CBaseEntity:SetAbsOrigin   ])
-- @return void
-- @param origin Vector
function CBaseEntity:SetAbsOrigin( origin ) end

---[[ CBaseEntity:SetAbsScale   ])
-- @return void
-- @param flScale float
function CBaseEntity:SetAbsScale( flScale ) end

---[[ CBaseEntity:SetAngles  Set entity pitch, yaw, roll by component. ])
-- @return void
-- @param fPitch float
-- @param fYaw float
-- @param fRoll float
function CBaseEntity:SetAngles( fPitch, fYaw, fRoll ) end

---[[ CBaseEntity:SetAngularVelocity  Set the local angular velocity - takes float pitch,yaw,roll velocities ])
-- @return void
-- @param pitchVel float
-- @param yawVel float
-- @param rollVel float
function CBaseEntity:SetAngularVelocity( pitchVel, yawVel, rollVel ) end

---[[ CBaseEntity:SetConstraint  Set the position of the constraint. ])
-- @return void
-- @param vPos Vector
function CBaseEntity:SetConstraint( vPos ) end

---[[ CBaseEntity:SetContext  SetContext( name , value, duration ): store any key/value pair in this entity's dialog contexts. Value must be a string. Will last for duration (set 0 to mean 'forever'). ])
-- @return void
-- @param pName string
-- @param pValue string
-- @param duration float
function CBaseEntity:SetContext( pName, pValue, duration ) end

---[[ CBaseEntity:SetContextNum  SetContextNum( name , value, duration ): store any key/value pair in this entity's dialog contexts. Value must be a number (int or float). Will last for duration (set 0 to mean 'forever'). ])
-- @return void
-- @param pName string
-- @param fValue float
-- @param duration float
function CBaseEntity:SetContextNum( pName, fValue, duration ) end

---[[ CBaseEntity:SetContextThink  Set a think function on this entity. ])
-- @return void
-- @param pszContextName string
-- @param hThinkFunc handle
-- @param flInterval float
function CBaseEntity:SetContextThink( pszContextName, hThinkFunc, flInterval ) end

---[[ CBaseEntity:SetEntityName  Set the name of an entity. ])
-- @return void
-- @param pName string
function CBaseEntity:SetEntityName( pName ) end

---[[ CBaseEntity:SetForwardVector  Set the orientation of the entity to have this forward vector. ])
-- @return void
-- @param v Vector
function CBaseEntity:SetForwardVector( v ) end

---[[ CBaseEntity:SetFriction  Set PLAYER friction, ignored for objects. ])
-- @return void
-- @param flFriction float
function CBaseEntity:SetFriction( flFriction ) end

---[[ CBaseEntity:SetGravity  Set PLAYER gravity, ignored for objects. ])
-- @return void
-- @param flGravity float
function CBaseEntity:SetGravity( flGravity ) end

---[[ CBaseEntity:SetHealth  Set the health of this entity. ])
-- @return void
-- @param nHealth int
function CBaseEntity:SetHealth( nHealth ) end

---[[ CBaseEntity:SetLocalAngles  Set entity local pitch, yaw, roll by component ])
-- @return void
-- @param fPitch float
-- @param fYaw float
-- @param fRoll float
function CBaseEntity:SetLocalAngles( fPitch, fYaw, fRoll ) end

---[[ CBaseEntity:SetLocalOrigin  Set entity local origin from a Vector ])
-- @return void
-- @param origin Vector
function CBaseEntity:SetLocalOrigin( origin ) end

---[[ CBaseEntity:SetLocalScale   ])
-- @return void
-- @param flScale float
function CBaseEntity:SetLocalScale( flScale ) end

---[[ CBaseEntity:SetMass  Set the mass of an entity. (does nothing if it doesn't have a physics object) ])
-- @return void
-- @param flMass float
function CBaseEntity:SetMass( flMass ) end

---[[ CBaseEntity:SetMaxHealth  Set the maximum health of this entity. ])
-- @return void
-- @param amt int
function CBaseEntity:SetMaxHealth( amt ) end

---[[ CBaseEntity:SetOrigin   ])
-- @return void
-- @param v Vector
function CBaseEntity:SetOrigin( v ) end

---[[ CBaseEntity:SetOwner  Sets this entity's owner ])
-- @return void
-- @param pOwner handle
function CBaseEntity:SetOwner( pOwner ) end

---[[ CBaseEntity:SetParent  Set the parent for this entity. ])
-- @return void
-- @param hParent handle
-- @param pAttachmentname string
function CBaseEntity:SetParent( hParent, pAttachmentname ) end

---[[ CBaseEntity:SetTeam   ])
-- @return void
-- @param iTeamNum int
function CBaseEntity:SetTeam( iTeamNum ) end

---[[ CBaseEntity:SetVelocity   ])
-- @return void
-- @param vecVelocity Vector
function CBaseEntity:SetVelocity( vecVelocity ) end

---[[ CBaseEntity:StopSound  Stops a named sound playing from this entity. ])
-- @return void
-- @param soundname string
function CBaseEntity:StopSound( soundname ) end

---[[ CBaseEntity:TakeDamage  Apply damage to this entity. Use CreateDamageInfo() to create a damageinfo object. ])
-- @return int
-- @param hInfo handle
function CBaseEntity:TakeDamage( hInfo ) end

---[[ CBaseEntity:TransformPointEntityToWorld  Returns the input Vector transformed from entity to world space ])
-- @return Vector
-- @param vPoint Vector
function CBaseEntity:TransformPointEntityToWorld( vPoint ) end

---[[ CBaseEntity:TransformPointWorldToEntity  Returns the input Vector transformed from world to entity space ])
-- @return Vector
-- @param vPoint Vector
function CBaseEntity:TransformPointWorldToEntity( vPoint ) end

---[[ CBaseEntity:Trigger  Fires off this entity's OnTrigger responses. ])
-- @return void
function CBaseEntity:Trigger(  ) end

---[[ CBaseEntity:ValidatePrivateScriptScope  Validates the private script scope and creates it if one doesn't exist. ])
-- @return void
function CBaseEntity:ValidatePrivateScriptScope(  ) end

---[[ CBaseFlex:GetCurrentScene  Returns the instance of the oldest active scene entity (if any). ])
-- @return handle
function CBaseFlex:GetCurrentScene(  ) end

---[[ CBaseFlex:GetSceneByIndex  Returns the instance of the scene entity at the specified index. ])
-- @return handle
-- @param index int
function CBaseFlex:GetSceneByIndex( index ) end

---[[ CBaseFlex:ScriptPlayScene  ( vcd file, delay ) - play specified vcd file ])
-- @return float
-- @param pszScene string
-- @param flDelay float
function CBaseFlex:ScriptPlayScene( pszScene, flDelay ) end

---[[ CBaseModelEntity:GetAttachmentAngles  Get the attachment id's angles as a p,y,r vector. ])
-- @return Vector
-- @param iAttachment int
function CBaseModelEntity:GetAttachmentAngles( iAttachment ) end

---[[ CBaseModelEntity:GetAttachmentForward  Get the attachment id's forward vector. ])
-- @return Vector
-- @param iAttachment int
function CBaseModelEntity:GetAttachmentForward( iAttachment ) end

---[[ CBaseModelEntity:GetAttachmentOrigin  Get the attachment id's origin vector. ])
-- @return Vector
-- @param iAttachment int
function CBaseModelEntity:GetAttachmentOrigin( iAttachment ) end

---[[ CBaseModelEntity:GetMaterialGroupHash  GetMaterialGroupHash(): Get the material group hash of this entity. ])
-- @return unsigned
function CBaseModelEntity:GetMaterialGroupHash(  ) end

---[[ CBaseModelEntity:GetMaterialGroupMask  GetMaterialGroupMask(): Get the mesh group mask of this entity. ])
-- @return uint64
function CBaseModelEntity:GetMaterialGroupMask(  ) end

---[[ CBaseModelEntity:GetModelScale  Get scale of entity's model. ])
-- @return float
function CBaseModelEntity:GetModelScale(  ) end

---[[ CBaseModelEntity:GetRenderAlpha  GetRenderAlpha(): Get the alpha modulation of this entity. ])
-- @return int
function CBaseModelEntity:GetRenderAlpha(  ) end

---[[ CBaseModelEntity:GetRenderColor  GetRenderColor(): Get the render color of the entity. ])
-- @return Vector
function CBaseModelEntity:GetRenderColor(  ) end

---[[ CBaseModelEntity:ScriptLookupAttachment  Get the named attachment id. ])
-- @return int
-- @param pAttachmentName string
function CBaseModelEntity:ScriptLookupAttachment( pAttachmentName ) end

---[[ CBaseModelEntity:SetBodygroup  Sets a bodygroup. ])
-- @return void
-- @param iGroup int
-- @param iValue int
function CBaseModelEntity:SetBodygroup( iGroup, iValue ) end

---[[ CBaseModelEntity:SetBodygroupByName  Sets a bodygroup by name. ])
-- @return void
-- @param pName string
-- @param iValue int
function CBaseModelEntity:SetBodygroupByName( pName, iValue ) end

---[[ CBaseModelEntity:SetLightGroup  SetLightGroup( string ): Sets the light group of the entity. ])
-- @return void
-- @param pLightGroup string
function CBaseModelEntity:SetLightGroup( pLightGroup ) end

---[[ CBaseModelEntity:SetMaterialGroup  SetMaterialGroup( string ): Set the material group of this entity. ])
-- @return void
-- @param pMaterialGroup string
function CBaseModelEntity:SetMaterialGroup( pMaterialGroup ) end

---[[ CBaseModelEntity:SetMaterialGroupHash  SetMaterialGroupHash( uint32 ): Set the material group hash of this entity. ])
-- @return void
-- @param nHash unsigned
function CBaseModelEntity:SetMaterialGroupHash( nHash ) end

---[[ CBaseModelEntity:SetMaterialGroupMask  SetMaterialGroupMask( uint64 ): Set the mesh group mask of this entity. ])
-- @return void
-- @param nMeshGroupMask uint64
function CBaseModelEntity:SetMaterialGroupMask( nMeshGroupMask ) end

---[[ CBaseModelEntity:SetModel   ])
-- @return void
-- @param pModelName string
function CBaseModelEntity:SetModel( pModelName ) end

---[[ CBaseModelEntity:SetModelScale  Set scale of entity's model. ])
-- @return void
-- @param flScale float
function CBaseModelEntity:SetModelScale( flScale ) end

---[[ CBaseModelEntity:SetRenderAlpha  SetRenderAlpha( int ): Set the alpha modulation of this entity. ])
-- @return void
-- @param nAlpha int
function CBaseModelEntity:SetRenderAlpha( nAlpha ) end

---[[ CBaseModelEntity:SetRenderColor  SetRenderColor( r, g, b ): Sets the render color of the entity. ])
-- @return void
-- @param r int
-- @param g int
-- @param b int
function CBaseModelEntity:SetRenderColor( r, g, b ) end

---[[ CBaseModelEntity:SetRenderMode  SetRenderMode( int ): Sets the render mode of the entity. ])
-- @return void
-- @param nMode int
function CBaseModelEntity:SetRenderMode( nMode ) end

---[[ CBaseModelEntity:SetSingleMeshGroup  SetSingleMeshGroup( string ): Set a single mesh group for this entity. ])
-- @return void
-- @param pMeshGroupName string
function CBaseModelEntity:SetSingleMeshGroup( pMeshGroupName ) end

---[[ CBaseModelEntity:SetSize   ])
-- @return void
-- @param mins Vector
-- @param maxs Vector
function CBaseModelEntity:SetSize( mins, maxs ) end

---[[ CBaseModelEntity:SetSkin  Set skin (int). ])
-- @return void
-- @param iSkin int
function CBaseModelEntity:SetSkin( iSkin ) end

---[[ CBasePlayer:GetEquippedWeapons  GetEquippedWeapons() : Returns an array of all the equipped weapons ])
-- @return table
function CBasePlayer:GetEquippedWeapons(  ) end

---[[ CBasePlayer:GetUserID  Returns the player's user id. ])
-- @return int
function CBasePlayer:GetUserID(  ) end

---[[ CBasePlayer:GetWeaponCount  GetWeaponCount() : Gets the number of weapons currently equipped ])
-- @return int
function CBasePlayer:GetWeaponCount(  ) end

---[[ CBasePlayer:IsNoclipping  Returns true if the player is in noclip mode. ])
-- @return bool
function CBasePlayer:IsNoclipping(  ) end

---[[ CBaseTrigger:Disable  Disable's the trigger ])
-- @return void
function CBaseTrigger:Disable(  ) end

---[[ CBaseTrigger:Enable  Enable the trigger ])
-- @return void
function CBaseTrigger:Enable(  ) end

---[[ CBaseTrigger:IsTouching  Checks whether the passed entity is touching the trigger. ])
-- @return bool
-- @param hEnt handle
function CBaseTrigger:IsTouching( hEnt ) end

---[[ CBodyComponent:AddImpulseAtPosition  Apply an impulse at a worldspace position to the physics ])
-- @return void
-- @param Vector_1 Vector
-- @param Vector_2 Vector
function CBodyComponent:AddImpulseAtPosition( Vector_1, Vector_2 ) end

---[[ CBodyComponent:AddVelocity  Add linear and angular velocity to the physics object ])
-- @return void
-- @param Vector_1 Vector
-- @param Vector_2 Vector
function CBodyComponent:AddVelocity( Vector_1, Vector_2 ) end

---[[ CBodyComponent:DetachFromParent  Detach from its parent ])
-- @return void
function CBodyComponent:DetachFromParent(  ) end

---[[ CBodyComponent:GetSequence  Returns the active sequence
 ])
-- @return <unknown>
function CBodyComponent:GetSequence(  ) end

---[[ CBodyComponent:IsAttachedToParent  Is attached to parent ])
-- @return bool
function CBodyComponent:IsAttachedToParent(  ) end

---[[ CBodyComponent:LookupSequence  Returns a sequence id given a name
 ])
-- @return <unknown>
-- @param string_1 string
function CBodyComponent:LookupSequence( string_1 ) end

---[[ CBodyComponent:SequenceDuration  Returns the duration in seconds of the specified sequence ])
-- @return float
-- @param string_1 string
function CBodyComponent:SequenceDuration( string_1 ) end

---[[ CBodyComponent:SetAngularVelocity   ])
-- @return void
-- @param Vector_1 Vector
function CBodyComponent:SetAngularVelocity( Vector_1 ) end

---[[ CBodyComponent:SetAnimation  Pass string for the animation to play on this model ])
-- @return void
-- @param string_1 string
function CBodyComponent:SetAnimation( string_1 ) end

---[[ CBodyComponent:SetMaterialGroup   ])
-- @return void
-- @param utlstringtoken_1 utlstringtoken
function CBodyComponent:SetMaterialGroup( utlstringtoken_1 ) end

---[[ CBodyComponent:SetVelocity   ])
-- @return void
-- @param Vector_1 Vector
function CBodyComponent:SetVelocity( Vector_1 ) end

---[[ CCustomGameEventManager:RegisterListener  ( string EventName, func CallbackFunction ) - Register a callback to be called when a particular custom event arrives. Returns a listener ID that can be used to unregister later. ])
-- @return int
-- @param string_1 string
-- @param handle_2 handle
function CCustomGameEventManager:RegisterListener( string_1, handle_2 ) end

---[[ CCustomGameEventManager:Send_ServerToAllClients  ( string EventName, table EventData ) ])
-- @return void
-- @param string_1 string
-- @param handle_2 handle
function CCustomGameEventManager:Send_ServerToAllClients( string_1, handle_2 ) end

---[[ CCustomGameEventManager:Send_ServerToPlayer  ( Entity Player, string EventName, table EventData ) ])
-- @return void
-- @param handle_1 handle
-- @param string_2 string
-- @param handle_3 handle
function CCustomGameEventManager:Send_ServerToPlayer( handle_1, string_2, handle_3 ) end

---[[ CCustomGameEventManager:Send_ServerToTeam  ( int TeamNumber, string EventName, table EventData ) ])
-- @return void
-- @param int_1 int
-- @param string_2 string
-- @param handle_3 handle
function CCustomGameEventManager:Send_ServerToTeam( int_1, string_2, handle_3 ) end

---[[ CCustomGameEventManager:UnregisterListener  ( int ListnerID ) - Unregister a specific listener ])
-- @return void
-- @param int_1 int
function CCustomGameEventManager:UnregisterListener( int_1 ) end

---[[ CCustomNetTableManager:GetTableValue  ( string TableName, string KeyName ) ])
-- @return table
-- @param string_1 string
-- @param string_2 string
function CCustomNetTableManager:GetTableValue( string_1, string_2 ) end

---[[ CCustomNetTableManager:SetTableValue  ( string TableName, string KeyName, script_table Value ) ])
-- @return bool
-- @param string_1 string
-- @param string_2 string
-- @param handle_3 handle
function CCustomNetTableManager:SetTableValue( string_1, string_2, handle_3 ) end

---[[ CDOTABaseAbility:CanAbilityBeUpgraded   ])
-- @return <unknown>
function CDOTABaseAbility:CanAbilityBeUpgraded(  ) end

---[[ CDOTABaseAbility:CastAbility   ])
-- @return bool
function CDOTABaseAbility:CastAbility(  ) end

---[[ CDOTABaseAbility:ContinueCasting   ])
-- @return bool
function CDOTABaseAbility:ContinueCasting(  ) end

---[[ CDOTABaseAbility:CreateVisibilityNode   ])
-- @return void
-- @param vLocation Vector
-- @param fRadius float
-- @param fDuration float
function CDOTABaseAbility:CreateVisibilityNode( vLocation, fRadius, fDuration ) end

---[[ CDOTABaseAbility:DecrementModifierRefCount   ])
-- @return void
function CDOTABaseAbility:DecrementModifierRefCount(  ) end

---[[ CDOTABaseAbility:EndChannel   ])
-- @return void
-- @param bInterrupted bool
function CDOTABaseAbility:EndChannel( bInterrupted ) end

---[[ CDOTABaseAbility:EndCooldown  Clear the cooldown remaining on this ability. ])
-- @return void
function CDOTABaseAbility:EndCooldown(  ) end

---[[ CDOTABaseAbility:GetAOERadius   ])
-- @return int
function CDOTABaseAbility:GetAOERadius(  ) end

---[[ CDOTABaseAbility:GetAbilityDamage   ])
-- @return int
function CDOTABaseAbility:GetAbilityDamage(  ) end

---[[ CDOTABaseAbility:GetAbilityDamageType   ])
-- @return int
function CDOTABaseAbility:GetAbilityDamageType(  ) end

---[[ CDOTABaseAbility:GetAbilityIndex   ])
-- @return int
function CDOTABaseAbility:GetAbilityIndex(  ) end

---[[ CDOTABaseAbility:GetAbilityKeyValues  Gets the key values definition for this ability. ])
-- @return table
function CDOTABaseAbility:GetAbilityKeyValues(  ) end

---[[ CDOTABaseAbility:GetAbilityName  Returns the name of this ability. ])
-- @return string
function CDOTABaseAbility:GetAbilityName(  ) end

---[[ CDOTABaseAbility:GetAbilityTargetFlags   ])
-- @return int
function CDOTABaseAbility:GetAbilityTargetFlags(  ) end

---[[ CDOTABaseAbility:GetAbilityTargetTeam   ])
-- @return int
function CDOTABaseAbility:GetAbilityTargetTeam(  ) end

---[[ CDOTABaseAbility:GetAbilityTargetType   ])
-- @return int
function CDOTABaseAbility:GetAbilityTargetType(  ) end

---[[ CDOTABaseAbility:GetAbilityType   ])
-- @return int
function CDOTABaseAbility:GetAbilityType(  ) end

---[[ CDOTABaseAbility:GetAnimationIgnoresModelScale   ])
-- @return bool
function CDOTABaseAbility:GetAnimationIgnoresModelScale(  ) end

---[[ CDOTABaseAbility:GetAssociatedPrimaryAbilities   ])
-- @return string
function CDOTABaseAbility:GetAssociatedPrimaryAbilities(  ) end

---[[ CDOTABaseAbility:GetAssociatedSecondaryAbilities   ])
-- @return string
function CDOTABaseAbility:GetAssociatedSecondaryAbilities(  ) end

---[[ CDOTABaseAbility:GetAutoCastState   ])
-- @return bool
function CDOTABaseAbility:GetAutoCastState(  ) end

---[[ CDOTABaseAbility:GetBackswingTime   ])
-- @return float
function CDOTABaseAbility:GetBackswingTime(  ) end

---[[ CDOTABaseAbility:GetBehavior   ])
-- @return int
function CDOTABaseAbility:GetBehavior(  ) end

---[[ CDOTABaseAbility:GetBehaviorInt  Get ability behavior flags as an int for compatability. ])
-- @return int
function CDOTABaseAbility:GetBehaviorInt(  ) end

---[[ CDOTABaseAbility:GetCastPoint   ])
-- @return float
function CDOTABaseAbility:GetCastPoint(  ) end

---[[ CDOTABaseAbility:GetCastRange  Gets the cast range of the ability. ])
-- @return int
-- @param vLocation Vector
-- @param hTarget handle
function CDOTABaseAbility:GetCastRange( vLocation, hTarget ) end

---[[ CDOTABaseAbility:GetCaster   ])
-- @return handle
function CDOTABaseAbility:GetCaster(  ) end

---[[ CDOTABaseAbility:GetChannelStartTime   ])
-- @return float
function CDOTABaseAbility:GetChannelStartTime(  ) end

---[[ CDOTABaseAbility:GetChannelTime   ])
-- @return float
function CDOTABaseAbility:GetChannelTime(  ) end

---[[ CDOTABaseAbility:GetChannelledManaCostPerSecond   ])
-- @return int
-- @param iLevel int
function CDOTABaseAbility:GetChannelledManaCostPerSecond( iLevel ) end

---[[ CDOTABaseAbility:GetCloneSource   ])
-- @return handle
function CDOTABaseAbility:GetCloneSource(  ) end

---[[ CDOTABaseAbility:GetConceptRecipientType   ])
-- @return int
function CDOTABaseAbility:GetConceptRecipientType(  ) end

---[[ CDOTABaseAbility:GetCooldown  Get the cooldown duration for this ability at a given level, not the amount of cooldown actually left. ])
-- @return float
-- @param iLevel int
function CDOTABaseAbility:GetCooldown( iLevel ) end

---[[ CDOTABaseAbility:GetCooldownTime   ])
-- @return float
function CDOTABaseAbility:GetCooldownTime(  ) end

---[[ CDOTABaseAbility:GetCooldownTimeRemaining   ])
-- @return float
function CDOTABaseAbility:GetCooldownTimeRemaining(  ) end

---[[ CDOTABaseAbility:GetCurrentAbilityCharges   ])
-- @return int
function CDOTABaseAbility:GetCurrentAbilityCharges(  ) end

---[[ CDOTABaseAbility:GetCursorPosition   ])
-- @return Vector
function CDOTABaseAbility:GetCursorPosition(  ) end

---[[ CDOTABaseAbility:GetCursorTarget   ])
-- @return handle
function CDOTABaseAbility:GetCursorTarget(  ) end

---[[ CDOTABaseAbility:GetCursorTargetingNothing   ])
-- @return bool
function CDOTABaseAbility:GetCursorTargetingNothing(  ) end

---[[ CDOTABaseAbility:GetDuration   ])
-- @return float
function CDOTABaseAbility:GetDuration(  ) end

---[[ CDOTABaseAbility:GetEffectiveCastRange  Gets the cast range of the ability, taking modifiers into account. ])
-- @return int
-- @param vLocation Vector
-- @param hTarget handle
function CDOTABaseAbility:GetEffectiveCastRange( vLocation, hTarget ) end

---[[ CDOTABaseAbility:GetEffectiveCooldown   ])
-- @return float
-- @param iLevel int
function CDOTABaseAbility:GetEffectiveCooldown( iLevel ) end

---[[ CDOTABaseAbility:GetGoldCost   ])
-- @return int
-- @param iLevel int
function CDOTABaseAbility:GetGoldCost( iLevel ) end

---[[ CDOTABaseAbility:GetGoldCostForUpgrade   ])
-- @return int
-- @param iLevel int
function CDOTABaseAbility:GetGoldCostForUpgrade( iLevel ) end

---[[ CDOTABaseAbility:GetHeroLevelRequiredToUpgrade   ])
-- @return int
function CDOTABaseAbility:GetHeroLevelRequiredToUpgrade(  ) end

---[[ CDOTABaseAbility:GetIntrinsicModifierName   ])
-- @return string
function CDOTABaseAbility:GetIntrinsicModifierName(  ) end

---[[ CDOTABaseAbility:GetLevel  Get the current level of the ability. ])
-- @return int
function CDOTABaseAbility:GetLevel(  ) end

---[[ CDOTABaseAbility:GetLevelSpecialValueFor   ])
-- @return table
-- @param szName string
-- @param nLevel int
function CDOTABaseAbility:GetLevelSpecialValueFor( szName, nLevel ) end

---[[ CDOTABaseAbility:GetLevelSpecialValueNoOverride   ])
-- @return table
-- @param szName string
-- @param nLevel int
function CDOTABaseAbility:GetLevelSpecialValueNoOverride( szName, nLevel ) end

---[[ CDOTABaseAbility:GetManaCost   ])
-- @return int
-- @param iLevel int
function CDOTABaseAbility:GetManaCost( iLevel ) end

---[[ CDOTABaseAbility:GetMaxAbilityCharges   ])
-- @return int
-- @param iLevel int
function CDOTABaseAbility:GetMaxAbilityCharges( iLevel ) end

---[[ CDOTABaseAbility:GetMaxLevel   ])
-- @return int
function CDOTABaseAbility:GetMaxLevel(  ) end

---[[ CDOTABaseAbility:GetModifierValue   ])
-- @return float
function CDOTABaseAbility:GetModifierValue(  ) end

---[[ CDOTABaseAbility:GetModifierValueBonus   ])
-- @return float
function CDOTABaseAbility:GetModifierValueBonus(  ) end

---[[ CDOTABaseAbility:GetPlaybackRateOverride   ])
-- @return float
function CDOTABaseAbility:GetPlaybackRateOverride(  ) end

---[[ CDOTABaseAbility:GetSharedCooldownName   ])
-- @return string
function CDOTABaseAbility:GetSharedCooldownName(  ) end

---[[ CDOTABaseAbility:GetSpecialValueFor  Gets a value from this ability's special value block for its current level. ])
-- @return table
-- @param szName string
function CDOTABaseAbility:GetSpecialValueFor( szName ) end

---[[ CDOTABaseAbility:GetStolenActivityModifier   ])
-- @return string
function CDOTABaseAbility:GetStolenActivityModifier(  ) end

---[[ CDOTABaseAbility:GetToggleState   ])
-- @return bool
function CDOTABaseAbility:GetToggleState(  ) end

---[[ CDOTABaseAbility:GetUpgradeRecommended   ])
-- @return bool
function CDOTABaseAbility:GetUpgradeRecommended(  ) end

---[[ CDOTABaseAbility:HeroXPChange   ])
-- @return bool
-- @param flXP float
function CDOTABaseAbility:HeroXPChange( flXP ) end

---[[ CDOTABaseAbility:IncrementModifierRefCount   ])
-- @return void
function CDOTABaseAbility:IncrementModifierRefCount(  ) end

---[[ CDOTABaseAbility:IsActivated   ])
-- @return bool
function CDOTABaseAbility:IsActivated(  ) end

---[[ CDOTABaseAbility:IsAttributeBonus   ])
-- @return bool
function CDOTABaseAbility:IsAttributeBonus(  ) end

---[[ CDOTABaseAbility:IsChanneling  Returns whether the ability is currently channeling. ])
-- @return bool
function CDOTABaseAbility:IsChanneling(  ) end

---[[ CDOTABaseAbility:IsCooldownReady   ])
-- @return bool
function CDOTABaseAbility:IsCooldownReady(  ) end

---[[ CDOTABaseAbility:IsCosmetic   ])
-- @return bool
-- @param hEntity handle
function CDOTABaseAbility:IsCosmetic( hEntity ) end

---[[ CDOTABaseAbility:IsFullyCastable  Returns whether the ability can be cast. ])
-- @return bool
function CDOTABaseAbility:IsFullyCastable(  ) end

---[[ CDOTABaseAbility:IsHidden   ])
-- @return bool
function CDOTABaseAbility:IsHidden(  ) end

---[[ CDOTABaseAbility:IsHiddenAsSecondaryAbility   ])
-- @return bool
function CDOTABaseAbility:IsHiddenAsSecondaryAbility(  ) end

---[[ CDOTABaseAbility:IsHiddenWhenStolen   ])
-- @return bool
function CDOTABaseAbility:IsHiddenWhenStolen(  ) end

---[[ CDOTABaseAbility:IsInAbilityPhase  Returns whether the ability is currently casting. ])
-- @return bool
function CDOTABaseAbility:IsInAbilityPhase(  ) end

---[[ CDOTABaseAbility:IsItem   ])
-- @return bool
function CDOTABaseAbility:IsItem(  ) end

---[[ CDOTABaseAbility:IsOwnersGoldEnough   ])
-- @return bool
-- @param nIssuerPlayerID int
function CDOTABaseAbility:IsOwnersGoldEnough( nIssuerPlayerID ) end

---[[ CDOTABaseAbility:IsOwnersGoldEnoughForUpgrade   ])
-- @return bool
function CDOTABaseAbility:IsOwnersGoldEnoughForUpgrade(  ) end

---[[ CDOTABaseAbility:IsOwnersManaEnough   ])
-- @return bool
function CDOTABaseAbility:IsOwnersManaEnough(  ) end

---[[ CDOTABaseAbility:IsPassive   ])
-- @return bool
function CDOTABaseAbility:IsPassive(  ) end

---[[ CDOTABaseAbility:IsRefreshable   ])
-- @return bool
function CDOTABaseAbility:IsRefreshable(  ) end

---[[ CDOTABaseAbility:IsSharedWithTeammates   ])
-- @return bool
function CDOTABaseAbility:IsSharedWithTeammates(  ) end

---[[ CDOTABaseAbility:IsStealable   ])
-- @return bool
function CDOTABaseAbility:IsStealable(  ) end

---[[ CDOTABaseAbility:IsStolen   ])
-- @return bool
function CDOTABaseAbility:IsStolen(  ) end

---[[ CDOTABaseAbility:IsToggle   ])
-- @return bool
function CDOTABaseAbility:IsToggle(  ) end

---[[ CDOTABaseAbility:IsTrained   ])
-- @return bool
function CDOTABaseAbility:IsTrained(  ) end

---[[ CDOTABaseAbility:MarkAbilityButtonDirty  Mark the ability button for this ability as needing a refresh. ])
-- @return void
function CDOTABaseAbility:MarkAbilityButtonDirty(  ) end

---[[ CDOTABaseAbility:NumModifiersUsingAbility   ])
-- @return int
function CDOTABaseAbility:NumModifiersUsingAbility(  ) end

---[[ CDOTABaseAbility:OnAbilityPhaseInterrupted   ])
-- @return void
function CDOTABaseAbility:OnAbilityPhaseInterrupted(  ) end

---[[ CDOTABaseAbility:OnAbilityPhaseStart   ])
-- @return bool
function CDOTABaseAbility:OnAbilityPhaseStart(  ) end

---[[ CDOTABaseAbility:OnAbilityPinged   ])
-- @return void
-- @param nPlayerID int
-- @param bCtrlHeld bool
function CDOTABaseAbility:OnAbilityPinged( nPlayerID, bCtrlHeld ) end

---[[ CDOTABaseAbility:OnChannelFinish   ])
-- @return void
-- @param bInterrupted bool
function CDOTABaseAbility:OnChannelFinish( bInterrupted ) end

---[[ CDOTABaseAbility:OnChannelThink   ])
-- @return void
-- @param flInterval float
function CDOTABaseAbility:OnChannelThink( flInterval ) end

---[[ CDOTABaseAbility:OnHeroCalculateStatBonus   ])
-- @return void
function CDOTABaseAbility:OnHeroCalculateStatBonus(  ) end

---[[ CDOTABaseAbility:OnHeroLevelUp   ])
-- @return void
function CDOTABaseAbility:OnHeroLevelUp(  ) end

---[[ CDOTABaseAbility:OnOwnerDied   ])
-- @return void
function CDOTABaseAbility:OnOwnerDied(  ) end

---[[ CDOTABaseAbility:OnOwnerSpawned   ])
-- @return void
function CDOTABaseAbility:OnOwnerSpawned(  ) end

---[[ CDOTABaseAbility:OnSpellStart   ])
-- @return void
function CDOTABaseAbility:OnSpellStart(  ) end

---[[ CDOTABaseAbility:OnToggle   ])
-- @return void
function CDOTABaseAbility:OnToggle(  ) end

---[[ CDOTABaseAbility:OnUpgrade   ])
-- @return void
function CDOTABaseAbility:OnUpgrade(  ) end

---[[ CDOTABaseAbility:PayGoldCost   ])
-- @return void
function CDOTABaseAbility:PayGoldCost(  ) end

---[[ CDOTABaseAbility:PayGoldCostForUpgrade   ])
-- @return void
function CDOTABaseAbility:PayGoldCostForUpgrade(  ) end

---[[ CDOTABaseAbility:PayManaCost   ])
-- @return void
function CDOTABaseAbility:PayManaCost(  ) end

---[[ CDOTABaseAbility:PlaysDefaultAnimWhenStolen   ])
-- @return bool
function CDOTABaseAbility:PlaysDefaultAnimWhenStolen(  ) end

---[[ CDOTABaseAbility:ProcsMagicStick   ])
-- @return bool
function CDOTABaseAbility:ProcsMagicStick(  ) end

---[[ CDOTABaseAbility:RefCountsModifiers   ])
-- @return bool
function CDOTABaseAbility:RefCountsModifiers(  ) end

---[[ CDOTABaseAbility:RefreshCharges   ])
-- @return void
function CDOTABaseAbility:RefreshCharges(  ) end

---[[ CDOTABaseAbility:RefreshIntrinsicModifier   ])
-- @return <unknown>
function CDOTABaseAbility:RefreshIntrinsicModifier(  ) end

---[[ CDOTABaseAbility:RefundManaCost   ])
-- @return void
function CDOTABaseAbility:RefundManaCost(  ) end

---[[ CDOTABaseAbility:RequiresFacing   ])
-- @return bool
function CDOTABaseAbility:RequiresFacing(  ) end

---[[ CDOTABaseAbility:ResetToggleOnRespawn   ])
-- @return bool
function CDOTABaseAbility:ResetToggleOnRespawn(  ) end

---[[ CDOTABaseAbility:SetAbilityIndex   ])
-- @return void
-- @param iIndex int
function CDOTABaseAbility:SetAbilityIndex( iIndex ) end

---[[ CDOTABaseAbility:SetActivated   ])
-- @return void
-- @param bActivated bool
function CDOTABaseAbility:SetActivated( bActivated ) end

---[[ CDOTABaseAbility:SetChanneling   ])
-- @return void
-- @param bChanneling bool
function CDOTABaseAbility:SetChanneling( bChanneling ) end

---[[ CDOTABaseAbility:SetCurrentAbilityCharges   ])
-- @return void
-- @param nCharges int
function CDOTABaseAbility:SetCurrentAbilityCharges( nCharges ) end

---[[ CDOTABaseAbility:SetFrozenCooldown   ])
-- @return void
-- @param bFrozenCooldown bool
function CDOTABaseAbility:SetFrozenCooldown( bFrozenCooldown ) end

---[[ CDOTABaseAbility:SetHidden   ])
-- @return void
-- @param bHidden bool
function CDOTABaseAbility:SetHidden( bHidden ) end

---[[ CDOTABaseAbility:SetInAbilityPhase   ])
-- @return void
-- @param bInAbilityPhase bool
function CDOTABaseAbility:SetInAbilityPhase( bInAbilityPhase ) end

---[[ CDOTABaseAbility:SetLevel  Sets the level of this ability. ])
-- @return void
-- @param iLevel int
function CDOTABaseAbility:SetLevel( iLevel ) end

---[[ CDOTABaseAbility:SetOverrideCastPoint   ])
-- @return void
-- @param flCastPoint float
function CDOTABaseAbility:SetOverrideCastPoint( flCastPoint ) end

---[[ CDOTABaseAbility:SetRefCountsModifiers   ])
-- @return void
-- @param bRefCounts bool
function CDOTABaseAbility:SetRefCountsModifiers( bRefCounts ) end

---[[ CDOTABaseAbility:SetStealable   ])
-- @return void
-- @param bStealable bool
function CDOTABaseAbility:SetStealable( bStealable ) end

---[[ CDOTABaseAbility:SetStolen   ])
-- @return void
-- @param bStolen bool
function CDOTABaseAbility:SetStolen( bStolen ) end

---[[ CDOTABaseAbility:SetUpgradeRecommended   ])
-- @return void
-- @param bUpgradeRecommended bool
function CDOTABaseAbility:SetUpgradeRecommended( bUpgradeRecommended ) end

---[[ CDOTABaseAbility:ShouldUseResources   ])
-- @return bool
function CDOTABaseAbility:ShouldUseResources(  ) end

---[[ CDOTABaseAbility:SpeakAbilityConcept   ])
-- @return void
-- @param iConcept int
function CDOTABaseAbility:SpeakAbilityConcept( iConcept ) end

---[[ CDOTABaseAbility:SpeakTrigger   ])
-- @return <unknown>
function CDOTABaseAbility:SpeakTrigger(  ) end

---[[ CDOTABaseAbility:StartCooldown   ])
-- @return void
-- @param flCooldown float
function CDOTABaseAbility:StartCooldown( flCooldown ) end

---[[ CDOTABaseAbility:ToggleAbility   ])
-- @return void
function CDOTABaseAbility:ToggleAbility(  ) end

---[[ CDOTABaseAbility:ToggleAutoCast   ])
-- @return void
function CDOTABaseAbility:ToggleAutoCast(  ) end

---[[ CDOTABaseAbility:UpgradeAbility   ])
-- @return void
-- @param bSupressSpeech bool
function CDOTABaseAbility:UpgradeAbility( bSupressSpeech ) end

---[[ CDOTABaseAbility:UseResources   ])
-- @return void
-- @param bMana bool
-- @param bGold bool
-- @param bCooldown bool
function CDOTABaseAbility:UseResources( bMana, bGold, bCooldown ) end

---[[ CDOTABaseGameMode:AddAbilityUpgradeToWhitelist   ])
-- @return void
-- @param pszAbilityName string
function CDOTABaseGameMode:AddAbilityUpgradeToWhitelist( pszAbilityName ) end

---[[ CDOTABaseGameMode:AddItemToCustomShop  ( pszItem, pszShop, pszCategory ) Add an item to purchase at a custom shop. ])
-- @return void
-- @param pszItemName string
-- @param pszShopName string
-- @param pszCategory string
function CDOTABaseGameMode:AddItemToCustomShop( pszItemName, pszShopName, pszCategory ) end

---[[ CDOTABaseGameMode:AddRealTimeCombatAnalyzerQuery  Begin tracking a sequence of events using the real time combat analyzer. ])
-- @return int
-- @param hQueryTable handle
-- @param hPlayer handle
-- @param pszQueryName string
function CDOTABaseGameMode:AddRealTimeCombatAnalyzerQuery( hQueryTable, hPlayer, pszQueryName ) end

---[[ CDOTABaseGameMode:AllocateFowBlockerRegion  Allocates an entity which can be used by custom games to control FoW occlusion volumes ])
-- @return handle
-- @param flMinX float
-- @param flMinY float
-- @param flMaxX float
-- @param flMaxY float
-- @param flGridSize float
function CDOTABaseGameMode:AllocateFowBlockerRegion( flMinX, flMinY, flMaxX, flMaxY, flGridSize ) end

---[[ CDOTABaseGameMode:AreWeatherEffectsDisabled  Get if weather effects are disabled on the client. ])
-- @return bool
function CDOTABaseGameMode:AreWeatherEffectsDisabled(  ) end

---[[ CDOTABaseGameMode:ClearBountyRunePickupFilter  Clear the script filter that controls bounty rune pickup behavior. ])
-- @return void
function CDOTABaseGameMode:ClearBountyRunePickupFilter(  ) end

---[[ CDOTABaseGameMode:ClearDamageFilter  Clear the script filter that controls how a unit takes damage. ])
-- @return void
function CDOTABaseGameMode:ClearDamageFilter(  ) end

---[[ CDOTABaseGameMode:ClearExecuteOrderFilter  Clear the script filter that controls when a unit picks up an item. ])
-- @return void
function CDOTABaseGameMode:ClearExecuteOrderFilter(  ) end

---[[ CDOTABaseGameMode:ClearHealingFilter  Clear the script filter that controls how a unit heals. ])
-- @return void
function CDOTABaseGameMode:ClearHealingFilter(  ) end

---[[ CDOTABaseGameMode:ClearItemAddedToInventoryFilter  Clear the script filter that controls the item added to inventory filter. ])
-- @return void
function CDOTABaseGameMode:ClearItemAddedToInventoryFilter(  ) end

---[[ CDOTABaseGameMode:ClearModifierGainedFilter  Clear the script filter that controls the modifier filter. ])
-- @return void
function CDOTABaseGameMode:ClearModifierGainedFilter(  ) end

---[[ CDOTABaseGameMode:ClearModifyExperienceFilter  Clear the script filter that controls how hero experience is modified. ])
-- @return void
function CDOTABaseGameMode:ClearModifyExperienceFilter(  ) end

---[[ CDOTABaseGameMode:ClearModifyGoldFilter  Clear the script filter that controls how hero gold is modified. ])
-- @return void
function CDOTABaseGameMode:ClearModifyGoldFilter(  ) end

---[[ CDOTABaseGameMode:ClearRuneSpawnFilter  Clear the script filter that controls what rune spawns. ])
-- @return void
function CDOTABaseGameMode:ClearRuneSpawnFilter(  ) end

---[[ CDOTABaseGameMode:ClearTrackingProjectileFilter  Clear the script filter that controls when tracking projectiles are launched. ])
-- @return void
function CDOTABaseGameMode:ClearTrackingProjectileFilter(  ) end

---[[ CDOTABaseGameMode:DisableClumpingBehaviorByDefault  Disable npc_dota_creature clumping behavior by default. ])
-- @return void
-- @param bDisabled bool
function CDOTABaseGameMode:DisableClumpingBehaviorByDefault( bDisabled ) end

---[[ CDOTABaseGameMode:DisableHudFlip  Use to disable hud flip for this mod ])
-- @return void
-- @param bDisable bool
function CDOTABaseGameMode:DisableHudFlip( bDisable ) end

---[[ CDOTABaseGameMode:EnableAbilityUpgradeWhitelist   ])
-- @return void
-- @param bEnabled bool
function CDOTABaseGameMode:EnableAbilityUpgradeWhitelist( bEnabled ) end

---[[ CDOTABaseGameMode:GetAlwaysShowPlayerInventory  Show the player hero's inventory in the HUD, regardless of what unit is selected. ])
-- @return bool
function CDOTABaseGameMode:GetAlwaysShowPlayerInventory(  ) end

---[[ CDOTABaseGameMode:GetAlwaysShowPlayerNames  Get whether player names are always shown, regardless of client setting. ])
-- @return bool
function CDOTABaseGameMode:GetAlwaysShowPlayerNames(  ) end

---[[ CDOTABaseGameMode:GetAnnouncerDisabled  Are in-game announcers disabled? ])
-- @return bool
function CDOTABaseGameMode:GetAnnouncerDisabled(  ) end

---[[ CDOTABaseGameMode:GetCameraDistanceOverride  Set a different camera distance; dota default is 1134. ])
-- @return float
function CDOTABaseGameMode:GetCameraDistanceOverride(  ) end

---[[ CDOTABaseGameMode:GetCustomAttributeDerivedStatValue  Get current derived stat value constant. ])
-- @return float
-- @param nDerivedStatType int
-- @param hHero handle
function CDOTABaseGameMode:GetCustomAttributeDerivedStatValue( nDerivedStatType, hHero ) end

---[[ CDOTABaseGameMode:GetCustomBackpackCooldownPercent  Get the current rate cooldown ticks down for items in the backpack. ])
-- @return float
function CDOTABaseGameMode:GetCustomBackpackCooldownPercent(  ) end

---[[ CDOTABaseGameMode:GetCustomBackpackSwapCooldown  Get the current custom backpack swap cooldown. ])
-- @return float
function CDOTABaseGameMode:GetCustomBackpackSwapCooldown(  ) end

---[[ CDOTABaseGameMode:GetCustomBuybackCooldownEnabled  Turns on capability to define custom buyback cooldowns. ])
-- @return bool
function CDOTABaseGameMode:GetCustomBuybackCooldownEnabled(  ) end

---[[ CDOTABaseGameMode:GetCustomBuybackCostEnabled  Turns on capability to define custom buyback costs. ])
-- @return bool
function CDOTABaseGameMode:GetCustomBuybackCostEnabled(  ) end

---[[ CDOTABaseGameMode:GetCustomDireScore  Get the topbar score display value for dire. ])
-- @return int
function CDOTABaseGameMode:GetCustomDireScore(  ) end

---[[ CDOTABaseGameMode:GetCustomGlyphCooldown  Get the current custom glyph cooldown. ])
-- @return float
function CDOTABaseGameMode:GetCustomGlyphCooldown(  ) end

---[[ CDOTABaseGameMode:GetCustomHeroMaxLevel  Allows definition of the max level heroes can achieve (default is 25). ])
-- @return int
function CDOTABaseGameMode:GetCustomHeroMaxLevel(  ) end

---[[ CDOTABaseGameMode:GetCustomRadiantScore  Get the topbar score display value for radiant. ])
-- @return int
function CDOTABaseGameMode:GetCustomRadiantScore(  ) end

---[[ CDOTABaseGameMode:GetCustomScanCooldown  Get the current custom scan cooldown. ])
-- @return float
function CDOTABaseGameMode:GetCustomScanCooldown(  ) end

---[[ CDOTABaseGameMode:GetDaynightCycleAdvanceRate  Get the rate at which the day/night cycle advances (1.0 = default). ])
-- @return float
function CDOTABaseGameMode:GetDaynightCycleAdvanceRate(  ) end

---[[ CDOTABaseGameMode:GetEventGameSeed  Get the Game Seed passed from the GC. ])
-- @return int
function CDOTABaseGameMode:GetEventGameSeed(  ) end

---[[ CDOTABaseGameMode:GetEventWindowStartTime  Get the Event Window Start Time passed from the GC. ])
-- @return unsigned
function CDOTABaseGameMode:GetEventWindowStartTime(  ) end

---[[ CDOTABaseGameMode:GetFixedRespawnTime  Gets the fixed respawn time. ])
-- @return float
function CDOTABaseGameMode:GetFixedRespawnTime(  ) end

---[[ CDOTABaseGameMode:GetFogOfWarDisabled  Turn the fog of war on or off. ])
-- @return bool
function CDOTABaseGameMode:GetFogOfWarDisabled(  ) end

---[[ CDOTABaseGameMode:GetGoldSoundDisabled  Turn the sound when gold is acquired off/on. ])
-- @return bool
function CDOTABaseGameMode:GetGoldSoundDisabled(  ) end

---[[ CDOTABaseGameMode:GetHUDVisible  Returns the HUD element visibility. ])
-- @return bool
-- @param iElement int
function CDOTABaseGameMode:GetHUDVisible( iElement ) end

---[[ CDOTABaseGameMode:GetMaximumAttackSpeed  Get the maximum attack speed for units. ])
-- @return int
function CDOTABaseGameMode:GetMaximumAttackSpeed(  ) end

---[[ CDOTABaseGameMode:GetMinimumAttackSpeed  Get the minimum attack speed for units. ])
-- @return int
function CDOTABaseGameMode:GetMinimumAttackSpeed(  ) end

---[[ CDOTABaseGameMode:GetRecommendedItemsDisabled  Turn the panel for showing recommended items at the shop off/on. ])
-- @return bool
function CDOTABaseGameMode:GetRecommendedItemsDisabled(  ) end

---[[ CDOTABaseGameMode:GetRespawnTimeScale  Returns the scale applied to non-fixed respawn times. ])
-- @return float
function CDOTABaseGameMode:GetRespawnTimeScale(  ) end

---[[ CDOTABaseGameMode:GetStashPurchasingDisabled  Turn purchasing items to the stash off/on. If purchasing to the stash is off the player must be at a shop to purchase items. ])
-- @return bool
function CDOTABaseGameMode:GetStashPurchasingDisabled(  ) end

---[[ CDOTABaseGameMode:GetStickyItemDisabled  Hide the sticky item in the quickbuy. ])
-- @return bool
function CDOTABaseGameMode:GetStickyItemDisabled(  ) end

---[[ CDOTABaseGameMode:GetTopBarTeamValuesOverride  Override the values of the team values on the top game bar. ])
-- @return bool
function CDOTABaseGameMode:GetTopBarTeamValuesOverride(  ) end

---[[ CDOTABaseGameMode:GetTopBarTeamValuesVisible  Turning on/off the team values on the top game bar. ])
-- @return bool
function CDOTABaseGameMode:GetTopBarTeamValuesVisible(  ) end

---[[ CDOTABaseGameMode:GetTowerBackdoorProtectionEnabled  Gets whether tower backdoor protection is enabled or not. ])
-- @return bool
function CDOTABaseGameMode:GetTowerBackdoorProtectionEnabled(  ) end

---[[ CDOTABaseGameMode:GetUseCustomHeroLevels  Are custom-defined XP values for hero level ups in use? ])
-- @return bool
function CDOTABaseGameMode:GetUseCustomHeroLevels(  ) end

---[[ CDOTABaseGameMode:IsAbilityUpgradeWhitelisted   ])
-- @return bool
-- @param pszAbilityName string
function CDOTABaseGameMode:IsAbilityUpgradeWhitelisted( pszAbilityName ) end

---[[ CDOTABaseGameMode:IsBuybackEnabled  Enables or disables buyback completely. ])
-- @return bool
function CDOTABaseGameMode:IsBuybackEnabled(  ) end

---[[ CDOTABaseGameMode:IsDaynightCycleDisabled  Is the day/night cycle disabled? ])
-- @return bool
function CDOTABaseGameMode:IsDaynightCycleDisabled(  ) end

---[[ CDOTABaseGameMode:ListenForQueryFailed  Set function and context for real time combat analyzer query failed. ])
-- @return void
-- @param hFunction handle
-- @param hContext handle
function CDOTABaseGameMode:ListenForQueryFailed( hFunction, hContext ) end

---[[ CDOTABaseGameMode:ListenForQueryProgressChanged  Set function and context for real time combat analyzer query progress changed. ])
-- @return void
-- @param hFunction handle
-- @param hContext handle
function CDOTABaseGameMode:ListenForQueryProgressChanged( hFunction, hContext ) end

---[[ CDOTABaseGameMode:ListenForQuerySucceeded  Set function and context for real time combat analyzer query succeeded. ])
-- @return void
-- @param hFunction handle
-- @param hContext handle
function CDOTABaseGameMode:ListenForQuerySucceeded( hFunction, hContext ) end

---[[ CDOTABaseGameMode:RemoveAbilityUpgradeFromWhitelist   ])
-- @return void
-- @param pszAbilityName string
function CDOTABaseGameMode:RemoveAbilityUpgradeFromWhitelist( pszAbilityName ) end

---[[ CDOTABaseGameMode:RemoveItemFromCustomShop  ( pszItem, pszShop ) Remove an item to purchase at a custom shop. ])
-- @return void
-- @param pszItemName string
-- @param pszShopName string
function CDOTABaseGameMode:RemoveItemFromCustomShop( pszItemName, pszShopName ) end

---[[ CDOTABaseGameMode:RemoveRealTimeCombatAnalyzerQuery  Stop tracking a combat analyzer query. ])
-- @return void
-- @param nQueryID int
function CDOTABaseGameMode:RemoveRealTimeCombatAnalyzerQuery( nQueryID ) end

---[[ CDOTABaseGameMode:SetAbilityTuningValueFilter  Set a filter function to control the tuning values that abilities use. (Modify the table and Return true to use new values, return false to use the old values) ])
-- @return void
-- @param hFunction handle
-- @param hContext handle
function CDOTABaseGameMode:SetAbilityTuningValueFilter( hFunction, hContext ) end

---[[ CDOTABaseGameMode:SetAllowNeutralItemDrops  If set to true, neutral items will be dropped on killing neutral monsters.  Otherwise nothing will be dropped. ])
-- @return void
-- @param bEnabled bool
function CDOTABaseGameMode:SetAllowNeutralItemDrops( bEnabled ) end

---[[ CDOTABaseGameMode:SetAlwaysShowPlayerInventory  Show the player hero's inventory in the HUD, regardless of what unit is selected. ])
-- @return void
-- @param bAlwaysShow bool
function CDOTABaseGameMode:SetAlwaysShowPlayerInventory( bAlwaysShow ) end

---[[ CDOTABaseGameMode:SetAlwaysShowPlayerNames  Set whether player names are always shown, regardless of client setting. ])
-- @return void
-- @param bEnabled bool
function CDOTABaseGameMode:SetAlwaysShowPlayerNames( bEnabled ) end

---[[ CDOTABaseGameMode:SetAnnouncerDisabled  Mutes the in-game announcer. ])
-- @return void
-- @param bDisabled bool
function CDOTABaseGameMode:SetAnnouncerDisabled( bDisabled ) end

---[[ CDOTABaseGameMode:SetBotThinkingEnabled  Enables/Disables bots in custom games. Note: this will only work with default heroes in the dota map. ])
-- @return void
-- @param bEnabled bool
function CDOTABaseGameMode:SetBotThinkingEnabled( bEnabled ) end

---[[ CDOTABaseGameMode:SetBotsAlwaysPushWithHuman  Set if the bots should try their best to push with a human player. ])
-- @return void
-- @param bAlwaysPush bool
function CDOTABaseGameMode:SetBotsAlwaysPushWithHuman( bAlwaysPush ) end

---[[ CDOTABaseGameMode:SetBotsInLateGame  Set if bots should enable their late game behavior. ])
-- @return void
-- @param bLateGame bool
function CDOTABaseGameMode:SetBotsInLateGame( bLateGame ) end

---[[ CDOTABaseGameMode:SetBotsMaxPushTier  Set the max tier of tower that bots want to push. (-1 to disable) ])
-- @return void
-- @param nMaxTier int
function CDOTABaseGameMode:SetBotsMaxPushTier( nMaxTier ) end

---[[ CDOTABaseGameMode:SetBountyRunePickupFilter  Set a filter function to control the behavior when a bounty rune is picked up. (Modify the table and Return true to use new values, return false to cancel the event) ])
-- @return void
-- @param hFunction handle
-- @param hContext handle
function CDOTABaseGameMode:SetBountyRunePickupFilter( hFunction, hContext ) end

---[[ CDOTABaseGameMode:SetBountyRuneSpawnInterval  Set bounty rune spawn rate ])
-- @return void
-- @param flInterval float
function CDOTABaseGameMode:SetBountyRuneSpawnInterval( flInterval ) end

---[[ CDOTABaseGameMode:SetBuybackEnabled  Enables or disables buyback completely. ])
-- @return void
-- @param bEnabled bool
function CDOTABaseGameMode:SetBuybackEnabled( bEnabled ) end

---[[ CDOTABaseGameMode:SetCameraDistanceOverride  Set a different camera distance; dota default is 1134. ])
-- @return void
-- @param flCameraDistanceOverride float
function CDOTABaseGameMode:SetCameraDistanceOverride( flCameraDistanceOverride ) end

---[[ CDOTABaseGameMode:SetCameraSmoothCountOverride  Set a different camera smooth count; dota default is 8. ])
-- @return void
-- @param nSmoothCount int
function CDOTABaseGameMode:SetCameraSmoothCountOverride( nSmoothCount ) end

---[[ CDOTABaseGameMode:SetCameraZRange  Sets the camera Z range ])
-- @return void
-- @param flMinZ float
-- @param flMaxZ float
function CDOTABaseGameMode:SetCameraZRange( flMinZ, flMaxZ ) end

---[[ CDOTABaseGameMode:SetCanSellAnywhere   ])
-- @return void
-- @param bAllow bool
function CDOTABaseGameMode:SetCanSellAnywhere( bAllow ) end

---[[ CDOTABaseGameMode:SetCustomAttributeDerivedStatValue  Modify derived stat value constants. ( AttributeDerivedStat eStatType, float flNewValue. ])
-- @return void
-- @param nStatType int
-- @param flNewValue float
function CDOTABaseGameMode:SetCustomAttributeDerivedStatValue( nStatType, flNewValue ) end

---[[ CDOTABaseGameMode:SetCustomBackpackCooldownPercent  Set the rate cooldown ticks down for items in the backpack. ])
-- @return void
-- @param flPercent float
function CDOTABaseGameMode:SetCustomBackpackCooldownPercent( flPercent ) end

---[[ CDOTABaseGameMode:SetCustomBackpackSwapCooldown  Set a custom cooldown for swapping items into the backpack. ])
-- @return void
-- @param flCooldown float
function CDOTABaseGameMode:SetCustomBackpackSwapCooldown( flCooldown ) end

---[[ CDOTABaseGameMode:SetCustomBuybackCooldownEnabled  Turns on capability to define custom buyback cooldowns. ])
-- @return void
-- @param bEnabled bool
function CDOTABaseGameMode:SetCustomBuybackCooldownEnabled( bEnabled ) end

---[[ CDOTABaseGameMode:SetCustomBuybackCostEnabled  Turns on capability to define custom buyback costs. ])
-- @return void
-- @param bEnabled bool
function CDOTABaseGameMode:SetCustomBuybackCostEnabled( bEnabled ) end

---[[ CDOTABaseGameMode:SetCustomDireScore  Sets the topbar score display value for dire. ])
-- @return void
-- @param nScore int
function CDOTABaseGameMode:SetCustomDireScore( nScore ) end

---[[ CDOTABaseGameMode:SetCustomGameForceHero  Force all players to use the specified hero and disable the normal hero selection process. Must be used before hero selection. ])
-- @return void
-- @param pHeroName string
function CDOTABaseGameMode:SetCustomGameForceHero( pHeroName ) end

---[[ CDOTABaseGameMode:SetCustomGlyphCooldown  Set a custom cooldown for team Glyph ability. ])
-- @return void
-- @param flCooldown float
function CDOTABaseGameMode:SetCustomGlyphCooldown( flCooldown ) end

---[[ CDOTABaseGameMode:SetCustomHeroMaxLevel  Allows definition of the max level heroes can achieve (default is 25). ])
-- @return void
-- @param int_1 int
function CDOTABaseGameMode:SetCustomHeroMaxLevel( int_1 ) end

---[[ CDOTABaseGameMode:SetCustomRadiantScore  Sets the topbar score display value for radiant. ])
-- @return void
-- @param nScore int
function CDOTABaseGameMode:SetCustomRadiantScore( nScore ) end

---[[ CDOTABaseGameMode:SetCustomScanCooldown  Set a custom cooldown for team Scan ability. ])
-- @return void
-- @param flCooldown float
function CDOTABaseGameMode:SetCustomScanCooldown( flCooldown ) end

---[[ CDOTABaseGameMode:SetCustomTerrainWeatherEffect  Set the effect used as a custom weather effect, when units are on non-default terrain, in this mode. ])
-- @return void
-- @param pszEffectName string
function CDOTABaseGameMode:SetCustomTerrainWeatherEffect( pszEffectName ) end

---[[ CDOTABaseGameMode:SetCustomXPRequiredToReachNextLevel  Allows definition of a table of hero XP values. ])
-- @return void
-- @param hTable handle
function CDOTABaseGameMode:SetCustomXPRequiredToReachNextLevel( hTable ) end

---[[ CDOTABaseGameMode:SetDamageFilter  Set a filter function to control the behavior when a unit takes damage. (Modify the table and Return true to use new values, return false to cancel the event) ])
-- @return void
-- @param hFunction handle
-- @param hContext handle
function CDOTABaseGameMode:SetDamageFilter( hFunction, hContext ) end

---[[ CDOTABaseGameMode:SetDaynightCycleAdvanceRate  Sets the rate at which the day/night cycle advances (1.0 = default). ])
-- @return void
-- @param flRate float
function CDOTABaseGameMode:SetDaynightCycleAdvanceRate( flRate ) end

---[[ CDOTABaseGameMode:SetDaynightCycleDisabled  Enable or disable the day/night cycle. ])
-- @return void
-- @param bDisable bool
function CDOTABaseGameMode:SetDaynightCycleDisabled( bDisable ) end

---[[ CDOTABaseGameMode:SetDeathOverlayDisabled  Specify whether the full screen death overlay effect plays when the selected hero dies. ])
-- @return void
-- @param bDisabled bool
function CDOTABaseGameMode:SetDeathOverlayDisabled( bDisabled ) end

---[[ CDOTABaseGameMode:SetDefaultStickyItem  Sets the default sticky item in the quickbuy ])
-- @return void
-- @param pItem string
function CDOTABaseGameMode:SetDefaultStickyItem( pItem ) end

---[[ CDOTABaseGameMode:SetDraftingBanningTimeOverride  Set drafting hero banning time ])
-- @return void
-- @param flValue float
function CDOTABaseGameMode:SetDraftingBanningTimeOverride( flValue ) end

---[[ CDOTABaseGameMode:SetDraftingHeroPickSelectTimeOverride  Set drafting hero pick time ])
-- @return void
-- @param flValue float
function CDOTABaseGameMode:SetDraftingHeroPickSelectTimeOverride( flValue ) end

---[[ CDOTABaseGameMode:SetExecuteOrderFilter  Set a filter function to control the behavior when a unit picks up an item. (Modify the table and Return true to use new values, return false to cancel the event) ])
-- @return void
-- @param hFunction handle
-- @param hContext handle
function CDOTABaseGameMode:SetExecuteOrderFilter( hFunction, hContext ) end

---[[ CDOTABaseGameMode:SetFixedRespawnTime  Set a fixed delay for all players to respawn after. ])
-- @return void
-- @param flFixedRespawnTime float
function CDOTABaseGameMode:SetFixedRespawnTime( flFixedRespawnTime ) end

---[[ CDOTABaseGameMode:SetFogOfWarDisabled  Turn the fog of war on or off. ])
-- @return void
-- @param bDisabled bool
function CDOTABaseGameMode:SetFogOfWarDisabled( bDisabled ) end

---[[ CDOTABaseGameMode:SetForceRightClickAttackDisabled  Prevent users from using the right click deny setting. ])
-- @return void
-- @param bDisabled bool
function CDOTABaseGameMode:SetForceRightClickAttackDisabled( bDisabled ) end

---[[ CDOTABaseGameMode:SetFountainConstantManaRegen  Set the constant rate that the fountain will regen mana. (-1 for default) ])
-- @return void
-- @param flConstantManaRegen float
function CDOTABaseGameMode:SetFountainConstantManaRegen( flConstantManaRegen ) end

---[[ CDOTABaseGameMode:SetFountainPercentageHealthRegen  Set the percentage rate that the fountain will regen health. (-1 for default) ])
-- @return void
-- @param flPercentageHealthRegen float
function CDOTABaseGameMode:SetFountainPercentageHealthRegen( flPercentageHealthRegen ) end

---[[ CDOTABaseGameMode:SetFountainPercentageManaRegen  Set the percentage rate that the fountain will regen mana. (-1 for default) ])
-- @return void
-- @param flPercentageManaRegen float
function CDOTABaseGameMode:SetFountainPercentageManaRegen( flPercentageManaRegen ) end

---[[ CDOTABaseGameMode:SetFreeCourierModeEnabled  If set to true, enable 7.23 free courier mode. ])
-- @return void
-- @param bEnabled bool
function CDOTABaseGameMode:SetFreeCourierModeEnabled( bEnabled ) end

---[[ CDOTABaseGameMode:SetFriendlyBuildingMoveToEnabled  Allows clicks on friendly buildings to be handled normally. ])
-- @return void
-- @param bEnabled bool
function CDOTABaseGameMode:SetFriendlyBuildingMoveToEnabled( bEnabled ) end

---[[ CDOTABaseGameMode:SetGoldSoundDisabled  Turn the sound when gold is acquired off/on. ])
-- @return void
-- @param bDisabled bool
function CDOTABaseGameMode:SetGoldSoundDisabled( bDisabled ) end

---[[ CDOTABaseGameMode:SetHUDVisible  Set the HUD element visibility. ])
-- @return void
-- @param iHUDElement int
-- @param bVisible bool
function CDOTABaseGameMode:SetHUDVisible( iHUDElement, bVisible ) end

---[[ CDOTABaseGameMode:SetHealingFilter  Set a filter function to control the behavior when a unit heals. (Modify the table and Return true to use new values, return false to cancel the event) ])
-- @return void
-- @param hFunction handle
-- @param hContext handle
function CDOTABaseGameMode:SetHealingFilter( hFunction, hContext ) end

---[[ CDOTABaseGameMode:SetHudCombatEventsDisabled  Specify whether the default combat events will show in the HUD. ])
-- @return void
-- @param bDisabled bool
function CDOTABaseGameMode:SetHudCombatEventsDisabled( bDisabled ) end

---[[ CDOTABaseGameMode:SetItemAddedToInventoryFilter  Set a filter function to control what happens to items that are added to an inventory, return false to cancel the event ])
-- @return void
-- @param hFunction handle
-- @param hContext handle
function CDOTABaseGameMode:SetItemAddedToInventoryFilter( hFunction, hContext ) end

---[[ CDOTABaseGameMode:SetKillableTombstones  Set whether tombstones can be channeled to be removed by enemy heroes. ])
-- @return void
-- @param bEnabled bool
function CDOTABaseGameMode:SetKillableTombstones( bEnabled ) end

---[[ CDOTABaseGameMode:SetKillingSpreeAnnouncerDisabled  Mutes the in-game killing spree announcer. ])
-- @return void
-- @param bDisabled bool
function CDOTABaseGameMode:SetKillingSpreeAnnouncerDisabled( bDisabled ) end

---[[ CDOTABaseGameMode:SetLoseGoldOnDeath  Use to disable gold loss on death. ])
-- @return void
-- @param bEnabled bool
function CDOTABaseGameMode:SetLoseGoldOnDeath( bEnabled ) end

---[[ CDOTABaseGameMode:SetMaximumAttackSpeed  Set the maximum attack speed for units. ])
-- @return void
-- @param nMaxSpeed int
function CDOTABaseGameMode:SetMaximumAttackSpeed( nMaxSpeed ) end

---[[ CDOTABaseGameMode:SetMinimumAttackSpeed  Set the minimum attack speed for units. ])
-- @return void
-- @param nMinSpeed int
function CDOTABaseGameMode:SetMinimumAttackSpeed( nMinSpeed ) end

---[[ CDOTABaseGameMode:SetModifierGainedFilter  Set a filter function to control modifiers that are gained, return false to destroy modifier. ])
-- @return void
-- @param hFunction handle
-- @param hContext handle
function CDOTABaseGameMode:SetModifierGainedFilter( hFunction, hContext ) end

---[[ CDOTABaseGameMode:SetModifyExperienceFilter  Set a filter function to control the behavior when a hero's experience is modified. (Modify the table and Return true to use new values, return false to cancel the event) ])
-- @return void
-- @param hFunction handle
-- @param hContext handle
function CDOTABaseGameMode:SetModifyExperienceFilter( hFunction, hContext ) end

---[[ CDOTABaseGameMode:SetModifyGoldFilter  Set a filter function to control the behavior when a hero's gold is modified. (Modify the table and Return true to use new values, return false to cancel the event) ])
-- @return void
-- @param hFunction handle
-- @param hContext handle
function CDOTABaseGameMode:SetModifyGoldFilter( hFunction, hContext ) end

---[[ CDOTABaseGameMode:SetNeutralItemHideUndiscoveredEnabled  When enabled, undiscovered items in the neutral item stash are hidden. ])
-- @return void
-- @param bEnable bool
function CDOTABaseGameMode:SetNeutralItemHideUndiscoveredEnabled( bEnable ) end

---[[ CDOTABaseGameMode:SetNeutralStashEnabled  Allow items to be sent to the neutral stash. ])
-- @return void
-- @param bEnable bool
function CDOTABaseGameMode:SetNeutralStashEnabled( bEnable ) end

---[[ CDOTABaseGameMode:SetNeutralStashTeamViewOnlyEnabled  When enabled, the all neutral items tab cannot be viewed. ])
-- @return void
-- @param bEnable bool
function CDOTABaseGameMode:SetNeutralStashTeamViewOnlyEnabled( bEnable ) end

---[[ CDOTABaseGameMode:SetOverrideSelectionEntity  Set an override for the default selection entity, instead of each player's hero. ])
-- @return void
-- @param hOverrideEntity handle
function CDOTABaseGameMode:SetOverrideSelectionEntity( hOverrideEntity ) end

---[[ CDOTABaseGameMode:SetPauseEnabled  Set pausing enabled/disabled ])
-- @return void
-- @param bEnabled bool
function CDOTABaseGameMode:SetPauseEnabled( bEnabled ) end

---[[ CDOTABaseGameMode:SetPowerRuneSpawnInterval  Set power rune spawn rate ])
-- @return void
-- @param flInterval float
function CDOTABaseGameMode:SetPowerRuneSpawnInterval( flInterval ) end

---[[ CDOTABaseGameMode:SetRandomHeroBonusItemGrantDisabled  Disables bonus items for randoming a hero. ])
-- @return void
-- @param bDisabled bool
function CDOTABaseGameMode:SetRandomHeroBonusItemGrantDisabled( bDisabled ) end

---[[ CDOTABaseGameMode:SetRecommendedItemsDisabled  Turn the panel for showing recommended items at the shop off/on. ])
-- @return void
-- @param bDisabled bool
function CDOTABaseGameMode:SetRecommendedItemsDisabled( bDisabled ) end

---[[ CDOTABaseGameMode:SetRemoveIllusionsOnDeath  Make it so illusions are immediately removed upon death, rather than sticking around for a few seconds. ])
-- @return void
-- @param bRemove bool
function CDOTABaseGameMode:SetRemoveIllusionsOnDeath( bRemove ) end

---[[ CDOTABaseGameMode:SetRespawnTimeScale  Sets the scale applied to non-fixed respawn times. 1 = default DOTA respawn calculations. ])
-- @return void
-- @param flValue float
function CDOTABaseGameMode:SetRespawnTimeScale( flValue ) end

---[[ CDOTABaseGameMode:SetRuneEnabled  Set if a given type of rune is enabled. ])
-- @return void
-- @param nRune int
-- @param bEnabled bool
function CDOTABaseGameMode:SetRuneEnabled( nRune, bEnabled ) end

---[[ CDOTABaseGameMode:SetRuneSpawnFilter  Set a filter function to control what rune spawns. (Modify the table and Return true to use new values, return false to cancel the event) ])
-- @return void
-- @param hFunction handle
-- @param hContext handle
function CDOTABaseGameMode:SetRuneSpawnFilter( hFunction, hContext ) end

---[[ CDOTABaseGameMode:SetSelectionGoldPenaltyEnabled  Enable/disable gold penalty for late picking. ])
-- @return void
-- @param bEnabled bool
function CDOTABaseGameMode:SetSelectionGoldPenaltyEnabled( bEnabled ) end

---[[ CDOTABaseGameMode:SetSendToStashEnabled  Allow items to be sent to the stash. ])
-- @return void
-- @param bEnable bool
function CDOTABaseGameMode:SetSendToStashEnabled( bEnable ) end

---[[ CDOTABaseGameMode:SetStashPurchasingDisabled  Turn purchasing items to the stash off/on. If purchasing to the stash is off the player must be at a shop to purchase items. ])
-- @return void
-- @param bDisabled bool
function CDOTABaseGameMode:SetStashPurchasingDisabled( bDisabled ) end

---[[ CDOTABaseGameMode:SetStickyItemDisabled  Hide the sticky item in the quickbuy. ])
-- @return void
-- @param bDisabled bool
function CDOTABaseGameMode:SetStickyItemDisabled( bDisabled ) end

---[[ CDOTABaseGameMode:SetTPScrollSlotItemOverride  Sets the item which goes in the TP scroll slot ])
-- @return void
-- @param pItemName string
function CDOTABaseGameMode:SetTPScrollSlotItemOverride( pItemName ) end

---[[ CDOTABaseGameMode:SetTopBarTeamValue  Set the team values on the top game bar. ])
-- @return void
-- @param iTeam int
-- @param nValue int
function CDOTABaseGameMode:SetTopBarTeamValue( iTeam, nValue ) end

---[[ CDOTABaseGameMode:SetTopBarTeamValuesOverride  Override the values of the team values on the top game bar. ])
-- @return void
-- @param bOverride bool
function CDOTABaseGameMode:SetTopBarTeamValuesOverride( bOverride ) end

---[[ CDOTABaseGameMode:SetTopBarTeamValuesVisible  Turning on/off the team values on the top game bar. ])
-- @return void
-- @param bVisible bool
function CDOTABaseGameMode:SetTopBarTeamValuesVisible( bVisible ) end

---[[ CDOTABaseGameMode:SetTowerBackdoorProtectionEnabled  Enables/Disables tower backdoor protection. ])
-- @return void
-- @param bEnabled bool
function CDOTABaseGameMode:SetTowerBackdoorProtectionEnabled( bEnabled ) end

---[[ CDOTABaseGameMode:SetTrackingProjectileFilter  Set a filter function to control when tracking projectiles are launched. (Modify the table and Return true to use new values, return false to cancel the event) ])
-- @return void
-- @param hFunction handle
-- @param hContext handle
function CDOTABaseGameMode:SetTrackingProjectileFilter( hFunction, hContext ) end

---[[ CDOTABaseGameMode:SetUnseenFogOfWarEnabled  Enable or disable unseen fog of war. When enabled parts of the map the player has never seen will be completely hidden by fog of war. ])
-- @return void
-- @param bEnabled bool
function CDOTABaseGameMode:SetUnseenFogOfWarEnabled( bEnabled ) end

---[[ CDOTABaseGameMode:SetUseCustomHeroLevels  Turn on custom-defined XP values for hero level ups.  The table should be defined before switching this on. ])
-- @return void
-- @param bEnabled bool
function CDOTABaseGameMode:SetUseCustomHeroLevels( bEnabled ) end

---[[ CDOTABaseGameMode:SetUseDefaultDOTARuneSpawnLogic  If set to true, use current rune spawn rules.  Either setting respects custom spawn intervals. ])
-- @return void
-- @param bEnabled bool
function CDOTABaseGameMode:SetUseDefaultDOTARuneSpawnLogic( bEnabled ) end

---[[ CDOTABaseGameMode:SetUseTurboCouriers  Enables or disables turbo couriers. ])
-- @return void
-- @param bEnabled bool
function CDOTABaseGameMode:SetUseTurboCouriers( bEnabled ) end

---[[ CDOTABaseGameMode:SetWeatherEffectsDisabled  Set if weather effects are disabled. ])
-- @return void
-- @param bDisable bool
function CDOTABaseGameMode:SetWeatherEffectsDisabled( bDisable ) end

---[[ CDOTAGameManager:GetHeroDataByName_Script  Get the hero unit  ])
-- @return table
-- @param string_1 string
function CDOTAGameManager:GetHeroDataByName_Script( string_1 ) end

---[[ CDOTAGameManager:GetHeroIDByName  Get the hero ID given the hero name. ])
-- @return int
-- @param string_1 string
function CDOTAGameManager:GetHeroIDByName( string_1 ) end

---[[ CDOTAGameManager:GetHeroNameByID  Get the hero name given a hero ID. ])
-- @return string
-- @param int_1 int
function CDOTAGameManager:GetHeroNameByID( int_1 ) end

---[[ CDOTAGameManager:GetHeroNameForUnitName  Get the hero name given a unit name. ])
-- @return string
-- @param string_1 string
function CDOTAGameManager:GetHeroNameForUnitName( string_1 ) end

---[[ CDOTAGameManager:GetHeroUnitNameByID  Get the hero unit name given the hero ID. ])
-- @return string
-- @param int_1 int
function CDOTAGameManager:GetHeroUnitNameByID( int_1 ) end

---[[ CDOTAGamerules:AddBotPlayerWithEntityScript  Spawn a bot player of the passed hero name, player name, and team. ])
-- @return handle
-- @param string_1 string
-- @param string_2 string
-- @param int_3 int
-- @param string_4 string
-- @param bool_5 bool
function CDOTAGamerules:AddBotPlayerWithEntityScript( string_1, string_2, int_3, string_4, bool_5 ) end

---[[ CDOTAGamerules:AddEventMetadataLeaderboardEntry  Event-only ( string szNameSuffix, int nStars, int nMaxStars, int nExtraData1, int nExtraData2 ) ])
-- @return bool
-- @param string_1 string
-- @param unsigned_2 unsigned
-- @param unsigned_3 unsigned
-- @param unsigned_4 unsigned
-- @param unsigned_5 unsigned
-- @param unsigned_6 unsigned
-- @param unsigned_7 unsigned
-- @param unsigned_8 unsigned
-- @param unsigned_9 unsigned
function CDOTAGamerules:AddEventMetadataLeaderboardEntry( string_1, unsigned_2, unsigned_3, unsigned_4, unsigned_5, unsigned_6, unsigned_7, unsigned_8, unsigned_9 ) end

---[[ CDOTAGamerules:AddEventMetadataLeaderboardEntryRawScore  Event-only ( string szNameSuffix, int nScore, int nExtraData1, int nExtraData2 ) ])
-- @return bool
-- @param string_1 string
-- @param unsigned_2 unsigned
-- @param unsigned_3 unsigned
-- @param unsigned_4 unsigned
-- @param unsigned_5 unsigned
-- @param unsigned_6 unsigned
-- @param unsigned_7 unsigned
-- @param unsigned_8 unsigned
function CDOTAGamerules:AddEventMetadataLeaderboardEntryRawScore( string_1, unsigned_2, unsigned_3, unsigned_4, unsigned_5, unsigned_6, unsigned_7, unsigned_8 ) end

---[[ CDOTAGamerules:AddItemToWhiteList  Add an item to the whitelist ])
-- @return void
-- @param string_1 string
function CDOTAGamerules:AddItemToWhiteList( string_1 ) end

---[[ CDOTAGamerules:AddMinimapDebugPoint  Add a point on the minimap. ])
-- @return void
-- @param int_1 int
-- @param Vector_2 Vector
-- @param int_3 int
-- @param int_4 int
-- @param int_5 int
-- @param int_6 int
-- @param float_7 float
function CDOTAGamerules:AddMinimapDebugPoint( int_1, Vector_2, int_3, int_4, int_5, int_6, float_7 ) end

---[[ CDOTAGamerules:AddMinimapDebugPointForTeam  Add a point on the minimap for a specific team. ])
-- @return void
-- @param int_1 int
-- @param Vector_2 Vector
-- @param int_3 int
-- @param int_4 int
-- @param int_5 int
-- @param int_6 int
-- @param float_7 float
-- @param int_8 int
function CDOTAGamerules:AddMinimapDebugPointForTeam( int_1, Vector_2, int_3, int_4, int_5, int_6, float_7, int_8 ) end

---[[ CDOTAGamerules:BeginNightstalkerNight  Begin night stalker night. ])
-- @return void
-- @param float_1 float
function CDOTAGamerules:BeginNightstalkerNight( float_1 ) end

---[[ CDOTAGamerules:BeginTemporaryNight  Begin temporary night. ])
-- @return void
-- @param float_1 float
function CDOTAGamerules:BeginTemporaryNight( float_1 ) end

---[[ CDOTAGamerules:BotPopulate  Fills all the teams with bots if cheat mode is enabled. ])
-- @return void
function CDOTAGamerules:BotPopulate(  ) end

---[[ CDOTAGamerules:Defeated  Kills the ancient, etc. ])
-- @return void
function CDOTAGamerules:Defeated(  ) end

---[[ CDOTAGamerules:DidMatchSignoutTimeOut  true when we have waited some time after end of the game and not received signout ])
-- @return bool
function CDOTAGamerules:DidMatchSignoutTimeOut(  ) end

---[[ CDOTAGamerules:EnableCustomGameSetupAutoLaunch  Enabled (true) or disable (false) auto launch for custom game setup. ])
-- @return void
-- @param bool_1 bool
function CDOTAGamerules:EnableCustomGameSetupAutoLaunch( bool_1 ) end

---[[ CDOTAGamerules:ExecuteTeamPing  Sends a minimap ping to all players on the team ])
-- @return void
-- @param int_1 int
-- @param float_2 float
-- @param float_3 float
-- @param handle_4 handle
-- @param int_5 int
function CDOTAGamerules:ExecuteTeamPing( int_1, float_2, float_3, handle_4, int_5 ) end

---[[ CDOTAGamerules:FinishCustomGameSetup  Indicate that the custom game setup phase is complete, and advance to the game. ])
-- @return void
function CDOTAGamerules:FinishCustomGameSetup(  ) end

---[[ CDOTAGamerules:ForceCreepSpawn  Spawn the next wave of creeps. ])
-- @return void
function CDOTAGamerules:ForceCreepSpawn(  ) end

---[[ CDOTAGamerules:ForceGameStart  Transition game state to DOTA_GAMERULES_STATE_GAME_IN_PROGRESS ])
-- @return void
function CDOTAGamerules:ForceGameStart(  ) end

---[[ CDOTAGamerules:GetAnnouncer  Get the announcer for a team ])
-- @return handle
-- @param int_1 int
function CDOTAGamerules:GetAnnouncer( int_1 ) end

---[[ CDOTAGamerules:GetBannedHeroIDs  Returns the hero unit IDs banned in this game, if any ])
-- @return table
function CDOTAGamerules:GetBannedHeroIDs(  ) end

---[[ CDOTAGamerules:GetBannedHeroes  Returns the hero unit names banned in this game, if any ])
-- @return table
function CDOTAGamerules:GetBannedHeroes(  ) end

---[[ CDOTAGamerules:GetCustomGameDifficulty  Returns the difficulty level of the custom game mode ])
-- @return int
function CDOTAGamerules:GetCustomGameDifficulty(  ) end

---[[ CDOTAGamerules:GetCustomGameTeamMaxPlayers  Get whether a team is selectable during game setup ])
-- @return int
-- @param int_1 int
function CDOTAGamerules:GetCustomGameTeamMaxPlayers( int_1 ) end

---[[ CDOTAGamerules:GetDOTATime  (b IncludePregameTime b IncludeNegativeTime) Returns the actual DOTA in-game clock time. ])
-- @return float
-- @param bool_1 bool
-- @param bool_2 bool
function CDOTAGamerules:GetDOTATime( bool_1, bool_2 ) end

---[[ CDOTAGamerules:GetDifficulty  Returns difficulty level of the custom game mode ])
-- @return int
function CDOTAGamerules:GetDifficulty(  ) end

---[[ CDOTAGamerules:GetDroppedItem  Gets the Xth dropped item ])
-- @return handle
-- @param int_1 int
function CDOTAGamerules:GetDroppedItem( int_1 ) end

---[[ CDOTAGamerules:GetGameFrameTime  Returns the number of seconds elapsed since the last frame was renderered. This time doesn't count up when the game is paused ])
-- @return float
function CDOTAGamerules:GetGameFrameTime(  ) end

---[[ CDOTAGamerules:GetGameModeEntity  Get the game mode entity ])
-- @return handle
function CDOTAGamerules:GetGameModeEntity(  ) end

---[[ CDOTAGamerules:GetGameSessionConfigValue  Get a string value from the game session config (map options) ])
-- @return string
-- @param string_1 string
-- @param string_2 string
function CDOTAGamerules:GetGameSessionConfigValue( string_1, string_2 ) end

---[[ CDOTAGamerules:GetGameTime  Returns the number of seconds elapsed since map start. This time doesn't count up when the game is paused ])
-- @return float
function CDOTAGamerules:GetGameTime(  ) end

---[[ CDOTAGamerules:GetItemStockCount  Get the stock count of the item ])
-- @return int
-- @param int_1 int
-- @param string_2 string
-- @param int_3 int
function CDOTAGamerules:GetItemStockCount( int_1, string_2, int_3 ) end

---[[ CDOTAGamerules:GetItemStockDuration  Get the time it takes to add a new item to stock ])
-- @return float
-- @param int_1 int
-- @param string_2 string
-- @param int_3 int
function CDOTAGamerules:GetItemStockDuration( int_1, string_2, int_3 ) end

---[[ CDOTAGamerules:GetItemStockTime  Get the time an item will be added to stock ])
-- @return float
-- @param int_1 int
-- @param string_2 string
-- @param int_3 int
function CDOTAGamerules:GetItemStockTime( int_1, string_2, int_3 ) end

---[[ CDOTAGamerules:GetMatchSignoutComplete  Have we received the post match signout message that includes reward information ])
-- @return bool
function CDOTAGamerules:GetMatchSignoutComplete(  ) end

---[[ CDOTAGamerules:GetNextBountyRuneSpawnTime  Gets next bounty rune spawn time ])
-- @return float
function CDOTAGamerules:GetNextBountyRuneSpawnTime(  ) end

---[[ CDOTAGamerules:GetNextRuneSpawnTime  Gets next rune spawn time ])
-- @return float
function CDOTAGamerules:GetNextRuneSpawnTime(  ) end

---[[ CDOTAGamerules:GetNianTotalDamageTaken  For New Bloom, get total damage taken by the Nian / Year Beast ])
-- @return int
function CDOTAGamerules:GetNianTotalDamageTaken(  ) end

---[[ CDOTAGamerules:GetPlayerCustomGameAccountRecord  (Preview/Unreleased) Gets the player's custom game account record, as it looked at the start of this session ])
-- @return table
-- @param int_1 int
function CDOTAGamerules:GetPlayerCustomGameAccountRecord( int_1 ) end

---[[ CDOTAGamerules:GetStateTransitionTime  Get time remaining between state changes. ])
-- @return float
function CDOTAGamerules:GetStateTransitionTime(  ) end

---[[ CDOTAGamerules:GetTimeOfDay  Get the time of day ])
-- @return float
function CDOTAGamerules:GetTimeOfDay(  ) end

---[[ CDOTAGamerules:GetWeatherWindDirection  Get Weather Wind Direction Vector ])
-- @return Vector
function CDOTAGamerules:GetWeatherWindDirection(  ) end

---[[ CDOTAGamerules:IncreaseItemStock  Increase an item's stock count, clamped to item max (nTeamNumber, szItemName, nCount, nPlayerID . ])
-- @return void
-- @param int_1 int
-- @param string_2 string
-- @param int_3 int
-- @param int_4 int
function CDOTAGamerules:IncreaseItemStock( int_1, string_2, int_3, int_4 ) end

---[[ CDOTAGamerules:IsCheatMode  Are cheats enabled on the server ])
-- @return bool
function CDOTAGamerules:IsCheatMode(  ) end

---[[ CDOTAGamerules:IsDaytime  Is it day time? ])
-- @return bool
function CDOTAGamerules:IsDaytime(  ) end

---[[ CDOTAGamerules:IsGamePaused  Returns whether the game is paused. ])
-- @return bool
function CDOTAGamerules:IsGamePaused(  ) end

---[[ CDOTAGamerules:IsHeroRespawnEnabled  Returns whether hero respawn is enabled. ])
-- @return bool
function CDOTAGamerules:IsHeroRespawnEnabled(  ) end

---[[ CDOTAGamerules:IsInBanPhase  Are we in the ban phase of hero pick? ])
-- @return bool
function CDOTAGamerules:IsInBanPhase(  ) end

---[[ CDOTAGamerules:IsItemInWhiteList  Query an item in the whitelist ])
-- @return bool
-- @param string_1 string
function CDOTAGamerules:IsItemInWhiteList( string_1 ) end

---[[ CDOTAGamerules:IsNightstalkerNight  Is it night stalker night-time? ])
-- @return bool
function CDOTAGamerules:IsNightstalkerNight(  ) end

---[[ CDOTAGamerules:IsTemporaryNight  Is it temporarily night-time? ])
-- @return bool
function CDOTAGamerules:IsTemporaryNight(  ) end

---[[ CDOTAGamerules:LockCustomGameSetupTeamAssignment  Lock (true) or unlock (false) team assignemnt. If team assignment is locked players cannot change teams. ])
-- @return void
-- @param bool_1 bool
function CDOTAGamerules:LockCustomGameSetupTeamAssignment( bool_1 ) end

---[[ CDOTAGamerules:MakeTeamLose  Makes the specified team lose ])
-- @return void
-- @param int_1 int
function CDOTAGamerules:MakeTeamLose( int_1 ) end

---[[ CDOTAGamerules:ModifyGoldFiltered  Like ModifyGold, but will use the gold filter if SetFilterMoreGold has been set true ])
-- @return int
-- @param int_1 int
-- @param int_2 int
-- @param bool_3 bool
-- @param int_4 int
function CDOTAGamerules:ModifyGoldFiltered( int_1, int_2, bool_3, int_4 ) end

---[[ CDOTAGamerules:NumDroppedItems  Returns the number of items currently dropped on the ground ])
-- @return int
function CDOTAGamerules:NumDroppedItems(  ) end

---[[ CDOTAGamerules:PlayerHasCustomGameHostPrivileges  Whether a player has custom game host privileges (shuffle teams, etc.) ])
-- @return bool
-- @param handle_1 handle
function CDOTAGamerules:PlayerHasCustomGameHostPrivileges( handle_1 ) end

---[[ CDOTAGamerules:Playtesting_UpdateAddOnKeyValues  Updates custom hero, unit and ability KeyValues in memory with the latest values from disk ])
-- @return void
function CDOTAGamerules:Playtesting_UpdateAddOnKeyValues(  ) end

---[[ CDOTAGamerules:PrepareSpawners  Prepare Dota lane style spawners with a given interval ])
-- @return void
-- @param float_1 float
function CDOTAGamerules:PrepareSpawners( float_1 ) end

---[[ CDOTAGamerules:RemoveFakeClient  Removes a fake client ])
-- @return void
-- @param int_1 int
function CDOTAGamerules:RemoveFakeClient( int_1 ) end

---[[ CDOTAGamerules:RemoveItemFromWhiteList  Remove an item from the whitelist ])
-- @return void
-- @param string_1 string
function CDOTAGamerules:RemoveItemFromWhiteList( string_1 ) end

---[[ CDOTAGamerules:ResetDefeated  Restart after killing the ancient, etc. ])
-- @return void
function CDOTAGamerules:ResetDefeated(  ) end

---[[ CDOTAGamerules:ResetGameTime  Restart gametime from 0 ])
-- @return void
function CDOTAGamerules:ResetGameTime(  ) end

---[[ CDOTAGamerules:ResetToCustomGameSetup  Restart at custom game setup. ])
-- @return void
function CDOTAGamerules:ResetToCustomGameSetup(  ) end

---[[ CDOTAGamerules:ResetToHeroSelection  Restart the game at hero selection ])
-- @return void
function CDOTAGamerules:ResetToHeroSelection(  ) end

---[[ CDOTAGamerules:Script_GetMatchID  Get the MatchID for this game. ])
-- @return uint64
function CDOTAGamerules:Script_GetMatchID(  ) end

---[[ CDOTAGamerules:SendCustomMessage  Sends a message on behalf of a player. ])
-- @return void
-- @param string_1 string
-- @param int_2 int
-- @param int_3 int
function CDOTAGamerules:SendCustomMessage( string_1, int_2, int_3 ) end

---[[ CDOTAGamerules:SendCustomMessageToTeam  Sends a message on behalf of a player to the specified team. ])
-- @return void
-- @param string_1 string
-- @param int_2 int
-- @param int_3 int
-- @param int_4 int
function CDOTAGamerules:SendCustomMessageToTeam( string_1, int_2, int_3, int_4 ) end

---[[ CDOTAGamerules:SetAllowOutpostBonuses  Allow Outposts granting XP ])
-- @return void
-- @param bool_1 bool
function CDOTAGamerules:SetAllowOutpostBonuses( bool_1 ) end

---[[ CDOTAGamerules:SetCreepMinimapIconScale  (flMinimapCreepIconScale) - Scale the creep icons on the minimap. ])
-- @return void
-- @param float_1 float
function CDOTAGamerules:SetCreepMinimapIconScale( float_1 ) end

---[[ CDOTAGamerules:SetCreepSpawningEnabled  Sets whether the regular Dota creeps spawn. ])
-- @return void
-- @param bool_1 bool
function CDOTAGamerules:SetCreepSpawningEnabled( bool_1 ) end

---[[ CDOTAGamerules:SetCustomGameAccountRecordSaveFunction  (Preview/Unreleased) Sets a callback to handle saving custom game account records (callback is passed a Player ID and should return a flat simple table) ])
-- @return void
-- @param handle_1 handle
-- @param handle_2 handle
function CDOTAGamerules:SetCustomGameAccountRecordSaveFunction( handle_1, handle_2 ) end

---[[ CDOTAGamerules:SetCustomGameAllowBattleMusic  Sets a flag to enable/disable the default music handling code for custom games ])
-- @return void
-- @param bool_1 bool
function CDOTAGamerules:SetCustomGameAllowBattleMusic( bool_1 ) end

---[[ CDOTAGamerules:SetCustomGameAllowHeroPickMusic  Sets a flag to enable/disable the default music handling code for custom games ])
-- @return void
-- @param bool_1 bool
function CDOTAGamerules:SetCustomGameAllowHeroPickMusic( bool_1 ) end

---[[ CDOTAGamerules:SetCustomGameAllowMusicAtGameStart  Sets a flag to enable/disable the default music handling code for custom games ])
-- @return void
-- @param bool_1 bool
function CDOTAGamerules:SetCustomGameAllowMusicAtGameStart( bool_1 ) end

---[[ CDOTAGamerules:SetCustomGameAllowSecondaryAbilitiesOnOtherUnits  Sets a flag to enable/disable the casting secondary abilities from units other than the player's own hero. ])
-- @return void
-- @param bool_1 bool
function CDOTAGamerules:SetCustomGameAllowSecondaryAbilitiesOnOtherUnits( bool_1 ) end

---[[ CDOTAGamerules:SetCustomGameBansPerTeam  Set number of hero bans each team gets ])
-- @return void
-- @param int_1 int
function CDOTAGamerules:SetCustomGameBansPerTeam( int_1 ) end

---[[ CDOTAGamerules:SetCustomGameDifficulty  Set the difficulty level of the custom game mode ])
-- @return void
-- @param int_1 int
function CDOTAGamerules:SetCustomGameDifficulty( int_1 ) end

---[[ CDOTAGamerules:SetCustomGameEndDelay  Sets the game end delay. ])
-- @return void
-- @param float_1 float
function CDOTAGamerules:SetCustomGameEndDelay( float_1 ) end

---[[ CDOTAGamerules:SetCustomGameSetupAutoLaunchDelay  Set the amount of time to wait for auto launch. ])
-- @return void
-- @param float_1 float
function CDOTAGamerules:SetCustomGameSetupAutoLaunchDelay( float_1 ) end

---[[ CDOTAGamerules:SetCustomGameSetupRemainingTime  Set the amount of remaining time, in seconds, for custom game setup. 0 = finish immediately, -1 = wait forever ])
-- @return void
-- @param float_1 float
function CDOTAGamerules:SetCustomGameSetupRemainingTime( float_1 ) end

---[[ CDOTAGamerules:SetCustomGameSetupTimeout  Setup (pre-gameplay) phase timeout. 0 = instant, -1 = forever (until FinishCustomGameSetup is called) ])
-- @return void
-- @param float_1 float
function CDOTAGamerules:SetCustomGameSetupTimeout( float_1 ) end

---[[ CDOTAGamerules:SetCustomGameTeamMaxPlayers  Set whether a team is selectable during game setup ])
-- @return void
-- @param int_1 int
-- @param int_2 int
function CDOTAGamerules:SetCustomGameTeamMaxPlayers( int_1, int_2 ) end

---[[ CDOTAGamerules:SetCustomVictoryMessage  Sets the victory message. ])
-- @return void
-- @param string_1 string
function CDOTAGamerules:SetCustomVictoryMessage( string_1 ) end

---[[ CDOTAGamerules:SetCustomVictoryMessageDuration  Sets the victory message duration. ])
-- @return void
-- @param float_1 float
function CDOTAGamerules:SetCustomVictoryMessageDuration( float_1 ) end

---[[ CDOTAGamerules:SetEventMetadataCustomTable  Event-only ( table hMetadataTable ) ])
-- @return bool
-- @param handle_1 handle
function CDOTAGamerules:SetEventMetadataCustomTable( handle_1 ) end

---[[ CDOTAGamerules:SetEventSignoutCustomTable  Event-only ( table hMetadataTable ) ])
-- @return bool
-- @param handle_1 handle
function CDOTAGamerules:SetEventSignoutCustomTable( handle_1 ) end

---[[ CDOTAGamerules:SetFilterMoreGold  Sets whether to filter more gold events than normal ])
-- @return void
-- @param bool_1 bool
function CDOTAGamerules:SetFilterMoreGold( bool_1 ) end

---[[ CDOTAGamerules:SetFirstBloodActive  Sets whether First Blood has been triggered. ])
-- @return void
-- @param bool_1 bool
function CDOTAGamerules:SetFirstBloodActive( bool_1 ) end

---[[ CDOTAGamerules:SetGameTimeFrozen  Freeze the game time. ])
-- @return void
-- @param bool_1 bool
function CDOTAGamerules:SetGameTimeFrozen( bool_1 ) end

---[[ CDOTAGamerules:SetGameWinner  Makes the specified team win ])
-- @return void
-- @param int_1 int
function CDOTAGamerules:SetGameWinner( int_1 ) end

---[[ CDOTAGamerules:SetGlyphCooldown  Set Glyph cooldown for team ])
-- @return void
-- @param int_1 int
-- @param float_2 float
function CDOTAGamerules:SetGlyphCooldown( int_1, float_2 ) end

---[[ CDOTAGamerules:SetGoldPerTick  Set the auto gold increase per timed interval. ])
-- @return void
-- @param int_1 int
function CDOTAGamerules:SetGoldPerTick( int_1 ) end

---[[ CDOTAGamerules:SetGoldTickTime  Set the time interval between auto gold increases. ])
-- @return void
-- @param float_1 float
function CDOTAGamerules:SetGoldTickTime( float_1 ) end

---[[ CDOTAGamerules:SetHeroMinimapIconScale  (flMinimapHeroIconScale) - Scale the hero minimap icons on the minimap. ])
-- @return void
-- @param float_1 float
function CDOTAGamerules:SetHeroMinimapIconScale( float_1 ) end

---[[ CDOTAGamerules:SetHeroRespawnEnabled  Control if the normal DOTA hero respawn rules apply. ])
-- @return void
-- @param bool_1 bool
function CDOTAGamerules:SetHeroRespawnEnabled( bool_1 ) end

---[[ CDOTAGamerules:SetHeroSelectPenaltyTime  Sets amount of penalty time before randoming a hero ])
-- @return void
-- @param float_1 float
function CDOTAGamerules:SetHeroSelectPenaltyTime( float_1 ) end

---[[ CDOTAGamerules:SetHeroSelectionTime  Sets the amount of time players have to pick their hero. ])
-- @return void
-- @param float_1 float
function CDOTAGamerules:SetHeroSelectionTime( float_1 ) end

---[[ CDOTAGamerules:SetHideKillMessageHeaders  Sets whether the multikill, streak, and first-blood banners appear at the top of the screen. ])
-- @return void
-- @param bool_1 bool
function CDOTAGamerules:SetHideKillMessageHeaders( bool_1 ) end

---[[ CDOTAGamerules:SetIgnoreLobbyTeamsInCustomGame  Set whether custom and event games should ignore Lobby teams when assigning players to teams. Defaults to true. ])
-- @return void
-- @param bool_1 bool
function CDOTAGamerules:SetIgnoreLobbyTeamsInCustomGame( bool_1 ) end

---[[ CDOTAGamerules:SetItemStockCount  Set the stock count of the item ])
-- @return void
-- @param int_1 int
-- @param int_2 int
-- @param string_3 string
-- @param int_4 int
function CDOTAGamerules:SetItemStockCount( int_1, int_2, string_3, int_4 ) end

---[[ CDOTAGamerules:SetNextBountyRuneSpawnTime  Sets next bounty rune spawn time ])
-- @return void
-- @param float_1 float
function CDOTAGamerules:SetNextBountyRuneSpawnTime( float_1 ) end

---[[ CDOTAGamerules:SetNextRuneSpawnTime  Sets next rune spawn time ])
-- @return void
-- @param float_1 float
function CDOTAGamerules:SetNextRuneSpawnTime( float_1 ) end

---[[ CDOTAGamerules:SetOverlayHealthBarUnit  Show this unit's health on the overlay health bar ])
-- @return void
-- @param handle_1 handle
-- @param int_2 int
function CDOTAGamerules:SetOverlayHealthBarUnit( handle_1, int_2 ) end

---[[ CDOTAGamerules:SetPostGameTime  Sets the amount of time players have between the game ending and the server disconnecting them. ])
-- @return void
-- @param float_1 float
function CDOTAGamerules:SetPostGameTime( float_1 ) end

---[[ CDOTAGamerules:SetPreGameTime  Sets the amount of time players have between picking their hero and game start. ])
-- @return void
-- @param float_1 float
function CDOTAGamerules:SetPreGameTime( float_1 ) end

---[[ CDOTAGamerules:SetRuneMinimapIconScale  (flMinimapRuneIconScale) - Scale the rune icons on the minimap. ])
-- @return void
-- @param float_1 float
function CDOTAGamerules:SetRuneMinimapIconScale( float_1 ) end

---[[ CDOTAGamerules:SetRuneSpawnTime  Sets the amount of time between rune spawns. ])
-- @return void
-- @param float_1 float
function CDOTAGamerules:SetRuneSpawnTime( float_1 ) end

---[[ CDOTAGamerules:SetSafeToLeave  (bSafeToLeave) - Mark this game as safe to leave. ])
-- @return void
-- @param bool_1 bool
function CDOTAGamerules:SetSafeToLeave( bool_1 ) end

---[[ CDOTAGamerules:SetSameHeroSelectionEnabled  When true, players can repeatedly pick the same hero. ])
-- @return void
-- @param bool_1 bool
function CDOTAGamerules:SetSameHeroSelectionEnabled( bool_1 ) end

---[[ CDOTAGamerules:SetShowcaseTime  Sets the amount of time players have between the strategy phase and entering the pre-game phase. ])
-- @return void
-- @param float_1 float
function CDOTAGamerules:SetShowcaseTime( float_1 ) end

---[[ CDOTAGamerules:SetSpeechUseSpawnInsteadOfRespawnConcept  Set whether to speak a Spawn concept instead of a Respawn concept on respawn. ])
-- @return void
-- @param bool_1 bool
function CDOTAGamerules:SetSpeechUseSpawnInsteadOfRespawnConcept( bool_1 ) end

---[[ CDOTAGamerules:SetStartingGold  Set the starting gold amount. ])
-- @return void
-- @param int_1 int
function CDOTAGamerules:SetStartingGold( int_1 ) end

---[[ CDOTAGamerules:SetStrategyTime  Sets the amount of time players have between the hero selection and entering the showcase phase. ])
-- @return void
-- @param float_1 float
function CDOTAGamerules:SetStrategyTime( float_1 ) end

---[[ CDOTAGamerules:SetTimeOfDay  Set the time of day. ])
-- @return void
-- @param float_1 float
function CDOTAGamerules:SetTimeOfDay( float_1 ) end

---[[ CDOTAGamerules:SetTreeRegrowTime  Sets the tree regrow time in seconds. ])
-- @return void
-- @param float_1 float
function CDOTAGamerules:SetTreeRegrowTime( float_1 ) end

---[[ CDOTAGamerules:SetUseBaseGoldBountyOnHeroes  Heroes will use the basic NPC functionality for determining their bounty, rather than DOTA specific formulas. ])
-- @return void
-- @param bool_1 bool
function CDOTAGamerules:SetUseBaseGoldBountyOnHeroes( bool_1 ) end

---[[ CDOTAGamerules:SetUseCustomHeroXPValues  Allows heroes in the map to give a specific amount of XP (this value must be set). ])
-- @return void
-- @param bool_1 bool
function CDOTAGamerules:SetUseCustomHeroXPValues( bool_1 ) end

---[[ CDOTAGamerules:SetUseUniversalShopMode  When true, all items are available at as long as any shop is in range. ])
-- @return void
-- @param bool_1 bool
function CDOTAGamerules:SetUseUniversalShopMode( bool_1 ) end

---[[ CDOTAGamerules:SetWeatherWindDirection  Set Weather Wind Direction Vector ])
-- @return void
-- @param Vector_1 Vector
function CDOTAGamerules:SetWeatherWindDirection( Vector_1 ) end

---[[ CDOTAGamerules:SetWhiteListEnabled  Item whitelist functionality enable/disable ])
-- @return void
-- @param bool_1 bool
function CDOTAGamerules:SetWhiteListEnabled( bool_1 ) end

---[[ CDOTAGamerules:SpawnAndReleaseCreeps  Spawn and release the next creep wave from Dota lane style spawners. ])
-- @return void
function CDOTAGamerules:SpawnAndReleaseCreeps(  ) end

---[[ CDOTAGamerules:SpawnNeutralCreeps  Spawn and release the next set of neutral camps. ])
-- @return void
function CDOTAGamerules:SpawnNeutralCreeps(  ) end

---[[ CDOTAGamerules:State_Get  Get the current Gamerules state ])
-- @return int
function CDOTAGamerules:State_Get(  ) end

---[[ CDOTAPlayer:CheckForCourierSpawning  Attempt to spawn the appropriate couriers for this mode. ])
-- @return handle
-- @param hHero handle
function CDOTAPlayer:CheckForCourierSpawning( hHero ) end

---[[ CDOTAPlayer:GetAssignedHero  Get the player's hero. ])
-- @return handle
function CDOTAPlayer:GetAssignedHero(  ) end

---[[ CDOTAPlayer:GetPlayerID  Get the player's official PlayerID; notably is -1 when the player isn't yet on a team. ])
-- @return int
function CDOTAPlayer:GetPlayerID(  ) end

---[[ CDOTAPlayer:MakeRandomHeroSelection  Randoms this player's hero. ])
-- @return void
function CDOTAPlayer:MakeRandomHeroSelection(  ) end

---[[ CDOTAPlayer:SetAssignedHeroEntity  Sets this player's hero . ])
-- @return void
-- @param hHero handle
function CDOTAPlayer:SetAssignedHeroEntity( hHero ) end

---[[ CDOTAPlayer:SetKillCamUnit  Set the kill cam unit for this hero. ])
-- @return void
-- @param hEntity handle
function CDOTAPlayer:SetKillCamUnit( hEntity ) end

---[[ CDOTAPlayer:SetMusicStatus  (nMusicStatus, flIntensity) - Set the music status for this player, note this will only really apply if dota_music_battle_enable is off. ])
-- @return void
-- @param nMusicStatus int
-- @param flIntensity float
function CDOTAPlayer:SetMusicStatus( nMusicStatus, flIntensity ) end

---[[ CDOTAPlayer:SetSelectedHero  Sets this player's hero selection. ])
-- @return void
-- @param pszHeroName string
function CDOTAPlayer:SetSelectedHero( pszHeroName ) end

---[[ CDOTAPlayer:SpawnCourierAtPosition  Spawn a courier for this player at the given position. ])
-- @return handle
-- @param vLocation Vector
function CDOTAPlayer:SpawnCourierAtPosition( vLocation ) end

---[[ CDOTATutorial:AddBot  Add a computer controlled bot. ])
-- @return bool
-- @param string_1 string
-- @param string_2 string
-- @param string_3 string
-- @param bool_4 bool
function CDOTATutorial:AddBot( string_1, string_2, string_3, bool_4 ) end

---[[ CDOTATutorial:AddQuest  Add a quest to the quest log ])
-- @return void
-- @param string_1 string
-- @param int_2 int
-- @param string_3 string
-- @param string_4 string
function CDOTATutorial:AddQuest( string_1, int_2, string_3, string_4 ) end

---[[ CDOTATutorial:AddShopWhitelistItem  Add an item to the shop whitelist. ])
-- @return void
-- @param string_1 string
function CDOTATutorial:AddShopWhitelistItem( string_1 ) end

---[[ CDOTATutorial:CompleteQuest  Complete a quest, ])
-- @return void
-- @param string_1 string
function CDOTATutorial:CompleteQuest( string_1 ) end

---[[ CDOTATutorial:CreateLocationTask  Add a task to move to a specific location ])
-- @return void
-- @param Vector_1 Vector
function CDOTATutorial:CreateLocationTask( Vector_1 ) end

---[[ CDOTATutorial:EnableCreepAggroViz  Alert the player when a creep becomes agro to their hero. ])
-- @return void
-- @param bool_1 bool
function CDOTATutorial:EnableCreepAggroViz( bool_1 ) end

---[[ CDOTATutorial:EnablePlayerOffscreenTip  Enable the tip to alert players how to find their hero. ])
-- @return void
-- @param bool_1 bool
function CDOTATutorial:EnablePlayerOffscreenTip( bool_1 ) end

---[[ CDOTATutorial:EnableTowerAggroViz  Alert the player when a tower becomes agro to their hero. ])
-- @return void
-- @param bool_1 bool
function CDOTATutorial:EnableTowerAggroViz( bool_1 ) end

---[[ CDOTATutorial:FinishTutorial  End the tutorial. ])
-- @return void
function CDOTATutorial:FinishTutorial(  ) end

---[[ CDOTATutorial:ForceGameStart  Force the start of the game. ])
-- @return void
function CDOTATutorial:ForceGameStart(  ) end

---[[ CDOTATutorial:GetTimeFrozen  Is our time frozen? ])
-- @return bool
function CDOTATutorial:GetTimeFrozen(  ) end

---[[ CDOTATutorial:IsItemInWhiteList  Is this item currently in the white list. ])
-- @return bool
-- @param string_1 string
function CDOTATutorial:IsItemInWhiteList( string_1 ) end

---[[ CDOTATutorial:RemoveShopWhitelistItem  Remove an item from the shop whitelist. ])
-- @return void
-- @param string_1 string
function CDOTATutorial:RemoveShopWhitelistItem( string_1 ) end

---[[ CDOTATutorial:SelectHero  Select a hero for the local player ])
-- @return void
-- @param string_1 string
function CDOTATutorial:SelectHero( string_1 ) end

---[[ CDOTATutorial:SelectPlayerTeam  Select the team for the local player ])
-- @return void
-- @param string_1 string
function CDOTATutorial:SelectPlayerTeam( string_1 ) end

---[[ CDOTATutorial:SetItemGuide  Set the current item guide. ])
-- @return void
-- @param string_1 string
function CDOTATutorial:SetItemGuide( string_1 ) end

---[[ CDOTATutorial:SetOrModifyPlayerGold  Set gold amount for the tutorial player. (int) GoldAmount, (bool) true=Set, false=Modify ])
-- @return void
-- @param int_1 int
-- @param bool_2 bool
function CDOTATutorial:SetOrModifyPlayerGold( int_1, bool_2 ) end

---[[ CDOTATutorial:SetQuickBuy  Set players quick buy item. ])
-- @return void
-- @param string_1 string
function CDOTATutorial:SetQuickBuy( string_1 ) end

---[[ CDOTATutorial:SetShopOpen  Set the shop open or closed. ])
-- @return void
-- @param bool_1 bool
function CDOTATutorial:SetShopOpen( bool_1 ) end

---[[ CDOTATutorial:SetTimeFrozen  Set if we should freeze time or not. ])
-- @return void
-- @param bool_1 bool
function CDOTATutorial:SetTimeFrozen( bool_1 ) end

---[[ CDOTATutorial:SetTutorialConvar  Set a tutorial convar ])
-- @return void
-- @param string_1 string
-- @param string_2 string
function CDOTATutorial:SetTutorialConvar( string_1, string_2 ) end

---[[ CDOTATutorial:SetTutorialUI  Set the UI to use a reduced version to focus attention to specific elements. ])
-- @return void
-- @param int_1 int
function CDOTATutorial:SetTutorialUI( int_1 ) end

---[[ CDOTATutorial:SetWhiteListEnabled  Set if we should whitelist shop items. ])
-- @return void
-- @param bool_1 bool
function CDOTATutorial:SetWhiteListEnabled( bool_1 ) end

---[[ CDOTATutorial:StartTutorialMode  Initialize Tutorial Mode ])
-- @return void
function CDOTATutorial:StartTutorialMode(  ) end

---[[ CDOTATutorial:UpgradePlayerAbility  Upgrade a specific ability for the local hero ])
-- @return void
-- @param string_1 string
function CDOTATutorial:UpgradePlayerAbility( string_1 ) end

---[[ CDOTAVoteSystem:StartVote  Starts a vote, based upon a table of parameters ])
-- @return void
-- @param handle_1 handle
function CDOTAVoteSystem:StartVote( handle_1 ) end

---[[ CDOTA_Ability_Aghanim_Spear:LaunchSpear  Launch Spear to a target position from a source position ])
-- @return void
-- @param vTarget Vector
-- @param vStart Vector
function CDOTA_Ability_Aghanim_Spear:LaunchSpear( vTarget, vStart ) end

---[[ CDOTA_Ability_Animation_Attack:SetPlaybackRate  Override playbackrate ])
-- @return void
-- @param flRate float
function CDOTA_Ability_Animation_Attack:SetPlaybackRate( flRate ) end

---[[ CDOTA_Ability_Animation_TailSpin:SetPlaybackRate  Override playbackrate ])
-- @return void
-- @param flRate float
function CDOTA_Ability_Animation_TailSpin:SetPlaybackRate( flRate ) end

---[[ CDOTA_Ability_DataDriven:ApplyDataDrivenModifier  Applies a data driven modifier to the target ])
-- @return handle
-- @param hCaster handle
-- @param hTarget handle
-- @param pszModifierName string
-- @param hModifierTable handle
function CDOTA_Ability_DataDriven:ApplyDataDrivenModifier( hCaster, hTarget, pszModifierName, hModifierTable ) end

---[[ CDOTA_Ability_DataDriven:ApplyDataDrivenThinker  Applies a data driven thinker at the location ])
-- @return handle
-- @param hCaster handle
-- @param vLocation Vector
-- @param pszModifierName string
-- @param hModifierTable handle
function CDOTA_Ability_DataDriven:ApplyDataDrivenThinker( hCaster, vLocation, pszModifierName, hModifierTable ) end

---[[ CDOTA_Ability_Lua:CastFilterResult  Determine whether an issued command with no target is valid. ])
-- @return int
function CDOTA_Ability_Lua:CastFilterResult(  ) end

---[[ CDOTA_Ability_Lua:CastFilterResultLocation  (Vector vLocation) Determine whether an issued command on a location is valid. ])
-- @return int
-- @param vLocation Vector
function CDOTA_Ability_Lua:CastFilterResultLocation( vLocation ) end

---[[ CDOTA_Ability_Lua:CastFilterResultTarget  (HSCRIPT hTarget) Determine whether an issued command on a target is valid. ])
-- @return int
-- @param hTarget handle
function CDOTA_Ability_Lua:CastFilterResultTarget( hTarget ) end

---[[ CDOTA_Ability_Lua:GetAOERadius  Controls the size of the AOE casting cursor. ])
-- @return float
function CDOTA_Ability_Lua:GetAOERadius(  ) end

---[[ CDOTA_Ability_Lua:GetAssociatedPrimaryAbilities  Returns abilities that are stolen simultaneously, or otherwise related in functionality. ])
-- @return string
function CDOTA_Ability_Lua:GetAssociatedPrimaryAbilities(  ) end

---[[ CDOTA_Ability_Lua:GetAssociatedSecondaryAbilities  Returns other abilities that are stolen simultaneously, or otherwise related in functionality.  Generally hidden abilities. ])
-- @return string
function CDOTA_Ability_Lua:GetAssociatedSecondaryAbilities(  ) end

---[[ CDOTA_Ability_Lua:GetBehavior  Return cast behavior type of this ability. ])
-- @return uint64
function CDOTA_Ability_Lua:GetBehavior(  ) end

---[[ CDOTA_Ability_Lua:GetCastAnimation  Return casting animation of this ability. ])
-- @return int
function CDOTA_Ability_Lua:GetCastAnimation(  ) end

---[[ CDOTA_Ability_Lua:GetCastPoint  Return cast point of this ability. ])
-- @return float
function CDOTA_Ability_Lua:GetCastPoint(  ) end

---[[ CDOTA_Ability_Lua:GetCastRange  Return cast range of this ability. ])
-- @return int
-- @param vLocation Vector
-- @param hTarget handle
function CDOTA_Ability_Lua:GetCastRange( vLocation, hTarget ) end

---[[ CDOTA_Ability_Lua:GetCastRangeBonus   ])
-- @return int
-- @param hTarget handle
function CDOTA_Ability_Lua:GetCastRangeBonus( hTarget ) end

---[[ CDOTA_Ability_Lua:GetChannelAnimation  Return channel animation of this ability. ])
-- @return int
function CDOTA_Ability_Lua:GetChannelAnimation(  ) end

---[[ CDOTA_Ability_Lua:GetChannelTime  Return the channel time of this ability. ])
-- @return float
function CDOTA_Ability_Lua:GetChannelTime(  ) end

---[[ CDOTA_Ability_Lua:GetChannelledManaCostPerSecond  Return mana cost at the given level per second while channeling (-1 is current). ])
-- @return int
-- @param iLevel int
function CDOTA_Ability_Lua:GetChannelledManaCostPerSecond( iLevel ) end

---[[ CDOTA_Ability_Lua:GetConceptRecipientType  Return who hears speech when this spell is cast. ])
-- @return int
function CDOTA_Ability_Lua:GetConceptRecipientType(  ) end

---[[ CDOTA_Ability_Lua:GetCooldown  Return cooldown of this ability. ])
-- @return float
-- @param iLevel int
function CDOTA_Ability_Lua:GetCooldown( iLevel ) end

---[[ CDOTA_Ability_Lua:GetCustomCastError  Return the error string of a failed command with no target. ])
-- @return string
function CDOTA_Ability_Lua:GetCustomCastError(  ) end

---[[ CDOTA_Ability_Lua:GetCustomCastErrorLocation  (Vector vLocation) Return the error string of a failed command on a location. ])
-- @return string
-- @param vLocation Vector
function CDOTA_Ability_Lua:GetCustomCastErrorLocation( vLocation ) end

---[[ CDOTA_Ability_Lua:GetCustomCastErrorTarget  (HSCRIPT hTarget) Return the error string of a failed command on a target. ])
-- @return string
-- @param hTarget handle
function CDOTA_Ability_Lua:GetCustomCastErrorTarget( hTarget ) end

---[[ CDOTA_Ability_Lua:GetEffectiveCastRange  Return cast range of this ability, accounting for modifiers. ])
-- @return int
-- @param vLocation Vector
-- @param hTarget handle
function CDOTA_Ability_Lua:GetEffectiveCastRange( vLocation, hTarget ) end

---[[ CDOTA_Ability_Lua:GetGoldCost  Return gold cost at the given level (-1 is current). ])
-- @return int
-- @param iLevel int
function CDOTA_Ability_Lua:GetGoldCost( iLevel ) end

---[[ CDOTA_Ability_Lua:GetIntrinsicModifierName  Returns the name of the modifier applied passively by this ability. ])
-- @return string
function CDOTA_Ability_Lua:GetIntrinsicModifierName(  ) end

---[[ CDOTA_Ability_Lua:GetManaCost  Return mana cost at the given level (-1 is current). ])
-- @return int
-- @param iLevel int
function CDOTA_Ability_Lua:GetManaCost( iLevel ) end

---[[ CDOTA_Ability_Lua:GetPlaybackRateOverride  Return the animation rate of the cast animation. ])
-- @return float
function CDOTA_Ability_Lua:GetPlaybackRateOverride(  ) end

---[[ CDOTA_Ability_Lua:IsCosmetic  Is this a cosmetic only ability? ])
-- @return bool
-- @param hEntity handle
function CDOTA_Ability_Lua:IsCosmetic( hEntity ) end

---[[ CDOTA_Ability_Lua:IsHiddenAbilityCastable  Returns true if this ability can be used when not on the action panel. ])
-- @return bool
function CDOTA_Ability_Lua:IsHiddenAbilityCastable(  ) end

---[[ CDOTA_Ability_Lua:IsHiddenWhenStolen  Returns true if this ability is hidden when stolen by Spell Steal. ])
-- @return bool
function CDOTA_Ability_Lua:IsHiddenWhenStolen(  ) end

---[[ CDOTA_Ability_Lua:IsRefreshable  Returns true if this ability is refreshed by Refresher Orb. ])
-- @return bool
function CDOTA_Ability_Lua:IsRefreshable(  ) end

---[[ CDOTA_Ability_Lua:IsStealable  Returns true if this ability can be stolen by Spell Steal. ])
-- @return bool
function CDOTA_Ability_Lua:IsStealable(  ) end

---[[ CDOTA_Ability_Lua:OnAbilityPhaseInterrupted  Cast time did not complete successfully. ])
-- @return void
function CDOTA_Ability_Lua:OnAbilityPhaseInterrupted(  ) end

---[[ CDOTA_Ability_Lua:OnAbilityPhaseStart  Cast time begins (return true for successful cast). ])
-- @return bool
function CDOTA_Ability_Lua:OnAbilityPhaseStart(  ) end

---[[ CDOTA_Ability_Lua:OnAbilityPinged  The ability was pinged (nPlayerID, bCtrlHeld). ])
-- @return void
-- @param nPlayerID int
-- @param bCtrlHeld bool
function CDOTA_Ability_Lua:OnAbilityPinged( nPlayerID, bCtrlHeld ) end

---[[ CDOTA_Ability_Lua:OnChannelFinish  (bool bInterrupted) Channel finished. ])
-- @return void
-- @param bInterrupted bool
function CDOTA_Ability_Lua:OnChannelFinish( bInterrupted ) end

---[[ CDOTA_Ability_Lua:OnChannelThink  (float flInterval) Channeling is taking place. ])
-- @return void
-- @param flInterval float
function CDOTA_Ability_Lua:OnChannelThink( flInterval ) end

---[[ CDOTA_Ability_Lua:OnHeroCalculateStatBonus  Caster (hero only) gained a level, skilled an ability, or received a new stat bonus. ])
-- @return void
function CDOTA_Ability_Lua:OnHeroCalculateStatBonus(  ) end

---[[ CDOTA_Ability_Lua:OnHeroDiedNearby  A hero has died in the vicinity (ie Urn), takes table of params. ])
-- @return void
-- @param unit handle
-- @param attacker handle
-- @param table handle
function CDOTA_Ability_Lua:OnHeroDiedNearby( unit, attacker, table ) end

---[[ CDOTA_Ability_Lua:OnHeroLevelUp  Caster gained a level. ])
-- @return void
function CDOTA_Ability_Lua:OnHeroLevelUp(  ) end

---[[ CDOTA_Ability_Lua:OnInventoryContentsChanged  Caster inventory changed. ])
-- @return void
function CDOTA_Ability_Lua:OnInventoryContentsChanged(  ) end

---[[ CDOTA_Ability_Lua:OnItemEquipped  ( HSCRIPT hItem ) Caster equipped item. ])
-- @return void
-- @param hItem handle
function CDOTA_Ability_Lua:OnItemEquipped( hItem ) end

---[[ CDOTA_Ability_Lua:OnOwnerDied  Caster died. ])
-- @return void
function CDOTA_Ability_Lua:OnOwnerDied(  ) end

---[[ CDOTA_Ability_Lua:OnOwnerSpawned  Caster respawned or spawned for the first time. ])
-- @return void
function CDOTA_Ability_Lua:OnOwnerSpawned(  ) end

---[[ CDOTA_Ability_Lua:OnProjectileHit  (HSCRIPT hTarget, Vector vLocation) Projectile has collided with a given target or reached its destination (target is invalid). ])
-- @return bool
-- @param hTarget handle
-- @param vLocation Vector
function CDOTA_Ability_Lua:OnProjectileHit( hTarget, vLocation ) end

---[[ CDOTA_Ability_Lua:OnProjectileHitHandle  (HSCRIPT hTarget, Vector vLocation, int nHandle) Projectile has collided with a given target or reached its destination (target is invalid). ])
-- @return bool
-- @param hTarget handle
-- @param vLocation Vector
-- @param iProjectileHandle int
function CDOTA_Ability_Lua:OnProjectileHitHandle( hTarget, vLocation, iProjectileHandle ) end

---[[ CDOTA_Ability_Lua:OnProjectileHit_ExtraData  (HSCRIPT hTarget, Vector vLocation, table kv) Projectile has collided with a given target or reached its destination (target is invalid). ])
-- @return bool
-- @param hTarget handle
-- @param vLocation Vector
-- @param table handle
function CDOTA_Ability_Lua:OnProjectileHit_ExtraData( hTarget, vLocation, table ) end

---[[ CDOTA_Ability_Lua:OnProjectileThink  (Vector vLocation) Projectile is actively moving. ])
-- @return void
-- @param vLocation Vector
function CDOTA_Ability_Lua:OnProjectileThink( vLocation ) end

---[[ CDOTA_Ability_Lua:OnProjectileThinkHandle  (int nProjectileHandle) Projectile is actively moving. ])
-- @return void
-- @param iProjectileHandle int
function CDOTA_Ability_Lua:OnProjectileThinkHandle( iProjectileHandle ) end

---[[ CDOTA_Ability_Lua:OnProjectileThink_ExtraData  (Vector vLocation, table kv ) Projectile is actively moving. ])
-- @return void
-- @param vLocation Vector
-- @param table handle
function CDOTA_Ability_Lua:OnProjectileThink_ExtraData( vLocation, table ) end

---[[ CDOTA_Ability_Lua:OnSpellStart  Cast time finished, spell effects begin. ])
-- @return void
function CDOTA_Ability_Lua:OnSpellStart(  ) end

---[[ CDOTA_Ability_Lua:OnStolen  ( HSCRIPT hAbility ) Special behavior when stolen by Spell Steal. ])
-- @return void
-- @param hSourceAbility handle
function CDOTA_Ability_Lua:OnStolen( hSourceAbility ) end

---[[ CDOTA_Ability_Lua:OnToggle  Ability is toggled on/off. ])
-- @return void
function CDOTA_Ability_Lua:OnToggle(  ) end

---[[ CDOTA_Ability_Lua:OnUnStolen  Special behavior when lost by Spell Steal. ])
-- @return void
function CDOTA_Ability_Lua:OnUnStolen(  ) end

---[[ CDOTA_Ability_Lua:OnUpgrade  Ability gained a level. ])
-- @return void
function CDOTA_Ability_Lua:OnUpgrade(  ) end

---[[ CDOTA_Ability_Lua:OtherAbilitiesAlwaysInterruptChanneling   ])
-- @return bool
function CDOTA_Ability_Lua:OtherAbilitiesAlwaysInterruptChanneling(  ) end

---[[ CDOTA_Ability_Lua:ProcsMagicStick  Returns true if this ability will generate magic stick charges for nearby enemies. ])
-- @return bool
function CDOTA_Ability_Lua:ProcsMagicStick(  ) end

---[[ CDOTA_Ability_Lua:RequiresFacing  Does this ability need the caster to face the target before executing? ])
-- @return bool
function CDOTA_Ability_Lua:RequiresFacing(  ) end

---[[ CDOTA_Ability_Lua:ResetToggleOnRespawn  Returns true if this ability should return to the default toggle state when its parent respawns. ])
-- @return bool
function CDOTA_Ability_Lua:ResetToggleOnRespawn(  ) end

---[[ CDOTA_Ability_Lua:SpeakTrigger  Return the type of speech used. ])
-- @return int
function CDOTA_Ability_Lua:SpeakTrigger(  ) end

---[[ CDOTA_Ability_Nian_Dive:SetPlaybackRate  Override playbackrate ])
-- @return void
-- @param flRate float
function CDOTA_Ability_Nian_Dive:SetPlaybackRate( flRate ) end

---[[ CDOTA_Ability_Nian_Leap:SetPlaybackRate  Override playbackrate ])
-- @return void
-- @param flRate float
function CDOTA_Ability_Nian_Leap:SetPlaybackRate( flRate ) end

---[[ CDOTA_Ability_Nian_Roar:GetCastCount  Number of times Nian has used the roar ])
-- @return int
function CDOTA_Ability_Nian_Roar:GetCastCount(  ) end

---[[ CDOTA_BaseNPC:AddAbility  Add an ability to this unit by name. ])
-- @return handle
-- @param pszAbilityName string
function CDOTA_BaseNPC:AddAbility( pszAbilityName ) end

---[[ CDOTA_BaseNPC:AddActivityModifier  Add an activity modifier that affects future StartGesture calls ])
-- @return void
-- @param szName string
function CDOTA_BaseNPC:AddActivityModifier( szName ) end

---[[ CDOTA_BaseNPC:AddItem  Add an item to this unit's inventory. ])
-- @return handle
-- @param hItem handle
function CDOTA_BaseNPC:AddItem( hItem ) end

---[[ CDOTA_BaseNPC:AddItemByName  Add an item to this unit's inventory. ])
-- @return handle
-- @param pszItemName string
function CDOTA_BaseNPC:AddItemByName( pszItemName ) end

---[[ CDOTA_BaseNPC:AddNewModifier  Add a modifier to this unit. ])
-- @return handle
-- @param hCaster handle
-- @param hAbility handle
-- @param pszScriptName string
-- @param hModifierTable handle
function CDOTA_BaseNPC:AddNewModifier( hCaster, hAbility, pszScriptName, hModifierTable ) end

---[[ CDOTA_BaseNPC:AddNoDraw  Adds the no draw flag. ])
-- @return void
function CDOTA_BaseNPC:AddNoDraw(  ) end

---[[ CDOTA_BaseNPC:AddSpeechBubble  Add a speech bubble(1-4 live at a time) to this NPC. ])
-- @return void
-- @param iBubble int
-- @param pszSpeech string
-- @param flDuration float
-- @param unOffsetX unsigned
-- @param unOffsetY unsigned
function CDOTA_BaseNPC:AddSpeechBubble( iBubble, pszSpeech, flDuration, unOffsetX, unOffsetY ) end

---[[ CDOTA_BaseNPC:AlertNearbyUnits   ])
-- @return void
-- @param hAttacker handle
-- @param hAbility handle
function CDOTA_BaseNPC:AlertNearbyUnits( hAttacker, hAbility ) end

---[[ CDOTA_BaseNPC:AngerNearbyUnits   ])
-- @return void
function CDOTA_BaseNPC:AngerNearbyUnits(  ) end

---[[ CDOTA_BaseNPC:AttackNoEarlierThan   ])
-- @return void
-- @param flTime float
function CDOTA_BaseNPC:AttackNoEarlierThan( flTime ) end

---[[ CDOTA_BaseNPC:AttackReady   ])
-- @return bool
function CDOTA_BaseNPC:AttackReady(  ) end

---[[ CDOTA_BaseNPC:BoundingRadius2D   ])
-- @return float
function CDOTA_BaseNPC:BoundingRadius2D(  ) end

---[[ CDOTA_BaseNPC:CalculateGenericBonuses   ])
-- @return void
function CDOTA_BaseNPC:CalculateGenericBonuses(  ) end

---[[ CDOTA_BaseNPC:CanEntityBeSeenByMyTeam  Check FoW to see if an entity is visible. ])
-- @return bool
-- @param hEntity handle
function CDOTA_BaseNPC:CanEntityBeSeenByMyTeam( hEntity ) end

---[[ CDOTA_BaseNPC:CanSellItems  Query if this unit can sell items. ])
-- @return bool
function CDOTA_BaseNPC:CanSellItems(  ) end

---[[ CDOTA_BaseNPC:CastAbilityImmediately  Cast an ability immediately. ])
-- @return void
-- @param hAbility handle
-- @param iPlayerIndex int
function CDOTA_BaseNPC:CastAbilityImmediately( hAbility, iPlayerIndex ) end

---[[ CDOTA_BaseNPC:CastAbilityNoTarget  Cast an ability with no target. ])
-- @return void
-- @param hAbility handle
-- @param iPlayerIndex int
function CDOTA_BaseNPC:CastAbilityNoTarget( hAbility, iPlayerIndex ) end

---[[ CDOTA_BaseNPC:CastAbilityOnPosition  Cast an ability on a position. ])
-- @return void
-- @param vPosition Vector
-- @param hAbility handle
-- @param iPlayerIndex int
function CDOTA_BaseNPC:CastAbilityOnPosition( vPosition, hAbility, iPlayerIndex ) end

---[[ CDOTA_BaseNPC:CastAbilityOnTarget  Cast an ability on a target entity. ])
-- @return void
-- @param hTarget handle
-- @param hAbility handle
-- @param iPlayerIndex int
function CDOTA_BaseNPC:CastAbilityOnTarget( hTarget, hAbility, iPlayerIndex ) end

---[[ CDOTA_BaseNPC:CastAbilityToggle  Toggle an ability. ])
-- @return void
-- @param hAbility handle
-- @param iPlayerIndex int
function CDOTA_BaseNPC:CastAbilityToggle( hAbility, iPlayerIndex ) end

---[[ CDOTA_BaseNPC:ChangeTeam   ])
-- @return void
-- @param iTeamNum int
function CDOTA_BaseNPC:ChangeTeam( iTeamNum ) end

---[[ CDOTA_BaseNPC:ClearActivityModifiers  Clear Activity modifiers ])
-- @return void
function CDOTA_BaseNPC:ClearActivityModifiers(  ) end

---[[ CDOTA_BaseNPC:DestroyAllSpeechBubbles   ])
-- @return void
function CDOTA_BaseNPC:DestroyAllSpeechBubbles(  ) end

---[[ CDOTA_BaseNPC:DisassembleItem  Disassemble the passed item in this unit's inventory. ])
-- @return void
-- @param hItem handle
function CDOTA_BaseNPC:DisassembleItem( hItem ) end

---[[ CDOTA_BaseNPC:DropItemAtPosition  Drop an item at a given point. ])
-- @return void
-- @param vDest Vector
-- @param hItem handle
function CDOTA_BaseNPC:DropItemAtPosition( vDest, hItem ) end

---[[ CDOTA_BaseNPC:DropItemAtPositionImmediate  Immediately drop a carried item at a given position. ])
-- @return void
-- @param hItem handle
-- @param vPosition Vector
function CDOTA_BaseNPC:DropItemAtPositionImmediate( hItem, vPosition ) end

---[[ CDOTA_BaseNPC:EjectItemFromStash  Drops the selected item out of this unit's stash. ])
-- @return void
-- @param hItem handle
function CDOTA_BaseNPC:EjectItemFromStash( hItem ) end

---[[ CDOTA_BaseNPC:FaceTowards  This unit will be set to face the target point. ])
-- @return void
-- @param vTarget Vector
function CDOTA_BaseNPC:FaceTowards( vTarget ) end

---[[ CDOTA_BaseNPC:FadeGesture  Fade and remove the given gesture activity. ])
-- @return void
-- @param nActivity int
function CDOTA_BaseNPC:FadeGesture( nActivity ) end

---[[ CDOTA_BaseNPC:FindAbilityByName  Retrieve an ability by name from the unit. ])
-- @return handle
-- @param pAbilityName string
function CDOTA_BaseNPC:FindAbilityByName( pAbilityName ) end

---[[ CDOTA_BaseNPC:FindAllModifiers  Returns a table of all of the modifiers on the NPC. ])
-- @return table
function CDOTA_BaseNPC:FindAllModifiers(  ) end

---[[ CDOTA_BaseNPC:FindAllModifiersByName  Returns a table of all of the modifiers on the NPC with the passed name (modifierName) ])
-- @return table
-- @param pszScriptName string
function CDOTA_BaseNPC:FindAllModifiersByName( pszScriptName ) end

---[[ CDOTA_BaseNPC:FindItemInInventory  Get handle to first item in inventory, else nil. ])
-- @return handle
-- @param pszItemName string
function CDOTA_BaseNPC:FindItemInInventory( pszItemName ) end

---[[ CDOTA_BaseNPC:FindModifierByName  Return a handle to the modifier of the given name if found, else nil (string Name ) ])
-- @return handle
-- @param pszScriptName string
function CDOTA_BaseNPC:FindModifierByName( pszScriptName ) end

---[[ CDOTA_BaseNPC:FindModifierByNameAndCaster  Return a handle to the modifier of the given name from the passed caster if found, else nil ( string Name, hCaster ) ])
-- @return handle
-- @param pszScriptName string
-- @param hCaster handle
function CDOTA_BaseNPC:FindModifierByNameAndCaster( pszScriptName, hCaster ) end

---[[ CDOTA_BaseNPC:ForceKill  Kill this unit immediately. ])
-- @return void
-- @param bReincarnate bool
function CDOTA_BaseNPC:ForceKill( bReincarnate ) end

---[[ CDOTA_BaseNPC:ForcePlayActivityOnce  Play an activity once, and then go back to idle. ])
-- @return void
-- @param nActivity int
function CDOTA_BaseNPC:ForcePlayActivityOnce( nActivity ) end

---[[ CDOTA_BaseNPC:GetAbilityByIndex  Retrieve an ability by index from the unit. ])
-- @return handle
-- @param iIndex int
function CDOTA_BaseNPC:GetAbilityByIndex( iIndex ) end

---[[ CDOTA_BaseNPC:GetAbilityCount   ])
-- @return int
function CDOTA_BaseNPC:GetAbilityCount(  ) end

---[[ CDOTA_BaseNPC:GetAcquisitionRange  Gets the range at which this unit will auto-acquire. ])
-- @return float
function CDOTA_BaseNPC:GetAcquisitionRange(  ) end

---[[ CDOTA_BaseNPC:GetAdditionalBattleMusicWeight  Combat involving this creature will have this weight added to the music calcuations. ])
-- @return float
function CDOTA_BaseNPC:GetAdditionalBattleMusicWeight(  ) end

---[[ CDOTA_BaseNPC:GetAggroTarget  Returns this unit's aggro target. ])
-- @return handle
function CDOTA_BaseNPC:GetAggroTarget(  ) end

---[[ CDOTA_BaseNPC:GetAttackAnimationPoint   ])
-- @return float
function CDOTA_BaseNPC:GetAttackAnimationPoint(  ) end

---[[ CDOTA_BaseNPC:GetAttackCapability   ])
-- @return int
function CDOTA_BaseNPC:GetAttackCapability(  ) end

---[[ CDOTA_BaseNPC:GetAttackDamage  Returns a random integer between the minimum and maximum base damage of the unit. ])
-- @return int
function CDOTA_BaseNPC:GetAttackDamage(  ) end

---[[ CDOTA_BaseNPC:GetAttackRangeBuffer  Gets the attack range buffer. ])
-- @return float
function CDOTA_BaseNPC:GetAttackRangeBuffer(  ) end

---[[ CDOTA_BaseNPC:GetAttackSpeed   ])
-- @return float
function CDOTA_BaseNPC:GetAttackSpeed(  ) end

---[[ CDOTA_BaseNPC:GetAttackTarget   ])
-- @return handle
function CDOTA_BaseNPC:GetAttackTarget(  ) end

---[[ CDOTA_BaseNPC:GetAttacksPerSecond   ])
-- @return float
function CDOTA_BaseNPC:GetAttacksPerSecond(  ) end

---[[ CDOTA_BaseNPC:GetAverageTrueAttackDamage  Returns the average value of the minimum and maximum damage values. ])
-- @return int
-- @param hTarget handle
function CDOTA_BaseNPC:GetAverageTrueAttackDamage( hTarget ) end

---[[ CDOTA_BaseNPC:GetBaseAttackRange   ])
-- @return int
function CDOTA_BaseNPC:GetBaseAttackRange(  ) end

---[[ CDOTA_BaseNPC:GetBaseAttackTime   ])
-- @return float
function CDOTA_BaseNPC:GetBaseAttackTime(  ) end

---[[ CDOTA_BaseNPC:GetBaseDamageMax  Get the maximum attack damage of this unit. ])
-- @return int
function CDOTA_BaseNPC:GetBaseDamageMax(  ) end

---[[ CDOTA_BaseNPC:GetBaseDamageMin  Get the minimum attack damage of this unit. ])
-- @return int
function CDOTA_BaseNPC:GetBaseDamageMin(  ) end

---[[ CDOTA_BaseNPC:GetBaseDayTimeVisionRange  Returns the vision range before modifiers. ])
-- @return int
function CDOTA_BaseNPC:GetBaseDayTimeVisionRange(  ) end

---[[ CDOTA_BaseNPC:GetBaseHealthBarOffset   ])
-- @return int
function CDOTA_BaseNPC:GetBaseHealthBarOffset(  ) end

---[[ CDOTA_BaseNPC:GetBaseHealthRegen   ])
-- @return float
function CDOTA_BaseNPC:GetBaseHealthRegen(  ) end

---[[ CDOTA_BaseNPC:GetBaseMagicalResistanceValue  Returns base magical armor value. ])
-- @return float
function CDOTA_BaseNPC:GetBaseMagicalResistanceValue(  ) end

---[[ CDOTA_BaseNPC:GetBaseMaxHealth  Gets the base max health value. ])
-- @return float
function CDOTA_BaseNPC:GetBaseMaxHealth(  ) end

---[[ CDOTA_BaseNPC:GetBaseMoveSpeed   ])
-- @return float
function CDOTA_BaseNPC:GetBaseMoveSpeed(  ) end

---[[ CDOTA_BaseNPC:GetBaseNightTimeVisionRange  Returns the vision range after modifiers. ])
-- @return int
function CDOTA_BaseNPC:GetBaseNightTimeVisionRange(  ) end

---[[ CDOTA_BaseNPC:GetBonusManaRegen  This Mana regen is derived from constant bonuses like Basilius. ])
-- @return float
function CDOTA_BaseNPC:GetBonusManaRegen(  ) end

---[[ CDOTA_BaseNPC:GetCastPoint   ])
-- @return float
-- @param bAttack bool
function CDOTA_BaseNPC:GetCastPoint( bAttack ) end

---[[ CDOTA_BaseNPC:GetCastRangeBonus   ])
-- @return float
function CDOTA_BaseNPC:GetCastRangeBonus(  ) end

---[[ CDOTA_BaseNPC:GetCloneSource  Get clone source (Meepo Prime, if this is a Meepo) ])
-- @return handle
function CDOTA_BaseNPC:GetCloneSource(  ) end

---[[ CDOTA_BaseNPC:GetCollisionPadding  Returns the size of the collision padding around the hull. ])
-- @return float
function CDOTA_BaseNPC:GetCollisionPadding(  ) end

---[[ CDOTA_BaseNPC:GetCooldownReduction   ])
-- @return float
function CDOTA_BaseNPC:GetCooldownReduction(  ) end

---[[ CDOTA_BaseNPC:GetCreationTime   ])
-- @return float
function CDOTA_BaseNPC:GetCreationTime(  ) end

---[[ CDOTA_BaseNPC:GetCurrentActiveAbility  Get the ability this unit is currently casting. ])
-- @return handle
function CDOTA_BaseNPC:GetCurrentActiveAbility(  ) end

---[[ CDOTA_BaseNPC:GetCurrentVisionRange  Gets the current vision range. ])
-- @return int
function CDOTA_BaseNPC:GetCurrentVisionRange(  ) end

---[[ CDOTA_BaseNPC:GetCursorCastTarget   ])
-- @return handle
function CDOTA_BaseNPC:GetCursorCastTarget(  ) end

---[[ CDOTA_BaseNPC:GetCursorPosition   ])
-- @return Vector
function CDOTA_BaseNPC:GetCursorPosition(  ) end

---[[ CDOTA_BaseNPC:GetCursorTargetingNothing   ])
-- @return bool
function CDOTA_BaseNPC:GetCursorTargetingNothing(  ) end

---[[ CDOTA_BaseNPC:GetDamageMax  Get the maximum attack damage of this unit. ])
-- @return int
function CDOTA_BaseNPC:GetDamageMax(  ) end

---[[ CDOTA_BaseNPC:GetDamageMin  Get the minimum attack damage of this unit. ])
-- @return int
function CDOTA_BaseNPC:GetDamageMin(  ) end

---[[ CDOTA_BaseNPC:GetDayTimeVisionRange  Returns the vision range after modifiers. ])
-- @return int
function CDOTA_BaseNPC:GetDayTimeVisionRange(  ) end

---[[ CDOTA_BaseNPC:GetDeathXP  Get the XP bounty on this unit. ])
-- @return int
function CDOTA_BaseNPC:GetDeathXP(  ) end

---[[ CDOTA_BaseNPC:GetDisplayAttackSpeed  Attack speed expressed as constant value ])
-- @return float
function CDOTA_BaseNPC:GetDisplayAttackSpeed(  ) end

---[[ CDOTA_BaseNPC:GetEvasion   ])
-- @return float
function CDOTA_BaseNPC:GetEvasion(  ) end

---[[ CDOTA_BaseNPC:GetForceAttackTarget   ])
-- @return handle
function CDOTA_BaseNPC:GetForceAttackTarget(  ) end

---[[ CDOTA_BaseNPC:GetGoldBounty  Get the gold bounty on this unit. ])
-- @return int
function CDOTA_BaseNPC:GetGoldBounty(  ) end

---[[ CDOTA_BaseNPC:GetHasteFactor   ])
-- @return float
function CDOTA_BaseNPC:GetHasteFactor(  ) end

---[[ CDOTA_BaseNPC:GetHealthDeficit  Returns integer amount of health missing from max. ])
-- @return int
function CDOTA_BaseNPC:GetHealthDeficit(  ) end

---[[ CDOTA_BaseNPC:GetHealthPercent  Get the current health percent of the unit. ])
-- @return int
function CDOTA_BaseNPC:GetHealthPercent(  ) end

---[[ CDOTA_BaseNPC:GetHealthRegen   ])
-- @return float
function CDOTA_BaseNPC:GetHealthRegen(  ) end

---[[ CDOTA_BaseNPC:GetHullRadius  Get the collision hull radius of this NPC. ])
-- @return float
function CDOTA_BaseNPC:GetHullRadius(  ) end

---[[ CDOTA_BaseNPC:GetIdealSpeed  Returns speed after all modifiers. ])
-- @return float
function CDOTA_BaseNPC:GetIdealSpeed(  ) end

---[[ CDOTA_BaseNPC:GetIdealSpeedNoSlows  Returns speed after all modifiers, but excluding those that reduce speed. ])
-- @return float
function CDOTA_BaseNPC:GetIdealSpeedNoSlows(  ) end

---[[ CDOTA_BaseNPC:GetIncreasedAttackSpeed   ])
-- @return float
function CDOTA_BaseNPC:GetIncreasedAttackSpeed(  ) end

---[[ CDOTA_BaseNPC:GetInitialGoalEntity  Returns the initial waypoint goal for this NPC. ])
-- @return handle
function CDOTA_BaseNPC:GetInitialGoalEntity(  ) end

---[[ CDOTA_BaseNPC:GetInitialGoalPosition  Get waypoint position for this NPC. ])
-- @return Vector
function CDOTA_BaseNPC:GetInitialGoalPosition(  ) end

---[[ CDOTA_BaseNPC:GetItemInSlot  Returns nth item in inventory slot (index is zero based). ])
-- @return handle
-- @param i int
function CDOTA_BaseNPC:GetItemInSlot( i ) end

---[[ CDOTA_BaseNPC:GetLastAttackTime   ])
-- @return float
function CDOTA_BaseNPC:GetLastAttackTime(  ) end

---[[ CDOTA_BaseNPC:GetLastDamageTime  Get the last time this NPC took damage ])
-- @return float
function CDOTA_BaseNPC:GetLastDamageTime(  ) end

---[[ CDOTA_BaseNPC:GetLastIdleChangeTime  Get the last game time that this unit switched to/from idle state. ])
-- @return float
function CDOTA_BaseNPC:GetLastIdleChangeTime(  ) end

---[[ CDOTA_BaseNPC:GetLevel  Returns the level of this unit. ])
-- @return int
function CDOTA_BaseNPC:GetLevel(  ) end

---[[ CDOTA_BaseNPC:GetMagicalArmorValue  Returns current magical armor value. ])
-- @return float
function CDOTA_BaseNPC:GetMagicalArmorValue(  ) end

---[[ CDOTA_BaseNPC:GetMainControllingPlayer  Returns the player ID of the controlling player. ])
-- @return int
function CDOTA_BaseNPC:GetMainControllingPlayer(  ) end

---[[ CDOTA_BaseNPC:GetMana  Get the mana on this unit. ])
-- @return float
function CDOTA_BaseNPC:GetMana(  ) end

---[[ CDOTA_BaseNPC:GetManaPercent  Get the percent of mana remaining. ])
-- @return int
function CDOTA_BaseNPC:GetManaPercent(  ) end

---[[ CDOTA_BaseNPC:GetManaRegen   ])
-- @return float
function CDOTA_BaseNPC:GetManaRegen(  ) end

---[[ CDOTA_BaseNPC:GetMaxMana  Get the maximum mana of this unit. ])
-- @return float
function CDOTA_BaseNPC:GetMaxMana(  ) end

---[[ CDOTA_BaseNPC:GetMaximumGoldBounty  Get the maximum gold bounty for this unit. ])
-- @return int
function CDOTA_BaseNPC:GetMaximumGoldBounty(  ) end

---[[ CDOTA_BaseNPC:GetMinimumGoldBounty  Get the minimum gold bounty for this unit. ])
-- @return int
function CDOTA_BaseNPC:GetMinimumGoldBounty(  ) end

---[[ CDOTA_BaseNPC:GetModelRadius   ])
-- @return float
function CDOTA_BaseNPC:GetModelRadius(  ) end

---[[ CDOTA_BaseNPC:GetModifierCount  How many modifiers does this unit have? ])
-- @return int
function CDOTA_BaseNPC:GetModifierCount(  ) end

---[[ CDOTA_BaseNPC:GetModifierNameByIndex  Get a modifier name by index. ])
-- @return string
-- @param nIndex int
function CDOTA_BaseNPC:GetModifierNameByIndex( nIndex ) end

---[[ CDOTA_BaseNPC:GetModifierStackCount  Gets the stack count of a given modifier. ])
-- @return int
-- @param pszScriptName string
-- @param hCaster handle
function CDOTA_BaseNPC:GetModifierStackCount( pszScriptName, hCaster ) end

---[[ CDOTA_BaseNPC:GetMoveSpeedModifier   ])
-- @return float
-- @param flBaseSpeed float
-- @param bReturnUnslowed bool
function CDOTA_BaseNPC:GetMoveSpeedModifier( flBaseSpeed, bReturnUnslowed ) end

---[[ CDOTA_BaseNPC:GetMustReachEachGoalEntity  Set whether this NPC is required to reach each goal entity, rather than being allowed to unkink their path. ])
-- @return bool
function CDOTA_BaseNPC:GetMustReachEachGoalEntity(  ) end

---[[ CDOTA_BaseNPC:GetNeutralSpawnerName  Get the name of this camp's neutral spawner. ])
-- @return string
function CDOTA_BaseNPC:GetNeutralSpawnerName(  ) end

---[[ CDOTA_BaseNPC:GetNeverMoveToClearSpace  If set to true, we will never attempt to move this unit to clear space, even when it unphases. ])
-- @return bool
function CDOTA_BaseNPC:GetNeverMoveToClearSpace(  ) end

---[[ CDOTA_BaseNPC:GetNightTimeVisionRange  Returns the vision range after modifiers. ])
-- @return int
function CDOTA_BaseNPC:GetNightTimeVisionRange(  ) end

---[[ CDOTA_BaseNPC:GetOpposingTeamNumber   ])
-- @return int
function CDOTA_BaseNPC:GetOpposingTeamNumber(  ) end

---[[ CDOTA_BaseNPC:GetPaddedCollisionRadius  Get the collision hull radius (including padding) of this NPC. ])
-- @return float
function CDOTA_BaseNPC:GetPaddedCollisionRadius(  ) end

---[[ CDOTA_BaseNPC:GetPhysicalArmorBaseValue  Returns base physical armor value. ])
-- @return float
function CDOTA_BaseNPC:GetPhysicalArmorBaseValue(  ) end

---[[ CDOTA_BaseNPC:GetPhysicalArmorValue  Returns current physical armor value. ])
-- @return float
-- @param bIgnoreBase bool
function CDOTA_BaseNPC:GetPhysicalArmorValue( bIgnoreBase ) end

---[[ CDOTA_BaseNPC:GetPlayerOwner  Returns the player that owns this unit. ])
-- @return handle
function CDOTA_BaseNPC:GetPlayerOwner(  ) end

---[[ CDOTA_BaseNPC:GetPlayerOwnerID  Get the owner player ID for this unit. ])
-- @return int
function CDOTA_BaseNPC:GetPlayerOwnerID(  ) end

---[[ CDOTA_BaseNPC:GetProjectileSpeed   ])
-- @return int
function CDOTA_BaseNPC:GetProjectileSpeed(  ) end

---[[ CDOTA_BaseNPC:GetRangeToUnit   ])
-- @return float
-- @param hNPC handle
function CDOTA_BaseNPC:GetRangeToUnit( hNPC ) end

---[[ CDOTA_BaseNPC:GetRangedProjectileName   ])
-- @return string
function CDOTA_BaseNPC:GetRangedProjectileName(  ) end

---[[ CDOTA_BaseNPC:GetSecondsPerAttack   ])
-- @return float
function CDOTA_BaseNPC:GetSecondsPerAttack(  ) end

---[[ CDOTA_BaseNPC:GetSpellAmplification   ])
-- @return float
-- @param bBaseOnly bool
function CDOTA_BaseNPC:GetSpellAmplification( bBaseOnly ) end

---[[ CDOTA_BaseNPC:GetStatusResistance   ])
-- @return float
function CDOTA_BaseNPC:GetStatusResistance(  ) end

---[[ CDOTA_BaseNPC:GetTotalPurchasedUpgradeGoldCost  Get how much gold has been spent on ability upgrades. ])
-- @return int
function CDOTA_BaseNPC:GetTotalPurchasedUpgradeGoldCost(  ) end

---[[ CDOTA_BaseNPC:GetUnitLabel   ])
-- @return string
function CDOTA_BaseNPC:GetUnitLabel(  ) end

---[[ CDOTA_BaseNPC:GetUnitName  Get the name of this unit. ])
-- @return string
function CDOTA_BaseNPC:GetUnitName(  ) end

---[[ CDOTA_BaseNPC:GiveMana  Give mana to this unit, this can be used for mana gained by abilities or item usage. ])
-- @return void
-- @param flMana float
function CDOTA_BaseNPC:GiveMana( flMana ) end

---[[ CDOTA_BaseNPC:HasAbility  See whether this unit has an ability by name. ])
-- @return bool
-- @param pszAbilityName string
function CDOTA_BaseNPC:HasAbility( pszAbilityName ) end

---[[ CDOTA_BaseNPC:HasAnyActiveAbilities   ])
-- @return bool
function CDOTA_BaseNPC:HasAnyActiveAbilities(  ) end

---[[ CDOTA_BaseNPC:HasAttackCapability   ])
-- @return bool
function CDOTA_BaseNPC:HasAttackCapability(  ) end

---[[ CDOTA_BaseNPC:HasFlyMovementCapability   ])
-- @return bool
function CDOTA_BaseNPC:HasFlyMovementCapability(  ) end

---[[ CDOTA_BaseNPC:HasFlyingVision   ])
-- @return bool
function CDOTA_BaseNPC:HasFlyingVision(  ) end

---[[ CDOTA_BaseNPC:HasGroundMovementCapability   ])
-- @return bool
function CDOTA_BaseNPC:HasGroundMovementCapability(  ) end

---[[ CDOTA_BaseNPC:HasInventory  Does this unit have an inventory. ])
-- @return bool
function CDOTA_BaseNPC:HasInventory(  ) end

---[[ CDOTA_BaseNPC:HasItemInInventory  See whether this unit has an item by name. ])
-- @return bool
-- @param pItemName string
function CDOTA_BaseNPC:HasItemInInventory( pItemName ) end

---[[ CDOTA_BaseNPC:HasModifier  Sees if this unit has a given modifier. ])
-- @return bool
-- @param pszScriptName string
function CDOTA_BaseNPC:HasModifier( pszScriptName ) end

---[[ CDOTA_BaseNPC:HasMovementCapability   ])
-- @return bool
function CDOTA_BaseNPC:HasMovementCapability(  ) end

---[[ CDOTA_BaseNPC:HasScepter   ])
-- @return bool
function CDOTA_BaseNPC:HasScepter(  ) end

---[[ CDOTA_BaseNPC:Heal  Heal this unit. ])
-- @return void
-- @param flAmount float
-- @param hInflictor handle
function CDOTA_BaseNPC:Heal( flAmount, hInflictor ) end

---[[ CDOTA_BaseNPC:Hold  Hold position. ])
-- @return void
function CDOTA_BaseNPC:Hold(  ) end

---[[ CDOTA_BaseNPC:Interrupt   ])
-- @return void
function CDOTA_BaseNPC:Interrupt(  ) end

---[[ CDOTA_BaseNPC:InterruptChannel   ])
-- @return void
function CDOTA_BaseNPC:InterruptChannel(  ) end

---[[ CDOTA_BaseNPC:InterruptMotionControllers   ])
-- @return void
-- @param bFindClearSpace bool
function CDOTA_BaseNPC:InterruptMotionControllers( bFindClearSpace ) end

---[[ CDOTA_BaseNPC:IsAlive  Is this unit alive? ])
-- @return bool
function CDOTA_BaseNPC:IsAlive(  ) end

---[[ CDOTA_BaseNPC:IsAncient  Is this unit an Ancient? ])
-- @return bool
function CDOTA_BaseNPC:IsAncient(  ) end

---[[ CDOTA_BaseNPC:IsAttackImmune   ])
-- @return bool
function CDOTA_BaseNPC:IsAttackImmune(  ) end

---[[ CDOTA_BaseNPC:IsAttacking   ])
-- @return bool
function CDOTA_BaseNPC:IsAttacking(  ) end

---[[ CDOTA_BaseNPC:IsAttackingEntity   ])
-- @return bool
-- @param hEntity handle
function CDOTA_BaseNPC:IsAttackingEntity( hEntity ) end

---[[ CDOTA_BaseNPC:IsBarracks  Is this unit a Barracks? ])
-- @return bool
function CDOTA_BaseNPC:IsBarracks(  ) end

---[[ CDOTA_BaseNPC:IsBlind   ])
-- @return bool
function CDOTA_BaseNPC:IsBlind(  ) end

---[[ CDOTA_BaseNPC:IsBlockDisabled   ])
-- @return bool
function CDOTA_BaseNPC:IsBlockDisabled(  ) end

---[[ CDOTA_BaseNPC:IsBoss  Is this unit a boss? ])
-- @return bool
function CDOTA_BaseNPC:IsBoss(  ) end

---[[ CDOTA_BaseNPC:IsBuilding  Is this unit a building? ])
-- @return bool
function CDOTA_BaseNPC:IsBuilding(  ) end

---[[ CDOTA_BaseNPC:IsChanneling  Is this unit currently channeling a spell? ])
-- @return bool
function CDOTA_BaseNPC:IsChanneling(  ) end

---[[ CDOTA_BaseNPC:IsClone  Is this unit a clone? (Meepo) ])
-- @return bool
function CDOTA_BaseNPC:IsClone(  ) end

---[[ CDOTA_BaseNPC:IsCommandRestricted   ])
-- @return bool
function CDOTA_BaseNPC:IsCommandRestricted(  ) end

---[[ CDOTA_BaseNPC:IsConsideredHero  Is this unit a considered a hero for targeting purposes? ])
-- @return bool
function CDOTA_BaseNPC:IsConsideredHero(  ) end

---[[ CDOTA_BaseNPC:IsControllableByAnyPlayer  Is this unit controlled by any non-bot player? ])
-- @return bool
function CDOTA_BaseNPC:IsControllableByAnyPlayer(  ) end

---[[ CDOTA_BaseNPC:IsCourier  Is this unit a courier? ])
-- @return bool
function CDOTA_BaseNPC:IsCourier(  ) end

---[[ CDOTA_BaseNPC:IsCreature  Is this a Creature type NPC? ])
-- @return bool
function CDOTA_BaseNPC:IsCreature(  ) end

---[[ CDOTA_BaseNPC:IsCreep  Is this unit a creep? ])
-- @return bool
function CDOTA_BaseNPC:IsCreep(  ) end

---[[ CDOTA_BaseNPC:IsCreepHero  Is this unit a creep hero? ])
-- @return bool
function CDOTA_BaseNPC:IsCreepHero(  ) end

---[[ CDOTA_BaseNPC:IsCurrentlyHorizontalMotionControlled   ])
-- @return bool
function CDOTA_BaseNPC:IsCurrentlyHorizontalMotionControlled(  ) end

---[[ CDOTA_BaseNPC:IsCurrentlyVerticalMotionControlled   ])
-- @return bool
function CDOTA_BaseNPC:IsCurrentlyVerticalMotionControlled(  ) end

---[[ CDOTA_BaseNPC:IsDisarmed   ])
-- @return bool
function CDOTA_BaseNPC:IsDisarmed(  ) end

---[[ CDOTA_BaseNPC:IsDominated   ])
-- @return bool
function CDOTA_BaseNPC:IsDominated(  ) end

---[[ CDOTA_BaseNPC:IsEvadeDisabled   ])
-- @return bool
function CDOTA_BaseNPC:IsEvadeDisabled(  ) end

---[[ CDOTA_BaseNPC:IsFort  Is this unit an Ancient? ])
-- @return bool
function CDOTA_BaseNPC:IsFort(  ) end

---[[ CDOTA_BaseNPC:IsFrozen   ])
-- @return bool
function CDOTA_BaseNPC:IsFrozen(  ) end

---[[ CDOTA_BaseNPC:IsHero  Is this a hero or hero illusion? ])
-- @return bool
function CDOTA_BaseNPC:IsHero(  ) end

---[[ CDOTA_BaseNPC:IsHexed   ])
-- @return bool
function CDOTA_BaseNPC:IsHexed(  ) end

---[[ CDOTA_BaseNPC:IsIdle  Is this creature currently idle? ])
-- @return bool
function CDOTA_BaseNPC:IsIdle(  ) end

---[[ CDOTA_BaseNPC:IsIllusion   ])
-- @return bool
function CDOTA_BaseNPC:IsIllusion(  ) end

---[[ CDOTA_BaseNPC:IsInRangeOfShop  Ask whether this unit is in range of the specified shop ( DOTA_SHOP_TYPE shop, bool bMustBePhysicallyNear ])
-- @return bool
-- @param nShopType int
-- @param bPhysical bool
function CDOTA_BaseNPC:IsInRangeOfShop( nShopType, bPhysical ) end

---[[ CDOTA_BaseNPC:IsInvisible   ])
-- @return bool
function CDOTA_BaseNPC:IsInvisible(  ) end

---[[ CDOTA_BaseNPC:IsInvulnerable   ])
-- @return bool
function CDOTA_BaseNPC:IsInvulnerable(  ) end

---[[ CDOTA_BaseNPC:IsLowAttackPriority   ])
-- @return bool
function CDOTA_BaseNPC:IsLowAttackPriority(  ) end

---[[ CDOTA_BaseNPC:IsMagicImmune   ])
-- @return bool
function CDOTA_BaseNPC:IsMagicImmune(  ) end

---[[ CDOTA_BaseNPC:IsMovementImpaired   ])
-- @return bool
function CDOTA_BaseNPC:IsMovementImpaired(  ) end

---[[ CDOTA_BaseNPC:IsMoving  Is this unit moving? ])
-- @return bool
function CDOTA_BaseNPC:IsMoving(  ) end

---[[ CDOTA_BaseNPC:IsMuted   ])
-- @return bool
function CDOTA_BaseNPC:IsMuted(  ) end

---[[ CDOTA_BaseNPC:IsNeutralUnitType  Is this a neutral? ])
-- @return bool
function CDOTA_BaseNPC:IsNeutralUnitType(  ) end

---[[ CDOTA_BaseNPC:IsNightmared   ])
-- @return bool
function CDOTA_BaseNPC:IsNightmared(  ) end

---[[ CDOTA_BaseNPC:IsOpposingTeam   ])
-- @return bool
-- @param nTeam int
function CDOTA_BaseNPC:IsOpposingTeam( nTeam ) end

---[[ CDOTA_BaseNPC:IsOther  Is this unit a ward-type unit? ])
-- @return bool
function CDOTA_BaseNPC:IsOther(  ) end

---[[ CDOTA_BaseNPC:IsOutOfGame   ])
-- @return bool
function CDOTA_BaseNPC:IsOutOfGame(  ) end

---[[ CDOTA_BaseNPC:IsOwnedByAnyPlayer  Is this unit owned by any non-bot player? ])
-- @return bool
function CDOTA_BaseNPC:IsOwnedByAnyPlayer(  ) end

---[[ CDOTA_BaseNPC:IsPhantom  Is this a phantom unit? ])
-- @return bool
function CDOTA_BaseNPC:IsPhantom(  ) end

---[[ CDOTA_BaseNPC:IsPhantomBlocker   ])
-- @return bool
function CDOTA_BaseNPC:IsPhantomBlocker(  ) end

---[[ CDOTA_BaseNPC:IsPhased   ])
-- @return bool
function CDOTA_BaseNPC:IsPhased(  ) end

---[[ CDOTA_BaseNPC:IsPositionInRange   ])
-- @return bool
-- @param vPosition Vector
-- @param flRange float
function CDOTA_BaseNPC:IsPositionInRange( vPosition, flRange ) end

---[[ CDOTA_BaseNPC:IsRangedAttacker  Is this unit a ranged attacker? ])
-- @return bool
function CDOTA_BaseNPC:IsRangedAttacker(  ) end

---[[ CDOTA_BaseNPC:IsRealHero  Is this a real hero? ])
-- @return bool
function CDOTA_BaseNPC:IsRealHero(  ) end

---[[ CDOTA_BaseNPC:IsReincarnating   ])
-- @return bool
function CDOTA_BaseNPC:IsReincarnating(  ) end

---[[ CDOTA_BaseNPC:IsRooted   ])
-- @return bool
function CDOTA_BaseNPC:IsRooted(  ) end

---[[ CDOTA_BaseNPC:IsShrine  Is this a shrine? ])
-- @return bool
function CDOTA_BaseNPC:IsShrine(  ) end

---[[ CDOTA_BaseNPC:IsSilenced   ])
-- @return bool
function CDOTA_BaseNPC:IsSilenced(  ) end

---[[ CDOTA_BaseNPC:IsSpeciallyDeniable   ])
-- @return bool
function CDOTA_BaseNPC:IsSpeciallyDeniable(  ) end

---[[ CDOTA_BaseNPC:IsSpeciallyUndeniable   ])
-- @return bool
function CDOTA_BaseNPC:IsSpeciallyUndeniable(  ) end

---[[ CDOTA_BaseNPC:IsStunned   ])
-- @return bool
function CDOTA_BaseNPC:IsStunned(  ) end

---[[ CDOTA_BaseNPC:IsSummoned  Is this unit summoned? ])
-- @return bool
function CDOTA_BaseNPC:IsSummoned(  ) end

---[[ CDOTA_BaseNPC:IsTempestDouble   ])
-- @return bool
function CDOTA_BaseNPC:IsTempestDouble(  ) end

---[[ CDOTA_BaseNPC:IsTower  Is this a tower? ])
-- @return bool
function CDOTA_BaseNPC:IsTower(  ) end

---[[ CDOTA_BaseNPC:IsUnableToMiss   ])
-- @return bool
function CDOTA_BaseNPC:IsUnableToMiss(  ) end

---[[ CDOTA_BaseNPC:IsUnselectable   ])
-- @return bool
function CDOTA_BaseNPC:IsUnselectable(  ) end

---[[ CDOTA_BaseNPC:IsUntargetable   ])
-- @return bool
function CDOTA_BaseNPC:IsUntargetable(  ) end

---[[ CDOTA_BaseNPC:Kill  Kills this NPC, with the params Ability and Attacker. ])
-- @return void
-- @param hAbility handle
-- @param hAttacker handle
function CDOTA_BaseNPC:Kill( hAbility, hAttacker ) end

---[[ CDOTA_BaseNPC:MakeIllusion   ])
-- @return void
function CDOTA_BaseNPC:MakeIllusion(  ) end

---[[ CDOTA_BaseNPC:MakePhantomBlocker   ])
-- @return void
function CDOTA_BaseNPC:MakePhantomBlocker(  ) end

---[[ CDOTA_BaseNPC:MakeVisibleDueToAttack   ])
-- @return void
-- @param iTeam int
-- @param flRadius float
function CDOTA_BaseNPC:MakeVisibleDueToAttack( iTeam, flRadius ) end

---[[ CDOTA_BaseNPC:MakeVisibleToTeam   ])
-- @return void
-- @param iTeam int
-- @param flDuration float
function CDOTA_BaseNPC:MakeVisibleToTeam( iTeam, flDuration ) end

---[[ CDOTA_BaseNPC:ManageModelChanges   ])
-- @return void
function CDOTA_BaseNPC:ManageModelChanges(  ) end

---[[ CDOTA_BaseNPC:ModifyHealth  Sets the health to a specific value, with optional flags or inflictors. ])
-- @return void
-- @param iDesiredHealthValue int
-- @param hAbility handle
-- @param bLethal bool
-- @param iAdditionalFlags int
function CDOTA_BaseNPC:ModifyHealth( iDesiredHealthValue, hAbility, bLethal, iAdditionalFlags ) end

---[[ CDOTA_BaseNPC:MoveToNPC  Move to follow a unit. ])
-- @return void
-- @param hNPC handle
function CDOTA_BaseNPC:MoveToNPC( hNPC ) end

---[[ CDOTA_BaseNPC:MoveToNPCToGiveItem  Give an item to another unit. ])
-- @return void
-- @param hNPC handle
-- @param hItem handle
function CDOTA_BaseNPC:MoveToNPCToGiveItem( hNPC, hItem ) end

---[[ CDOTA_BaseNPC:MoveToPosition  Issue a Move-To command. ])
-- @return void
-- @param vDest Vector
function CDOTA_BaseNPC:MoveToPosition( vDest ) end

---[[ CDOTA_BaseNPC:MoveToPositionAggressive  Issue an Attack-Move-To command. ])
-- @return void
-- @param vDest Vector
function CDOTA_BaseNPC:MoveToPositionAggressive( vDest ) end

---[[ CDOTA_BaseNPC:MoveToTargetToAttack  Move to a target to attack. ])
-- @return void
-- @param hTarget handle
function CDOTA_BaseNPC:MoveToTargetToAttack( hTarget ) end

---[[ CDOTA_BaseNPC:NoHealthBar   ])
-- @return bool
function CDOTA_BaseNPC:NoHealthBar(  ) end

---[[ CDOTA_BaseNPC:NoTeamMoveTo   ])
-- @return bool
function CDOTA_BaseNPC:NoTeamMoveTo(  ) end

---[[ CDOTA_BaseNPC:NoTeamSelect   ])
-- @return bool
function CDOTA_BaseNPC:NoTeamSelect(  ) end

---[[ CDOTA_BaseNPC:NoUnitCollision   ])
-- @return bool
function CDOTA_BaseNPC:NoUnitCollision(  ) end

---[[ CDOTA_BaseNPC:NotOnMinimap   ])
-- @return bool
function CDOTA_BaseNPC:NotOnMinimap(  ) end

---[[ CDOTA_BaseNPC:NotOnMinimapForEnemies   ])
-- @return bool
function CDOTA_BaseNPC:NotOnMinimapForEnemies(  ) end

---[[ CDOTA_BaseNPC:NotifyWearablesOfModelChange   ])
-- @return void
-- @param bOriginalModel bool
function CDOTA_BaseNPC:NotifyWearablesOfModelChange( bOriginalModel ) end

---[[ CDOTA_BaseNPC:PassivesDisabled   ])
-- @return bool
function CDOTA_BaseNPC:PassivesDisabled(  ) end

---[[ CDOTA_BaseNPC:PatrolToPosition  Issue a Patrol-To command. ])
-- @return void
-- @param vDest Vector
function CDOTA_BaseNPC:PatrolToPosition( vDest ) end

---[[ CDOTA_BaseNPC:PerformAttack  Performs an attack on a target. ])
-- @return void
-- @param hTarget handle
-- @param bUseCastAttackOrb bool
-- @param bProcessProcs bool
-- @param bSkipCooldown bool
-- @param bIgnoreInvis bool
-- @param bUseProjectile bool
-- @param bFakeAttack bool
-- @param bNeverMiss bool
function CDOTA_BaseNPC:PerformAttack( hTarget, bUseCastAttackOrb, bProcessProcs, bSkipCooldown, bIgnoreInvis, bUseProjectile, bFakeAttack, bNeverMiss ) end

---[[ CDOTA_BaseNPC:PickupDroppedItem  Pick up a dropped item. ])
-- @return void
-- @param hItem handle
function CDOTA_BaseNPC:PickupDroppedItem( hItem ) end

---[[ CDOTA_BaseNPC:PickupRune  Pick up a rune. ])
-- @return void
-- @param hItem handle
function CDOTA_BaseNPC:PickupRune( hItem ) end

---[[ CDOTA_BaseNPC:PlayVCD  Play a VCD on the NPC. ])
-- @return void
-- @param pVCD string
function CDOTA_BaseNPC:PlayVCD( pVCD ) end

---[[ CDOTA_BaseNPC:ProvidesVision   ])
-- @return bool
function CDOTA_BaseNPC:ProvidesVision(  ) end

---[[ CDOTA_BaseNPC:Purge  (bool RemovePositiveBuffs, bool RemoveDebuffs, bool BuffsCreatedThisFrameOnly, bool RemoveStuns, bool RemoveExceptions) ])
-- @return void
-- @param bRemovePositiveBuffs bool
-- @param bRemoveDebuffs bool
-- @param bFrameOnly bool
-- @param bRemoveStuns bool
-- @param bRemoveExceptions bool
function CDOTA_BaseNPC:Purge( bRemovePositiveBuffs, bRemoveDebuffs, bFrameOnly, bRemoveStuns, bRemoveExceptions ) end

---[[ CDOTA_BaseNPC:QueueConcept  Queue a response system concept with the TLK_DOTA_CUSTOM concept, after a delay. ])
-- @return void
-- @param flDelay float
-- @param hCriteriaTable handle
-- @param hCompletionCallbackFn handle
-- @param hContext handle
-- @param hCallbackInfo handle
function CDOTA_BaseNPC:QueueConcept( flDelay, hCriteriaTable, hCompletionCallbackFn, hContext, hCallbackInfo ) end

---[[ CDOTA_BaseNPC:QueueTeamConcept  Queue a response system concept with the TLK_DOTA_CUSTOM concept, after a delay, for the same team this speaker is on. ])
-- @return void
-- @param flDelay float
-- @param hCriteriaTable handle
-- @param hCompletionCallbackFn handle
-- @param hContext handle
-- @param hCallbackInfo handle
function CDOTA_BaseNPC:QueueTeamConcept( flDelay, hCriteriaTable, hCompletionCallbackFn, hContext, hCallbackInfo ) end

---[[ CDOTA_BaseNPC:QueueTeamConceptNoSpectators  Queue a response system concept with the TLK_DOTA_CUSTOM concept, after a delay, for the same team this speaker is on. Is not played for spectators. ])
-- @return void
-- @param flDelay float
-- @param hCriteriaTable handle
-- @param hCompletionCallbackFn handle
-- @param hContext handle
-- @param hCallbackInfo handle
function CDOTA_BaseNPC:QueueTeamConceptNoSpectators( flDelay, hCriteriaTable, hCompletionCallbackFn, hContext, hCallbackInfo ) end

---[[ CDOTA_BaseNPC:ReduceMana  Remove mana from this unit, this can be used for involuntary mana loss, not for mana that is spent. ])
-- @return void
-- @param flAmount float
function CDOTA_BaseNPC:ReduceMana( flAmount ) end

---[[ CDOTA_BaseNPC:RemoveAbility  Remove an ability from this unit by name. ])
-- @return void
-- @param pszAbilityName string
function CDOTA_BaseNPC:RemoveAbility( pszAbilityName ) end

---[[ CDOTA_BaseNPC:RemoveAbilityByHandle  Remove the passed ability from this unit. ])
-- @return void
-- @param hAbility handle
function CDOTA_BaseNPC:RemoveAbilityByHandle( hAbility ) end

---[[ CDOTA_BaseNPC:RemoveAbilityFromIndexByName   ])
-- @return void
-- @param pszAbilityName string
function CDOTA_BaseNPC:RemoveAbilityFromIndexByName( pszAbilityName ) end

---[[ CDOTA_BaseNPC:RemoveAllModifiers  (int targets [0=all, 1=enemy, 2=ally], bool bNow, bool bPermanent, bool bDeath) ])
-- @return void
-- @param targets int
-- @param bNow bool
-- @param bPermanent bool
-- @param bDeath bool
function CDOTA_BaseNPC:RemoveAllModifiers( targets, bNow, bPermanent, bDeath ) end

---[[ CDOTA_BaseNPC:RemoveGesture  Remove the given gesture activity. ])
-- @return void
-- @param nActivity int
function CDOTA_BaseNPC:RemoveGesture( nActivity ) end

---[[ CDOTA_BaseNPC:RemoveHorizontalMotionController   ])
-- @return void
-- @param hBuff handle
function CDOTA_BaseNPC:RemoveHorizontalMotionController( hBuff ) end

---[[ CDOTA_BaseNPC:RemoveItem  Removes the passed item from this unit's inventory and deletes it. ])
-- @return void
-- @param hItem handle
function CDOTA_BaseNPC:RemoveItem( hItem ) end

---[[ CDOTA_BaseNPC:RemoveModifierByName  Removes a modifier. ])
-- @return void
-- @param pszScriptName string
function CDOTA_BaseNPC:RemoveModifierByName( pszScriptName ) end

---[[ CDOTA_BaseNPC:RemoveModifierByNameAndCaster  Removes a modifier that was cast by the given caster. ])
-- @return void
-- @param pszScriptName string
-- @param hCaster handle
function CDOTA_BaseNPC:RemoveModifierByNameAndCaster( pszScriptName, hCaster ) end

---[[ CDOTA_BaseNPC:RemoveNoDraw  Remove the no draw flag. ])
-- @return void
function CDOTA_BaseNPC:RemoveNoDraw(  ) end

---[[ CDOTA_BaseNPC:RemoveVerticalMotionController   ])
-- @return void
-- @param hBuff handle
function CDOTA_BaseNPC:RemoveVerticalMotionController( hBuff ) end

---[[ CDOTA_BaseNPC:RespawnUnit  Respawns the target unit if it can be respawned. ])
-- @return void
function CDOTA_BaseNPC:RespawnUnit(  ) end

---[[ CDOTA_BaseNPC:Script_GetAttackRange  Gets this unit's attack range after all modifiers. ])
-- @return float
function CDOTA_BaseNPC:Script_GetAttackRange(  ) end

---[[ CDOTA_BaseNPC:Script_IsDeniable   ])
-- @return bool
function CDOTA_BaseNPC:Script_IsDeniable(  ) end

---[[ CDOTA_BaseNPC:SellItem  Sells the passed item in this unit's inventory. ])
-- @return void
-- @param hItem handle
function CDOTA_BaseNPC:SellItem( hItem ) end

---[[ CDOTA_BaseNPC:SetAbilityByIndex  Set the ability by index. ])
-- @return void
-- @param hAbility handle
-- @param iIndex int
function CDOTA_BaseNPC:SetAbilityByIndex( hAbility, iIndex ) end

---[[ CDOTA_BaseNPC:SetAcquisitionRange   ])
-- @return void
-- @param nRange int
function CDOTA_BaseNPC:SetAcquisitionRange( nRange ) end

---[[ CDOTA_BaseNPC:SetAdditionalBattleMusicWeight  Combat involving this creature will have this weight added to the music calcuations. ])
-- @return void
-- @param flWeight float
function CDOTA_BaseNPC:SetAdditionalBattleMusicWeight( flWeight ) end

---[[ CDOTA_BaseNPC:SetAggroTarget  Set this unit's aggro target to a specified unit. ])
-- @return void
-- @param hAggroTarget handle
function CDOTA_BaseNPC:SetAggroTarget( hAggroTarget ) end

---[[ CDOTA_BaseNPC:SetAttackCapability   ])
-- @return void
-- @param iAttackCapabilities int
function CDOTA_BaseNPC:SetAttackCapability( iAttackCapabilities ) end

---[[ CDOTA_BaseNPC:SetAttacking   ])
-- @return void
-- @param hAttackTarget handle
function CDOTA_BaseNPC:SetAttacking( hAttackTarget ) end

---[[ CDOTA_BaseNPC:SetBaseAttackTime   ])
-- @return void
-- @param flBaseAttackTime float
function CDOTA_BaseNPC:SetBaseAttackTime( flBaseAttackTime ) end

---[[ CDOTA_BaseNPC:SetBaseDamageMax  Sets the maximum base damage. ])
-- @return void
-- @param nMax int
function CDOTA_BaseNPC:SetBaseDamageMax( nMax ) end

---[[ CDOTA_BaseNPC:SetBaseDamageMin  Sets the minimum base damage. ])
-- @return void
-- @param nMin int
function CDOTA_BaseNPC:SetBaseDamageMin( nMin ) end

---[[ CDOTA_BaseNPC:SetBaseHealthRegen   ])
-- @return void
-- @param flHealthRegen float
function CDOTA_BaseNPC:SetBaseHealthRegen( flHealthRegen ) end

---[[ CDOTA_BaseNPC:SetBaseMagicalResistanceValue  Sets base magical armor value. ])
-- @return void
-- @param flMagicalResistanceValue float
function CDOTA_BaseNPC:SetBaseMagicalResistanceValue( flMagicalResistanceValue ) end

---[[ CDOTA_BaseNPC:SetBaseManaRegen   ])
-- @return void
-- @param flManaRegen float
function CDOTA_BaseNPC:SetBaseManaRegen( flManaRegen ) end

---[[ CDOTA_BaseNPC:SetBaseMaxHealth  Set a new base max health value. ])
-- @return void
-- @param flBaseMaxHealth float
function CDOTA_BaseNPC:SetBaseMaxHealth( flBaseMaxHealth ) end

---[[ CDOTA_BaseNPC:SetBaseMoveSpeed   ])
-- @return void
-- @param iMoveSpeed int
function CDOTA_BaseNPC:SetBaseMoveSpeed( iMoveSpeed ) end

---[[ CDOTA_BaseNPC:SetCanSellItems  Set whether or not this unit is allowed to sell items (bCanSellItems) ])
-- @return void
-- @param bCanSell bool
function CDOTA_BaseNPC:SetCanSellItems( bCanSell ) end

---[[ CDOTA_BaseNPC:SetControllableByPlayer  Set this unit controllable by the player with the passed ID. ])
-- @return void
-- @param iIndex int
-- @param bSkipAdjustingPosition bool
function CDOTA_BaseNPC:SetControllableByPlayer( iIndex, bSkipAdjustingPosition ) end

---[[ CDOTA_BaseNPC:SetCursorCastTarget   ])
-- @return void
-- @param hEntity handle
function CDOTA_BaseNPC:SetCursorCastTarget( hEntity ) end

---[[ CDOTA_BaseNPC:SetCursorPosition   ])
-- @return void
-- @param vLocation Vector
function CDOTA_BaseNPC:SetCursorPosition( vLocation ) end

---[[ CDOTA_BaseNPC:SetCursorTargetingNothing   ])
-- @return void
-- @param bTargetingNothing bool
function CDOTA_BaseNPC:SetCursorTargetingNothing( bTargetingNothing ) end

---[[ CDOTA_BaseNPC:SetCustomHealthLabel   ])
-- @return void
-- @param pLabel string
-- @param r int
-- @param g int
-- @param b int
function CDOTA_BaseNPC:SetCustomHealthLabel( pLabel, r, g, b ) end

---[[ CDOTA_BaseNPC:SetDayTimeVisionRange  Set the base vision range. ])
-- @return void
-- @param iRange int
function CDOTA_BaseNPC:SetDayTimeVisionRange( iRange ) end

---[[ CDOTA_BaseNPC:SetDeathXP  Set the XP bounty on this unit. ])
-- @return void
-- @param iXPBounty int
function CDOTA_BaseNPC:SetDeathXP( iXPBounty ) end

---[[ CDOTA_BaseNPC:SetForceAttackTarget   ])
-- @return void
-- @param hNPC handle
function CDOTA_BaseNPC:SetForceAttackTarget( hNPC ) end

---[[ CDOTA_BaseNPC:SetForceAttackTargetAlly   ])
-- @return void
-- @param hNPC handle
function CDOTA_BaseNPC:SetForceAttackTargetAlly( hNPC ) end

---[[ CDOTA_BaseNPC:SetHasInventory  Set if this unit has an inventory. ])
-- @return void
-- @param bHasInventory bool
function CDOTA_BaseNPC:SetHasInventory( bHasInventory ) end

---[[ CDOTA_BaseNPC:SetHealthBarOffsetOverride   ])
-- @return void
-- @param nOffset int
function CDOTA_BaseNPC:SetHealthBarOffsetOverride( nOffset ) end

---[[ CDOTA_BaseNPC:SetHullRadius  Set the collision hull radius of this NPC. ])
-- @return void
-- @param flHullRadius float
function CDOTA_BaseNPC:SetHullRadius( flHullRadius ) end

---[[ CDOTA_BaseNPC:SetIdleAcquire   ])
-- @return void
-- @param bIdleAcquire bool
function CDOTA_BaseNPC:SetIdleAcquire( bIdleAcquire ) end

---[[ CDOTA_BaseNPC:SetInitialGoalEntity  Sets the initial waypoint goal for this NPC. ])
-- @return void
-- @param hGoal handle
function CDOTA_BaseNPC:SetInitialGoalEntity( hGoal ) end

---[[ CDOTA_BaseNPC:SetInitialGoalPosition  Set waypoint position for this NPC. ])
-- @return void
-- @param vPosition Vector
function CDOTA_BaseNPC:SetInitialGoalPosition( vPosition ) end

---[[ CDOTA_BaseNPC:SetMana  Set the mana on this unit. ])
-- @return void
-- @param flMana float
function CDOTA_BaseNPC:SetMana( flMana ) end

---[[ CDOTA_BaseNPC:SetMaxMana  Set the maximum mana of this unit. ])
-- @return void
-- @param flMaxMana float
function CDOTA_BaseNPC:SetMaxMana( flMaxMana ) end

---[[ CDOTA_BaseNPC:SetMaximumGoldBounty  Set the maximum gold bounty for this unit. ])
-- @return void
-- @param iGoldBountyMax int
function CDOTA_BaseNPC:SetMaximumGoldBounty( iGoldBountyMax ) end

---[[ CDOTA_BaseNPC:SetMinimumGoldBounty  Set the minimum gold bounty for this unit. ])
-- @return void
-- @param iGoldBountyMin int
function CDOTA_BaseNPC:SetMinimumGoldBounty( iGoldBountyMin ) end

---[[ CDOTA_BaseNPC:SetModifierStackCount  Sets the stack count of a given modifier. ])
-- @return void
-- @param pszScriptName string
-- @param hCaster handle
-- @param nStackCount int
function CDOTA_BaseNPC:SetModifierStackCount( pszScriptName, hCaster, nStackCount ) end

---[[ CDOTA_BaseNPC:SetMoveCapability   ])
-- @return void
-- @param iMoveCapabilities int
function CDOTA_BaseNPC:SetMoveCapability( iMoveCapabilities ) end

---[[ CDOTA_BaseNPC:SetMustReachEachGoalEntity  Set whether this NPC is required to reach each goal entity, rather than being allowed to unkink their path. ])
-- @return void
-- @param must bool
function CDOTA_BaseNPC:SetMustReachEachGoalEntity( must ) end

---[[ CDOTA_BaseNPC:SetNeverMoveToClearSpace  If set to true, we will never attempt to move this unit to clear space, even when it unphases. ])
-- @return void
-- @param neverMoveToClearSpace bool
function CDOTA_BaseNPC:SetNeverMoveToClearSpace( neverMoveToClearSpace ) end

---[[ CDOTA_BaseNPC:SetNightTimeVisionRange  Returns the vision range after modifiers. ])
-- @return void
-- @param iRange int
function CDOTA_BaseNPC:SetNightTimeVisionRange( iRange ) end

---[[ CDOTA_BaseNPC:SetOrigin  Set the unit's origin. ])
-- @return void
-- @param vLocation Vector
function CDOTA_BaseNPC:SetOrigin( vLocation ) end

---[[ CDOTA_BaseNPC:SetOriginalModel  Sets the original model of this entity, which it will tend to fall back to anytime its state changes. ])
-- @return void
-- @param pszModelName string
function CDOTA_BaseNPC:SetOriginalModel( pszModelName ) end

---[[ CDOTA_BaseNPC:SetPhysicalArmorBaseValue  Sets base physical armor value. ])
-- @return void
-- @param flPhysicalArmorValue float
function CDOTA_BaseNPC:SetPhysicalArmorBaseValue( flPhysicalArmorValue ) end

---[[ CDOTA_BaseNPC:SetRangedProjectileName   ])
-- @return void
-- @param pProjectileName string
function CDOTA_BaseNPC:SetRangedProjectileName( pProjectileName ) end

---[[ CDOTA_BaseNPC:SetRevealRadius  sets the client side map reveal radius for this unit ])
-- @return void
-- @param revealRadius float
function CDOTA_BaseNPC:SetRevealRadius( revealRadius ) end

---[[ CDOTA_BaseNPC:SetShouldDoFlyHeightVisual   ])
-- @return void
-- @param bShouldVisuallyFly bool
function CDOTA_BaseNPC:SetShouldDoFlyHeightVisual( bShouldVisuallyFly ) end

---[[ CDOTA_BaseNPC:SetStolenScepter   ])
-- @return void
-- @param bStolenScepter bool
function CDOTA_BaseNPC:SetStolenScepter( bStolenScepter ) end

---[[ CDOTA_BaseNPC:SetUnitCanRespawn   ])
-- @return void
-- @param bCanRespawn bool
function CDOTA_BaseNPC:SetUnitCanRespawn( bCanRespawn ) end

---[[ CDOTA_BaseNPC:SetUnitName   ])
-- @return void
-- @param pName string
function CDOTA_BaseNPC:SetUnitName( pName ) end

---[[ CDOTA_BaseNPC:ShouldIdleAcquire   ])
-- @return bool
function CDOTA_BaseNPC:ShouldIdleAcquire(  ) end

---[[ CDOTA_BaseNPC:SpeakConcept  Speak a response system concept with the TLK_DOTA_CUSTOM concept. ])
-- @return void
-- @param hCriteriaTable handle
function CDOTA_BaseNPC:SpeakConcept( hCriteriaTable ) end

---[[ CDOTA_BaseNPC:SpendMana  Spend mana from this unit, this can be used for spending mana from abilities or item usage. ])
-- @return void
-- @param flManaSpent float
-- @param hAbility handle
function CDOTA_BaseNPC:SpendMana( flManaSpent, hAbility ) end

---[[ CDOTA_BaseNPC:StartGesture  Add the given gesture activity. ])
-- @return void
-- @param nActivity int
function CDOTA_BaseNPC:StartGesture( nActivity ) end

---[[ CDOTA_BaseNPC:StartGestureFadeWithSequenceSettings  Add the given gesture activity faded according to its sequence settings. ])
-- @return void
-- @param nActivity int
function CDOTA_BaseNPC:StartGestureFadeWithSequenceSettings( nActivity ) end

---[[ CDOTA_BaseNPC:StartGestureWithFade  Add the given gesture activity faded according to to the parameters. ])
-- @return void
-- @param nActivity int
-- @param fFadeIn float
-- @param fFadeOut float
function CDOTA_BaseNPC:StartGestureWithFade( nActivity, fFadeIn, fFadeOut ) end

---[[ CDOTA_BaseNPC:StartGestureWithPlaybackRate  Add the given gesture activity with a playback rate override. ])
-- @return void
-- @param nActivity int
-- @param flRate float
function CDOTA_BaseNPC:StartGestureWithPlaybackRate( nActivity, flRate ) end

---[[ CDOTA_BaseNPC:Stop  Stop the current order. ])
-- @return void
function CDOTA_BaseNPC:Stop(  ) end

---[[ CDOTA_BaseNPC:StopFacing   ])
-- @return void
function CDOTA_BaseNPC:StopFacing(  ) end

---[[ CDOTA_BaseNPC:SwapAbilities  Swaps the slots of the two passed abilities and sets them enabled/disabled. ])
-- @return void
-- @param pAbilityName1 string
-- @param pAbilityName2 string
-- @param bEnable1 bool
-- @param bEnable2 bool
function CDOTA_BaseNPC:SwapAbilities( pAbilityName1, pAbilityName2, bEnable1, bEnable2 ) end

---[[ CDOTA_BaseNPC:SwapItems  Swap the contents of two item slots (slot1, slot2) ])
-- @return void
-- @param nSlot1 int
-- @param nSlot2 int
function CDOTA_BaseNPC:SwapItems( nSlot1, nSlot2 ) end

---[[ CDOTA_BaseNPC:TakeItem  Removed the passed item from this unit's inventory. ])
-- @return handle
-- @param hItem handle
function CDOTA_BaseNPC:TakeItem( hItem ) end

---[[ CDOTA_BaseNPC:TimeUntilNextAttack   ])
-- @return float
function CDOTA_BaseNPC:TimeUntilNextAttack(  ) end

---[[ CDOTA_BaseNPC:TriggerModifierDodge   ])
-- @return bool
function CDOTA_BaseNPC:TriggerModifierDodge(  ) end

---[[ CDOTA_BaseNPC:TriggerSpellAbsorb   ])
-- @return bool
-- @param hAbility handle
function CDOTA_BaseNPC:TriggerSpellAbsorb( hAbility ) end

---[[ CDOTA_BaseNPC:TriggerSpellReflect  Trigger the Lotus Orb-like effect.(hAbility) ])
-- @return void
-- @param hAbility handle
function CDOTA_BaseNPC:TriggerSpellReflect( hAbility ) end

---[[ CDOTA_BaseNPC:UnHideAbilityToSlot  Makes the first ability unhidden, and puts it where second ability currently is. Will do nothing if the first ability is already unhidden and in a valid slot. ])
-- @return void
-- @param pszAbilityName string
-- @param pszReplacedAbilityName string
function CDOTA_BaseNPC:UnHideAbilityToSlot( pszAbilityName, pszReplacedAbilityName ) end

---[[ CDOTA_BaseNPC:UnitCanRespawn   ])
-- @return bool
function CDOTA_BaseNPC:UnitCanRespawn(  ) end

---[[ CDOTA_BaseNPC:WasKilledPassively   ])
-- @return bool
function CDOTA_BaseNPC:WasKilledPassively(  ) end

---[[ CDOTA_BaseNPC_Building:GetInvulnCount  Get the invulnerability count for a building. ])
-- @return int
function CDOTA_BaseNPC_Building:GetInvulnCount(  ) end

---[[ CDOTA_BaseNPC_Building:SetInvulnCount  Set the invulnerability counter of this building. ])
-- @return void
-- @param nInvulnCount int
function CDOTA_BaseNPC_Building:SetInvulnCount( nInvulnCount ) end

---[[ CDOTA_BaseNPC_Creature:AddItemDrop  Add the specified item drop to this creature. ])
-- @return void
-- @param hDropData handle
function CDOTA_BaseNPC_Creature:AddItemDrop( hDropData ) end

---[[ CDOTA_BaseNPC_Creature:CreatureLevelUp  Level the creature up by the specified number of levels ])
-- @return void
-- @param iLevels int
function CDOTA_BaseNPC_Creature:CreatureLevelUp( iLevels ) end

---[[ CDOTA_BaseNPC_Creature:GetDisableResistance  Set creature's current disable resistance ])
-- @return float
function CDOTA_BaseNPC_Creature:GetDisableResistance(  ) end

---[[ CDOTA_BaseNPC_Creature:GetUltimateDisableResistance  Set creature's current disable resistance from ultimates ])
-- @return float
function CDOTA_BaseNPC_Creature:GetUltimateDisableResistance(  ) end

---[[ CDOTA_BaseNPC_Creature:IsChampion  Is this unit a champion? ])
-- @return bool
function CDOTA_BaseNPC_Creature:IsChampion(  ) end

---[[ CDOTA_BaseNPC_Creature:IsReincarnating  Is this creature respawning? ])
-- @return bool
function CDOTA_BaseNPC_Creature:IsReincarnating(  ) end

---[[ CDOTA_BaseNPC_Creature:RemoveAllItemDrops  Remove all item drops from this creature. ])
-- @return void
function CDOTA_BaseNPC_Creature:RemoveAllItemDrops(  ) end

---[[ CDOTA_BaseNPC_Creature:SetArmorGain  Set the armor gained per level on this creature. ])
-- @return void
-- @param flArmorGain float
function CDOTA_BaseNPC_Creature:SetArmorGain( flArmorGain ) end

---[[ CDOTA_BaseNPC_Creature:SetAttackTimeGain  Set the attack time gained per level on this creature. ])
-- @return void
-- @param flAttackTimeGain float
function CDOTA_BaseNPC_Creature:SetAttackTimeGain( flAttackTimeGain ) end

---[[ CDOTA_BaseNPC_Creature:SetBountyGain  Set the bounty gold gained per level on this creature. ])
-- @return void
-- @param nBountyGain int
function CDOTA_BaseNPC_Creature:SetBountyGain( nBountyGain ) end

---[[ CDOTA_BaseNPC_Creature:SetChampion  Flag this unit as a champion creature. ])
-- @return void
-- @param bIsChampion bool
function CDOTA_BaseNPC_Creature:SetChampion( bIsChampion ) end

---[[ CDOTA_BaseNPC_Creature:SetDamageGain  Set the damage gained per level on this creature. ])
-- @return void
-- @param nDamageGain int
function CDOTA_BaseNPC_Creature:SetDamageGain( nDamageGain ) end

---[[ CDOTA_BaseNPC_Creature:SetDisableResistance  Set creature's current disable resistance ])
-- @return void
-- @param flDisableResistance float
function CDOTA_BaseNPC_Creature:SetDisableResistance( flDisableResistance ) end

---[[ CDOTA_BaseNPC_Creature:SetDisableResistanceGain  Set the disable resistance gained per level on this creature. ])
-- @return void
-- @param flDisableResistanceGain float
function CDOTA_BaseNPC_Creature:SetDisableResistanceGain( flDisableResistanceGain ) end

---[[ CDOTA_BaseNPC_Creature:SetHPGain  Set the hit points gained per level on this creature. ])
-- @return void
-- @param nHPGain int
function CDOTA_BaseNPC_Creature:SetHPGain( nHPGain ) end

---[[ CDOTA_BaseNPC_Creature:SetHPRegenGain  Set the hit points regen gained per level on this creature. ])
-- @return void
-- @param flHPRegenGain float
function CDOTA_BaseNPC_Creature:SetHPRegenGain( flHPRegenGain ) end

---[[ CDOTA_BaseNPC_Creature:SetMagicResistanceGain  Set the magic resistance gained per level on this creature. ])
-- @return void
-- @param flMagicResistanceGain float
function CDOTA_BaseNPC_Creature:SetMagicResistanceGain( flMagicResistanceGain ) end

---[[ CDOTA_BaseNPC_Creature:SetManaGain  Set the mana points gained per level on this creature. ])
-- @return void
-- @param nManaGain int
function CDOTA_BaseNPC_Creature:SetManaGain( nManaGain ) end

---[[ CDOTA_BaseNPC_Creature:SetManaRegenGain  Set the mana points regen gained per level on this creature. ])
-- @return void
-- @param flManaRegenGain float
function CDOTA_BaseNPC_Creature:SetManaRegenGain( flManaRegenGain ) end

---[[ CDOTA_BaseNPC_Creature:SetMoveSpeedGain  Set the move speed gained per level on this creature. ])
-- @return void
-- @param nMoveSpeedGain int
function CDOTA_BaseNPC_Creature:SetMoveSpeedGain( nMoveSpeedGain ) end

---[[ CDOTA_BaseNPC_Creature:SetRequiresReachingEndPath  Set whether creatures require reaching their end path before becoming idle ])
-- @return void
-- @param bRequiresReachingEndPath bool
function CDOTA_BaseNPC_Creature:SetRequiresReachingEndPath( bRequiresReachingEndPath ) end

---[[ CDOTA_BaseNPC_Creature:SetUltimateDisableResistance  Set creature's current disable resistance from ultimates ])
-- @return void
-- @param flUltDisableResistance float
function CDOTA_BaseNPC_Creature:SetUltimateDisableResistance( flUltDisableResistance ) end

---[[ CDOTA_BaseNPC_Creature:SetXPGain  Set the XP gained per level on this creature. ])
-- @return void
-- @param nXPGain int
function CDOTA_BaseNPC_Creature:SetXPGain( nXPGain ) end

---[[ CDOTA_BaseNPC_Hero:AddExperience  Params: Float XP, Bool applyBotDifficultyScaling ])
-- @return bool
-- @param flXP float
-- @param nReason int
-- @param bApplyBotDifficultyScaling bool
-- @param bIncrementTotal bool
function CDOTA_BaseNPC_Hero:AddExperience( flXP, nReason, bApplyBotDifficultyScaling, bIncrementTotal ) end

---[[ CDOTA_BaseNPC_Hero:Buyback  Spend the gold and buyback with this hero. ])
-- @return void
function CDOTA_BaseNPC_Hero:Buyback(  ) end

---[[ CDOTA_BaseNPC_Hero:CalculateStatBonus  Recalculate all stats after the hero gains stats. ])
-- @return void
-- @param bForce bool
function CDOTA_BaseNPC_Hero:CalculateStatBonus( bForce ) end

---[[ CDOTA_BaseNPC_Hero:CanEarnGold  Returns boolean value result of buyback gold limit time less than game time. ])
-- @return bool
function CDOTA_BaseNPC_Hero:CanEarnGold(  ) end

---[[ CDOTA_BaseNPC_Hero:ClearLastHitMultikill  Value is stored in PlayerResource. ])
-- @return void
function CDOTA_BaseNPC_Hero:ClearLastHitMultikill(  ) end

---[[ CDOTA_BaseNPC_Hero:ClearLastHitStreak  Value is stored in PlayerResource. ])
-- @return void
function CDOTA_BaseNPC_Hero:ClearLastHitStreak(  ) end

---[[ CDOTA_BaseNPC_Hero:ClearStreak  Value is stored in PlayerResource. ])
-- @return void
function CDOTA_BaseNPC_Hero:ClearStreak(  ) end

---[[ CDOTA_BaseNPC_Hero:GetAbilityPoints  Gets the current unspent ability points. ])
-- @return int
function CDOTA_BaseNPC_Hero:GetAbilityPoints(  ) end

---[[ CDOTA_BaseNPC_Hero:GetAdditionalOwnedUnits   ])
-- @return table
function CDOTA_BaseNPC_Hero:GetAdditionalOwnedUnits(  ) end

---[[ CDOTA_BaseNPC_Hero:GetAgility   ])
-- @return float
function CDOTA_BaseNPC_Hero:GetAgility(  ) end

---[[ CDOTA_BaseNPC_Hero:GetAgilityGain   ])
-- @return float
function CDOTA_BaseNPC_Hero:GetAgilityGain(  ) end

---[[ CDOTA_BaseNPC_Hero:GetAssists  Value is stored in PlayerResource. ])
-- @return int
function CDOTA_BaseNPC_Hero:GetAssists(  ) end

---[[ CDOTA_BaseNPC_Hero:GetAttacker   ])
-- @return int
-- @param nIndex int
function CDOTA_BaseNPC_Hero:GetAttacker( nIndex ) end

---[[ CDOTA_BaseNPC_Hero:GetBaseAgility   ])
-- @return float
function CDOTA_BaseNPC_Hero:GetBaseAgility(  ) end

---[[ CDOTA_BaseNPC_Hero:GetBaseDamageMax  Hero damage is also affected by attributes. ])
-- @return int
function CDOTA_BaseNPC_Hero:GetBaseDamageMax(  ) end

---[[ CDOTA_BaseNPC_Hero:GetBaseDamageMin  Hero damage is also affected by attributes. ])
-- @return int
function CDOTA_BaseNPC_Hero:GetBaseDamageMin(  ) end

---[[ CDOTA_BaseNPC_Hero:GetBaseIntellect   ])
-- @return float
function CDOTA_BaseNPC_Hero:GetBaseIntellect(  ) end

---[[ CDOTA_BaseNPC_Hero:GetBaseManaRegen  Returns the base mana regen. ])
-- @return float
function CDOTA_BaseNPC_Hero:GetBaseManaRegen(  ) end

---[[ CDOTA_BaseNPC_Hero:GetBaseStrength   ])
-- @return float
function CDOTA_BaseNPC_Hero:GetBaseStrength(  ) end

---[[ CDOTA_BaseNPC_Hero:GetBonusDamageFromPrimaryStat   ])
-- @return int
function CDOTA_BaseNPC_Hero:GetBonusDamageFromPrimaryStat(  ) end

---[[ CDOTA_BaseNPC_Hero:GetBuybackCooldownTime  Return float value for the amount of time left on cooldown for this hero's buyback. ])
-- @return float
function CDOTA_BaseNPC_Hero:GetBuybackCooldownTime(  ) end

---[[ CDOTA_BaseNPC_Hero:GetBuybackCost  Return integer value for the gold cost of a buyback. ])
-- @return int
-- @param bReturnOldValues bool
function CDOTA_BaseNPC_Hero:GetBuybackCost( bReturnOldValues ) end

---[[ CDOTA_BaseNPC_Hero:GetBuybackGoldLimitTime  Returns the amount of time gold gain is limited after buying back. ])
-- @return float
function CDOTA_BaseNPC_Hero:GetBuybackGoldLimitTime(  ) end

---[[ CDOTA_BaseNPC_Hero:GetCurrentXP  Returns the amount of XP  ])
-- @return int
function CDOTA_BaseNPC_Hero:GetCurrentXP(  ) end

---[[ CDOTA_BaseNPC_Hero:GetDeathGoldCost   ])
-- @return int
function CDOTA_BaseNPC_Hero:GetDeathGoldCost(  ) end

---[[ CDOTA_BaseNPC_Hero:GetDeaths  Value is stored in PlayerResource. ])
-- @return int
function CDOTA_BaseNPC_Hero:GetDeaths(  ) end

---[[ CDOTA_BaseNPC_Hero:GetDenies  Value is stored in PlayerResource. ])
-- @return int
function CDOTA_BaseNPC_Hero:GetDenies(  ) end

---[[ CDOTA_BaseNPC_Hero:GetGold  Returns gold amount for the player owning this hero ])
-- @return int
function CDOTA_BaseNPC_Hero:GetGold(  ) end

---[[ CDOTA_BaseNPC_Hero:GetGoldBounty   ])
-- @return int
function CDOTA_BaseNPC_Hero:GetGoldBounty(  ) end

---[[ CDOTA_BaseNPC_Hero:GetHeroID   ])
-- @return int
function CDOTA_BaseNPC_Hero:GetHeroID(  ) end

---[[ CDOTA_BaseNPC_Hero:GetIncreasedAttackSpeed  Hero attack speed is also affected by agility. ])
-- @return float
function CDOTA_BaseNPC_Hero:GetIncreasedAttackSpeed(  ) end

---[[ CDOTA_BaseNPC_Hero:GetIntellect   ])
-- @return float
function CDOTA_BaseNPC_Hero:GetIntellect(  ) end

---[[ CDOTA_BaseNPC_Hero:GetIntellectGain   ])
-- @return float
function CDOTA_BaseNPC_Hero:GetIntellectGain(  ) end

---[[ CDOTA_BaseNPC_Hero:GetKills  Value is stored in PlayerResource. ])
-- @return int
function CDOTA_BaseNPC_Hero:GetKills(  ) end

---[[ CDOTA_BaseNPC_Hero:GetLastHits  Value is stored in PlayerResource. ])
-- @return int
function CDOTA_BaseNPC_Hero:GetLastHits(  ) end

---[[ CDOTA_BaseNPC_Hero:GetMostRecentDamageTime   ])
-- @return float
function CDOTA_BaseNPC_Hero:GetMostRecentDamageTime(  ) end

---[[ CDOTA_BaseNPC_Hero:GetMultipleKillCount   ])
-- @return int
function CDOTA_BaseNPC_Hero:GetMultipleKillCount(  ) end

---[[ CDOTA_BaseNPC_Hero:GetNumAttackers   ])
-- @return int
function CDOTA_BaseNPC_Hero:GetNumAttackers(  ) end

---[[ CDOTA_BaseNPC_Hero:GetNumItemsInInventory   ])
-- @return int
function CDOTA_BaseNPC_Hero:GetNumItemsInInventory(  ) end

---[[ CDOTA_BaseNPC_Hero:GetNumItemsInStash   ])
-- @return int
function CDOTA_BaseNPC_Hero:GetNumItemsInStash(  ) end

---[[ CDOTA_BaseNPC_Hero:GetPhysicalArmorBaseValue  Hero armor is affected by attributes. ])
-- @return float
function CDOTA_BaseNPC_Hero:GetPhysicalArmorBaseValue(  ) end

---[[ CDOTA_BaseNPC_Hero:GetPlayerID  Returns player ID of the player owning this hero ])
-- @return int
function CDOTA_BaseNPC_Hero:GetPlayerID(  ) end

---[[ CDOTA_BaseNPC_Hero:GetPrimaryAttribute  0 = strength, 1 = agility, 2 = intelligence. ])
-- @return int
function CDOTA_BaseNPC_Hero:GetPrimaryAttribute(  ) end

---[[ CDOTA_BaseNPC_Hero:GetPrimaryStatValue   ])
-- @return float
function CDOTA_BaseNPC_Hero:GetPrimaryStatValue(  ) end

---[[ CDOTA_BaseNPC_Hero:GetReplicatingOtherHero   ])
-- @return handle
function CDOTA_BaseNPC_Hero:GetReplicatingOtherHero(  ) end

---[[ CDOTA_BaseNPC_Hero:GetRespawnTime   ])
-- @return float
function CDOTA_BaseNPC_Hero:GetRespawnTime(  ) end

---[[ CDOTA_BaseNPC_Hero:GetRespawnsDisabled  Is this hero prevented from respawning? ])
-- @return bool
function CDOTA_BaseNPC_Hero:GetRespawnsDisabled(  ) end

---[[ CDOTA_BaseNPC_Hero:GetStreak  Value is stored in PlayerResource. ])
-- @return int
function CDOTA_BaseNPC_Hero:GetStreak(  ) end

---[[ CDOTA_BaseNPC_Hero:GetStrength   ])
-- @return float
function CDOTA_BaseNPC_Hero:GetStrength(  ) end

---[[ CDOTA_BaseNPC_Hero:GetStrengthGain   ])
-- @return float
function CDOTA_BaseNPC_Hero:GetStrengthGain(  ) end

---[[ CDOTA_BaseNPC_Hero:GetTimeUntilRespawn   ])
-- @return float
function CDOTA_BaseNPC_Hero:GetTimeUntilRespawn(  ) end

---[[ CDOTA_BaseNPC_Hero:GetTogglableWearable  Get wearable entity in slot (slot) ])
-- @return handle
-- @param nSlotType int
function CDOTA_BaseNPC_Hero:GetTogglableWearable( nSlotType ) end

---[[ CDOTA_BaseNPC_Hero:HasAnyAvailableInventorySpace   ])
-- @return bool
function CDOTA_BaseNPC_Hero:HasAnyAvailableInventorySpace(  ) end

---[[ CDOTA_BaseNPC_Hero:HasFlyingVision   ])
-- @return bool
function CDOTA_BaseNPC_Hero:HasFlyingVision(  ) end

---[[ CDOTA_BaseNPC_Hero:HasOwnerAbandoned   ])
-- @return bool
function CDOTA_BaseNPC_Hero:HasOwnerAbandoned(  ) end

---[[ CDOTA_BaseNPC_Hero:HasRoomForItem  Args: const char* pItemName, bool bIncludeStashCombines, bool bAllowSelling ])
-- @return int
-- @param pItemName string
-- @param bIncludeStashCombines bool
-- @param bAllowSelling bool
function CDOTA_BaseNPC_Hero:HasRoomForItem( pItemName, bIncludeStashCombines, bAllowSelling ) end

---[[ CDOTA_BaseNPC_Hero:HeroLevelUp  Levels up the hero, true or false to play effects. ])
-- @return void
-- @param bPlayEffects bool
function CDOTA_BaseNPC_Hero:HeroLevelUp( bPlayEffects ) end

---[[ CDOTA_BaseNPC_Hero:IncrementAssists  Value is stored in PlayerResource. ])
-- @return void
-- @param iKillerID int
function CDOTA_BaseNPC_Hero:IncrementAssists( iKillerID ) end

---[[ CDOTA_BaseNPC_Hero:IncrementDeaths  Value is stored in PlayerResource. ])
-- @return void
-- @param iKillerID int
function CDOTA_BaseNPC_Hero:IncrementDeaths( iKillerID ) end

---[[ CDOTA_BaseNPC_Hero:IncrementDenies  Value is stored in PlayerResource. ])
-- @return void
function CDOTA_BaseNPC_Hero:IncrementDenies(  ) end

---[[ CDOTA_BaseNPC_Hero:IncrementKills  Passed ID is for the victim, killer ID is ID of the current hero.  Value is stored in PlayerResource. ])
-- @return void
-- @param iVictimID int
function CDOTA_BaseNPC_Hero:IncrementKills( iVictimID ) end

---[[ CDOTA_BaseNPC_Hero:IncrementLastHitMultikill  Value is stored in PlayerResource. ])
-- @return void
function CDOTA_BaseNPC_Hero:IncrementLastHitMultikill(  ) end

---[[ CDOTA_BaseNPC_Hero:IncrementLastHitStreak  Value is stored in PlayerResource. ])
-- @return void
function CDOTA_BaseNPC_Hero:IncrementLastHitStreak(  ) end

---[[ CDOTA_BaseNPC_Hero:IncrementLastHits  Value is stored in PlayerResource. ])
-- @return void
function CDOTA_BaseNPC_Hero:IncrementLastHits(  ) end

---[[ CDOTA_BaseNPC_Hero:IncrementNearbyCreepDeaths  Value is stored in PlayerResource. ])
-- @return void
function CDOTA_BaseNPC_Hero:IncrementNearbyCreepDeaths(  ) end

---[[ CDOTA_BaseNPC_Hero:IncrementStreak  Value is stored in PlayerResource. ])
-- @return void
function CDOTA_BaseNPC_Hero:IncrementStreak(  ) end

---[[ CDOTA_BaseNPC_Hero:IsBuybackDisabledByReapersScythe   ])
-- @return bool
function CDOTA_BaseNPC_Hero:IsBuybackDisabledByReapersScythe(  ) end

---[[ CDOTA_BaseNPC_Hero:IsReincarnating   ])
-- @return bool
function CDOTA_BaseNPC_Hero:IsReincarnating(  ) end

---[[ CDOTA_BaseNPC_Hero:IsStashEnabled   ])
-- @return bool
function CDOTA_BaseNPC_Hero:IsStashEnabled(  ) end

---[[ CDOTA_BaseNPC_Hero:KilledHero  Args: Hero, Inflictor ])
-- @return void
-- @param hHero handle
-- @param hInflictor handle
function CDOTA_BaseNPC_Hero:KilledHero( hHero, hInflictor ) end

---[[ CDOTA_BaseNPC_Hero:ModifyAgility  Adds passed value to base attribute value, then calls CalculateStatBonus. ])
-- @return void
-- @param flNewAgility float
function CDOTA_BaseNPC_Hero:ModifyAgility( flNewAgility ) end

---[[ CDOTA_BaseNPC_Hero:ModifyGold  Gives this hero some gold.  Args: int nGoldChange, bool bReliable, int reason ])
-- @return int
-- @param iGoldChange int
-- @param bReliable bool
-- @param iReason int
function CDOTA_BaseNPC_Hero:ModifyGold( iGoldChange, bReliable, iReason ) end

---[[ CDOTA_BaseNPC_Hero:ModifyGoldFiltered  Gives this hero some gold, using the gold filter if extra filtering is on.  Args: int nGoldChange, bool bReliable, int reason ])
-- @return int
-- @param iGoldChange int
-- @param bReliabe bool
-- @param iReason int
function CDOTA_BaseNPC_Hero:ModifyGoldFiltered( iGoldChange, bReliabe, iReason ) end

---[[ CDOTA_BaseNPC_Hero:ModifyIntellect  Adds passed value to base attribute value, then calls CalculateStatBonus. ])
-- @return void
-- @param flNewIntellect float
function CDOTA_BaseNPC_Hero:ModifyIntellect( flNewIntellect ) end

---[[ CDOTA_BaseNPC_Hero:ModifyStrength  Adds passed value to base attribute value, then calls CalculateStatBonus. ])
-- @return void
-- @param flNewStrength float
function CDOTA_BaseNPC_Hero:ModifyStrength( flNewStrength ) end

---[[ CDOTA_BaseNPC_Hero:PerformTaunt   ])
-- @return void
function CDOTA_BaseNPC_Hero:PerformTaunt(  ) end

---[[ CDOTA_BaseNPC_Hero:RecordLastHit   ])
-- @return void
function CDOTA_BaseNPC_Hero:RecordLastHit(  ) end

---[[ CDOTA_BaseNPC_Hero:RespawnHero  Respawn this hero. ])
-- @return void
-- @param bBuyBack bool
-- @param bRespawnPenalty bool
function CDOTA_BaseNPC_Hero:RespawnHero( bBuyBack, bRespawnPenalty ) end

---[[ CDOTA_BaseNPC_Hero:SetAbilityPoints  Sets the current unspent ability points. ])
-- @return void
-- @param iPoints int
function CDOTA_BaseNPC_Hero:SetAbilityPoints( iPoints ) end

---[[ CDOTA_BaseNPC_Hero:SetBaseAgility   ])
-- @return void
-- @param flAgility float
function CDOTA_BaseNPC_Hero:SetBaseAgility( flAgility ) end

---[[ CDOTA_BaseNPC_Hero:SetBaseIntellect   ])
-- @return void
-- @param flIntellect float
function CDOTA_BaseNPC_Hero:SetBaseIntellect( flIntellect ) end

---[[ CDOTA_BaseNPC_Hero:SetBaseStrength   ])
-- @return void
-- @param flStrength float
function CDOTA_BaseNPC_Hero:SetBaseStrength( flStrength ) end

---[[ CDOTA_BaseNPC_Hero:SetBotDifficulty   ])
-- @return void
-- @param nDifficulty int
function CDOTA_BaseNPC_Hero:SetBotDifficulty( nDifficulty ) end

---[[ CDOTA_BaseNPC_Hero:SetBuyBackDisabledByReapersScythe   ])
-- @return void
-- @param bBuybackDisabled bool
function CDOTA_BaseNPC_Hero:SetBuyBackDisabledByReapersScythe( bBuybackDisabled ) end

---[[ CDOTA_BaseNPC_Hero:SetBuybackCooldownTime  Sets the buyback cooldown time. ])
-- @return void
-- @param flTime float
function CDOTA_BaseNPC_Hero:SetBuybackCooldownTime( flTime ) end

---[[ CDOTA_BaseNPC_Hero:SetBuybackGoldLimitTime  Set the amount of time gold gain is limited after buying back. ])
-- @return void
-- @param flTime float
function CDOTA_BaseNPC_Hero:SetBuybackGoldLimitTime( flTime ) end

---[[ CDOTA_BaseNPC_Hero:SetCustomDeathXP  Sets a custom experience value for this hero.  Note, GameRules boolean must be set for this to work! ])
-- @return void
-- @param iValue int
function CDOTA_BaseNPC_Hero:SetCustomDeathXP( iValue ) end

---[[ CDOTA_BaseNPC_Hero:SetGold  Sets the gold amount for the player owning this hero ])
-- @return void
-- @param iGold int
-- @param bReliable bool
function CDOTA_BaseNPC_Hero:SetGold( iGold, bReliable ) end

---[[ CDOTA_BaseNPC_Hero:SetPlayerID   ])
-- @return void
-- @param iPlayerID int
function CDOTA_BaseNPC_Hero:SetPlayerID( iPlayerID ) end

---[[ CDOTA_BaseNPC_Hero:SetPrimaryAttribute  Set this hero's primary attribute value. ])
-- @return void
-- @param nPrimaryAttribute int
function CDOTA_BaseNPC_Hero:SetPrimaryAttribute( nPrimaryAttribute ) end

---[[ CDOTA_BaseNPC_Hero:SetRespawnPosition   ])
-- @return void
-- @param vOrigin Vector
function CDOTA_BaseNPC_Hero:SetRespawnPosition( vOrigin ) end

---[[ CDOTA_BaseNPC_Hero:SetRespawnsDisabled  Prevent this hero from respawning. ])
-- @return void
-- @param bDisableRespawns bool
function CDOTA_BaseNPC_Hero:SetRespawnsDisabled( bDisableRespawns ) end

---[[ CDOTA_BaseNPC_Hero:SetStashEnabled   ])
-- @return void
-- @param bEnabled bool
function CDOTA_BaseNPC_Hero:SetStashEnabled( bEnabled ) end

---[[ CDOTA_BaseNPC_Hero:SetTimeUntilRespawn   ])
-- @return void
-- @param time float
function CDOTA_BaseNPC_Hero:SetTimeUntilRespawn( time ) end

---[[ CDOTA_BaseNPC_Hero:ShouldDoFlyHeightVisual   ])
-- @return bool
function CDOTA_BaseNPC_Hero:ShouldDoFlyHeightVisual(  ) end

---[[ CDOTA_BaseNPC_Hero:SpendGold  Args: int nGold, int nReason ])
-- @return void
-- @param iCost int
-- @param iReason int
function CDOTA_BaseNPC_Hero:SpendGold( iCost, iReason ) end

---[[ CDOTA_BaseNPC_Hero:UpgradeAbility  This upgrades the passed ability if it exists and the hero has enough ability points. ])
-- @return void
-- @param hAbility handle
function CDOTA_BaseNPC_Hero:UpgradeAbility( hAbility ) end

---[[ CDOTA_BaseNPC_Hero:WillReincarnate   ])
-- @return bool
function CDOTA_BaseNPC_Hero:WillReincarnate(  ) end

---[[ CDOTA_BaseNPC_Shop:GetShopType  Get the DOTA_SHOP_TYPE ])
-- @return int
function CDOTA_BaseNPC_Shop:GetShopType(  ) end

---[[ CDOTA_BaseNPC_Shop:SetShopType  Set the DOTA_SHOP_TYPE. ])
-- @return void
-- @param eShopType int
function CDOTA_BaseNPC_Shop:SetShopType( eShopType ) end

---[[ CDOTA_BaseNPC_Trap_Ward:GetTrapTarget  Get the trap target for this entity. ])
-- @return Vector
function CDOTA_BaseNPC_Trap_Ward:GetTrapTarget(  ) end

---[[ CDOTA_BaseNPC_Trap_Ward:SetAnimation  Set the animation sequence for this entity. ])
-- @return void
-- @param pAnimation string
function CDOTA_BaseNPC_Trap_Ward:SetAnimation( pAnimation ) end

---[[ CDOTA_BaseNPC_Watch_Tower:GetInteractAbilityName  The name of the ability used when triggering interaction on the outpost. ])
-- @return string
function CDOTA_BaseNPC_Watch_Tower:GetInteractAbilityName(  ) end

---[[ CDOTA_BaseNPC_Watch_Tower:SetInteractAbilityName  The name of the ability used when triggering interaction on the outpost. ])
-- @return void
-- @param pszInteractAbilityName string
function CDOTA_BaseNPC_Watch_Tower:SetInteractAbilityName( pszInteractAbilityName ) end

---[[ CDOTA_Buff:AddParticle  (index, bDestroyImmediately, bStatusEffect, priority, bHeroEffect, bOverheadEffect ])
-- @return void
-- @param i int
-- @param bDestroyImmediately bool
-- @param bStatusEffect bool
-- @param iPriority int
-- @param bHeroEffect bool
-- @param bOverheadEffect bool
function CDOTA_Buff:AddParticle( i, bDestroyImmediately, bStatusEffect, iPriority, bHeroEffect, bOverheadEffect ) end

---[[ CDOTA_Buff:CheckStateToTable   ])
-- @return void
-- @param table handle
function CDOTA_Buff:CheckStateToTable( table ) end

---[[ CDOTA_Buff:DecrementStackCount  Decrease this modifier's stack count by 1. ])
-- @return void
function CDOTA_Buff:DecrementStackCount(  ) end

---[[ CDOTA_Buff:Destroy  Run all associated destroy functions, then remove the modifier. ])
-- @return void
function CDOTA_Buff:Destroy(  ) end

---[[ CDOTA_Buff:DestroyOnExpire   ])
-- @return bool
function CDOTA_Buff:DestroyOnExpire(  ) end

---[[ CDOTA_Buff:ForceRefresh  Run all associated refresh functions on this modifier as if it was re-applied. ])
-- @return void
function CDOTA_Buff:ForceRefresh(  ) end

---[[ CDOTA_Buff:GetAbility  Get the ability that generated the modifier. ])
-- @return handle
function CDOTA_Buff:GetAbility(  ) end

---[[ CDOTA_Buff:GetAuraDuration  Returns aura stickiness (default 0.5) ])
-- @return float
function CDOTA_Buff:GetAuraDuration(  ) end

---[[ CDOTA_Buff:GetAuraOwner   ])
-- @return handle
function CDOTA_Buff:GetAuraOwner(  ) end

---[[ CDOTA_Buff:GetCaster  Get the owner of the ability responsible for the modifier. ])
-- @return handle
function CDOTA_Buff:GetCaster(  ) end

---[[ CDOTA_Buff:GetClass   ])
-- @return string
function CDOTA_Buff:GetClass(  ) end

---[[ CDOTA_Buff:GetCreationTime   ])
-- @return float
function CDOTA_Buff:GetCreationTime(  ) end

---[[ CDOTA_Buff:GetDieTime   ])
-- @return float
function CDOTA_Buff:GetDieTime(  ) end

---[[ CDOTA_Buff:GetDuration   ])
-- @return float
function CDOTA_Buff:GetDuration(  ) end

---[[ CDOTA_Buff:GetElapsedTime   ])
-- @return float
function CDOTA_Buff:GetElapsedTime(  ) end

---[[ CDOTA_Buff:GetLastAppliedTime   ])
-- @return float
function CDOTA_Buff:GetLastAppliedTime(  ) end

---[[ CDOTA_Buff:GetName   ])
-- @return string
function CDOTA_Buff:GetName(  ) end

---[[ CDOTA_Buff:GetParent  Get the unit the modifier is parented to. ])
-- @return handle
function CDOTA_Buff:GetParent(  ) end

---[[ CDOTA_Buff:GetRemainingTime   ])
-- @return float
function CDOTA_Buff:GetRemainingTime(  ) end

---[[ CDOTA_Buff:GetSerialNumber   ])
-- @return int
function CDOTA_Buff:GetSerialNumber(  ) end

---[[ CDOTA_Buff:GetStackCount   ])
-- @return int
function CDOTA_Buff:GetStackCount(  ) end

---[[ CDOTA_Buff:HasFunction   ])
-- @return bool
-- @param iFunction int
function CDOTA_Buff:HasFunction( iFunction ) end

---[[ CDOTA_Buff:IncrementStackCount  Increase this modifier's stack count by 1. ])
-- @return void
function CDOTA_Buff:IncrementStackCount(  ) end

---[[ CDOTA_Buff:IsDebuff   ])
-- @return bool
function CDOTA_Buff:IsDebuff(  ) end

---[[ CDOTA_Buff:IsHexDebuff   ])
-- @return bool
function CDOTA_Buff:IsHexDebuff(  ) end

---[[ CDOTA_Buff:IsStunDebuff   ])
-- @return bool
function CDOTA_Buff:IsStunDebuff(  ) end

---[[ CDOTA_Buff:SendBuffRefreshToClients   ])
-- @return void
function CDOTA_Buff:SendBuffRefreshToClients(  ) end

---[[ CDOTA_Buff:SetDuration  (flTime, bInformClients) ])
-- @return void
-- @param flDuration float
-- @param bInformClient bool
function CDOTA_Buff:SetDuration( flDuration, bInformClient ) end

---[[ CDOTA_Buff:SetStackCount   ])
-- @return void
-- @param iCount int
function CDOTA_Buff:SetStackCount( iCount ) end

---[[ CDOTA_Buff:StartIntervalThink  Start this modifier's think function (OnIntervalThink) with the given interval (float).  To stop, call with -1. ])
-- @return void
-- @param flInterval float
function CDOTA_Buff:StartIntervalThink( flInterval ) end

---[[ CDOTA_CustomUIManager:DynamicHud_Create  Create a new custom UI HUD element for the specified player(s). ( int PlayerID /*-1 means everyone*/, string ElementID /* should be unique */, string LayoutFileName, table DialogVariables /* can be nil */ ) ])
-- @return void
-- @param int_1 int
-- @param string_2 string
-- @param string_3 string
-- @param handle_4 handle
function CDOTA_CustomUIManager:DynamicHud_Create( int_1, string_2, string_3, handle_4 ) end

---[[ CDOTA_CustomUIManager:DynamicHud_Destroy  Destroy a custom hud element ( int PlayerID /*-1 means everyone*/, string ElementID ) ])
-- @return void
-- @param int_1 int
-- @param string_2 string
function CDOTA_CustomUIManager:DynamicHud_Destroy( int_1, string_2 ) end

---[[ CDOTA_CustomUIManager:DynamicHud_SetDialogVariables  Add or modify dialog variables for an existing custom hud element ( int PlayerID /*-1 means everyone*/, string ElementID, table DialogVariables ) ])
-- @return void
-- @param int_1 int
-- @param string_2 string
-- @param handle_3 handle
function CDOTA_CustomUIManager:DynamicHud_SetDialogVariables( int_1, string_2, handle_3 ) end

---[[ CDOTA_CustomUIManager:DynamicHud_SetVisible  Toggle the visibility of an existing custom hud element ( int PlayerID /*-1 means everyone*/, string ElementID, bool Visible ) ])
-- @return void
-- @param int_1 int
-- @param string_2 string
-- @param bool_3 bool
function CDOTA_CustomUIManager:DynamicHud_SetVisible( int_1, string_2, bool_3 ) end

---[[ CDOTA_Item:CanBeUsedOutOfInventory   ])
-- @return bool
function CDOTA_Item:CanBeUsedOutOfInventory(  ) end

---[[ CDOTA_Item:GetContainer  Get the container for this item. ])
-- @return handle
function CDOTA_Item:GetContainer(  ) end

---[[ CDOTA_Item:GetCost   ])
-- @return int
function CDOTA_Item:GetCost(  ) end

---[[ CDOTA_Item:GetCurrentCharges  Get the number of charges this item currently has. ])
-- @return int
function CDOTA_Item:GetCurrentCharges(  ) end

---[[ CDOTA_Item:GetInitialCharges  Get the initial number of charges this item has. ])
-- @return int
function CDOTA_Item:GetInitialCharges(  ) end

---[[ CDOTA_Item:GetItemSlot   ])
-- @return int
function CDOTA_Item:GetItemSlot(  ) end

---[[ CDOTA_Item:GetItemState  Gets whether item is unequipped or ready. ])
-- @return int
function CDOTA_Item:GetItemState(  ) end

---[[ CDOTA_Item:GetParent  Get the parent for this item. ])
-- @return handle
function CDOTA_Item:GetParent(  ) end

---[[ CDOTA_Item:GetPurchaseTime  Get the purchase time of this item ])
-- @return float
function CDOTA_Item:GetPurchaseTime(  ) end

---[[ CDOTA_Item:GetPurchaser  Get the purchaser for this item. ])
-- @return handle
function CDOTA_Item:GetPurchaser(  ) end

---[[ CDOTA_Item:GetSecondaryCharges  Get the number of secondary charges this item currently has. ])
-- @return int
function CDOTA_Item:GetSecondaryCharges(  ) end

---[[ CDOTA_Item:GetShareability   ])
-- @return int
function CDOTA_Item:GetShareability(  ) end

---[[ CDOTA_Item:GetValuelessCharges  Get the number of valueless charges this item currently has. ])
-- @return int
function CDOTA_Item:GetValuelessCharges(  ) end

---[[ CDOTA_Item:IsAlertableItem   ])
-- @return bool
function CDOTA_Item:IsAlertableItem(  ) end

---[[ CDOTA_Item:IsCastOnPickup   ])
-- @return bool
function CDOTA_Item:IsCastOnPickup(  ) end

---[[ CDOTA_Item:IsCombinable   ])
-- @return bool
function CDOTA_Item:IsCombinable(  ) end

---[[ CDOTA_Item:IsCombineLocked   ])
-- @return bool
function CDOTA_Item:IsCombineLocked(  ) end

---[[ CDOTA_Item:IsDisassemblable   ])
-- @return bool
function CDOTA_Item:IsDisassemblable(  ) end

---[[ CDOTA_Item:IsDroppable   ])
-- @return bool
function CDOTA_Item:IsDroppable(  ) end

---[[ CDOTA_Item:IsInBackpack   ])
-- @return bool
function CDOTA_Item:IsInBackpack(  ) end

---[[ CDOTA_Item:IsItem   ])
-- @return bool
function CDOTA_Item:IsItem(  ) end

---[[ CDOTA_Item:IsKillable   ])
-- @return bool
function CDOTA_Item:IsKillable(  ) end

---[[ CDOTA_Item:IsMuted   ])
-- @return bool
function CDOTA_Item:IsMuted(  ) end

---[[ CDOTA_Item:IsNeutralDrop   ])
-- @return bool
function CDOTA_Item:IsNeutralDrop(  ) end

---[[ CDOTA_Item:IsPermanent  Is this a permanent item? ])
-- @return bool
function CDOTA_Item:IsPermanent(  ) end

---[[ CDOTA_Item:IsPurchasable   ])
-- @return bool
function CDOTA_Item:IsPurchasable(  ) end

---[[ CDOTA_Item:IsRecipe   ])
-- @return bool
function CDOTA_Item:IsRecipe(  ) end

---[[ CDOTA_Item:IsRecipeGenerated   ])
-- @return bool
function CDOTA_Item:IsRecipeGenerated(  ) end

---[[ CDOTA_Item:IsSellable   ])
-- @return bool
function CDOTA_Item:IsSellable(  ) end

---[[ CDOTA_Item:IsStackable   ])
-- @return bool
function CDOTA_Item:IsStackable(  ) end

---[[ CDOTA_Item:LaunchLoot   ])
-- @return void
-- @param bAutoUse bool
-- @param flHeight float
-- @param flDuration float
-- @param vEndPoint Vector
function CDOTA_Item:LaunchLoot( bAutoUse, flHeight, flDuration, vEndPoint ) end

---[[ CDOTA_Item:LaunchLootInitialHeight   ])
-- @return void
-- @param bAutoUse bool
-- @param flInitialHeight float
-- @param flLaunchHeight float
-- @param flDuration float
-- @param vEndPoint Vector
function CDOTA_Item:LaunchLootInitialHeight( bAutoUse, flInitialHeight, flLaunchHeight, flDuration, vEndPoint ) end

---[[ CDOTA_Item:LaunchLootRequiredHeight   ])
-- @return void
-- @param bAutoUse bool
-- @param flRequiredHeight float
-- @param flHeight float
-- @param flDuration float
-- @param vEndPoint Vector
function CDOTA_Item:LaunchLootRequiredHeight( bAutoUse, flRequiredHeight, flHeight, flDuration, vEndPoint ) end

---[[ CDOTA_Item:ModifyNumValuelessCharges  Modifies the number of valueless charges on this item ])
-- @return void
-- @param iCharges int
function CDOTA_Item:ModifyNumValuelessCharges( iCharges ) end

---[[ CDOTA_Item:OnEquip   ])
-- @return void
function CDOTA_Item:OnEquip(  ) end

---[[ CDOTA_Item:OnUnequip   ])
-- @return void
function CDOTA_Item:OnUnequip(  ) end

---[[ CDOTA_Item:RequiresCharges   ])
-- @return bool
function CDOTA_Item:RequiresCharges(  ) end

---[[ CDOTA_Item:SetCanBeUsedOutOfInventory   ])
-- @return void
-- @param bValue bool
function CDOTA_Item:SetCanBeUsedOutOfInventory( bValue ) end

---[[ CDOTA_Item:SetCastOnPickup   ])
-- @return void
-- @param bCastOnPickUp bool
function CDOTA_Item:SetCastOnPickup( bCastOnPickUp ) end

---[[ CDOTA_Item:SetCombineLocked   ])
-- @return void
-- @param bCombineLocked bool
function CDOTA_Item:SetCombineLocked( bCombineLocked ) end

---[[ CDOTA_Item:SetCurrentCharges  Set the number of charges on this item ])
-- @return void
-- @param iCharges int
function CDOTA_Item:SetCurrentCharges( iCharges ) end

---[[ CDOTA_Item:SetDroppable   ])
-- @return void
-- @param bDroppable bool
function CDOTA_Item:SetDroppable( bDroppable ) end

---[[ CDOTA_Item:SetItemState  Sets whether item is unequipped or ready. ])
-- @return void
-- @param iState int
function CDOTA_Item:SetItemState( iState ) end

---[[ CDOTA_Item:SetOnlyPlayerHeroPickup   ])
-- @return void
-- @param bOnlyPlayerHero bool
function CDOTA_Item:SetOnlyPlayerHeroPickup( bOnlyPlayerHero ) end

---[[ CDOTA_Item:SetPurchaseTime  Set the purchase time of this item ])
-- @return void
-- @param flTime float
function CDOTA_Item:SetPurchaseTime( flTime ) end

---[[ CDOTA_Item:SetPurchaser  Set the purchaser of record for this item. ])
-- @return void
-- @param hPurchaser handle
function CDOTA_Item:SetPurchaser( hPurchaser ) end

---[[ CDOTA_Item:SetSecondaryCharges  Set the number of secondary charges on this item ])
-- @return void
-- @param iCharges int
function CDOTA_Item:SetSecondaryCharges( iCharges ) end

---[[ CDOTA_Item:SetSellable   ])
-- @return void
-- @param bSellable bool
function CDOTA_Item:SetSellable( bSellable ) end

---[[ CDOTA_Item:SetShareability   ])
-- @return void
-- @param iShareability int
function CDOTA_Item:SetShareability( iShareability ) end

---[[ CDOTA_Item:SetStacksWithOtherOwners   ])
-- @return void
-- @param bStacksWithOtherOwners bool
function CDOTA_Item:SetStacksWithOtherOwners( bStacksWithOtherOwners ) end

---[[ CDOTA_Item:SpendCharge   ])
-- @return void
function CDOTA_Item:SpendCharge(  ) end

---[[ CDOTA_Item:StacksWithOtherOwners   ])
-- @return bool
function CDOTA_Item:StacksWithOtherOwners(  ) end

---[[ CDOTA_Item:Think  Think this item ])
-- @return void
function CDOTA_Item:Think(  ) end

---[[ CDOTA_ItemSpawner:GetItemName  Returns the item name ])
-- @return string
function CDOTA_ItemSpawner:GetItemName(  ) end

---[[ CDOTA_Item_BagOfGold:SetLifeTime  Set the life time of this item ])
-- @return void
-- @param flTime float
function CDOTA_Item_BagOfGold:SetLifeTime( flTime ) end

---[[ CDOTA_Item_DataDriven:ApplyDataDrivenModifier  Applies a data driven modifier to the target ])
-- @return void
-- @param hCaster handle
-- @param hTarget handle
-- @param pszModifierName string
-- @param hModifierTable handle
function CDOTA_Item_DataDriven:ApplyDataDrivenModifier( hCaster, hTarget, pszModifierName, hModifierTable ) end

---[[ CDOTA_Item_DataDriven:ApplyDataDrivenThinker  Applies a data driven thinker at the location ])
-- @return handle
-- @param hCaster handle
-- @param vLocation Vector
-- @param pszModifierName string
-- @param hModifierTable handle
function CDOTA_Item_DataDriven:ApplyDataDrivenThinker( hCaster, vLocation, pszModifierName, hModifierTable ) end

---[[ CDOTA_Item_Lua:CanUnitPickUp  Returns true if this item can be picked up by the target unit. ])
-- @return bool
-- @param hUnit handle
function CDOTA_Item_Lua:CanUnitPickUp( hUnit ) end

---[[ CDOTA_Item_Lua:CastFilterResult  Determine whether an issued command with no target is valid. ])
-- @return int
function CDOTA_Item_Lua:CastFilterResult(  ) end

---[[ CDOTA_Item_Lua:CastFilterResultLocation  (Vector vLocation) Determine whether an issued command on a location is valid. ])
-- @return int
-- @param vLocation Vector
function CDOTA_Item_Lua:CastFilterResultLocation( vLocation ) end

---[[ CDOTA_Item_Lua:CastFilterResultTarget  (HSCRIPT hTarget) Determine whether an issued command on a target is valid. ])
-- @return int
-- @param hTarget handle
function CDOTA_Item_Lua:CastFilterResultTarget( hTarget ) end

---[[ CDOTA_Item_Lua:GetAssociatedPrimaryAbilities  Returns abilities that are stolen simultaneously, or otherwise related in functionality. ])
-- @return string
function CDOTA_Item_Lua:GetAssociatedPrimaryAbilities(  ) end

---[[ CDOTA_Item_Lua:GetAssociatedSecondaryAbilities  Returns other abilities that are stolen simultaneously, or otherwise related in functionality.  Generally hidden abilities. ])
-- @return string
function CDOTA_Item_Lua:GetAssociatedSecondaryAbilities(  ) end

---[[ CDOTA_Item_Lua:GetBehavior  Return cast behavior type of this ability. ])
-- @return int
function CDOTA_Item_Lua:GetBehavior(  ) end

---[[ CDOTA_Item_Lua:GetCastRange  Return cast range of this ability. ])
-- @return int
-- @param vLocation Vector
-- @param hTarget handle
function CDOTA_Item_Lua:GetCastRange( vLocation, hTarget ) end

---[[ CDOTA_Item_Lua:GetChannelTime  Return the channel time of this ability. ])
-- @return float
function CDOTA_Item_Lua:GetChannelTime(  ) end

---[[ CDOTA_Item_Lua:GetChannelledManaCostPerSecond  Return mana cost at the given level per second while channeling (-1 is current). ])
-- @return int
-- @param iLevel int
function CDOTA_Item_Lua:GetChannelledManaCostPerSecond( iLevel ) end

---[[ CDOTA_Item_Lua:GetConceptRecipientType  Return who hears speech when this spell is cast. ])
-- @return int
function CDOTA_Item_Lua:GetConceptRecipientType(  ) end

---[[ CDOTA_Item_Lua:GetCooldown  Return cooldown of this ability. ])
-- @return float
-- @param iLevel int
function CDOTA_Item_Lua:GetCooldown( iLevel ) end

---[[ CDOTA_Item_Lua:GetCustomCastError  Return the error string of a failed command with no target. ])
-- @return string
function CDOTA_Item_Lua:GetCustomCastError(  ) end

---[[ CDOTA_Item_Lua:GetCustomCastErrorLocation  (Vector vLocation) Return the error string of a failed command on a location. ])
-- @return string
-- @param vLocation Vector
function CDOTA_Item_Lua:GetCustomCastErrorLocation( vLocation ) end

---[[ CDOTA_Item_Lua:GetCustomCastErrorTarget  (HSCRIPT hTarget) Return the error string of a failed command on a target. ])
-- @return string
-- @param hTarget handle
function CDOTA_Item_Lua:GetCustomCastErrorTarget( hTarget ) end

---[[ CDOTA_Item_Lua:GetEffectiveCastRange  Return cast range of this ability, taking modifiers into account. ])
-- @return int
-- @param vLocation Vector
-- @param hTarget handle
function CDOTA_Item_Lua:GetEffectiveCastRange( vLocation, hTarget ) end

---[[ CDOTA_Item_Lua:GetGoldCost  Return gold cost at the given level (-1 is current). ])
-- @return int
-- @param iLevel int
function CDOTA_Item_Lua:GetGoldCost( iLevel ) end

---[[ CDOTA_Item_Lua:GetIntrinsicModifierName  Returns the name of the modifier applied passively by this ability. ])
-- @return string
function CDOTA_Item_Lua:GetIntrinsicModifierName(  ) end

---[[ CDOTA_Item_Lua:GetManaCost  Return mana cost at the given level (-1 is current). ])
-- @return int
-- @param iLevel int
function CDOTA_Item_Lua:GetManaCost( iLevel ) end

---[[ CDOTA_Item_Lua:GetPlaybackRateOverride  Return the animation rate of the cast animation. ])
-- @return float
function CDOTA_Item_Lua:GetPlaybackRateOverride(  ) end

---[[ CDOTA_Item_Lua:IsHiddenAbilityCastable  Returns true if this ability can be used when not on the action panel. ])
-- @return bool
function CDOTA_Item_Lua:IsHiddenAbilityCastable(  ) end

---[[ CDOTA_Item_Lua:IsHiddenWhenStolen  Returns true if this ability is hidden when stolen by Spell Steal. ])
-- @return bool
function CDOTA_Item_Lua:IsHiddenWhenStolen(  ) end

---[[ CDOTA_Item_Lua:IsMuted  Returns whether this item is muted or not. ])
-- @return bool
function CDOTA_Item_Lua:IsMuted(  ) end

---[[ CDOTA_Item_Lua:IsRefreshable  Returns true if this ability is refreshed by Refresher Orb. ])
-- @return bool
function CDOTA_Item_Lua:IsRefreshable(  ) end

---[[ CDOTA_Item_Lua:IsStealable  Returns true if this ability can be stolen by Spell Steal. ])
-- @return bool
function CDOTA_Item_Lua:IsStealable(  ) end

---[[ CDOTA_Item_Lua:OnAbilityPhaseInterrupted  Cast time did not complete successfully. ])
-- @return void
function CDOTA_Item_Lua:OnAbilityPhaseInterrupted(  ) end

---[[ CDOTA_Item_Lua:OnAbilityPhaseStart  Cast time begins (return true for successful cast). ])
-- @return bool
function CDOTA_Item_Lua:OnAbilityPhaseStart(  ) end

---[[ CDOTA_Item_Lua:OnChannelFinish  (bool bInterrupted) Channel finished. ])
-- @return void
-- @param bInterrupted bool
function CDOTA_Item_Lua:OnChannelFinish( bInterrupted ) end

---[[ CDOTA_Item_Lua:OnChannelThink  (float flInterval) Channeling is taking place. ])
-- @return void
-- @param flInterval float
function CDOTA_Item_Lua:OnChannelThink( flInterval ) end

---[[ CDOTA_Item_Lua:OnChargeCountChanged  Runs when item's charge count changes. ])
-- @return void
function CDOTA_Item_Lua:OnChargeCountChanged(  ) end

---[[ CDOTA_Item_Lua:OnHeroCalculateStatBonus  Caster (hero only) gained a level, skilled an ability, or received a new stat bonus. ])
-- @return void
function CDOTA_Item_Lua:OnHeroCalculateStatBonus(  ) end

---[[ CDOTA_Item_Lua:OnHeroDiedNearby  A hero has died in the vicinity (ie Urn), takes table of params. ])
-- @return void
-- @param unit handle
-- @param attacker handle
-- @param table handle
function CDOTA_Item_Lua:OnHeroDiedNearby( unit, attacker, table ) end

---[[ CDOTA_Item_Lua:OnHeroLevelUp  Caster gained a level. ])
-- @return void
function CDOTA_Item_Lua:OnHeroLevelUp(  ) end

---[[ CDOTA_Item_Lua:OnInventoryContentsChanged  Caster inventory changed. ])
-- @return void
function CDOTA_Item_Lua:OnInventoryContentsChanged(  ) end

---[[ CDOTA_Item_Lua:OnItemEquipped  ( HSCRIPT hItem ) Caster equipped item. ])
-- @return void
-- @param hItem handle
function CDOTA_Item_Lua:OnItemEquipped( hItem ) end

---[[ CDOTA_Item_Lua:OnOwnerDied  Caster died. ])
-- @return void
function CDOTA_Item_Lua:OnOwnerDied(  ) end

---[[ CDOTA_Item_Lua:OnOwnerSpawned  Caster respawned or spawned for the first time. ])
-- @return void
function CDOTA_Item_Lua:OnOwnerSpawned(  ) end

---[[ CDOTA_Item_Lua:OnProjectileHit  (HSCRIPT hTarget, Vector vLocation) Projectile has collided with a given target or reached its destination (target is invalid). ])
-- @return bool
-- @param hTarget handle
-- @param vLocation Vector
function CDOTA_Item_Lua:OnProjectileHit( hTarget, vLocation ) end

---[[ CDOTA_Item_Lua:OnProjectileThink  (Vector vLocation) Projectile is actively moving. ])
-- @return void
-- @param vLocation Vector
function CDOTA_Item_Lua:OnProjectileThink( vLocation ) end

---[[ CDOTA_Item_Lua:OnSpellStart  Cast time finished, spell effects begin. ])
-- @return void
function CDOTA_Item_Lua:OnSpellStart(  ) end

---[[ CDOTA_Item_Lua:OnStolen  ( HSCRIPT hAbility ) Special behavior when stolen by Spell Steal. ])
-- @return void
-- @param hSourceAbility handle
function CDOTA_Item_Lua:OnStolen( hSourceAbility ) end

---[[ CDOTA_Item_Lua:OnToggle  Ability is toggled on/off. ])
-- @return void
function CDOTA_Item_Lua:OnToggle(  ) end

---[[ CDOTA_Item_Lua:OnUnStolen  Special behavior when lost by Spell Steal. ])
-- @return void
function CDOTA_Item_Lua:OnUnStolen(  ) end

---[[ CDOTA_Item_Lua:OnUpgrade  Ability gained a level. ])
-- @return void
function CDOTA_Item_Lua:OnUpgrade(  ) end

---[[ CDOTA_Item_Lua:ProcsMagicStick  Returns true if this ability will generate magic stick charges for nearby enemies. ])
-- @return bool
function CDOTA_Item_Lua:ProcsMagicStick(  ) end

---[[ CDOTA_Item_Lua:SpeakTrigger  Return the type of speech used. ])
-- @return int
function CDOTA_Item_Lua:SpeakTrigger(  ) end

---[[ CDOTA_Item_Physical:GetContainedItem  Returned the contained item. ])
-- @return handle
function CDOTA_Item_Physical:GetContainedItem(  ) end

---[[ CDOTA_Item_Physical:GetCreationTime  Returns the game time when this item was created in the world ])
-- @return float
function CDOTA_Item_Physical:GetCreationTime(  ) end

---[[ CDOTA_Item_Physical:SetContainedItem  Set the contained item. ])
-- @return void
-- @param hItem handle
function CDOTA_Item_Physical:SetContainedItem( hItem ) end

---[[ CDOTA_MapTree:CutDown  Cuts down this tree. Parameters: int nTeamNumberKnownTo (-1 = invalid team) ])
-- @return void
-- @param nTeamNumberKnownTo int
function CDOTA_MapTree:CutDown( nTeamNumberKnownTo ) end

---[[ CDOTA_MapTree:CutDownRegrowAfter  Cuts down this tree. Parameters: float flRegrowAfter (-1 = never regrow), int nTeamNumberKnownTo (-1 = invalid team) ])
-- @return void
-- @param flRegrowAfter float
-- @param nTeamNumberKnownTo int
function CDOTA_MapTree:CutDownRegrowAfter( flRegrowAfter, nTeamNumberKnownTo ) end

---[[ CDOTA_MapTree:GrowBack  Grows back the tree if it was cut down. ])
-- @return void
function CDOTA_MapTree:GrowBack(  ) end

---[[ CDOTA_MapTree:IsStanding  Returns true if the tree is standing, false if it has been cut down ])
-- @return bool
function CDOTA_MapTree:IsStanding(  ) end

---[[ CDOTA_Modifier_Lua:AllowIllusionDuplicate  True/false if this modifier is active on illusions. ])
-- @return bool
function CDOTA_Modifier_Lua:AllowIllusionDuplicate(  ) end

---[[ CDOTA_Modifier_Lua:CanParentBeAutoAttacked   ])
-- @return bool
function CDOTA_Modifier_Lua:CanParentBeAutoAttacked(  ) end

---[[ CDOTA_Modifier_Lua:DestroyOnExpire  True/false if this buff is removed when the duration expires. ])
-- @return bool
function CDOTA_Modifier_Lua:DestroyOnExpire(  ) end

---[[ CDOTA_Modifier_Lua:GetAttributes  Return the types of attributes applied to this modifier (enum value from DOTAModifierAttribute_t ])
-- @return int
function CDOTA_Modifier_Lua:GetAttributes(  ) end

---[[ CDOTA_Modifier_Lua:GetAuraDuration  Returns aura stickiness ])
-- @return float
function CDOTA_Modifier_Lua:GetAuraDuration(  ) end

---[[ CDOTA_Modifier_Lua:GetAuraEntityReject  Return true/false if this entity should receive the aura under specific conditions ])
-- @return bool
-- @param hEntity handle
function CDOTA_Modifier_Lua:GetAuraEntityReject( hEntity ) end

---[[ CDOTA_Modifier_Lua:GetAuraRadius  Return the range around the parent this aura tries to apply its buff. ])
-- @return int
function CDOTA_Modifier_Lua:GetAuraRadius(  ) end

---[[ CDOTA_Modifier_Lua:GetAuraSearchFlags  Return the unit flags this aura respects when placing buffs. ])
-- @return int
function CDOTA_Modifier_Lua:GetAuraSearchFlags(  ) end

---[[ CDOTA_Modifier_Lua:GetAuraSearchTeam  Return the teams this aura applies its buff to. ])
-- @return int
function CDOTA_Modifier_Lua:GetAuraSearchTeam(  ) end

---[[ CDOTA_Modifier_Lua:GetAuraSearchType  Return the unit classifications this aura applies its buff to. ])
-- @return int
function CDOTA_Modifier_Lua:GetAuraSearchType(  ) end

---[[ CDOTA_Modifier_Lua:GetEffectAttachType  Return the attach type of the particle system from GetEffectName. ])
-- @return int
function CDOTA_Modifier_Lua:GetEffectAttachType(  ) end

---[[ CDOTA_Modifier_Lua:GetEffectName  Return the name of the particle system that is created while this modifier is active. ])
-- @return string
function CDOTA_Modifier_Lua:GetEffectName(  ) end

---[[ CDOTA_Modifier_Lua:GetHeroEffectName  Return the name of the hero effect particle system that is created while this modifier is active. ])
-- @return string
function CDOTA_Modifier_Lua:GetHeroEffectName(  ) end

---[[ CDOTA_Modifier_Lua:GetModifierAura  The name of the secondary modifier that will be applied by this modifier (if it is an aura). ])
-- @return string
function CDOTA_Modifier_Lua:GetModifierAura(  ) end

---[[ CDOTA_Modifier_Lua:GetPriority  Return the priority order this modifier will be applied over others. ])
-- @return int
function CDOTA_Modifier_Lua:GetPriority(  ) end

---[[ CDOTA_Modifier_Lua:GetStatusEffectName  Return the name of the status effect particle system that is created while this modifier is active. ])
-- @return string
function CDOTA_Modifier_Lua:GetStatusEffectName(  ) end

---[[ CDOTA_Modifier_Lua:GetTexture  Return the name of the buff icon to be shown for this modifier. ])
-- @return string
function CDOTA_Modifier_Lua:GetTexture(  ) end

---[[ CDOTA_Modifier_Lua:HeroEffectPriority  Relationship of this hero effect with those from other buffs (higher is more likely to be shown). ])
-- @return int
function CDOTA_Modifier_Lua:HeroEffectPriority(  ) end

---[[ CDOTA_Modifier_Lua:IsAura  True/false if this modifier is an aura. ])
-- @return bool
function CDOTA_Modifier_Lua:IsAura(  ) end

---[[ CDOTA_Modifier_Lua:IsAuraActiveOnDeath  True/false if this aura provides buffs when the parent is dead. ])
-- @return bool
function CDOTA_Modifier_Lua:IsAuraActiveOnDeath(  ) end

---[[ CDOTA_Modifier_Lua:IsDebuff  True/false if this modifier should be displayed as a debuff. ])
-- @return bool
function CDOTA_Modifier_Lua:IsDebuff(  ) end

---[[ CDOTA_Modifier_Lua:IsHidden  True/false if this modifier should be displayed on the buff bar. ])
-- @return bool
function CDOTA_Modifier_Lua:IsHidden(  ) end

---[[ CDOTA_Modifier_Lua:IsPermanent   ])
-- @return bool
function CDOTA_Modifier_Lua:IsPermanent(  ) end

---[[ CDOTA_Modifier_Lua:IsPurgable  True/false if this modifier can be purged. ])
-- @return bool
function CDOTA_Modifier_Lua:IsPurgable(  ) end

---[[ CDOTA_Modifier_Lua:IsPurgeException  True/false if this modifier can be purged by strong dispels. ])
-- @return bool
function CDOTA_Modifier_Lua:IsPurgeException(  ) end

---[[ CDOTA_Modifier_Lua:IsStunDebuff  True/false if this modifier is considered a stun for purge reasons. ])
-- @return bool
function CDOTA_Modifier_Lua:IsStunDebuff(  ) end

---[[ CDOTA_Modifier_Lua:OnCreated  Runs when the modifier is created. ])
-- @return void
-- @param table handle
function CDOTA_Modifier_Lua:OnCreated( table ) end

---[[ CDOTA_Modifier_Lua:OnDestroy  Runs when the modifier is destroyed (after unit loses modifier). ])
-- @return void
function CDOTA_Modifier_Lua:OnDestroy(  ) end

---[[ CDOTA_Modifier_Lua:OnIntervalThink  Runs when the think interval occurs. ])
-- @return void
function CDOTA_Modifier_Lua:OnIntervalThink(  ) end

---[[ CDOTA_Modifier_Lua:OnRefresh  Runs when the modifier is refreshed. ])
-- @return void
-- @param table handle
function CDOTA_Modifier_Lua:OnRefresh( table ) end

---[[ CDOTA_Modifier_Lua:OnRemoved  Runs when the modifier is destroyed (before unit loses modifier). ])
-- @return void
function CDOTA_Modifier_Lua:OnRemoved(  ) end

---[[ CDOTA_Modifier_Lua:OnStackCountChanged  Runs when stack count changes (param is old count). ])
-- @return void
-- @param iStackCount int
function CDOTA_Modifier_Lua:OnStackCountChanged( iStackCount ) end

---[[ CDOTA_Modifier_Lua:RemoveOnDeath  True/false if this modifier is removed when the parent dies. ])
-- @return bool
function CDOTA_Modifier_Lua:RemoveOnDeath(  ) end

---[[ CDOTA_Modifier_Lua:SetHasCustomTransmitterData   ])
-- @return void
-- @param bHasCustomData bool
function CDOTA_Modifier_Lua:SetHasCustomTransmitterData( bHasCustomData ) end

---[[ CDOTA_Modifier_Lua:ShouldUseOverheadOffset  Apply the overhead offset to the attached effect. ])
-- @return bool
function CDOTA_Modifier_Lua:ShouldUseOverheadOffset(  ) end

---[[ CDOTA_Modifier_Lua:StatusEffectPriority  Relationship of this status effect with those from other buffs (higher is more likely to be shown). ])
-- @return int
function CDOTA_Modifier_Lua:StatusEffectPriority(  ) end

---[[ CDOTA_Modifier_Lua_Horizontal_Motion:ApplyHorizontalMotionController  Starts the horizontal motion controller effects for this buff.  Returns true if successful. ])
-- @return bool
function CDOTA_Modifier_Lua_Horizontal_Motion:ApplyHorizontalMotionController(  ) end

---[[ CDOTA_Modifier_Lua_Horizontal_Motion:GetPriority  Get the priority ])
-- @return int
function CDOTA_Modifier_Lua_Horizontal_Motion:GetPriority(  ) end

---[[ CDOTA_Modifier_Lua_Horizontal_Motion:OnHorizontalMotionInterrupted  Called when the motion gets interrupted. ])
-- @return void
function CDOTA_Modifier_Lua_Horizontal_Motion:OnHorizontalMotionInterrupted(  ) end

---[[ CDOTA_Modifier_Lua_Horizontal_Motion:SetPriority  Set the priority ])
-- @return void
-- @param nMotionPriority int
function CDOTA_Modifier_Lua_Horizontal_Motion:SetPriority( nMotionPriority ) end

---[[ CDOTA_Modifier_Lua_Horizontal_Motion:UpdateHorizontalMotion  Perform any motion from the given interval on the NPC. ])
-- @return void
-- @param me handle
-- @param dt float
function CDOTA_Modifier_Lua_Horizontal_Motion:UpdateHorizontalMotion( me, dt ) end

---[[ CDOTA_Modifier_Lua_Motion_Both:ApplyHorizontalMotionController  Starts the horizontal motion controller effects for this buff.  Returns true if successful. ])
-- @return bool
function CDOTA_Modifier_Lua_Motion_Both:ApplyHorizontalMotionController(  ) end

---[[ CDOTA_Modifier_Lua_Motion_Both:ApplyVerticalMotionController  Starts the vertical motion controller effects for this buff.  Returns true if successful. ])
-- @return bool
function CDOTA_Modifier_Lua_Motion_Both:ApplyVerticalMotionController(  ) end

---[[ CDOTA_Modifier_Lua_Motion_Both:GetPriority  Get the priority ])
-- @return int
function CDOTA_Modifier_Lua_Motion_Both:GetPriority(  ) end

---[[ CDOTA_Modifier_Lua_Motion_Both:OnHorizontalMotionInterrupted  Called when the motion gets interrupted. ])
-- @return void
function CDOTA_Modifier_Lua_Motion_Both:OnHorizontalMotionInterrupted(  ) end

---[[ CDOTA_Modifier_Lua_Motion_Both:OnVerticalMotionInterrupted  Called when the motion gets interrupted. ])
-- @return void
function CDOTA_Modifier_Lua_Motion_Both:OnVerticalMotionInterrupted(  ) end

---[[ CDOTA_Modifier_Lua_Motion_Both:SetPriority  Set the priority ])
-- @return void
-- @param nMotionPriority int
function CDOTA_Modifier_Lua_Motion_Both:SetPriority( nMotionPriority ) end

---[[ CDOTA_Modifier_Lua_Motion_Both:UpdateHorizontalMotion  Perform any motion from the given interval on the NPC. ])
-- @return void
-- @param me handle
-- @param dt float
function CDOTA_Modifier_Lua_Motion_Both:UpdateHorizontalMotion( me, dt ) end

---[[ CDOTA_Modifier_Lua_Motion_Both:UpdateVerticalMotion  Perform any motion from the given interval on the NPC. ])
-- @return void
-- @param me handle
-- @param dt float
function CDOTA_Modifier_Lua_Motion_Both:UpdateVerticalMotion( me, dt ) end

---[[ CDOTA_Modifier_Lua_Vertical_Motion:ApplyVerticalMotionController  Starts the vertical motion controller effects for this buff.  Returns true if successful. ])
-- @return bool
function CDOTA_Modifier_Lua_Vertical_Motion:ApplyVerticalMotionController(  ) end

---[[ CDOTA_Modifier_Lua_Vertical_Motion:GetMotionPriority  Get the priority ])
-- @return int
function CDOTA_Modifier_Lua_Vertical_Motion:GetMotionPriority(  ) end

---[[ CDOTA_Modifier_Lua_Vertical_Motion:OnVerticalMotionInterrupted  Called when the motion gets interrupted. ])
-- @return void
function CDOTA_Modifier_Lua_Vertical_Motion:OnVerticalMotionInterrupted(  ) end

---[[ CDOTA_Modifier_Lua_Vertical_Motion:SetMotionPriority  Set the priority ])
-- @return void
-- @param nMotionPriority int
function CDOTA_Modifier_Lua_Vertical_Motion:SetMotionPriority( nMotionPriority ) end

---[[ CDOTA_Modifier_Lua_Vertical_Motion:UpdateVerticalMotion  Perform any motion from the given interval on the NPC. ])
-- @return void
-- @param me handle
-- @param dt float
function CDOTA_Modifier_Lua_Vertical_Motion:UpdateVerticalMotion( me, dt ) end

---[[ CDOTA_NeutralSpawner:CreatePendingUnits   ])
-- @return void
function CDOTA_NeutralSpawner:CreatePendingUnits(  ) end

---[[ CDOTA_NeutralSpawner:SelectSpawnType   ])
-- @return void
function CDOTA_NeutralSpawner:SelectSpawnType(  ) end

---[[ CDOTA_NeutralSpawner:SpawnNextBatch   ])
-- @return void
-- @param bIgnoreBlockers bool
function CDOTA_NeutralSpawner:SpawnNextBatch( bIgnoreBlockers ) end

---[[ CDOTA_PlayerResource:AddAegisPickup   ])
-- @return void
-- @param iPlayerID int
function CDOTA_PlayerResource:AddAegisPickup( iPlayerID ) end

---[[ CDOTA_PlayerResource:AddCandyEvent   ])
-- @return void
-- @param iPlayerID int
-- @param nReason int
function CDOTA_PlayerResource:AddCandyEvent( iPlayerID, nReason ) end

---[[ CDOTA_PlayerResource:AddClaimedFarm   ])
-- @return void
-- @param iPlayerID int
-- @param flFarmValue float
-- @param bEarnedValue bool
function CDOTA_PlayerResource:AddClaimedFarm( iPlayerID, flFarmValue, bEarnedValue ) end

---[[ CDOTA_PlayerResource:AddGoldSpentOnSupport   ])
-- @return void
-- @param iPlayerID int
-- @param iCost int
function CDOTA_PlayerResource:AddGoldSpentOnSupport( iPlayerID, iCost ) end

---[[ CDOTA_PlayerResource:AddNeutralItemToStash   ])
-- @return void
-- @param iPlayerID int
-- @param nTeamNumber int
-- @param hItem handle
function CDOTA_PlayerResource:AddNeutralItemToStash( iPlayerID, nTeamNumber, hItem ) end

---[[ CDOTA_PlayerResource:AddRunePickup   ])
-- @return void
-- @param iPlayerID int
function CDOTA_PlayerResource:AddRunePickup( iPlayerID ) end

---[[ CDOTA_PlayerResource:AreUnitsSharedWithPlayerID   ])
-- @return bool
-- @param nUnitOwnerPlayerID int
-- @param nOtherPlayerID int
function CDOTA_PlayerResource:AreUnitsSharedWithPlayerID( nUnitOwnerPlayerID, nOtherPlayerID ) end

---[[ CDOTA_PlayerResource:CanRepick   ])
-- @return bool
-- @param iPlayerID int
function CDOTA_PlayerResource:CanRepick( iPlayerID ) end

---[[ CDOTA_PlayerResource:ClearKillsMatrix   ])
-- @return void
-- @param iPlayerID int
function CDOTA_PlayerResource:ClearKillsMatrix( iPlayerID ) end

---[[ CDOTA_PlayerResource:ClearLastHitMultikill   ])
-- @return void
-- @param iPlayerID int
function CDOTA_PlayerResource:ClearLastHitMultikill( iPlayerID ) end

---[[ CDOTA_PlayerResource:ClearLastHitStreak   ])
-- @return void
-- @param iPlayerID int
function CDOTA_PlayerResource:ClearLastHitStreak( iPlayerID ) end

---[[ CDOTA_PlayerResource:ClearRawPlayerDamageMatrix   ])
-- @return void
-- @param iPlayerID int
function CDOTA_PlayerResource:ClearRawPlayerDamageMatrix( iPlayerID ) end

---[[ CDOTA_PlayerResource:ClearStreak   ])
-- @return void
-- @param iPlayerID int
function CDOTA_PlayerResource:ClearStreak( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetAegisPickups   ])
-- @return int
-- @param iPlayerID int
function CDOTA_PlayerResource:GetAegisPickups( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetAssists   ])
-- @return int
-- @param iPlayerID int
function CDOTA_PlayerResource:GetAssists( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetBroadcasterChannel   ])
-- @return unsigned
-- @param iPlayerID int
function CDOTA_PlayerResource:GetBroadcasterChannel( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetBroadcasterChannelSlot   ])
-- @return unsigned
-- @param iPlayerID int
function CDOTA_PlayerResource:GetBroadcasterChannelSlot( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetClaimedDenies   ])
-- @return int
-- @param iPlayerID int
function CDOTA_PlayerResource:GetClaimedDenies( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetClaimedFarm   ])
-- @return float
-- @param iPlayerID int
-- @param bOnlyEarned bool
function CDOTA_PlayerResource:GetClaimedFarm( iPlayerID, bOnlyEarned ) end

---[[ CDOTA_PlayerResource:GetClaimedMisses   ])
-- @return int
-- @param iPlayerID int
function CDOTA_PlayerResource:GetClaimedMisses( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetConnectionState   ])
-- @return <unknown>
-- @param iPlayerID int
function CDOTA_PlayerResource:GetConnectionState( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetCreepDamageTaken   ])
-- @return int
-- @param iPlayerID int
-- @param bTotal bool
function CDOTA_PlayerResource:GetCreepDamageTaken( iPlayerID, bTotal ) end

---[[ CDOTA_PlayerResource:GetCustomBuybackCooldown   ])
-- @return float
-- @param iPlayerID int
function CDOTA_PlayerResource:GetCustomBuybackCooldown( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetCustomBuybackCost   ])
-- @return int
-- @param iPlayerID int
function CDOTA_PlayerResource:GetCustomBuybackCost( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetCustomTeamAssignment  Get the current custom team assignment for this player. ])
-- @return int
-- @param iPlayerID int
function CDOTA_PlayerResource:GetCustomTeamAssignment( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetDamageDoneToHero   ])
-- @return int
-- @param iPlayerID int
-- @param iVictimID int
function CDOTA_PlayerResource:GetDamageDoneToHero( iPlayerID, iVictimID ) end

---[[ CDOTA_PlayerResource:GetDeaths   ])
-- @return int
-- @param iPlayerID int
function CDOTA_PlayerResource:GetDeaths( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetDenies   ])
-- @return int
-- @param iPlayerID int
function CDOTA_PlayerResource:GetDenies( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetEventGameCustomActionClaimCount  (nPlayerID, nActionID) ])
-- @return int
-- @param nPlayerID int
-- @param unActionID unsigned
function CDOTA_PlayerResource:GetEventGameCustomActionClaimCount( nPlayerID, unActionID ) end

---[[ CDOTA_PlayerResource:GetEventGameCustomActionClaimCountByName  (nPlayerID, pActionName) ])
-- @return int
-- @param nPlayerID int
-- @param pActionName string
function CDOTA_PlayerResource:GetEventGameCustomActionClaimCountByName( nPlayerID, pActionName ) end

---[[ CDOTA_PlayerResource:GetEventPointsForPlayerID   ])
-- @return unsigned
-- @param nPlayerID int
function CDOTA_PlayerResource:GetEventPointsForPlayerID( nPlayerID ) end

---[[ CDOTA_PlayerResource:GetEventPremiumPoints   ])
-- @return unsigned
-- @param nPlayerID int
function CDOTA_PlayerResource:GetEventPremiumPoints( nPlayerID ) end

---[[ CDOTA_PlayerResource:GetEventRanks   ])
-- @return <unknown>
-- @param nPlayerID int
function CDOTA_PlayerResource:GetEventRanks( nPlayerID ) end

---[[ CDOTA_PlayerResource:GetGold   ])
-- @return int
-- @param iPlayerID int
function CDOTA_PlayerResource:GetGold( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetGoldLostToDeath   ])
-- @return int
-- @param iPlayerID int
function CDOTA_PlayerResource:GetGoldLostToDeath( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetGoldPerMin   ])
-- @return float
-- @param iPlayerID int
function CDOTA_PlayerResource:GetGoldPerMin( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetGoldSpentOnBuybacks   ])
-- @return int
-- @param iPlayerID int
function CDOTA_PlayerResource:GetGoldSpentOnBuybacks( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetGoldSpentOnConsumables   ])
-- @return int
-- @param iPlayerID int
function CDOTA_PlayerResource:GetGoldSpentOnConsumables( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetGoldSpentOnItems   ])
-- @return int
-- @param iPlayerID int
function CDOTA_PlayerResource:GetGoldSpentOnItems( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetGoldSpentOnSupport   ])
-- @return int
-- @param iPlayerID int
function CDOTA_PlayerResource:GetGoldSpentOnSupport( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetHealing   ])
-- @return float
-- @param iPlayerID int
function CDOTA_PlayerResource:GetHealing( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetHeroDamageTaken   ])
-- @return int
-- @param iPlayerID int
-- @param bTotal bool
function CDOTA_PlayerResource:GetHeroDamageTaken( iPlayerID, bTotal ) end

---[[ CDOTA_PlayerResource:GetKills   ])
-- @return int
-- @param iPlayerID int
function CDOTA_PlayerResource:GetKills( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetKillsDoneToHero   ])
-- @return int
-- @param iPlayerID int
-- @param iVictimID int
function CDOTA_PlayerResource:GetKillsDoneToHero( iPlayerID, iVictimID ) end

---[[ CDOTA_PlayerResource:GetLastHitMultikill   ])
-- @return int
-- @param iPlayerID int
function CDOTA_PlayerResource:GetLastHitMultikill( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetLastHitStreak   ])
-- @return int
-- @param iPlayerID int
function CDOTA_PlayerResource:GetLastHitStreak( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetLastHits   ])
-- @return int
-- @param iPlayerID int
function CDOTA_PlayerResource:GetLastHits( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetLevel   ])
-- @return int
-- @param iPlayerID int
function CDOTA_PlayerResource:GetLevel( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetLiveSpectatorTeam   ])
-- @return <unknown>
-- @param iPlayerID int
function CDOTA_PlayerResource:GetLiveSpectatorTeam( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetMisses   ])
-- @return int
-- @param iPlayerID int
function CDOTA_PlayerResource:GetMisses( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetNearbyCreepDeaths   ])
-- @return int
-- @param iPlayerID int
function CDOTA_PlayerResource:GetNearbyCreepDeaths( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetNetWorth   ])
-- @return int
-- @param iPlayerID int
function CDOTA_PlayerResource:GetNetWorth( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetNthCourierForTeam   ])
-- @return handle
-- @param nCourierIndex int
-- @param nTeamNumber int
function CDOTA_PlayerResource:GetNthCourierForTeam( nCourierIndex, nTeamNumber ) end

---[[ CDOTA_PlayerResource:GetNthPlayerIDOnTeam   ])
-- @return int
-- @param iTeamNumber int
-- @param iNthPlayer int
function CDOTA_PlayerResource:GetNthPlayerIDOnTeam( iTeamNumber, iNthPlayer ) end

---[[ CDOTA_PlayerResource:GetNumConnectedHumanPlayers  Players on a valid team (radiant, dire, or custom*) who haven't abandoned the game ])
-- @return int
function CDOTA_PlayerResource:GetNumConnectedHumanPlayers(  ) end

---[[ CDOTA_PlayerResource:GetNumConsumablesPurchased   ])
-- @return int
-- @param iPlayerID int
function CDOTA_PlayerResource:GetNumConsumablesPurchased( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetNumCouriersForTeam   ])
-- @return int
-- @param nTeamNumber int
function CDOTA_PlayerResource:GetNumCouriersForTeam( nTeamNumber ) end

---[[ CDOTA_PlayerResource:GetNumItemsPurchased   ])
-- @return int
-- @param iPlayerID int
function CDOTA_PlayerResource:GetNumItemsPurchased( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetPartyID   ])
-- @return uint64
-- @param iPlayerID int
function CDOTA_PlayerResource:GetPartyID( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetPlayer   ])
-- @return handle
-- @param iPlayerID int
function CDOTA_PlayerResource:GetPlayer( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetPlayerCount  Includes spectators and players not assigned to a team ])
-- @return int
function CDOTA_PlayerResource:GetPlayerCount(  ) end

---[[ CDOTA_PlayerResource:GetPlayerCountForTeam   ])
-- @return int
-- @param iTeam int
function CDOTA_PlayerResource:GetPlayerCountForTeam( iTeam ) end

---[[ CDOTA_PlayerResource:GetPlayerLoadedCompletely   ])
-- @return bool
-- @param iPlayerID int
function CDOTA_PlayerResource:GetPlayerLoadedCompletely( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetPlayerName   ])
-- @return string
-- @param iPlayerID int
function CDOTA_PlayerResource:GetPlayerName( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetPreferredCourierForPlayer   ])
-- @return handle
-- @param nPlayerId int
function CDOTA_PlayerResource:GetPreferredCourierForPlayer( nPlayerId ) end

---[[ CDOTA_PlayerResource:GetRawPlayerDamage   ])
-- @return int
-- @param iPlayerID int
function CDOTA_PlayerResource:GetRawPlayerDamage( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetReliableGold   ])
-- @return int
-- @param iPlayerID int
function CDOTA_PlayerResource:GetReliableGold( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetRespawnSeconds   ])
-- @return int
-- @param iPlayerID int
function CDOTA_PlayerResource:GetRespawnSeconds( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetRoshanKills   ])
-- @return int
-- @param iPlayerID int
function CDOTA_PlayerResource:GetRoshanKills( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetRunePickups   ])
-- @return int
-- @param iPlayerID int
function CDOTA_PlayerResource:GetRunePickups( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetSelectedHeroEntity   ])
-- @return handle
-- @param iPlayerID int
function CDOTA_PlayerResource:GetSelectedHeroEntity( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetSelectedHeroID   ])
-- @return int
-- @param iPlayerID int
function CDOTA_PlayerResource:GetSelectedHeroID( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetSelectedHeroName   ])
-- @return string
-- @param iPlayerID int
function CDOTA_PlayerResource:GetSelectedHeroName( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetSteamAccountID   ])
-- @return unsigned
-- @param iPlayerID int
function CDOTA_PlayerResource:GetSteamAccountID( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetSteamID  Get the 64 bit steam ID for a given player. ])
-- @return uint64
-- @param iPlayerID int
function CDOTA_PlayerResource:GetSteamID( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetStreak   ])
-- @return int
-- @param iPlayerID int
function CDOTA_PlayerResource:GetStreak( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetStuns   ])
-- @return float
-- @param iPlayerID int
function CDOTA_PlayerResource:GetStuns( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetTeam   ])
-- @return int
-- @param iPlayerID int
function CDOTA_PlayerResource:GetTeam( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetTeamKills   ])
-- @return int
-- @param iTeam int
function CDOTA_PlayerResource:GetTeamKills( iTeam ) end

---[[ CDOTA_PlayerResource:GetTeamPlayerCount  (Deprecated: use GetNumConnectedHumanPlayers) Players on a valid team (radiant, dire, or custom*) who haven't abandoned the game ])
-- @return int
function CDOTA_PlayerResource:GetTeamPlayerCount(  ) end

---[[ CDOTA_PlayerResource:GetTimeOfLastConsumablePurchase   ])
-- @return float
-- @param iPlayerID int
function CDOTA_PlayerResource:GetTimeOfLastConsumablePurchase( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetTimeOfLastDeath   ])
-- @return float
-- @param iPlayerID int
function CDOTA_PlayerResource:GetTimeOfLastDeath( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetTimeOfLastItemPurchase   ])
-- @return float
-- @param iPlayerID int
function CDOTA_PlayerResource:GetTimeOfLastItemPurchase( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetTotalEarnedGold   ])
-- @return int
-- @param iPlayerID int
function CDOTA_PlayerResource:GetTotalEarnedGold( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetTotalEarnedXP   ])
-- @return int
-- @param iPlayerID int
function CDOTA_PlayerResource:GetTotalEarnedXP( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetTotalGoldSpent   ])
-- @return int
-- @param iPlayerID int
function CDOTA_PlayerResource:GetTotalGoldSpent( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetTowerDamageTaken   ])
-- @return int
-- @param iPlayerID int
-- @param bTotal bool
function CDOTA_PlayerResource:GetTowerDamageTaken( iPlayerID, bTotal ) end

---[[ CDOTA_PlayerResource:GetTowerKills   ])
-- @return int
-- @param iPlayerID int
function CDOTA_PlayerResource:GetTowerKills( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetUnitShareMaskForPlayer   ])
-- @return int
-- @param nPlayerID int
-- @param nOtherPlayerID int
function CDOTA_PlayerResource:GetUnitShareMaskForPlayer( nPlayerID, nOtherPlayerID ) end

---[[ CDOTA_PlayerResource:GetUnreliableGold   ])
-- @return int
-- @param iPlayerID int
function CDOTA_PlayerResource:GetUnreliableGold( iPlayerID ) end

---[[ CDOTA_PlayerResource:GetXPPerMin   ])
-- @return float
-- @param iPlayerID int
function CDOTA_PlayerResource:GetXPPerMin( iPlayerID ) end

---[[ CDOTA_PlayerResource:HasCustomGameTicketForPlayerID  Does this player have a custom game ticket for this game? ])
-- @return bool
-- @param iPlayerID int
function CDOTA_PlayerResource:HasCustomGameTicketForPlayerID( iPlayerID ) end

---[[ CDOTA_PlayerResource:HasRandomed   ])
-- @return bool
-- @param iPlayerID int
function CDOTA_PlayerResource:HasRandomed( iPlayerID ) end

---[[ CDOTA_PlayerResource:HasSelectedHero   ])
-- @return bool
-- @param iPlayerID int
function CDOTA_PlayerResource:HasSelectedHero( iPlayerID ) end

---[[ CDOTA_PlayerResource:HasSetEventGameCustomActionClaimCount   ])
-- @return bool
function CDOTA_PlayerResource:HasSetEventGameCustomActionClaimCount(  ) end

---[[ CDOTA_PlayerResource:HaveAllPlayersJoined   ])
-- @return bool
function CDOTA_PlayerResource:HaveAllPlayersJoined(  ) end

---[[ CDOTA_PlayerResource:IncrementAssists   ])
-- @return void
-- @param iPlayerID int
-- @param iVictimID int
function CDOTA_PlayerResource:IncrementAssists( iPlayerID, iVictimID ) end

---[[ CDOTA_PlayerResource:IncrementClaimedDenies   ])
-- @return void
-- @param iPlayerID int
function CDOTA_PlayerResource:IncrementClaimedDenies( iPlayerID ) end

---[[ CDOTA_PlayerResource:IncrementClaimedMisses   ])
-- @return void
-- @param iPlayerID int
function CDOTA_PlayerResource:IncrementClaimedMisses( iPlayerID ) end

---[[ CDOTA_PlayerResource:IncrementDeaths   ])
-- @return void
-- @param iPlayerID int
-- @param iKillerID int
function CDOTA_PlayerResource:IncrementDeaths( iPlayerID, iKillerID ) end

---[[ CDOTA_PlayerResource:IncrementDenies   ])
-- @return void
-- @param iPlayerID int
function CDOTA_PlayerResource:IncrementDenies( iPlayerID ) end

---[[ CDOTA_PlayerResource:IncrementKills   ])
-- @return void
-- @param iPlayerID int
-- @param iVictimID int
function CDOTA_PlayerResource:IncrementKills( iPlayerID, iVictimID ) end

---[[ CDOTA_PlayerResource:IncrementLastHitMultikill   ])
-- @return void
-- @param iPlayerID int
function CDOTA_PlayerResource:IncrementLastHitMultikill( iPlayerID ) end

---[[ CDOTA_PlayerResource:IncrementLastHitStreak   ])
-- @return void
-- @param iPlayerID int
function CDOTA_PlayerResource:IncrementLastHitStreak( iPlayerID ) end

---[[ CDOTA_PlayerResource:IncrementLastHits   ])
-- @return void
-- @param iPlayerID int
function CDOTA_PlayerResource:IncrementLastHits( iPlayerID ) end

---[[ CDOTA_PlayerResource:IncrementMisses   ])
-- @return void
-- @param iPlayerID int
function CDOTA_PlayerResource:IncrementMisses( iPlayerID ) end

---[[ CDOTA_PlayerResource:IncrementNearbyCreepDeaths   ])
-- @return void
-- @param iPlayerID int
function CDOTA_PlayerResource:IncrementNearbyCreepDeaths( iPlayerID ) end

---[[ CDOTA_PlayerResource:IncrementStreak   ])
-- @return void
-- @param iPlayerID int
function CDOTA_PlayerResource:IncrementStreak( iPlayerID ) end

---[[ CDOTA_PlayerResource:IncrementTotalEarnedXP   ])
-- @return void
-- @param iPlayerID int
-- @param iXP int
-- @param nReason int
function CDOTA_PlayerResource:IncrementTotalEarnedXP( iPlayerID, iXP, nReason ) end

---[[ CDOTA_PlayerResource:IsBroadcaster   ])
-- @return bool
-- @param iPlayerID int
function CDOTA_PlayerResource:IsBroadcaster( iPlayerID ) end

---[[ CDOTA_PlayerResource:IsDisableHelpSetForPlayerID   ])
-- @return bool
-- @param nPlayerID int
-- @param nOtherPlayerID int
function CDOTA_PlayerResource:IsDisableHelpSetForPlayerID( nPlayerID, nOtherPlayerID ) end

---[[ CDOTA_PlayerResource:IsFakeClient   ])
-- @return bool
-- @param iPlayerID int
function CDOTA_PlayerResource:IsFakeClient( iPlayerID ) end

---[[ CDOTA_PlayerResource:IsHeroSelected   ])
-- @return bool
-- @param pHeroname string
-- @param bIgnoreUnrevealedPick bool
function CDOTA_PlayerResource:IsHeroSelected( pHeroname, bIgnoreUnrevealedPick ) end

---[[ CDOTA_PlayerResource:IsHeroSharedWithPlayerID   ])
-- @return bool
-- @param nUnitOwnerPlayerID int
-- @param nOtherPlayerID int
function CDOTA_PlayerResource:IsHeroSharedWithPlayerID( nUnitOwnerPlayerID, nOtherPlayerID ) end

---[[ CDOTA_PlayerResource:IsValidPlayer   ])
-- @return bool
-- @param iPlayerID int
function CDOTA_PlayerResource:IsValidPlayer( iPlayerID ) end

---[[ CDOTA_PlayerResource:IsValidPlayerID   ])
-- @return bool
-- @param iPlayerID int
function CDOTA_PlayerResource:IsValidPlayerID( iPlayerID ) end

---[[ CDOTA_PlayerResource:IsValidTeamPlayer   ])
-- @return bool
-- @param iPlayerID int
function CDOTA_PlayerResource:IsValidTeamPlayer( iPlayerID ) end

---[[ CDOTA_PlayerResource:IsValidTeamPlayerID   ])
-- @return bool
-- @param nPlayerID int
function CDOTA_PlayerResource:IsValidTeamPlayerID( nPlayerID ) end

---[[ CDOTA_PlayerResource:ModifyGold   ])
-- @return int
-- @param iPlayerID int
-- @param iGoldChange int
-- @param bReliable bool
-- @param nReason int
function CDOTA_PlayerResource:ModifyGold( iPlayerID, iGoldChange, bReliable, nReason ) end

---[[ CDOTA_PlayerResource:NumPlayers   ])
-- @return int
function CDOTA_PlayerResource:NumPlayers(  ) end

---[[ CDOTA_PlayerResource:NumTeamPlayers   ])
-- @return int
function CDOTA_PlayerResource:NumTeamPlayers(  ) end

---[[ CDOTA_PlayerResource:RecordConsumableAbilityChargeChange  Increment or decrement consumable charges (nPlayerID, item_definition_index, nChargeIncrementOrDecrement) ])
-- @return void
-- @param iPlayerID int
-- @param item_definition_index int
-- @param nChargeIncrementOrDecrement int
function CDOTA_PlayerResource:RecordConsumableAbilityChargeChange( iPlayerID, item_definition_index, nChargeIncrementOrDecrement ) end

---[[ CDOTA_PlayerResource:ReplaceHeroWith  (playerID, heroClassName, gold, XP) - replaces the player's hero with a new one of the specified class, gold and XP ])
-- @return handle
-- @param iPlayerID int
-- @param pszHeroClass string
-- @param nGold int
-- @param nXP int
function CDOTA_PlayerResource:ReplaceHeroWith( iPlayerID, pszHeroClass, nGold, nXP ) end

---[[ CDOTA_PlayerResource:ResetBuybackCostTime   ])
-- @return void
-- @param nPlayerID int
function CDOTA_PlayerResource:ResetBuybackCostTime( nPlayerID ) end

---[[ CDOTA_PlayerResource:ResetTotalEarnedGold   ])
-- @return void
-- @param iPlayerID int
function CDOTA_PlayerResource:ResetTotalEarnedGold( iPlayerID ) end

---[[ CDOTA_PlayerResource:SetBuybackCooldownTime   ])
-- @return void
-- @param nPlayerID int
-- @param flBuybackCooldown float
function CDOTA_PlayerResource:SetBuybackCooldownTime( nPlayerID, flBuybackCooldown ) end

---[[ CDOTA_PlayerResource:SetBuybackGoldLimitTime   ])
-- @return void
-- @param nPlayerID int
-- @param flBuybackCooldown float
function CDOTA_PlayerResource:SetBuybackGoldLimitTime( nPlayerID, flBuybackCooldown ) end

---[[ CDOTA_PlayerResource:SetCameraTarget  (playerID, entity) - force the given player's camera to follow the given entity ])
-- @return void
-- @param nPlayerID int
-- @param hTarget handle
function CDOTA_PlayerResource:SetCameraTarget( nPlayerID, hTarget ) end

---[[ CDOTA_PlayerResource:SetCanRepick   ])
-- @return void
-- @param iPlayerID int
-- @param bCanRepick bool
function CDOTA_PlayerResource:SetCanRepick( iPlayerID, bCanRepick ) end

---[[ CDOTA_PlayerResource:SetCustomBuybackCooldown  Set the buyback cooldown for this player. ])
-- @return void
-- @param iPlayerID int
-- @param flCooldownTime float
function CDOTA_PlayerResource:SetCustomBuybackCooldown( iPlayerID, flCooldownTime ) end

---[[ CDOTA_PlayerResource:SetCustomBuybackCost  Set the buyback cost for this player. ])
-- @return void
-- @param iPlayerID int
-- @param iGoldCost int
function CDOTA_PlayerResource:SetCustomBuybackCost( iPlayerID, iGoldCost ) end

---[[ CDOTA_PlayerResource:SetCustomIntParam   ])
-- @return void
-- @param iPlayerID int
-- @param iParam int
function CDOTA_PlayerResource:SetCustomIntParam( iPlayerID, iParam ) end

---[[ CDOTA_PlayerResource:SetCustomPlayerColor  Set custom color for player (minimap, scoreboard, etc) ])
-- @return void
-- @param iPlayerID int
-- @param r int
-- @param g int
-- @param b int
function CDOTA_PlayerResource:SetCustomPlayerColor( iPlayerID, r, g, b ) end

---[[ CDOTA_PlayerResource:SetCustomTeamAssignment  Set custom team assignment for this player. ])
-- @return void
-- @param iPlayerID int
-- @param iTeamAssignment int
function CDOTA_PlayerResource:SetCustomTeamAssignment( iPlayerID, iTeamAssignment ) end

---[[ CDOTA_PlayerResource:SetGold   ])
-- @return void
-- @param iPlayerID int
-- @param iGold int
-- @param bReliable bool
function CDOTA_PlayerResource:SetGold( iPlayerID, iGold, bReliable ) end

---[[ CDOTA_PlayerResource:SetHasRandomed   ])
-- @return void
-- @param iPlayerID int
function CDOTA_PlayerResource:SetHasRandomed( iPlayerID ) end

---[[ CDOTA_PlayerResource:SetLastBuybackTime   ])
-- @return void
-- @param iPlayerID int
-- @param iLastBuybackTime int
function CDOTA_PlayerResource:SetLastBuybackTime( iPlayerID, iLastBuybackTime ) end

---[[ CDOTA_PlayerResource:SetOverrideSelectionEntity  Set the forced selection entity for a player. ])
-- @return void
-- @param nPlayerID int
-- @param hEntity handle
function CDOTA_PlayerResource:SetOverrideSelectionEntity( nPlayerID, hEntity ) end

---[[ CDOTA_PlayerResource:SetUnitShareMaskForPlayer   ])
-- @return void
-- @param nPlayerID int
-- @param nOtherPlayerID int
-- @param nFlag int
-- @param bState bool
function CDOTA_PlayerResource:SetUnitShareMaskForPlayer( nPlayerID, nOtherPlayerID, nFlag, bState ) end

---[[ CDOTA_PlayerResource:SpendGold   ])
-- @return void
-- @param iPlayerID int
-- @param iCost int
-- @param iReason int
function CDOTA_PlayerResource:SpendGold( iPlayerID, iCost, iReason ) end

---[[ CDOTA_PlayerResource:UpdateTeamSlot   ])
-- @return void
-- @param iPlayerID int
-- @param iTeamNumber int
-- @param desiredSlot int
function CDOTA_PlayerResource:UpdateTeamSlot( iPlayerID, iTeamNumber, desiredSlot ) end

---[[ CDOTA_PlayerResource:WhoSelectedHero   ])
-- @return int
-- @param pHeroFilename string
-- @param bIgnoreUnrevealedPick bool
function CDOTA_PlayerResource:WhoSelectedHero( pHeroFilename, bIgnoreUnrevealedPick ) end

---[[ CDOTA_ShopTrigger:GetShopType  Get the DOTA_SHOP_TYPE ])
-- @return int
function CDOTA_ShopTrigger:GetShopType(  ) end

---[[ CDOTA_ShopTrigger:SetShopType  Set the DOTA_SHOP_TYPE. ])
-- @return void
-- @param eShopType int
function CDOTA_ShopTrigger:SetShopType( eShopType ) end

---[[ CDOTA_SimpleObstruction:IsEnabled  Returns whether the obstruction is currently active ])
-- @return bool
function CDOTA_SimpleObstruction:IsEnabled(  ) end

---[[ CDOTA_SimpleObstruction:SetEnabled  Enable or disable the obstruction ])
-- @return void
-- @param bEnabled bool
-- @param bForce bool
function CDOTA_SimpleObstruction:SetEnabled( bEnabled, bForce ) end

---[[ CDOTA_Unit_Courier:UpgradeCourier  Upgrade the courier ( int param ) times. ])
-- @return void
-- @param iLevel int
function CDOTA_Unit_Courier:UpgradeCourier( iLevel ) end

---[[ CDOTA_Unit_CustomGameAnnouncer:SetServerAuthoritative  Determines whether response criteria is matched on server or client ])
-- @return void
-- @param bIsServerAuthoritative bool
function CDOTA_Unit_CustomGameAnnouncer:SetServerAuthoritative( bIsServerAuthoritative ) end

---[[ CDOTA_Unit_Diretide_Portal:GetPartnerPortal   ])
-- @return handle
function CDOTA_Unit_Diretide_Portal:GetPartnerPortal(  ) end

---[[ CDOTA_Unit_Diretide_Portal:ResetPortal   ])
-- @return void
function CDOTA_Unit_Diretide_Portal:ResetPortal(  ) end

---[[ CDOTA_Unit_Diretide_Portal:SetInvasionRuneType   ])
-- @return void
-- @param nRuneType int
function CDOTA_Unit_Diretide_Portal:SetInvasionRuneType( nRuneType ) end

---[[ CDOTA_Unit_Diretide_Portal:SetPartnerPortal   ])
-- @return void
-- @param hPortal handle
function CDOTA_Unit_Diretide_Portal:SetPartnerPortal( hPortal ) end

---[[ CDOTA_Unit_Diretide_Portal:SetPortalActive   ])
-- @return void
-- @param bActive bool
function CDOTA_Unit_Diretide_Portal:SetPortalActive( bActive ) end

---[[ CDOTA_Unit_Nian:GetHorn  Is the Nian horn? ])
-- @return handle
function CDOTA_Unit_Nian:GetHorn(  ) end

---[[ CDOTA_Unit_Nian:GetTail  Is the Nian's tail broken? ])
-- @return handle
function CDOTA_Unit_Nian:GetTail(  ) end

---[[ CDOTA_Unit_Nian:IsHornAlive  Is the Nian's horn broken? ])
-- @return bool
function CDOTA_Unit_Nian:IsHornAlive(  ) end

---[[ CDOTA_Unit_Nian:IsTailAlive  Is the Nian's tail broken? ])
-- @return bool
function CDOTA_Unit_Nian:IsTailAlive(  ) end

---[[ CDebugOverlayScriptHelper:Axis  Draws an axis. Specify origin + orientation in world space. ])
-- @return void
-- @param Vector_1 Vector
-- @param Quaternion_2 Quaternion
-- @param float_3 float
-- @param bool_4 bool
-- @param float_5 float
function CDebugOverlayScriptHelper:Axis( Vector_1, Quaternion_2, float_3, bool_4, float_5 ) end

---[[ CDebugOverlayScriptHelper:Box  Draws a world-space axis-aligned box. Specify bounds in world space. ])
-- @return void
-- @param Vector_1 Vector
-- @param Vector_2 Vector
-- @param int_3 int
-- @param int_4 int
-- @param int_5 int
-- @param int_6 int
-- @param bool_7 bool
-- @param float_8 float
function CDebugOverlayScriptHelper:Box( Vector_1, Vector_2, int_3, int_4, int_5, int_6, bool_7, float_8 ) end

---[[ CDebugOverlayScriptHelper:BoxAngles  Draws an oriented box at the origin. Specify bounds in local space. ])
-- @return void
-- @param Vector_1 Vector
-- @param Vector_2 Vector
-- @param Vector_3 Vector
-- @param Quaternion_4 Quaternion
-- @param int_5 int
-- @param int_6 int
-- @param int_7 int
-- @param int_8 int
-- @param bool_9 bool
-- @param float_10 float
function CDebugOverlayScriptHelper:BoxAngles( Vector_1, Vector_2, Vector_3, Quaternion_4, int_5, int_6, int_7, int_8, bool_9, float_10 ) end

---[[ CDebugOverlayScriptHelper:Capsule  Draws a capsule. Specify base in world space. ])
-- @return void
-- @param Vector_1 Vector
-- @param Quaternion_2 Quaternion
-- @param float_3 float
-- @param float_4 float
-- @param int_5 int
-- @param int_6 int
-- @param int_7 int
-- @param int_8 int
-- @param bool_9 bool
-- @param float_10 float
function CDebugOverlayScriptHelper:Capsule( Vector_1, Quaternion_2, float_3, float_4, int_5, int_6, int_7, int_8, bool_9, float_10 ) end

---[[ CDebugOverlayScriptHelper:Circle  Draws a circle. Specify center in world space. ])
-- @return void
-- @param Vector_1 Vector
-- @param Quaternion_2 Quaternion
-- @param float_3 float
-- @param int_4 int
-- @param int_5 int
-- @param int_6 int
-- @param int_7 int
-- @param bool_8 bool
-- @param float_9 float
function CDebugOverlayScriptHelper:Circle( Vector_1, Quaternion_2, float_3, int_4, int_5, int_6, int_7, bool_8, float_9 ) end

---[[ CDebugOverlayScriptHelper:CircleScreenOriented  Draws a circle oriented to the screen. Specify center in world space. ])
-- @return void
-- @param Vector_1 Vector
-- @param float_2 float
-- @param int_3 int
-- @param int_4 int
-- @param int_5 int
-- @param int_6 int
-- @param bool_7 bool
-- @param float_8 float
function CDebugOverlayScriptHelper:CircleScreenOriented( Vector_1, float_2, int_3, int_4, int_5, int_6, bool_7, float_8 ) end

---[[ CDebugOverlayScriptHelper:Cone  Draws a wireframe cone. Specify endpoint and direction in world space. ])
-- @return void
-- @param Vector_1 Vector
-- @param Vector_2 Vector
-- @param float_3 float
-- @param float_4 float
-- @param int_5 int
-- @param int_6 int
-- @param int_7 int
-- @param int_8 int
-- @param bool_9 bool
-- @param float_10 float
function CDebugOverlayScriptHelper:Cone( Vector_1, Vector_2, float_3, float_4, int_5, int_6, int_7, int_8, bool_9, float_10 ) end

---[[ CDebugOverlayScriptHelper:Cross  Draws a screen-aligned cross. Specify origin in world space. ])
-- @return void
-- @param Vector_1 Vector
-- @param float_2 float
-- @param int_3 int
-- @param int_4 int
-- @param int_5 int
-- @param int_6 int
-- @param bool_7 bool
-- @param float_8 float
function CDebugOverlayScriptHelper:Cross( Vector_1, float_2, int_3, int_4, int_5, int_6, bool_7, float_8 ) end

---[[ CDebugOverlayScriptHelper:Cross3D  Draws a world-aligned cross. Specify origin in world space. ])
-- @return void
-- @param Vector_1 Vector
-- @param float_2 float
-- @param int_3 int
-- @param int_4 int
-- @param int_5 int
-- @param int_6 int
-- @param bool_7 bool
-- @param float_8 float
function CDebugOverlayScriptHelper:Cross3D( Vector_1, float_2, int_3, int_4, int_5, int_6, bool_7, float_8 ) end

---[[ CDebugOverlayScriptHelper:Cross3DOriented  Draws an oriented cross. Specify origin in world space. ])
-- @return void
-- @param Vector_1 Vector
-- @param Quaternion_2 Quaternion
-- @param float_3 float
-- @param int_4 int
-- @param int_5 int
-- @param int_6 int
-- @param int_7 int
-- @param bool_8 bool
-- @param float_9 float
function CDebugOverlayScriptHelper:Cross3DOriented( Vector_1, Quaternion_2, float_3, int_4, int_5, int_6, int_7, bool_8, float_9 ) end

---[[ CDebugOverlayScriptHelper:DrawTickMarkedLine  Draws a dashed line. Specify endpoints in world space. ])
-- @return void
-- @param Vector_1 Vector
-- @param Vector_2 Vector
-- @param float_3 float
-- @param int_4 int
-- @param int_5 int
-- @param int_6 int
-- @param int_7 int
-- @param int_8 int
-- @param bool_9 bool
-- @param float_10 float
function CDebugOverlayScriptHelper:DrawTickMarkedLine( Vector_1, Vector_2, float_3, int_4, int_5, int_6, int_7, int_8, bool_9, float_10 ) end

---[[ CDebugOverlayScriptHelper:EntityAttachments  Draws the attachments of the entity ])
-- @return void
-- @param ehandle_1 ehandle
-- @param float_2 float
-- @param float_3 float
function CDebugOverlayScriptHelper:EntityAttachments( ehandle_1, float_2, float_3 ) end

---[[ CDebugOverlayScriptHelper:EntityAxis  Draws the axis of the entity origin ])
-- @return void
-- @param ehandle_1 ehandle
-- @param float_2 float
-- @param bool_3 bool
-- @param float_4 float
function CDebugOverlayScriptHelper:EntityAxis( ehandle_1, float_2, bool_3, float_4 ) end

---[[ CDebugOverlayScriptHelper:EntityBounds  Draws bounds of an entity ])
-- @return void
-- @param ehandle_1 ehandle
-- @param int_2 int
-- @param int_3 int
-- @param int_4 int
-- @param int_5 int
-- @param bool_6 bool
-- @param float_7 float
function CDebugOverlayScriptHelper:EntityBounds( ehandle_1, int_2, int_3, int_4, int_5, bool_6, float_7 ) end

---[[ CDebugOverlayScriptHelper:EntitySkeleton  Draws the skeleton of the entity ])
-- @return void
-- @param ehandle_1 ehandle
-- @param float_2 float
function CDebugOverlayScriptHelper:EntitySkeleton( ehandle_1, float_2 ) end

---[[ CDebugOverlayScriptHelper:EntityText  Draws text on an entity ])
-- @return void
-- @param ehandle_1 ehandle
-- @param int_2 int
-- @param string_3 string
-- @param int_4 int
-- @param int_5 int
-- @param int_6 int
-- @param int_7 int
-- @param float_8 float
function CDebugOverlayScriptHelper:EntityText( ehandle_1, int_2, string_3, int_4, int_5, int_6, int_7, float_8 ) end

---[[ CDebugOverlayScriptHelper:FilledRect2D  Draws a screen-space filled 2D rectangle. Coordinates are in pixels. ])
-- @return void
-- @param Vector2D_1 Vector2D
-- @param Vector2D_2 Vector2D
-- @param int_3 int
-- @param int_4 int
-- @param int_5 int
-- @param int_6 int
-- @param float_7 float
function CDebugOverlayScriptHelper:FilledRect2D( Vector2D_1, Vector2D_2, int_3, int_4, int_5, int_6, float_7 ) end

---[[ CDebugOverlayScriptHelper:HorzArrow  Draws a horizontal arrow. Specify endpoints in world space. ])
-- @return void
-- @param Vector_1 Vector
-- @param Vector_2 Vector
-- @param float_3 float
-- @param int_4 int
-- @param int_5 int
-- @param int_6 int
-- @param int_7 int
-- @param bool_8 bool
-- @param float_9 float
function CDebugOverlayScriptHelper:HorzArrow( Vector_1, Vector_2, float_3, int_4, int_5, int_6, int_7, bool_8, float_9 ) end

---[[ CDebugOverlayScriptHelper:Line  Draws a line between two points ])
-- @return void
-- @param Vector_1 Vector
-- @param Vector_2 Vector
-- @param int_3 int
-- @param int_4 int
-- @param int_5 int
-- @param int_6 int
-- @param bool_7 bool
-- @param float_8 float
function CDebugOverlayScriptHelper:Line( Vector_1, Vector_2, int_3, int_4, int_5, int_6, bool_7, float_8 ) end

---[[ CDebugOverlayScriptHelper:Line2D  Draws a line between two points in screenspace ])
-- @return void
-- @param Vector2D_1 Vector2D
-- @param Vector2D_2 Vector2D
-- @param int_3 int
-- @param int_4 int
-- @param int_5 int
-- @param int_6 int
-- @param float_7 float
function CDebugOverlayScriptHelper:Line2D( Vector2D_1, Vector2D_2, int_3, int_4, int_5, int_6, float_7 ) end

---[[ CDebugOverlayScriptHelper:PopDebugOverlayScope  Pops the identifier used to group overlays. Overlays marked with this identifier can be deleted in a big batch. ])
-- @return void
function CDebugOverlayScriptHelper:PopDebugOverlayScope(  ) end

---[[ CDebugOverlayScriptHelper:PushAndClearDebugOverlayScope  Pushes an identifier used to group overlays. Deletes all existing overlays using this overlay id. ])
-- @return void
-- @param utlstringtoken_1 utlstringtoken
function CDebugOverlayScriptHelper:PushAndClearDebugOverlayScope( utlstringtoken_1 ) end

---[[ CDebugOverlayScriptHelper:PushDebugOverlayScope  Pushes an identifier used to group overlays. Overlays marked with this identifier can be deleted in a big batch. ])
-- @return void
-- @param utlstringtoken_1 utlstringtoken
function CDebugOverlayScriptHelper:PushDebugOverlayScope( utlstringtoken_1 ) end

---[[ CDebugOverlayScriptHelper:RemoveAllInScope  Removes all overlays marked with a specific identifier, regardless of their lifetime. ])
-- @return void
-- @param utlstringtoken_1 utlstringtoken
function CDebugOverlayScriptHelper:RemoveAllInScope( utlstringtoken_1 ) end

---[[ CDebugOverlayScriptHelper:SolidCone  Draws a solid cone. Specify endpoint and direction in world space. ])
-- @return void
-- @param Vector_1 Vector
-- @param Vector_2 Vector
-- @param float_3 float
-- @param float_4 float
-- @param int_5 int
-- @param int_6 int
-- @param int_7 int
-- @param int_8 int
-- @param bool_9 bool
-- @param float_10 float
function CDebugOverlayScriptHelper:SolidCone( Vector_1, Vector_2, float_3, float_4, int_5, int_6, int_7, int_8, bool_9, float_10 ) end

---[[ CDebugOverlayScriptHelper:Sphere  Draws a wireframe sphere. Specify center in world space. ])
-- @return void
-- @param Vector_1 Vector
-- @param float_2 float
-- @param int_3 int
-- @param int_4 int
-- @param int_5 int
-- @param int_6 int
-- @param bool_7 bool
-- @param float_8 float
function CDebugOverlayScriptHelper:Sphere( Vector_1, float_2, int_3, int_4, int_5, int_6, bool_7, float_8 ) end

---[[ CDebugOverlayScriptHelper:SweptBox  Draws a swept box. Specify endpoints in world space and the bounds in local space. ])
-- @return void
-- @param Vector_1 Vector
-- @param Vector_2 Vector
-- @param Vector_3 Vector
-- @param Vector_4 Vector
-- @param Quaternion_5 Quaternion
-- @param int_6 int
-- @param int_7 int
-- @param int_8 int
-- @param int_9 int
-- @param float_10 float
function CDebugOverlayScriptHelper:SweptBox( Vector_1, Vector_2, Vector_3, Vector_4, Quaternion_5, int_6, int_7, int_8, int_9, float_10 ) end

---[[ CDebugOverlayScriptHelper:Text  Draws 2D text. Specify origin in world space. ])
-- @return void
-- @param Vector_1 Vector
-- @param int_2 int
-- @param string_3 string
-- @param float_4 float
-- @param int_5 int
-- @param int_6 int
-- @param int_7 int
-- @param int_8 int
-- @param float_9 float
function CDebugOverlayScriptHelper:Text( Vector_1, int_2, string_3, float_4, int_5, int_6, int_7, int_8, float_9 ) end

---[[ CDebugOverlayScriptHelper:Texture  Draws a screen-space texture. Coordinates are in pixels. ])
-- @return void
-- @param string_1 string
-- @param Vector2D_2 Vector2D
-- @param Vector2D_3 Vector2D
-- @param int_4 int
-- @param int_5 int
-- @param int_6 int
-- @param int_7 int
-- @param Vector2D_8 Vector2D
-- @param Vector2D_9 Vector2D
-- @param float_10 float
function CDebugOverlayScriptHelper:Texture( string_1, Vector2D_2, Vector2D_3, int_4, int_5, int_6, int_7, Vector2D_8, Vector2D_9, float_10 ) end

---[[ CDebugOverlayScriptHelper:Triangle  Draws a filled triangle. Specify vertices in world space. ])
-- @return void
-- @param Vector_1 Vector
-- @param Vector_2 Vector
-- @param Vector_3 Vector
-- @param int_4 int
-- @param int_5 int
-- @param int_6 int
-- @param int_7 int
-- @param bool_8 bool
-- @param float_9 float
function CDebugOverlayScriptHelper:Triangle( Vector_1, Vector_2, Vector_3, int_4, int_5, int_6, int_7, bool_8, float_9 ) end

---[[ CDebugOverlayScriptHelper:VectorText3D  Draws 3D text. Specify origin + orientation in world space. ])
-- @return void
-- @param Vector_1 Vector
-- @param Quaternion_2 Quaternion
-- @param string_3 string
-- @param int_4 int
-- @param int_5 int
-- @param int_6 int
-- @param int_7 int
-- @param bool_8 bool
-- @param float_9 float
function CDebugOverlayScriptHelper:VectorText3D( Vector_1, Quaternion_2, string_3, int_4, int_5, int_6, int_7, bool_8, float_9 ) end

---[[ CDebugOverlayScriptHelper:VertArrow  Draws a vertical arrow. Specify endpoints in world space. ])
-- @return void
-- @param Vector_1 Vector
-- @param Vector_2 Vector
-- @param float_3 float
-- @param int_4 int
-- @param int_5 int
-- @param int_6 int
-- @param int_7 int
-- @param bool_8 bool
-- @param float_9 float
function CDebugOverlayScriptHelper:VertArrow( Vector_1, Vector_2, float_3, int_4, int_5, int_6, int_7, bool_8, float_9 ) end

---[[ CDebugOverlayScriptHelper:YawArrow  Draws a arrow associated with a specific yaw. Specify endpoints in world space. ])
-- @return void
-- @param Vector_1 Vector
-- @param float_2 float
-- @param float_3 float
-- @param float_4 float
-- @param int_5 int
-- @param int_6 int
-- @param int_7 int
-- @param int_8 int
-- @param bool_9 bool
-- @param float_10 float
function CDebugOverlayScriptHelper:YawArrow( Vector_1, float_2, float_3, float_4, int_5, int_6, int_7, int_8, bool_9, float_10 ) end

---[[ CDotaQuest:AddSubquest  Add a subquest to this quest ])
-- @return void
-- @param hSubquest handle
function CDotaQuest:AddSubquest( hSubquest ) end

---[[ CDotaQuest:CompleteQuest  Mark this quest complete ])
-- @return void
function CDotaQuest:CompleteQuest(  ) end

---[[ CDotaQuest:GetSubquest  Finds a subquest from this quest by index ])
-- @return handle
-- @param nIndex int
function CDotaQuest:GetSubquest( nIndex ) end

---[[ CDotaQuest:GetSubquestByName  Finds a subquest from this quest by name ])
-- @return handle
-- @param pszName string
function CDotaQuest:GetSubquestByName( pszName ) end

---[[ CDotaQuest:RemoveSubquest  Remove a subquest from this quest ])
-- @return void
-- @param hSubquest handle
function CDotaQuest:RemoveSubquest( hSubquest ) end

---[[ CDotaQuest:SetTextReplaceString  Set the text replace string for this quest ])
-- @return void
-- @param pszString string
function CDotaQuest:SetTextReplaceString( pszString ) end

---[[ CDotaQuest:SetTextReplaceValue  Set a quest value ])
-- @return void
-- @param valueSlot int
-- @param value int
function CDotaQuest:SetTextReplaceValue( valueSlot, value ) end

---[[ CDotaSubquestBase:CompleteSubquest  Mark this subquest complete ])
-- @return void
function CDotaSubquestBase:CompleteSubquest(  ) end

---[[ CDotaSubquestBase:SetTextReplaceString  Set the text replace string for this subquest ])
-- @return void
-- @param pszString string
function CDotaSubquestBase:SetTextReplaceString( pszString ) end

---[[ CDotaSubquestBase:SetTextReplaceValue  Set a subquest value ])
-- @return void
-- @param valueSlot int
-- @param value int
function CDotaSubquestBase:SetTextReplaceValue( valueSlot, value ) end

---[[ CDotaTutorialNPCBlocker:SetEnabled   ])
-- @return void
-- @param bEnabled bool
function CDotaTutorialNPCBlocker:SetEnabled( bEnabled ) end

---[[ CDotaTutorialNPCBlocker:SetOtherBlocker   ])
-- @return void
-- @param hBlocker handle
function CDotaTutorialNPCBlocker:SetOtherBlocker( hBlocker ) end

---[[ CEntities:CreateByClassname  Creates an entity by classname ])
-- @return handle
-- @param string_1 string
function CEntities:CreateByClassname( string_1 ) end

---[[ CEntities:FindAllByClassname  Finds all entities by class name. Returns an array containing all the found entities. ])
-- @return table
-- @param string_1 string
function CEntities:FindAllByClassname( string_1 ) end

---[[ CEntities:FindAllByClassnameWithin  Find entities by class name within a radius. ])
-- @return table
-- @param string_1 string
-- @param Vector_2 Vector
-- @param float_3 float
function CEntities:FindAllByClassnameWithin( string_1, Vector_2, float_3 ) end

---[[ CEntities:FindAllByModel  Find entities by model name. ])
-- @return table
-- @param string_1 string
function CEntities:FindAllByModel( string_1 ) end

---[[ CEntities:FindAllByName  Find all entities by name. Returns an array containing all the found entities in it. ])
-- @return table
-- @param string_1 string
function CEntities:FindAllByName( string_1 ) end

---[[ CEntities:FindAllByNameWithin  Find entities by name within a radius. ])
-- @return table
-- @param string_1 string
-- @param Vector_2 Vector
-- @param float_3 float
function CEntities:FindAllByNameWithin( string_1, Vector_2, float_3 ) end

---[[ CEntities:FindAllByTarget  Find entities by targetname. ])
-- @return table
-- @param string_1 string
function CEntities:FindAllByTarget( string_1 ) end

---[[ CEntities:FindAllInSphere  Find entities within a radius. ])
-- @return table
-- @param Vector_1 Vector
-- @param float_2 float
function CEntities:FindAllInSphere( Vector_1, float_2 ) end

---[[ CEntities:FindByClassname  Find entities by class name. Pass 'null' to start an iteration, or reference to a previously found entity to continue a search ])
-- @return handle
-- @param handle_1 handle
-- @param string_2 string
function CEntities:FindByClassname( handle_1, string_2 ) end

---[[ CEntities:FindByClassnameNearest  Find entities by class name nearest to a point. ])
-- @return handle
-- @param string_1 string
-- @param Vector_2 Vector
-- @param float_3 float
function CEntities:FindByClassnameNearest( string_1, Vector_2, float_3 ) end

---[[ CEntities:FindByClassnameWithin  Find entities by class name within a radius. Pass 'null' to start an iteration, or reference to a previously found entity to continue a search ])
-- @return handle
-- @param handle_1 handle
-- @param string_2 string
-- @param Vector_3 Vector
-- @param float_4 float
function CEntities:FindByClassnameWithin( handle_1, string_2, Vector_3, float_4 ) end

---[[ CEntities:FindByModel  Find entities by model name. Pass 'null' to start an iteration, or reference to a previously found entity to continue a search ])
-- @return handle
-- @param handle_1 handle
-- @param string_2 string
function CEntities:FindByModel( handle_1, string_2 ) end

---[[ CEntities:FindByModelWithin  Find entities by model name within a radius. Pass 'null' to start an iteration, or reference to a previously found entity to continue a search ])
-- @return handle
-- @param handle_1 handle
-- @param string_2 string
-- @param Vector_3 Vector
-- @param float_4 float
function CEntities:FindByModelWithin( handle_1, string_2, Vector_3, float_4 ) end

---[[ CEntities:FindByName  Find entities by name. Pass 'null' to start an iteration, or reference to a previously found entity to continue a search ])
-- @return handle
-- @param handle_1 handle
-- @param string_2 string
function CEntities:FindByName( handle_1, string_2 ) end

---[[ CEntities:FindByNameNearest  Find entities by name nearest to a point. ])
-- @return handle
-- @param string_1 string
-- @param Vector_2 Vector
-- @param float_3 float
function CEntities:FindByNameNearest( string_1, Vector_2, float_3 ) end

---[[ CEntities:FindByNameWithin  Find entities by name within a radius. Pass 'null' to start an iteration, or reference to a previously found entity to continue a search ])
-- @return handle
-- @param handle_1 handle
-- @param string_2 string
-- @param Vector_3 Vector
-- @param float_4 float
function CEntities:FindByNameWithin( handle_1, string_2, Vector_3, float_4 ) end

---[[ CEntities:FindByTarget  Find entities by targetname. Pass 'null' to start an iteration, or reference to a previously found entity to continue a search ])
-- @return handle
-- @param handle_1 handle
-- @param string_2 string
function CEntities:FindByTarget( handle_1, string_2 ) end

---[[ CEntities:FindInSphere  Find entities within a radius. Pass 'null' to start an iteration, or reference to a previously found entity to continue a search ])
-- @return handle
-- @param handle_1 handle
-- @param Vector_2 Vector
-- @param float_3 float
function CEntities:FindInSphere( handle_1, Vector_2, float_3 ) end

---[[ CEntities:First  Begin an iteration over the list of entities ])
-- @return handle
function CEntities:First(  ) end

---[[ CEntities:GetLocalPlayer  Get the local player. ])
-- @return handle
function CEntities:GetLocalPlayer(  ) end

---[[ CEntities:Next  Continue an iteration over the list of entities, providing reference to a previously found entity ])
-- @return handle
-- @param handle_1 handle
function CEntities:Next( handle_1 ) end

---[[ CEntityInstance:ConnectOutput  Adds an I/O connection that will call the named function on this entity when the specified output fires. ])
-- @return void
-- @param string_1 string
-- @param string_2 string
function CEntityInstance:ConnectOutput( string_1, string_2 ) end

---[[ CEntityInstance:Destroy   ])
-- @return void
function CEntityInstance:Destroy(  ) end

---[[ CEntityInstance:DisconnectOutput  Removes a connected script function from an I/O event on this entity. ])
-- @return void
-- @param string_1 string
-- @param string_2 string
function CEntityInstance:DisconnectOutput( string_1, string_2 ) end

---[[ CEntityInstance:DisconnectRedirectedOutput  Removes a connected script function from an I/O event on the passed entity. ])
-- @return void
-- @param string_1 string
-- @param string_2 string
-- @param handle_3 handle
function CEntityInstance:DisconnectRedirectedOutput( string_1, string_2, handle_3 ) end

---[[ CEntityInstance:FireOutput  Fire an entity output ])
-- @return void
-- @param string_1 string
-- @param handle_2 handle
-- @param handle_3 handle
-- @param table_4 table
-- @param float_5 float
function CEntityInstance:FireOutput( string_1, handle_2, handle_3, table_4, float_5 ) end

---[[ CEntityInstance:GetClassname   ])
-- @return string
function CEntityInstance:GetClassname(  ) end

---[[ CEntityInstance:GetDebugName  Get the entity name w/help if not defined (i.e. classname/etc) ])
-- @return string
function CEntityInstance:GetDebugName(  ) end

---[[ CEntityInstance:GetEntityHandle  Get the entity as an EHANDLE ])
-- @return ehandle
function CEntityInstance:GetEntityHandle(  ) end

---[[ CEntityInstance:GetEntityIndex   ])
-- @return int
function CEntityInstance:GetEntityIndex(  ) end

---[[ CEntityInstance:GetIntAttr  Get Integer Attribute ])
-- @return int
-- @param string_1 string
function CEntityInstance:GetIntAttr( string_1 ) end

---[[ CEntityInstance:GetName   ])
-- @return string
function CEntityInstance:GetName(  ) end

---[[ CEntityInstance:GetOrCreatePrivateScriptScope  Retrieve, creating if necessary, the private per-instance script-side data associated with an entity ])
-- @return handle
function CEntityInstance:GetOrCreatePrivateScriptScope(  ) end

---[[ CEntityInstance:GetOrCreatePublicScriptScope  Retrieve, creating if necessary, the public script-side data associated with an entity ])
-- @return handle
function CEntityInstance:GetOrCreatePublicScriptScope(  ) end

---[[ CEntityInstance:GetPrivateScriptScope  Retrieve the private per-instance script-side data associated with an entity ])
-- @return handle
function CEntityInstance:GetPrivateScriptScope(  ) end

---[[ CEntityInstance:GetPublicScriptScope  Retrieve the public script-side data associated with an entity ])
-- @return handle
function CEntityInstance:GetPublicScriptScope(  ) end

---[[ CEntityInstance:RedirectOutput  Adds an I/O connection that will call the named function on the passed entity when the specified output fires. ])
-- @return void
-- @param string_1 string
-- @param string_2 string
-- @param handle_3 handle
function CEntityInstance:RedirectOutput( string_1, string_2, handle_3 ) end

---[[ CEntityInstance:RemoveSelf  Delete this entity ])
-- @return void
function CEntityInstance:RemoveSelf(  ) end

---[[ CEntityInstance:SetIntAttr  Set Integer Attribute ])
-- @return void
-- @param string_1 string
-- @param int_2 int
function CEntityInstance:SetIntAttr( string_1, int_2 ) end

---[[ CEntityInstance:entindex   ])
-- @return int
function CEntityInstance:entindex(  ) end

---[[ CEnvEntityMaker:SpawnEntity  Create an entity at the location of the maker ])
-- @return void
function CEnvEntityMaker:SpawnEntity(  ) end

---[[ CEnvEntityMaker:SpawnEntityAtEntityOrigin  Create an entity at the location of a specified entity instance ])
-- @return void
-- @param hEntity handle
function CEnvEntityMaker:SpawnEntityAtEntityOrigin( hEntity ) end

---[[ CEnvEntityMaker:SpawnEntityAtLocation  Create an entity at a specified location and orientaton, orientation is Euler angle in degrees (pitch, yaw, roll) ])
-- @return void
-- @param vecAlternateOrigin Vector
-- @param vecAlternateAngles Vector
function CEnvEntityMaker:SpawnEntityAtLocation( vecAlternateOrigin, vecAlternateAngles ) end

---[[ CEnvEntityMaker:SpawnEntityAtNamedEntityOrigin  Create an entity at the location of a named entity ])
-- @return void
-- @param pszName string
function CEnvEntityMaker:SpawnEntityAtNamedEntityOrigin( pszName ) end

---[[ CEnvProjectedTexture:SetFarRange  Set light maximum range ])
-- @return void
-- @param flRange float
function CEnvProjectedTexture:SetFarRange( flRange ) end

---[[ CEnvProjectedTexture:SetLinearAttenuation  Set light linear attenuation value ])
-- @return void
-- @param flAtten float
function CEnvProjectedTexture:SetLinearAttenuation( flAtten ) end

---[[ CEnvProjectedTexture:SetNearRange  Set light minimum range ])
-- @return void
-- @param flRange float
function CEnvProjectedTexture:SetNearRange( flRange ) end

---[[ CEnvProjectedTexture:SetQuadraticAttenuation  Set light quadratic attenuation value ])
-- @return void
-- @param flAtten float
function CEnvProjectedTexture:SetQuadraticAttenuation( flAtten ) end

---[[ CEnvProjectedTexture:SetVolumetrics  Turn on/off light volumetrics: bool bOn, float flIntensity, float flNoise, int nPlanes, float flPlaneOffset ])
-- @return void
-- @param bOn bool
-- @param flIntensity float
-- @param flNoise float
-- @param nPlanes int
-- @param flPlaneOffset float
function CEnvProjectedTexture:SetVolumetrics( bOn, flIntensity, flNoise, nPlanes, flPlaneOffset ) end

---[[ CFoWBlockerRegion:AddRectangularBlocker  AddRectangularBlocker( vMins, vMaxs, bClear ) : Sets or clears a blocker rectangle ])
-- @return void
-- @param vMins Vector
-- @param vMaxs Vector
-- @param bClearRegion bool
function CFoWBlockerRegion:AddRectangularBlocker( vMins, vMaxs, bClearRegion ) end

---[[ CFoWBlockerRegion:AddRectangularOutlineBlocker  AddRectangularOutlineBlocker( vMins, vMaxs, bClear ) : Sets or clears a blocker rectangle outline ])
-- @return void
-- @param vMins Vector
-- @param vMaxs Vector
-- @param bClearRegion bool
function CFoWBlockerRegion:AddRectangularOutlineBlocker( vMins, vMaxs, bClearRegion ) end

---[[ CInfoData:QueryColor  Query color data for this key ])
-- @return Vector
-- @param tok utlstringtoken
-- @param vDefault Vector
function CInfoData:QueryColor( tok, vDefault ) end

---[[ CInfoData:QueryFloat  Query float data for this key ])
-- @return float
-- @param tok utlstringtoken
-- @param flDefault float
function CInfoData:QueryFloat( tok, flDefault ) end

---[[ CInfoData:QueryInt  Query int data for this key ])
-- @return int
-- @param tok utlstringtoken
-- @param nDefault int
function CInfoData:QueryInt( tok, nDefault ) end

---[[ CInfoData:QueryNumber  Query number data for this key ])
-- @return float
-- @param tok utlstringtoken
-- @param flDefault float
function CInfoData:QueryNumber( tok, flDefault ) end

---[[ CInfoData:QueryString  Query string data for this key ])
-- @return string
-- @param tok utlstringtoken
-- @param pDefault string
function CInfoData:QueryString( tok, pDefault ) end

---[[ CInfoData:QueryVector  Query vector data for this key ])
-- @return Vector
-- @param tok utlstringtoken
-- @param vDefault Vector
function CInfoData:QueryVector( tok, vDefault ) end

---[[ CInfoPlayerStartDota:IsEnabled  Returns whether the object is currently active ])
-- @return bool
function CInfoPlayerStartDota:IsEnabled(  ) end

---[[ CInfoPlayerStartDota:SetEnabled  Enable or disable the obstruction ])
-- @return void
-- @param bEnabled bool
function CInfoPlayerStartDota:SetEnabled( bEnabled ) end

---[[ CInfoWorldLayer:HideWorldLayer  Hides this layer ])
-- @return void
function CInfoWorldLayer:HideWorldLayer(  ) end

---[[ CInfoWorldLayer:ShowWorldLayer  Shows this layer ])
-- @return void
function CInfoWorldLayer:ShowWorldLayer(  ) end

---[[ CLogicRelay:Trigger  Trigger( hActivator, hCaller ) : Triggers the logic_relay ])
-- @return void
-- @param hActivator handle
-- @param hCaller handle
function CLogicRelay:Trigger( hActivator, hCaller ) end

---[[ CMarkupVolumeTagged:HasTag  Does this volume have the given tag. ])
-- @return bool
-- @param pszTagName string
function CMarkupVolumeTagged:HasTag( pszTagName ) end

---[[ CNativeOutputs:AddOutput  Add an output ])
-- @return void
-- @param string_1 string
-- @param string_2 string
function CNativeOutputs:AddOutput( string_1, string_2 ) end

---[[ CNativeOutputs:Init  Initialize with number of outputs ])
-- @return void
-- @param int_1 int
function CNativeOutputs:Init( int_1 ) end

---[[ CPhysicsProp:DisableMotion  Disable motion for the prop ])
-- @return void
function CPhysicsProp:DisableMotion(  ) end

---[[ CPhysicsProp:EnableMotion  Enable motion for the prop ])
-- @return void
function CPhysicsProp:EnableMotion(  ) end

---[[ CPhysicsProp:SetDynamicVsDynamicContinuous  Enable/disable dynamic vs dynamic continuous collision traces ])
-- @return void
-- @param bIsDynamicVsDynamicContinuousEnabled bool
function CPhysicsProp:SetDynamicVsDynamicContinuous( bIsDynamicVsDynamicContinuousEnabled ) end

---[[ CPointClientUIWorldPanel:AcceptUserInput  Tells the panel to accept user input. ])
-- @return void
function CPointClientUIWorldPanel:AcceptUserInput(  ) end

---[[ CPointClientUIWorldPanel:AddCSSClasses  Adds CSS class(es) to the panel ])
-- @return void
-- @param pszClasses string
function CPointClientUIWorldPanel:AddCSSClasses( pszClasses ) end

---[[ CPointClientUIWorldPanel:IgnoreUserInput  Tells the panel to ignore user input. ])
-- @return void
function CPointClientUIWorldPanel:IgnoreUserInput(  ) end

---[[ CPointClientUIWorldPanel:IsGrabbable  Returns whether this entity is grabbable. ])
-- @return bool
function CPointClientUIWorldPanel:IsGrabbable(  ) end

---[[ CPointClientUIWorldPanel:RemoveCSSClasses  Remove CSS class(es) from the panel ])
-- @return void
-- @param pszClasses string
function CPointClientUIWorldPanel:RemoveCSSClasses( pszClasses ) end

---[[ CPointTemplate:DeleteCreatedSpawnGroups  DeleteCreatedSpawnGroups() : Deletes any spawn groups that this point_template has spawned. Note: The point_template will not be deleted by this. ])
-- @return void
function CPointTemplate:DeleteCreatedSpawnGroups(  ) end

---[[ CPointTemplate:ForceSpawn  ForceSpawn() : Spawns all of the entities the point_template is pointing at. ])
-- @return void
function CPointTemplate:ForceSpawn(  ) end

---[[ CPointTemplate:GetSpawnedEntities  GetSpawnedEntities() : Get the list of the most recent spawned entities ])
-- @return handle
function CPointTemplate:GetSpawnedEntities(  ) end

---[[ CPointTemplate:SetSpawnCallback  SetSpawnCallback( hCallbackFunc, hCallbackScope, hCallbackData ) : Set a callback for when the template spawns entities. The spawned entities will be passed in as an array. ])
-- @return void
-- @param hCallbackFunc handle
-- @param hCallbackScope handle
function CPointTemplate:SetSpawnCallback( hCallbackFunc, hCallbackScope ) end

---[[ CPointWorldText:SetMessage  Set the message on this entity. ])
-- @return void
-- @param pMessage string
function CPointWorldText:SetMessage( pMessage ) end

---[[ CSceneEntity:AddBroadcastTeamTarget  Adds a team (by index) to the broadcast list ])
-- @return void
-- @param int_1 int
function CSceneEntity:AddBroadcastTeamTarget( int_1 ) end

---[[ CSceneEntity:Cancel  Cancel scene playback ])
-- @return void
function CSceneEntity:Cancel(  ) end

---[[ CSceneEntity:EstimateLength  Returns length of this scene in seconds. ])
-- @return float
function CSceneEntity:EstimateLength(  ) end

---[[ CSceneEntity:FindCamera  Get the camera ])
-- @return handle
function CSceneEntity:FindCamera(  ) end

---[[ CSceneEntity:FindNamedEntity  given an entity reference, such as !target, get actual entity from scene object ])
-- @return handle
-- @param string_1 string
function CSceneEntity:FindNamedEntity( string_1 ) end

---[[ CSceneEntity:IsPaused  If this scene is currently paused. ])
-- @return bool
function CSceneEntity:IsPaused(  ) end

---[[ CSceneEntity:IsPlayingBack  If this scene is currently playing. ])
-- @return bool
function CSceneEntity:IsPlayingBack(  ) end

---[[ CSceneEntity:LoadSceneFromString  given a dummy scene name and a vcd string, load the scene ])
-- @return bool
-- @param string_1 string
-- @param string_2 string
function CSceneEntity:LoadSceneFromString( string_1, string_2 ) end

---[[ CSceneEntity:RemoveBroadcastTeamTarget  Removes a team (by index) from the broadcast list ])
-- @return void
-- @param int_1 int
function CSceneEntity:RemoveBroadcastTeamTarget( int_1 ) end

---[[ CSceneEntity:Start  Start scene playback, takes activatorEntity as param ])
-- @return void
-- @param handle_1 handle
function CSceneEntity:Start( handle_1 ) end

---[[ CScriptHeroList:GetAllHeroes  Returns all the heroes in the world ])
-- @return table
function CScriptHeroList:GetAllHeroes(  ) end

---[[ CScriptHeroList:GetHero  Get the Nth hero in the Hero List ])
-- @return handle
-- @param int_1 int
function CScriptHeroList:GetHero( int_1 ) end

---[[ CScriptHeroList:GetHeroCount  Returns the number of heroes in the world ])
-- @return int
function CScriptHeroList:GetHeroCount(  ) end

---[[ CScriptKeyValues:GetValue  Reads a spawn key ])
-- @return table
-- @param string_1 string
function CScriptKeyValues:GetValue( string_1 ) end

---[[ CScriptParticleManager:CreateParticle  Creates a new particle effect ])
-- @return int
-- @param string_1 string
-- @param int_2 int
-- @param handle_3 handle
function CScriptParticleManager:CreateParticle( string_1, int_2, handle_3 ) end

---[[ CScriptParticleManager:CreateParticleForPlayer  Creates a new particle effect that only plays for the specified player ])
-- @return int
-- @param string_1 string
-- @param int_2 int
-- @param handle_3 handle
-- @param handle_4 handle
function CScriptParticleManager:CreateParticleForPlayer( string_1, int_2, handle_3, handle_4 ) end

---[[ CScriptParticleManager:CreateParticleForTeam  Creates a new particle effect that only plays for the specified team ])
-- @return int
-- @param string_1 string
-- @param int_2 int
-- @param handle_3 handle
-- @param int_4 int
function CScriptParticleManager:CreateParticleForTeam( string_1, int_2, handle_3, int_4 ) end

---[[ CScriptParticleManager:DestroyParticle  (int index, bool bDestroyImmediately) - Destroy a particle, if bDestroyImmediately destroy it without playing end caps. ])
-- @return void
-- @param int_1 int
-- @param bool_2 bool
function CScriptParticleManager:DestroyParticle( int_1, bool_2 ) end

---[[ CScriptParticleManager:GetParticleReplacement   ])
-- @return string
-- @param string_1 string
-- @param handle_2 handle
function CScriptParticleManager:GetParticleReplacement( string_1, handle_2 ) end

---[[ CScriptParticleManager:ReleaseParticleIndex  Frees the specified particle index ])
-- @return void
-- @param int_1 int
function CScriptParticleManager:ReleaseParticleIndex( int_1 ) end

---[[ CScriptParticleManager:SetParticleAlwaysSimulate   ])
-- @return void
-- @param int_1 int
function CScriptParticleManager:SetParticleAlwaysSimulate( int_1 ) end

---[[ CScriptParticleManager:SetParticleControl  Set the control point data for a control on a particle effect ])
-- @return void
-- @param int_1 int
-- @param int_2 int
-- @param Vector_3 Vector
function CScriptParticleManager:SetParticleControl( int_1, int_2, Vector_3 ) end

---[[ CScriptParticleManager:SetParticleControlEnt   ])
-- @return void
-- @param int_1 int
-- @param int_2 int
-- @param handle_3 handle
-- @param int_4 int
-- @param string_5 string
-- @param Vector_6 Vector
-- @param bool_7 bool
function CScriptParticleManager:SetParticleControlEnt( int_1, int_2, handle_3, int_4, string_5, Vector_6, bool_7 ) end

---[[ CScriptParticleManager:SetParticleControlFallback  (int iIndex, int iPoint, Vector vecPosition) ])
-- @return void
-- @param int_1 int
-- @param int_2 int
-- @param Vector_3 Vector
function CScriptParticleManager:SetParticleControlFallback( int_1, int_2, Vector_3 ) end

---[[ CScriptParticleManager:SetParticleControlForward  (int nFXIndex, int nPoint, vForward) ])
-- @return void
-- @param int_1 int
-- @param int_2 int
-- @param Vector_3 Vector
function CScriptParticleManager:SetParticleControlForward( int_1, int_2, Vector_3 ) end

---[[ CScriptParticleManager:SetParticleControlOrientation  (int nFXIndex, int nPoint, vForward, vRight, vUp) - Set the orientation for a control on a particle effect (NOTE: This is left handed -- bad!!) ])
-- @return void
-- @param int_1 int
-- @param int_2 int
-- @param Vector_3 Vector
-- @param Vector_4 Vector
-- @param Vector_5 Vector
function CScriptParticleManager:SetParticleControlOrientation( int_1, int_2, Vector_3, Vector_4, Vector_5 ) end

---[[ CScriptParticleManager:SetParticleControlOrientationFLU  (int nFXIndex, int nPoint, Vector vecForward, Vector vecLeft, Vector vecUp) - Set the orientation for a control on a particle effect ])
-- @return void
-- @param int_1 int
-- @param int_2 int
-- @param Vector_3 Vector
-- @param Vector_4 Vector
-- @param Vector_5 Vector
function CScriptParticleManager:SetParticleControlOrientationFLU( int_1, int_2, Vector_3, Vector_4, Vector_5 ) end

---[[ CScriptParticleManager:SetParticleFoWProperties  int nfxindex, int nPoint, int nPoint2, float flRadius ])
-- @return void
-- @param int_1 int
-- @param int_2 int
-- @param int_3 int
-- @param float_4 float
function CScriptParticleManager:SetParticleFoWProperties( int_1, int_2, int_3, float_4 ) end

---[[ CScriptParticleManager:SetParticleShouldCheckFoW  int nfxindex, bool bCheckFoW ])
-- @return bool
-- @param int_1 int
-- @param bool_2 bool
function CScriptParticleManager:SetParticleShouldCheckFoW( int_1, bool_2 ) end

---[[ CScriptPrecacheContext:AddResource  Precaches a specific resource ])
-- @return void
-- @param string_1 string
function CScriptPrecacheContext:AddResource( string_1 ) end

---[[ CScriptPrecacheContext:GetValue  Reads a spawn key ])
-- @return table
-- @param string_1 string
function CScriptPrecacheContext:GetValue( string_1 ) end

---[[ Convars:GetBool  GetBool(name) : returns the convar as a boolean flag. ])
-- @return table
-- @param string_1 string
function Convars:GetBool( string_1 ) end

---[[ Convars:GetCommandClient  GetCommandClient() : returns the player who issued this console command. ])
-- @return handle
function Convars:GetCommandClient(  ) end

---[[ Convars:GetDOTACommandClient  GetDOTACommandClient() : returns the DOTA player who issued this console command. ])
-- @return handle
function Convars:GetDOTACommandClient(  ) end

---[[ Convars:GetFloat  GetFloat(name) : returns the convar as a float. May return null if no such convar. ])
-- @return table
-- @param string_1 string
function Convars:GetFloat( string_1 ) end

---[[ Convars:GetInt  GetInt(name) : returns the convar as an int. May return null if no such convar. ])
-- @return table
-- @param string_1 string
function Convars:GetInt( string_1 ) end

---[[ Convars:GetStr  GetStr(name) : returns the convar as a string. May return null if no such convar. ])
-- @return table
-- @param string_1 string
function Convars:GetStr( string_1 ) end

---[[ Convars:RegisterCommand  RegisterCommand(name, fn, helpString, flags) : register a console command. ])
-- @return void
-- @param string_1 string
-- @param handle_2 handle
-- @param string_3 string
-- @param int_4 int
function Convars:RegisterCommand( string_1, handle_2, string_3, int_4 ) end

---[[ Convars:RegisterConvar  RegisterConvar(name, defaultValue, helpString, flags): register a new console variable. ])
-- @return void
-- @param string_1 string
-- @param string_2 string
-- @param string_3 string
-- @param int_4 int
function Convars:RegisterConvar( string_1, string_2, string_3, int_4 ) end

---[[ Convars:SetBool  SetBool(name, val) : sets the value of the convar to the bool. ])
-- @return void
-- @param string_1 string
-- @param bool_2 bool
function Convars:SetBool( string_1, bool_2 ) end

---[[ Convars:SetFloat  SetFloat(name, val) : sets the value of the convar to the float. ])
-- @return void
-- @param string_1 string
-- @param float_2 float
function Convars:SetFloat( string_1, float_2 ) end

---[[ Convars:SetInt  SetInt(name, val) : sets the value of the convar to the int. ])
-- @return void
-- @param string_1 string
-- @param int_2 int
function Convars:SetInt( string_1, int_2 ) end

---[[ Convars:SetStr  SetStr(name, val) : sets the value of the convar to the string. ])
-- @return void
-- @param string_1 string
-- @param string_2 string
function Convars:SetStr( string_1, string_2 ) end

---[[ GlobalSys:CommandLineCheck  CommandLineCheck(name) : returns true if the command line param was used, otherwise false. ])
-- @return table
-- @param string_1 string
function GlobalSys:CommandLineCheck( string_1 ) end

---[[ GlobalSys:CommandLineFloat  CommandLineFloat(name) : returns the command line param as a float. ])
-- @return table
-- @param string_1 string
-- @param float_2 float
function GlobalSys:CommandLineFloat( string_1, float_2 ) end

---[[ GlobalSys:CommandLineInt  CommandLineInt(name) : returns the command line param as an int. ])
-- @return table
-- @param string_1 string
-- @param int_2 int
function GlobalSys:CommandLineInt( string_1, int_2 ) end

---[[ GlobalSys:CommandLineStr  CommandLineStr(name) : returns the command line param as a string. ])
-- @return table
-- @param string_1 string
-- @param string_2 string
function GlobalSys:CommandLineStr( string_1, string_2 ) end

---[[ GridNav:CanFindPath  Determine if it is possible to reach the specified end point from the specified start point. bool (vStart, vEnd) ])
-- @return bool
-- @param Vector_1 Vector
-- @param Vector_2 Vector
function GridNav:CanFindPath( Vector_1, Vector_2 ) end

---[[ GridNav:DestroyTreesAroundPoint  Destroy all trees in the area(vPosition, flRadius, bFullCollision ])
-- @return void
-- @param Vector_1 Vector
-- @param float_2 float
-- @param bool_3 bool
function GridNav:DestroyTreesAroundPoint( Vector_1, float_2, bool_3 ) end

---[[ GridNav:FindPathLength  Find a path between the two points an return the length of the path. If there is not a path between the points the returned value will be -1. float (vStart, vEnd ) ])
-- @return float
-- @param Vector_1 Vector
-- @param Vector_2 Vector
function GridNav:FindPathLength( Vector_1, Vector_2 ) end

---[[ GridNav:GetAllTreesAroundPoint  Returns a table full of tree HSCRIPTS (vPosition, flRadius, bFullCollision). ])
-- @return table
-- @param Vector_1 Vector
-- @param float_2 float
-- @param bool_3 bool
function GridNav:GetAllTreesAroundPoint( Vector_1, float_2, bool_3 ) end

---[[ GridNav:GridPosToWorldCenterX  Get the X position of the center of a given X index ])
-- @return float
-- @param int_1 int
function GridNav:GridPosToWorldCenterX( int_1 ) end

---[[ GridNav:GridPosToWorldCenterY  Get the Y position of the center of a given Y index ])
-- @return float
-- @param int_1 int
function GridNav:GridPosToWorldCenterY( int_1 ) end

---[[ GridNav:IsBlocked  Checks whether the given position is blocked ])
-- @return bool
-- @param Vector_1 Vector
function GridNav:IsBlocked( Vector_1 ) end

---[[ GridNav:IsNearbyTree  (position, radius, checkFullTreeRadius?) Checks whether there are any trees overlapping the given point ])
-- @return bool
-- @param Vector_1 Vector
-- @param float_2 float
-- @param bool_3 bool
function GridNav:IsNearbyTree( Vector_1, float_2, bool_3 ) end

---[[ GridNav:IsTraversable  Checks whether the given position is traversable ])
-- @return bool
-- @param Vector_1 Vector
function GridNav:IsTraversable( Vector_1 ) end

---[[ GridNav:RegrowAllTrees  Causes all trees in the map to regrow ])
-- @return void
function GridNav:RegrowAllTrees(  ) end

---[[ GridNav:WorldToGridPosX  Get the X index of a given world X position ])
-- @return int
-- @param float_1 float
function GridNav:WorldToGridPosX( float_1 ) end

---[[ GridNav:WorldToGridPosY  Get the Y index of a given world Y position ])
-- @return int
-- @param float_1 float
function GridNav:WorldToGridPosY( float_1 ) end

---[[ ProjectileManager:ChangeTrackingProjectileSpeed  Update speed ])
-- @return void
-- @param handle_1 handle
-- @param int_2 int
function ProjectileManager:ChangeTrackingProjectileSpeed( handle_1, int_2 ) end

---[[ ProjectileManager:CreateLinearProjectile  Creates a linear projectile and returns the projectile ID ])
-- @return int
-- @param handle_1 handle
function ProjectileManager:CreateLinearProjectile( handle_1 ) end

---[[ ProjectileManager:CreateTrackingProjectile  Creates a tracking projectile ])
-- @return int
-- @param handle_1 handle
function ProjectileManager:CreateTrackingProjectile( handle_1 ) end

---[[ ProjectileManager:DestroyLinearProjectile  Destroys the linear projectile matching the argument ID ])
-- @return void
-- @param int_1 int
function ProjectileManager:DestroyLinearProjectile( int_1 ) end

---[[ ProjectileManager:DestroyTrackingProjectile  Destroy a tracking projectile early ])
-- @return void
-- @param int_1 int
function ProjectileManager:DestroyTrackingProjectile( int_1 ) end

---[[ ProjectileManager:GetLinearProjectileLocation  Returns current location of projectile ])
-- @return Vector
-- @param int_1 int
function ProjectileManager:GetLinearProjectileLocation( int_1 ) end

---[[ ProjectileManager:GetLinearProjectileRadius  Returns current radius of projectile ])
-- @return float
-- @param int_1 int
function ProjectileManager:GetLinearProjectileRadius( int_1 ) end

---[[ ProjectileManager:GetLinearProjectileVelocity  Returns a vector representing the current velocity of the projectile. ])
-- @return Vector
-- @param int_1 int
function ProjectileManager:GetLinearProjectileVelocity( int_1 ) end

---[[ ProjectileManager:GetTrackingProjectileLocation  Returns current location of projectile ])
-- @return Vector
-- @param int_1 int
function ProjectileManager:GetTrackingProjectileLocation( int_1 ) end

---[[ ProjectileManager:IsValidProjectile  Is this a valid projectile? ])
-- @return bool
-- @param int_1 int
function ProjectileManager:IsValidProjectile( int_1 ) end

---[[ ProjectileManager:ProjectileDodge  Makes the specified unit dodge projectiles ])
-- @return void
-- @param handle_1 handle
function ProjectileManager:ProjectileDodge( handle_1 ) end

---[[ ProjectileManager:UpdateLinearProjectileDirection  Update velocity ])
-- @return void
-- @param int_1 int
-- @param Vector_2 Vector
-- @param float_3 float
function ProjectileManager:UpdateLinearProjectileDirection( int_1, Vector_2, float_3 ) end

---[[ SteamInfo:IsPublicUniverse  Is the script connected to the public Steam universe ])
-- @return bool
function SteamInfo:IsPublicUniverse(  ) end
]]