return [[---[[ AngleDiff  Returns the number of degrees difference between two yaw angles ])
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

---[[ CreateUniformRandomStream  ( iSeed ) - Creates a separate random number stream. ])
-- @return handle
-- @param int_1 int
function CreateUniformRandomStream( int_1 ) end

---[[ CrossVectors  (vector,vector) cross product between two vectors ])
-- @return Vector
-- @param Vector_1 Vector
-- @param Vector_2 Vector
function CrossVectors( Vector_1, Vector_2 ) end

---[[ DebugBreak  Breaks in the debugger ])
-- @return void
function DebugBreak(  ) end

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

---[[ EntIndexToHScript  Turn an entity index integer to an HScript representing that entity's script instance. ])
-- @return handle
-- @param int_1 int
function EntIndexToHScript( int_1 ) end

---[[ ExponentialDecay  Smooth curve decreasing slower as it approaches zero ])
-- @return float
-- @param float_1 float
-- @param float_2 float
-- @param float_3 float
function ExponentialDecay( float_1, float_2, float_3 ) end

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

---[[ GetFrameCount  Returns the engines current frame count ])
-- @return int
function GetFrameCount(  ) end

---[[ GetListenServerHost  Get the local player on a listen server. ])
-- @return handle
function GetListenServerHost(  ) end

---[[ GetLocalPlayerID  Get the local player ID. ])
-- @return int
function GetLocalPlayerID(  ) end

---[[ GetLocalPlayerTeam  Get the local player team. ])
-- @return int
-- @param int_1 int
function GetLocalPlayerTeam( int_1 ) end

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

---[[ GetUnitKeyValuesByName  Get unit data by ability name. ])
-- @return table
-- @param string_1 string
function GetUnitKeyValuesByName( string_1 ) end

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

---[[ IsMarkedForDeletion  Returns true if the entity is valid and marked for deletion. ])
-- @return bool
-- @param handle_1 handle
function IsMarkedForDeletion( handle_1 ) end

---[[ IsServer  Returns true if this is lua running from the server.dll. ])
-- @return bool
function IsServer(  ) end

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

---[[ Msg  Print a message ])
-- @return void
-- @param string_1 string
function Msg( string_1 ) end

---[[ Plat_FloatTime  Get the current float time from the engine ])
-- @return float
function Plat_FloatTime(  ) end

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

---[[ PrintLinkedConsoleMessage  Print a console message with a linked console command ])
-- @return void
-- @param string_1 string
-- @param string_2 string
function PrintLinkedConsoleMessage( string_1, string_2 ) end

---[[ QSlerp  (from angle, to angle, time) - Spherical lerp of angle from->to based on time ])
-- @return QAngle
-- @param QAngle_1 QAngle
-- @param QAngle_2 QAngle
-- @param float_3 float
function QSlerp( QAngle_1, QAngle_2, float_3 ) end

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

---[[ RegisterSpawnGroupFilterProxy  Create a C proxy for a script-based spawn group filter ])
-- @return void
-- @param string_1 string
function RegisterSpawnGroupFilterProxy( string_1 ) end

---[[ ReloadMOTD  Reloads the MotD file ])
-- @return void
function ReloadMOTD(  ) end

---[[ RemoveSpawnGroupFilterProxy  Remove the C proxy for a script-based spawn group filter ])
-- @return void
-- @param string_1 string
function RemoveSpawnGroupFilterProxy( string_1 ) end

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

---[[ SendToConsole  Send a string to the console as a client command ])
-- @return void
-- @param string_1 string
function SendToConsole( string_1 ) end

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

---[[ UTIL_Remove  Removes the specified entity ])
-- @return void
-- @param handle_1 handle
function UTIL_Remove( handle_1 ) end

---[[ UTIL_RemoveImmediate  Immediately removes the specified entity ])
-- @return void
-- @param handle_1 handle
function UTIL_RemoveImmediate( handle_1 ) end

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

--- Enum DOTAAbilitySpeakTrigger_t
DOTA_ABILITY_SPEAK_CAST = 1
DOTA_ABILITY_SPEAK_START_ACTION_PHASE = 0

--- Enum DOTALimits_t
DOTA_DEFAULT_MAX_TEAM = 5 -- Default number of players per team.
DOTA_DEFAULT_MAX_TEAM_PLAYERS = 10 -- Default number of non-spectator players supported.
DOTA_MAX_PLAYERS = 64 -- Max number of players connected to the server including spectators.
DOTA_MAX_PLAYER_TEAMS = 10 -- Max number of player teams supported.
DOTA_MAX_SPECTATOR_LOBBY_SIZE = 15 -- Max number of viewers in a spectator lobby.
DOTA_MAX_SPECTATOR_TEAM_SIZE = 40 -- How many spectators can watch.
DOTA_MAX_TEAM = 24 -- Max number of players per team.
DOTA_MAX_TEAM_PLAYERS = 24 -- Max number of non-spectator players supported.

--- Enum DOTAModifierAttribute_t
MODIFIER_ATTRIBUTE_AURA_PRIORITY = 8
MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE = 4
MODIFIER_ATTRIBUTE_MULTIPLE = 2
MODIFIER_ATTRIBUTE_NONE = 0
MODIFIER_ATTRIBUTE_PERMANENT = 1

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
DOTA_HEROPICK_STATE_COUNT = 62
DOTA_HEROPICK_STATE_CUSTOM_PICK_RULES = 60
DOTA_HEROPICK_STATE_FH_SELECT = 34
DOTA_HEROPICK_STATE_INTRO_SELECT_UNUSED = 3
DOTA_HEROPICK_STATE_MO_SELECT = 33
DOTA_HEROPICK_STATE_NONE = 0
DOTA_HEROPICK_STATE_RD_SELECT_UNUSED = 4
DOTA_HEROPICK_STATE_SCENARIO_PICK = 61
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

--- Enum modifierfunction
MODIFIER_EVENT_ON_ABILITY_END_CHANNEL = 186 -- OnAbilityEndChannel
MODIFIER_EVENT_ON_ABILITY_EXECUTED = 183 -- OnAbilityExecuted
MODIFIER_EVENT_ON_ABILITY_FULLY_CAST = 184 -- OnAbilityFullyCast
MODIFIER_EVENT_ON_ABILITY_START = 182 -- OnAbilityStart
MODIFIER_EVENT_ON_ASSIST = 231 -- OnAssist
MODIFIER_EVENT_ON_ATTACK = 175 -- OnAttack
MODIFIER_EVENT_ON_ATTACKED = 196 -- OnAttacked
MODIFIER_EVENT_ON_ATTACK_ALLIED = 178 -- OnAttackAllied
MODIFIER_EVENT_ON_ATTACK_CANCELLED = 244 -- OnAttackCancelled
MODIFIER_EVENT_ON_ATTACK_FAIL = 177 -- OnAttackFail
MODIFIER_EVENT_ON_ATTACK_FINISHED = 234 -- OnAttackFinished
MODIFIER_EVENT_ON_ATTACK_LANDED = 176 -- OnAttackLanded
MODIFIER_EVENT_ON_ATTACK_RECORD = 173 -- OnAttackRecord
MODIFIER_EVENT_ON_ATTACK_RECORD_DESTROY = 241 -- OnAttackRecordDestroy
MODIFIER_EVENT_ON_ATTACK_START = 174 -- OnAttackStart
MODIFIER_EVENT_ON_ATTEMPT_PROJECTILE_DODGE = 251 -- OnAttemptProjectileDodge
MODIFIER_EVENT_ON_BREAK_INVISIBILITY = 185 -- OnBreakInvisibility
MODIFIER_EVENT_ON_BUILDING_KILLED = 208 -- OnBuildingKilled
MODIFIER_EVENT_ON_DAMAGE_CALCULATED = 194 -- OnDamageCalculated
MODIFIER_EVENT_ON_DEATH = 197 -- OnDeath
MODIFIER_EVENT_ON_DEATH_PREVENTED = 190 -- OnDamagePrevented
MODIFIER_EVENT_ON_DOMINATED = 229 -- OnDominated
MODIFIER_EVENT_ON_HEALTH_GAINED = 203 -- OnHealthGained
MODIFIER_EVENT_ON_HEAL_RECEIVED = 207 -- OnHealReceived
MODIFIER_EVENT_ON_HERO_KILLED = 206 -- OnHeroKilled
MODIFIER_EVENT_ON_KILL = 230 -- OnKill
MODIFIER_EVENT_ON_MAGIC_DAMAGE_CALCULATED = 195 -- OnMagicDamageCalculated
MODIFIER_EVENT_ON_MANA_GAINED = 204 -- OnManaGained
MODIFIER_EVENT_ON_MODEL_CHANGED = 209 -- OnModelChanged
MODIFIER_EVENT_ON_MODIFIER_ADDED = 210 -- OnModifierAdded
MODIFIER_EVENT_ON_ORB_EFFECT = 192 -- Unused
MODIFIER_EVENT_ON_ORDER = 180 -- OnOrder
MODIFIER_EVENT_ON_PREDEBUFF_APPLIED = 252 -- OnPreDebuffApplied
MODIFIER_EVENT_ON_PROCESS_CLEAVE = 193 -- OnProcessCleave
MODIFIER_EVENT_ON_PROCESS_UPGRADE = 187 -- Unused
MODIFIER_EVENT_ON_PROJECTILE_DODGE = 179 -- OnProjectileDodge
MODIFIER_EVENT_ON_PROJECTILE_OBSTRUCTION_HIT = 242 -- OnProjectileObstructionHit
MODIFIER_EVENT_ON_REFRESH = 188 -- Unused
MODIFIER_EVENT_ON_RESPAWN = 198 -- OnRespawn
MODIFIER_EVENT_ON_SET_LOCATION = 202 -- OnSetLocation
MODIFIER_EVENT_ON_SPELL_TARGET_READY = 172 -- OnSpellTargetReady
MODIFIER_EVENT_ON_SPENT_MANA = 199 -- OnSpentMana
MODIFIER_EVENT_ON_STATE_CHANGED = 191 -- OnStateChanged
MODIFIER_EVENT_ON_TAKEDAMAGE = 189 -- OnTakeDamage
MODIFIER_EVENT_ON_TAKEDAMAGE_KILLCREDIT = 205 -- OnTakeDamageKillCredit
MODIFIER_EVENT_ON_TELEPORTED = 201 -- OnTeleported
MODIFIER_EVENT_ON_TELEPORTING = 200 -- OnTeleporting
MODIFIER_EVENT_ON_UNIT_MOVED = 181 -- OnUnitMoved
MODIFIER_FUNCTION_INVALID = 255
MODIFIER_FUNCTION_LAST = 254
MODIFIER_PROPERTY_ABILITY_LAYOUT = 228 -- GetModifierAbilityLayout
MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL = 148 -- GetAbsoluteNoDamageMagical
MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL = 147 -- GetAbsoluteNoDamagePhysical
MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE = 149 -- GetAbsoluteNoDamagePure
MODIFIER_PROPERTY_ABSORB_SPELL = 137 -- GetAbsorbSpell
MODIFIER_PROPERTY_ALWAYS_ALLOW_ATTACK = 159 -- GetAlwaysAllowAttack
MODIFIER_PROPERTY_ALWAYS_AUTOATTACK_WHILE_HOLD_POSITION = 171 -- GetAlwaysAutoAttackWhileHoldPosition
MODIFIER_PROPERTY_ALWAYS_ETHEREAL_ATTACK = 160 -- GetAllowEtherealAttack
MODIFIER_PROPERTY_ATTACKSPEED_BASE_OVERRIDE = 29 -- GetModifierAttackSpeedBaseOverride
MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT = 31 -- GetModifierAttackSpeedBonus_Constant
MODIFIER_PROPERTY_ATTACKSPEED_PERCENTAGE = 250 -- GetModifierAttackSpeedPercentage
MODIFIER_PROPERTY_ATTACKSPEED_REDUCTION_PERCENTAGE = 247 -- GetModifierAttackSpeedReductionPercentage
MODIFIER_PROPERTY_ATTACK_ANIM_TIME_PERCENTAGE = 121 -- GetModifierPercentageAttackAnimTime
MODIFIER_PROPERTY_ATTACK_POINT_CONSTANT = 38 -- GetModifierAttackPointConstant
MODIFIER_PROPERTY_ATTACK_RANGE_BASE_OVERRIDE = 106 -- GetModifierAttackRangeOverride
MODIFIER_PROPERTY_ATTACK_RANGE_BONUS = 107 -- GetModifierAttackRangeBonus
MODIFIER_PROPERTY_ATTACK_RANGE_BONUS_PERCENTAGE = 109 -- GetModifierAttackRangeBonusPercentage
MODIFIER_PROPERTY_ATTACK_RANGE_BONUS_UNIQUE = 108 -- GetModifierAttackRangeBonusUnique
MODIFIER_PROPERTY_ATTACK_WHILE_MOVING_TARGET = 249
MODIFIER_PROPERTY_AVOID_DAMAGE = 67 -- GetModifierAvoidDamage
MODIFIER_PROPERTY_AVOID_SPELL = 68 -- GetModifierAvoidSpell
MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE = 4 -- GetModifierBaseAttack_BonusDamage
MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE = 56 -- GetModifierBaseDamageOutgoing_Percentage
MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE_UNIQUE = 57 -- GetModifierBaseDamageOutgoing_PercentageUnique
MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT = 35 -- GetModifierBaseAttackTimeConstant
MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT_ADJUST = 36 -- GetModifierBaseAttackTimeConstant_Adjust
MODIFIER_PROPERTY_BASE_ATTACK_TIME_PERCENTAGE = 37 -- GetModifierBaseAttackTimePercentage
MODIFIER_PROPERTY_BASE_MANA_REGEN = 82 -- GetModifierBaseRegen
MODIFIER_PROPERTY_BONUSDAMAGEOUTGOING_PERCENTAGE = 39 -- GetModifierBonusDamageOutgoing_Percentage
MODIFIER_PROPERTY_BONUS_DAY_VISION = 140 -- GetBonusDayVision
MODIFIER_PROPERTY_BONUS_NIGHT_VISION = 141 -- GetBonusNightVision
MODIFIER_PROPERTY_BONUS_NIGHT_VISION_UNIQUE = 142 -- GetBonusNightVisionUnique
MODIFIER_PROPERTY_BONUS_VISION_PERCENTAGE = 143 -- GetBonusVisionPercentage
MODIFIER_PROPERTY_BOT_ATTACK_SCORE_BONUS = 246 -- BotAttackScoreBonus
MODIFIER_PROPERTY_BOUNTY_CREEP_MULTIPLIER = 163 -- Unused
MODIFIER_PROPERTY_BOUNTY_OTHER_MULTIPLIER = 164 -- Unused
MODIFIER_PROPERTY_CAN_ATTACK_TREES = 236 -- GetModifierCanAttackTrees
MODIFIER_PROPERTY_CASTTIME_PERCENTAGE = 120 -- GetModifierPercentageCasttime
MODIFIER_PROPERTY_CAST_RANGE_BONUS = 102 -- GetModifierCastRangeBonus
MODIFIER_PROPERTY_CAST_RANGE_BONUS_PERCENTAGE = 103 -- GetModifierCastRangeBonusPercentage
MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING = 105 -- GetModifierCastRangeBonusStacking
MODIFIER_PROPERTY_CAST_RANGE_BONUS_TARGET = 104 -- GetModifierCastRangeBonusTarget
MODIFIER_PROPERTY_CHANGE_ABILITY_VALUE = 225 -- GetModifierChangeAbilityValue
MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE = 118 -- GetModifierPercentageCooldown
MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE_ONGOING = 119 -- GetModifierPercentageCooldownOngoing
MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE_STACKING = 253 -- GetModifierPercentageCooldownStacking
MODIFIER_PROPERTY_COOLDOWN_REDUCTION_CONSTANT = 33 -- GetModifierCooldownReduction_Constant
MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE = 40 -- GetModifierDamageOutgoing_Percentage
MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE_ILLUSION = 41 -- GetModifierDamageOutgoing_Percentage_Illusion
MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE_ILLUSION_AMPLIFY = 42 -- GetModifierDamageOutgoing_Percentage_Illusion_Amplify
MODIFIER_PROPERTY_DEATHGOLDCOST = 124 -- GetModifierConstantDeathGoldCost
MODIFIER_PROPERTY_DISABLE_AUTOATTACK = 139 -- GetDisableAutoAttack
MODIFIER_PROPERTY_DISABLE_HEALING = 158 -- GetDisableHealing
MODIFIER_PROPERTY_DISABLE_TURNING = 223 -- GetModifierDisableTurning
MODIFIER_PROPERTY_DODGE_PROJECTILE = 166 -- GetModifierDodgeProjectile
MODIFIER_PROPERTY_DONT_GIVE_VISION_OF_ATTACKER = 239 -- GetModifierNoVisionOfAttacker
MODIFIER_PROPERTY_EVASION_CONSTANT = 62 -- GetModifierEvasion_Constant
MODIFIER_PROPERTY_EXP_RATE_BOOST = 125 -- GetModifierPercentageExpRateBoost
MODIFIER_PROPERTY_EXTRA_HEALTH_BONUS = 92 -- GetModifierExtraHealthBonus
MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE = 94 -- GetModifierExtraHealthPercentage
MODIFIER_PROPERTY_EXTRA_MANA_BONUS = 93 -- GetModifierExtraManaBonus
MODIFIER_PROPERTY_EXTRA_MANA_PERCENTAGE = 95 -- GetModifierExtraManaPercentage
MODIFIER_PROPERTY_EXTRA_STRENGTH_BONUS = 91 -- GetModifierExtraStrengthBonus
MODIFIER_PROPERTY_FIXED_ATTACK_RATE = 30 -- GetModifierFixedAttackRate
MODIFIER_PROPERTY_FIXED_DAY_VISION = 144 -- GetFixedDayVision
MODIFIER_PROPERTY_FIXED_NIGHT_VISION = 145 -- GetFixedNightVision
MODIFIER_PROPERTY_FORCE_DRAW_MINIMAP = 222 -- GetForceDrawOnMinimap
MODIFIER_PROPERTY_GOLD_RATE_BOOST = 126 -- GetModifierPercentageGoldRateBoost
MODIFIER_PROPERTY_HEALTH_BONUS = 89 -- GetModifierHealthBonus
MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT = 86 -- GetModifierConstantHealthRegen
MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE = 87 -- GetModifierHealthRegenPercentage
MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE_UNIQUE = 88 -- GetModifierHealthRegenPercentageUnique
MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_SOURCE = 47 -- GetModifierHealAmplify_PercentageSource
MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET = 48 -- GetModifierHealAmplify_PercentageTarget
MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE = 50 -- GetModifierHPRegenAmplify_Percentage
MODIFIER_PROPERTY_HP_REGEN_CAN_BE_NEGATIVE = 49 -- GetModifierHPRegen_CanBeNegative
MODIFIER_PROPERTY_IGNORE_ATTACKSPEED_LIMIT = 32 -- GetModifierAttackSpeed_Limit
MODIFIER_PROPERTY_IGNORE_CAST_ANGLE = 224 -- GetModifierIgnoreCastAngle
MODIFIER_PROPERTY_IGNORE_COOLDOWN = 235 -- GetModifierIgnoreCooldown
MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT = 27 -- GetModifierIgnoreMovespeedLimit
MODIFIER_PROPERTY_IGNORE_PHYSICAL_ARMOR = 76 -- GetModifierIgnorePhysicalArmor
MODIFIER_PROPERTY_ILLUSION_LABEL = 151 -- GetModifierIllusionLabel
MODIFIER_PROPERTY_INCOMING_DAMAGE_ILLUSION = 238
MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE = 58 -- GetModifierIncomingDamage_Percentage
MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_CONSTANT = 60 -- GetModifierIncomingPhysicalDamageConstant
MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_PERCENTAGE = 59 -- GetModifierIncomingPhysicalDamage_Percentage
MODIFIER_PROPERTY_INCOMING_SPELL_DAMAGE_CONSTANT = 61 -- GetModifierIncomingSpellDamageConstant
MODIFIER_PROPERTY_INVISIBILITY_ATTACK_BEHAVIOR_EXCEPTION = 14 -- GetModifierInvisibilityAttackBehaviorException
MODIFIER_PROPERTY_INVISIBILITY_LEVEL = 13 -- GetModifierInvisibilityLevel
MODIFIER_PROPERTY_IS_ILLUSION = 150 -- GetIsIllusion
MODIFIER_PROPERTY_IS_SCEPTER = 214 -- GetModifierScepter
MODIFIER_PROPERTY_IS_SHARD = 215 -- GetModifierShard
MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE = 51 -- GetModifierLifestealRegenAmplify_Percentage
MODIFIER_PROPERTY_LIFETIME_FRACTION = 219 -- GetUnitLifetimeFraction
MODIFIER_PROPERTY_MAGICAL_CONSTANT_BLOCK = 129 -- GetModifierMagical_ConstantBlock
MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BASE_REDUCTION = 77 -- GetModifierMagicalResistanceBaseReduction
MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS = 79 -- GetModifierMagicalResistanceBonus
MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS_ILLUSIONS = 80 -- GetModifierMagicalResistanceBonusIllusions
MODIFIER_PROPERTY_MAGICAL_RESISTANCE_DECREPIFY_UNIQUE = 81 -- GetModifierMagicalResistanceDecrepifyUnique
MODIFIER_PROPERTY_MAGICAL_RESISTANCE_DIRECT_MODIFICATION = 78 -- GetModifierMagicalResistanceDirectModification
MODIFIER_PROPERTY_MANACOST_PERCENTAGE = 122 -- GetModifierPercentageManacost
MODIFIER_PROPERTY_MANACOST_PERCENTAGE_STACKING = 123 -- GetModifierPercentageManacostStacking
MODIFIER_PROPERTY_MANACOST_REDUCTION_CONSTANT = 34 -- GetModifierManacostReduction_Constant
MODIFIER_PROPERTY_MANA_BONUS = 90 -- GetModifierManaBonus
MODIFIER_PROPERTY_MANA_DRAIN_AMPLIFY_PERCENTAGE = 54 -- GetModifierManaDrainAmplify_Percentage
MODIFIER_PROPERTY_MANA_REGEN_CONSTANT = 83 -- GetModifierConstantManaRegen
MODIFIER_PROPERTY_MANA_REGEN_CONSTANT_UNIQUE = 84 -- GetModifierConstantManaRegenUnique
MODIFIER_PROPERTY_MANA_REGEN_TOTAL_PERCENTAGE = 85 -- GetModifierTotalPercentageManaRegen
MODIFIER_PROPERTY_MAX_ATTACK_RANGE = 110 -- GetModifierMaxAttackRange
MODIFIER_PROPERTY_MAX_DEBUFF_DURATION = 168 -- GetModifierMaxDebuffDuration
MODIFIER_PROPERTY_MIN_HEALTH = 146 -- GetMinHealth
MODIFIER_PROPERTY_MISS_PERCENTAGE = 69 -- GetModifierMiss_Percentage
MODIFIER_PROPERTY_MODEL_CHANGE = 212 -- GetModifierModelChange
MODIFIER_PROPERTY_MODEL_SCALE = 213 -- GetModifierModelScale
MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE = 24 -- GetModifierMoveSpeed_Absolute
MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE_MAX = 26 -- GetModifierMoveSpeed_AbsoluteMax
MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE_MIN = 25 -- GetModifierMoveSpeed_AbsoluteMin
MODIFIER_PROPERTY_MOVESPEED_BASE_OVERRIDE = 17 -- GetModifierMoveSpeedOverride
MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT = 16 -- GetModifierMoveSpeedBonus_Constant
MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT_UNIQUE = 22 -- GetModifierMoveSpeedBonus_Constant_Unique
MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT_UNIQUE_2 = 23 -- GetModifierMoveSpeedBonus_Constant_Unique_2
MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE = 18 -- GetModifierMoveSpeedBonus_Percentage
MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE_UNIQUE = 19 -- GetModifierMoveSpeedBonus_Percentage_Unique
MODIFIER_PROPERTY_MOVESPEED_BONUS_UNIQUE = 20 -- GetModifierMoveSpeedBonus_Special_Boots
MODIFIER_PROPERTY_MOVESPEED_BONUS_UNIQUE_2 = 21 -- GetModifierMoveSpeedBonus_Special_Boots_2
MODIFIER_PROPERTY_MOVESPEED_LIMIT = 28 -- GetModifierMoveSpeed_Limit
MODIFIER_PROPERTY_MOVESPEED_REDUCTION_PERCENTAGE = 248 -- GetModifierMoveSpeedReductionPercentage
MODIFIER_PROPERTY_MP_REGEN_AMPLIFY_PERCENTAGE = 53 -- GetModifierMPRegenAmplify_Percentage
MODIFIER_PROPERTY_MP_RESTORE_AMPLIFY_PERCENTAGE = 55 -- GetModifierMPRestoreAmplify_Percentage
MODIFIER_PROPERTY_NEGATIVE_EVASION_CONSTANT = 63 -- GetModifierNegativeEvasion_Constant
MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL = 226 -- GetModifierOverrideAbilitySpecial
MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL_VALUE = 227 -- GetModifierOverrideAbilitySpecialValue
MODIFIER_PROPERTY_OVERRIDE_ANIMATION = 134 -- GetOverrideAnimation
MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE = 136 -- GetOverrideAnimationRate
MODIFIER_PROPERTY_OVERRIDE_ANIMATION_WEIGHT = 135 -- GetOverrideAnimationWeight
MODIFIER_PROPERTY_OVERRIDE_ATTACK_DAMAGE = 11 -- GetModifierOverrideAttackDamage
MODIFIER_PROPERTY_OVERRIDE_ATTACK_MAGICAL = 161 -- GetOverrideAttackMagical
MODIFIER_PROPERTY_PERSISTENT_INVISIBILITY = 15 -- GetModifierPersistentInvisibility
MODIFIER_PROPERTY_PHYSICAL_ARMOR_BASE_PERCENTAGE = 70 -- GetModifierPhysicalArmorBase_Percentage
MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS = 72 -- GetModifierPhysicalArmorBonus
MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS_POST = 75 -- GetModifierPhysicalArmorBonusPost
MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS_UNIQUE = 73 -- GetModifierPhysicalArmorBonusUnique
MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS_UNIQUE_ACTIVE = 74 -- GetModifierPhysicalArmorBonusUniqueActive
MODIFIER_PROPERTY_PHYSICAL_ARMOR_TOTAL_PERCENTAGE = 71 -- GetModifierPhysicalArmorTotal_Percentage
MODIFIER_PROPERTY_PHYSICAL_CONSTANT_BLOCK = 130 -- GetModifierPhysical_ConstantBlock
MODIFIER_PROPERTY_PHYSICAL_CONSTANT_BLOCK_SPECIAL = 131 -- GetModifierPhysical_ConstantBlockSpecial
MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE = 0 -- GetModifierPreAttack_BonusDamage
MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE_POST_CRIT = 3 -- GetModifierPreAttack_BonusDamagePostCrit
MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE_PROC = 2 -- GetModifierPreAttack_BonusDamage_Proc
MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE_TARGET = 1 -- GetModifierPreAttack_BonusDamage_Target
MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE = 127 -- GetModifierPreAttack_CriticalStrike
MODIFIER_PROPERTY_PREATTACK_DEADLY_BLOW = 170 -- GetModifierPreAttack_DeadlyBlow
MODIFIER_PROPERTY_PREATTACK_TARGET_CRITICALSTRIKE = 128 -- GetModifierPreAttack_Target_CriticalStrike
MODIFIER_PROPERTY_PRESERVE_PARTICLES_ON_MODEL_CHANGE = 233 -- PreserveParticlesOnModelChanged
MODIFIER_PROPERTY_PRE_ATTACK = 12 -- GetModifierPreAttack
MODIFIER_PROPERTY_PRIMARY_STAT_DAMAGE_MULTIPLIER = 169 -- GetPrimaryStatDamageMultiplier
MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_MAGICAL = 7 -- GetModifierProcAttack_BonusDamage_Magical
MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_MAGICAL_TARGET = 9 -- GetModifierProcAttack_BonusDamage_Magical_Target
MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL = 5 -- GetModifierProcAttack_BonusDamage_Physical
MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PURE = 8 -- GetModifierProcAttack_BonusDamage_Pure
MODIFIER_PROPERTY_PROCATTACK_CONVERT_PHYSICAL_TO_MAGICAL = 6 -- GetModifierProcAttack_ConvertPhysicalToMagical
MODIFIER_PROPERTY_PROCATTACK_FEEDBACK = 10 -- GetModifierProcAttack_Feedback
MODIFIER_PROPERTY_PROJECTILE_NAME = 113 -- GetModifierProjectileName
MODIFIER_PROPERTY_PROJECTILE_SPEED_BONUS = 111 -- GetModifierProjectileSpeedBonus
MODIFIER_PROPERTY_PROJECTILE_SPEED_BONUS_PERCENTAGE = 112 -- GetModifierProjectileSpeedBonusPercentage
MODIFIER_PROPERTY_PROVIDES_FOW_POSITION = 220 -- GetModifierProvidesFOWVision
MODIFIER_PROPERTY_RADAR_COOLDOWN_REDUCTION = 216 -- GetModifierRadarCooldownReduction
MODIFIER_PROPERTY_REFLECT_SPELL = 138 -- GetReflectSpell
MODIFIER_PROPERTY_REINCARNATION = 114 -- ReincarnateTime
MODIFIER_PROPERTY_RESPAWNTIME = 115 -- GetModifierConstantRespawnTime
MODIFIER_PROPERTY_RESPAWNTIME_PERCENTAGE = 116 -- GetModifierPercentageRespawnTime
MODIFIER_PROPERTY_RESPAWNTIME_STACKING = 117 -- GetModifierStackingRespawnTime
MODIFIER_PROPERTY_SPELLS_REQUIRE_HP = 221 -- GetModifierSpellsRequireHP
MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE = 45 -- GetModifierSpellAmplify_Percentage
MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE_CREEP = 44 -- GetModifierSpellAmplify_PercentageCreep
MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE_UNIQUE = 46 -- GetModifierSpellAmplify_PercentageUnique
MODIFIER_PROPERTY_SPELL_LIFESTEAL_AMPLIFY_PERCENTAGE = 52 -- GetModifierSpellLifestealRegenAmplify_Percentage
MODIFIER_PROPERTY_STATS_AGILITY_BONUS = 97 -- GetModifierBonusStats_Agility
MODIFIER_PROPERTY_STATS_AGILITY_BONUS_PERCENTAGE = 100 -- GetModifierBonusStats_Agility_Percentage
MODIFIER_PROPERTY_STATS_INTELLECT_BONUS = 98 -- GetModifierBonusStats_Intellect
MODIFIER_PROPERTY_STATS_INTELLECT_BONUS_PERCENTAGE = 101 -- GetModifierBonusStats_Intellect_Percentage
MODIFIER_PROPERTY_STATS_STRENGTH_BONUS = 96 -- GetModifierBonusStats_Strength
MODIFIER_PROPERTY_STATS_STRENGTH_BONUS_PERCENTAGE = 99 -- GetModifierBonusStats_Strength_Percentage
MODIFIER_PROPERTY_STATUS_RESISTANCE = 64 -- GetModifierStatusResistance
MODIFIER_PROPERTY_STATUS_RESISTANCE_CASTER = 66 -- GetModifierStatusResistanceCaster
MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING = 65 -- GetModifierStatusResistanceStacking
MODIFIER_PROPERTY_STRONG_ILLUSION = 152 -- GetModifierStrongIllusion
MODIFIER_PROPERTY_SUPER_ILLUSION = 153 -- GetModifierSuperIllusion
MODIFIER_PROPERTY_SUPER_ILLUSION_WITH_ULTIMATE = 154 -- GetModifierSuperIllusionWithUltimate
MODIFIER_PROPERTY_SUPPRESS_CLEAVE = 245 -- GetSuppressCleave
MODIFIER_PROPERTY_SUPPRESS_TELEPORT = 243 -- GetSuppressTeleport
MODIFIER_PROPERTY_TEMPEST_DOUBLE = 232 -- GetModifierTempestDouble
MODIFIER_PROPERTY_TOOLTIP = 211 -- OnTooltip
MODIFIER_PROPERTY_TOOLTIP2 = 240 -- OnTooltip2
MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE = 43 -- GetModifierTotalDamageOutgoing_Percentage
MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK = 133 -- GetModifierTotal_ConstantBlock
MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK_UNAVOIDABLE_PRE_ARMOR = 132 -- GetModifierPhysical_ConstantBlockUnavoidablePreArmor
MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS = 217 -- GetActivityTranslationModifiers
MODIFIER_PROPERTY_TRANSLATE_ATTACK_SOUND = 218 -- GetAttackSound
MODIFIER_PROPERTY_TRIGGER_COSMETIC_AND_END_ATTACK = 167 -- GetTriggerCosmeticAndEndAttack
MODIFIER_PROPERTY_TURN_RATE_OVERRIDE = 157 -- GetModifierTurnRate_Override
MODIFIER_PROPERTY_TURN_RATE_PERCENTAGE = 156 -- GetModifierTurnRate_Percentage
MODIFIER_PROPERTY_UNIT_DISALLOW_UPGRADING = 165 -- GetModifierUnitDisllowUpgrading
MODIFIER_PROPERTY_UNIT_STATS_NEEDS_REFRESH = 162 -- GetModifierUnitStatsNeedsRefresh
MODIFIER_PROPERTY_VISUAL_Z_DELTA = 237 -- GetVisualZDelta
MODIFIER_PROPERTY_XP_DURING_DEATH = 155 -- GetModifierXPDuringDeath

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
MODIFIER_STATE_ALLOW_PATHING_THROUGH_CLIFFS = 47
MODIFIER_STATE_ALLOW_PATHING_THROUGH_FISSURE = 48
MODIFIER_STATE_ALLOW_PATHING_THROUGH_TREES = 37
MODIFIER_STATE_ATTACK_ALLIES = 46
MODIFIER_STATE_ATTACK_IMMUNE = 2
MODIFIER_STATE_BLIND = 30
MODIFIER_STATE_BLOCK_DISABLED = 12
MODIFIER_STATE_CANNOT_BE_MOTION_CONTROLLED = 44
MODIFIER_STATE_CANNOT_MISS = 16
MODIFIER_STATE_CANNOT_TARGET_ENEMIES = 15
MODIFIER_STATE_COMMAND_RESTRICTED = 19
MODIFIER_STATE_DISARMED = 1
MODIFIER_STATE_DOMINATED = 29
MODIFIER_STATE_EVADE_DISABLED = 13
MODIFIER_STATE_FAKE_ALLY = 32
MODIFIER_STATE_FEARED = 42
MODIFIER_STATE_FLYING = 24
MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY = 33
MODIFIER_STATE_FORCED_FLYING_VISION = 45
MODIFIER_STATE_FROZEN = 18
MODIFIER_STATE_HEXED = 6
MODIFIER_STATE_IGNORING_MOVE_AND_ATTACK_ORDERS = 36
MODIFIER_STATE_IGNORING_STOP_ORDERS = 41
MODIFIER_STATE_INVISIBLE = 7
MODIFIER_STATE_INVULNERABLE = 8
MODIFIER_STATE_LAST = 50
MODIFIER_STATE_LOW_ATTACK_PRIORITY = 21
MODIFIER_STATE_MAGIC_IMMUNE = 9
MODIFIER_STATE_MUTED = 4
MODIFIER_STATE_NIGHTMARED = 11
MODIFIER_STATE_NOT_ON_MINIMAP = 20
MODIFIER_STATE_NOT_ON_MINIMAP_FOR_ENEMIES = 38
MODIFIER_STATE_NO_HEALTH_BAR = 22
MODIFIER_STATE_NO_HEALTH_BAR_FOR_ENEMIES = 23
MODIFIER_STATE_NO_TEAM_MOVE_TO = 26
MODIFIER_STATE_NO_TEAM_SELECT = 27
MODIFIER_STATE_NO_UNIT_COLLISION = 25
MODIFIER_STATE_OUT_OF_GAME = 31
MODIFIER_STATE_PASSIVES_DISABLED = 28
MODIFIER_STATE_PROVIDES_VISION = 10
MODIFIER_STATE_ROOTED = 0
MODIFIER_STATE_SILENCED = 3
MODIFIER_STATE_SPECIALLY_DENIABLE = 17
MODIFIER_STATE_SPECIALLY_UNDENIABLE = 49
MODIFIER_STATE_STUNNED = 5
MODIFIER_STATE_TAUNTED = 43
MODIFIER_STATE_TETHERED = 40
MODIFIER_STATE_TRUESIGHT_IMMUNE = 34
MODIFIER_STATE_UNSELECTABLE = 14
MODIFIER_STATE_UNSLOWABLE = 39
MODIFIER_STATE_UNTARGETABLE = 35
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
-- @return int
function CBodyComponent:GetSequence(  ) end

---[[ CBodyComponent:IsAttachedToParent  Is attached to parent ])
-- @return bool
function CBodyComponent:IsAttachedToParent(  ) end

---[[ CBodyComponent:LookupSequence  Returns a sequence id given a name
 ])
-- @return int
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

---[[ CCustomNetTableManager:GetTableValue  ( string TableName, string KeyName ) ])
-- @return table
-- @param string_1 string
-- @param string_2 string
function CCustomNetTableManager:GetTableValue( string_1, string_2 ) end

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

---[[ CDOTAGamerules:GetBannedHeroIDs  Returns the hero unit IDs banned in this game, if any ])
-- @return table
function CDOTAGamerules:GetBannedHeroIDs(  ) end

---[[ CDOTAGamerules:GetBannedHeroes  Returns the hero unit names banned in this game, if any ])
-- @return table
function CDOTAGamerules:GetBannedHeroes(  ) end

---[[ CDOTAGamerules:GetCustomGameDifficulty  Returns the difficulty level of the custom game mode ])
-- @return int
function CDOTAGamerules:GetCustomGameDifficulty(  ) end

---[[ CDOTAGamerules:GetDOTATime  (b IncludePregameTime b IncludeNegativeTime) Returns the actual DOTA in-game clock time. ])
-- @return float
-- @param bool_1 bool
-- @param bool_2 bool
function CDOTAGamerules:GetDOTATime( bool_1, bool_2 ) end

---[[ CDOTAGamerules:GetDifficulty  Returns difficulty level of the custom game mode ])
-- @return int
function CDOTAGamerules:GetDifficulty(  ) end

---[[ CDOTAGamerules:GetGameFrameTime  Returns the number of seconds elapsed since the last frame was renderered. This time doesn't count up when the game is paused ])
-- @return float
function CDOTAGamerules:GetGameFrameTime(  ) end

---[[ CDOTAGamerules:GetGameTime  Returns the number of seconds elapsed since map start. This time doesn't count up when the game is paused ])
-- @return float
function CDOTAGamerules:GetGameTime(  ) end

---[[ CDOTAGamerules:GetIetmStockDuration  Get the time it takes to add a new item to stock ])
-- @return float
-- @param int_1 int
-- @param string_2 string
-- @param int_3 int
function CDOTAGamerules:GetIetmStockDuration( int_1, string_2, int_3 ) end

---[[ CDOTAGamerules:GetItemStockCount  Get the stock count of the item ])
-- @return int
-- @param int_1 int
-- @param string_2 string
-- @param int_3 int
function CDOTAGamerules:GetItemStockCount( int_1, string_2, int_3 ) end

---[[ CDOTAGamerules:GetItemStockTime  Get the time an item will be added to stock ])
-- @return float
-- @param int_1 int
-- @param string_2 string
-- @param int_3 int
function CDOTAGamerules:GetItemStockTime( int_1, string_2, int_3 ) end

---[[ CDOTAGamerules:GetWeatherWindDirection  Get Weather Wind Direction Vector ])
-- @return Vector
function CDOTAGamerules:GetWeatherWindDirection(  ) end

---[[ CDOTAGamerules:IsCheatMode  Are cheats enabled on the server ])
-- @return bool
function CDOTAGamerules:IsCheatMode(  ) end

---[[ CDOTAGamerules:IsDev   ])
-- @return bool
function CDOTAGamerules:IsDev(  ) end

---[[ CDOTAGamerules:IsHeroEnabledViaLists  Is the hero not blacklisted, and is it either whitelisted or the whitelist is empty? ])
-- @return bool
-- @param string_1 string
function CDOTAGamerules:IsHeroEnabledViaLists( string_1 ) end

---[[ CDOTAGamerules:ShouldHideBlacklistedHeroes  Are blacklisted heroes hidden, or just dimmed, in hero picking? ])
-- @return bool
function CDOTAGamerules:ShouldHideBlacklistedHeroes(  ) end

---[[ CDOTAGamerules:State_Get  Get the current Gamerules state ])
-- @return int
function CDOTAGamerules:State_Get(  ) end

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

---[[ CDOTA_Buff:SetDuration  (flTime, bInformClients) ])
-- @return void
-- @param flDuration float
-- @param bInformClient bool
function CDOTA_Buff:SetDuration( flDuration, bInformClient ) end

---[[ CDOTA_Buff:SetOverheadEffectOffset   ])
-- @return bool
-- @param flOffset float
function CDOTA_Buff:SetOverheadEffectOffset( flOffset ) end

---[[ CDOTA_Buff:SetStackCount   ])
-- @return void
-- @param iCount int
function CDOTA_Buff:SetStackCount( iCount ) end

---[[ CDOTA_Buff:StartIntervalThink  Start this modifier's think function (OnIntervalThink) with the given interval (float).  To stop, call with -1. ])
-- @return void
-- @param flInterval float
function CDOTA_Buff:StartIntervalThink( flInterval ) end

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

---[[ CEntities:First  Begin an iteration over the list of entities ])
-- @return handle
function CEntities:First(  ) end

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

---[[ CNativeOutputs:AddOutput  Add an output ])
-- @return void
-- @param string_1 string
-- @param string_2 string
function CNativeOutputs:AddOutput( string_1, string_2 ) end

---[[ CNativeOutputs:Init  Initialize with number of outputs ])
-- @return void
-- @param int_1 int
function CNativeOutputs:Init( int_1 ) end

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

---[[ C_BaseEntity:GetAbsOrigin   ])
-- @return Vector
function C_BaseEntity:GetAbsOrigin(  ) end

---[[ C_BaseEntity:GetHealth   ])
-- @return int
function C_BaseEntity:GetHealth(  ) end

---[[ C_BaseEntity:GetMaxHealth   ])
-- @return int
function C_BaseEntity:GetMaxHealth(  ) end

---[[ C_BaseEntity:GetTeamNumber   ])
-- @return int
function C_BaseEntity:GetTeamNumber(  ) end

---[[ C_BaseEntity:SetContextThink  Set a think function on this entity. ])
-- @return void
-- @param pszContextName string
-- @param hThinkFunc handle
-- @param flInterval float
function C_BaseEntity:SetContextThink( pszContextName, hThinkFunc, flInterval ) end

---[[ C_BaseModelEntity:GetRenderAlpha  GetRenderAlpha(): Get the alpha modulation of this entity. ])
-- @return int
function C_BaseModelEntity:GetRenderAlpha(  ) end

---[[ C_DOTABaseAbility:GetAbilityName  Name of this ability. ])
-- @return string
function C_DOTABaseAbility:GetAbilityName(  ) end

---[[ C_DOTABaseAbility:GetBehavior   ])
-- @return int
function C_DOTABaseAbility:GetBehavior(  ) end

---[[ C_DOTABaseAbility:GetBehaviorInt  Get ability behavior flags as an int for compatibility. ])
-- @return int
function C_DOTABaseAbility:GetBehaviorInt(  ) end

---[[ C_DOTABaseAbility:GetCastPointModifier   ])
-- @return float
function C_DOTABaseAbility:GetCastPointModifier(  ) end

---[[ C_DOTABaseAbility:GetCaster  Get the owner of this ability. ])
-- @return handle
function C_DOTABaseAbility:GetCaster(  ) end

---[[ C_DOTABaseAbility:GetCurrentAbilityCharges  The number of charges remaining on this ability. ])
-- @return int
function C_DOTABaseAbility:GetCurrentAbilityCharges(  ) end

---[[ C_DOTABaseAbility:GetLevel  Return the level of the ability ])
-- @return int
function C_DOTABaseAbility:GetLevel(  ) end

---[[ C_DOTABaseAbility:GetLevelSpecialValueFor  Gets a value from this ability's special value block for passed level. ])
-- @return table
-- @param szName string
-- @param nLevel int
function C_DOTABaseAbility:GetLevelSpecialValueFor( szName, nLevel ) end

---[[ C_DOTABaseAbility:GetLevelSpecialValueNoOverride   ])
-- @return table
-- @param szName string
-- @param nLevel int
function C_DOTABaseAbility:GetLevelSpecialValueNoOverride( szName, nLevel ) end

---[[ C_DOTABaseAbility:GetSpecialValueFor  Gets a value from this ability's special value block for its current level. ])
-- @return table
-- @param szName string
function C_DOTABaseAbility:GetSpecialValueFor( szName ) end

---[[ C_DOTABaseAbility:GetToggleState  Whether or not this ability is toggled. ])
-- @return bool
function C_DOTABaseAbility:GetToggleState(  ) end

---[[ C_DOTABaseAbility:IsItem  Whether or not this ability is an item. ])
-- @return bool
function C_DOTABaseAbility:IsItem(  ) end

---[[ C_DOTA_Ability_Lua:CastFilterResult  Determine whether an issued command with no target is valid. ])
-- @return int
function C_DOTA_Ability_Lua:CastFilterResult(  ) end

---[[ C_DOTA_Ability_Lua:CastFilterResultLocation  (Vector vLocation) Determine whether an issued command on a location is valid. ])
-- @return int
-- @param vLocation Vector
function C_DOTA_Ability_Lua:CastFilterResultLocation( vLocation ) end

---[[ C_DOTA_Ability_Lua:CastFilterResultTarget  (HSCRIPT hTarget) Determine whether an issued command on a target is valid. ])
-- @return int
-- @param hTarget handle
function C_DOTA_Ability_Lua:CastFilterResultTarget( hTarget ) end

---[[ C_DOTA_Ability_Lua:GetAOERadius  Controls the size of the AOE casting cursor. ])
-- @return float
function C_DOTA_Ability_Lua:GetAOERadius(  ) end

---[[ C_DOTA_Ability_Lua:GetAbilityTextureName  Allows code overriding of the ability texture shown in the HUD. ])
-- @return string
function C_DOTA_Ability_Lua:GetAbilityTextureName(  ) end

---[[ C_DOTA_Ability_Lua:GetBehavior  Return cast behavior type of this ability. ])
-- @return uint64
function C_DOTA_Ability_Lua:GetBehavior(  ) end

---[[ C_DOTA_Ability_Lua:GetCastPoint  Return cast point of this ability. ])
-- @return float
function C_DOTA_Ability_Lua:GetCastPoint(  ) end

---[[ C_DOTA_Ability_Lua:GetCastRange  Return cast range of this ability. ])
-- @return int
-- @param vLocation Vector
-- @param hTarget handle
function C_DOTA_Ability_Lua:GetCastRange( vLocation, hTarget ) end

---[[ C_DOTA_Ability_Lua:GetCastRangeBonus   ])
-- @return int
-- @param hTarget handle
function C_DOTA_Ability_Lua:GetCastRangeBonus( hTarget ) end

---[[ C_DOTA_Ability_Lua:GetChannelTime  Return the channel time of this ability. ])
-- @return float
function C_DOTA_Ability_Lua:GetChannelTime(  ) end

---[[ C_DOTA_Ability_Lua:GetChannelledManaCostPerSecond  Return mana cost at the given level per second while channeling (-1 is current). ])
-- @return int
-- @param iLevel int
function C_DOTA_Ability_Lua:GetChannelledManaCostPerSecond( iLevel ) end

---[[ C_DOTA_Ability_Lua:GetCooldown  Return cooldown of this ability. ])
-- @return float
-- @param iLevel int
function C_DOTA_Ability_Lua:GetCooldown( iLevel ) end

---[[ C_DOTA_Ability_Lua:GetCustomCastError  Return the error string of a failed command with no target. ])
-- @return string
function C_DOTA_Ability_Lua:GetCustomCastError(  ) end

---[[ C_DOTA_Ability_Lua:GetCustomCastErrorLocation  (Vector vLocation) Return the error string of a failed command on a location. ])
-- @return string
-- @param vLocation Vector
function C_DOTA_Ability_Lua:GetCustomCastErrorLocation( vLocation ) end

---[[ C_DOTA_Ability_Lua:GetCustomCastErrorTarget  (HSCRIPT hTarget) Return the error string of a failed command on a target. ])
-- @return string
-- @param hTarget handle
function C_DOTA_Ability_Lua:GetCustomCastErrorTarget( hTarget ) end

---[[ C_DOTA_Ability_Lua:GetEffectiveCastRange  Return cast range of this ability, accounting for modifiers. ])
-- @return int
-- @param vLocation Vector
-- @param hTarget handle
function C_DOTA_Ability_Lua:GetEffectiveCastRange( vLocation, hTarget ) end

---[[ C_DOTA_Ability_Lua:GetGoldCost  Return gold cost at the given level (-1 is current). ])
-- @return int
-- @param iLevel int
function C_DOTA_Ability_Lua:GetGoldCost( iLevel ) end

---[[ C_DOTA_Ability_Lua:GetManaCost  Return mana cost at the given level (-1 is current). ])
-- @return int
-- @param iLevel int
function C_DOTA_Ability_Lua:GetManaCost( iLevel ) end

---[[ C_DOTA_Ability_Lua:IsHiddenAbilityCastable  Returns true if this ability can be used when not on the action panel. ])
-- @return bool
function C_DOTA_Ability_Lua:IsHiddenAbilityCastable(  ) end

---[[ C_DOTA_AghsFort_Ability_ArcWardenBoss_TempestDouble:SetNumDoubles  Sets the number of doubles to spawn. ])
-- @return void
-- @param nDoubles int
function C_DOTA_AghsFort_Ability_ArcWardenBoss_TempestDouble:SetNumDoubles( nDoubles ) end

---[[ C_DOTA_BaseNPC:FindAbilityByName  Retrieve an ability by name from the unit. ])
-- @return handle
-- @param pAbilityName string
function C_DOTA_BaseNPC:FindAbilityByName( pAbilityName ) end

---[[ C_DOTA_BaseNPC:GetAbilityCount   ])
-- @return int
function C_DOTA_BaseNPC:GetAbilityCount(  ) end

---[[ C_DOTA_BaseNPC:GetAttackSpeed   ])
-- @return float
function C_DOTA_BaseNPC:GetAttackSpeed(  ) end

---[[ C_DOTA_BaseNPC:GetAttacksPerSecond   ])
-- @return float
function C_DOTA_BaseNPC:GetAttacksPerSecond(  ) end

---[[ C_DOTA_BaseNPC:GetBaseAttackTime   ])
-- @return float
function C_DOTA_BaseNPC:GetBaseAttackTime(  ) end

---[[ C_DOTA_BaseNPC:GetBaseMagicalResistanceValue  Returns base magical armor value. ])
-- @return float
function C_DOTA_BaseNPC:GetBaseMagicalResistanceValue(  ) end

---[[ C_DOTA_BaseNPC:GetBaseMoveSpeed   ])
-- @return float
function C_DOTA_BaseNPC:GetBaseMoveSpeed(  ) end

---[[ C_DOTA_BaseNPC:GetCastRangeBonus   ])
-- @return float
function C_DOTA_BaseNPC:GetCastRangeBonus(  ) end

---[[ C_DOTA_BaseNPC:GetCollisionPadding  Returns the size of the collision padding around the hull. ])
-- @return float
function C_DOTA_BaseNPC:GetCollisionPadding(  ) end

---[[ C_DOTA_BaseNPC:GetCooldownReduction   ])
-- @return float
function C_DOTA_BaseNPC:GetCooldownReduction(  ) end

---[[ C_DOTA_BaseNPC:GetCurrentVisionRange  Gets the current vision range. ])
-- @return int
function C_DOTA_BaseNPC:GetCurrentVisionRange(  ) end

---[[ C_DOTA_BaseNPC:GetDamageMax   ])
-- @return int
function C_DOTA_BaseNPC:GetDamageMax(  ) end

---[[ C_DOTA_BaseNPC:GetDamageMin   ])
-- @return int
function C_DOTA_BaseNPC:GetDamageMin(  ) end

---[[ C_DOTA_BaseNPC:GetDayTimeVisionRange  Returns the vision range after modifiers. ])
-- @return int
function C_DOTA_BaseNPC:GetDayTimeVisionRange(  ) end

---[[ C_DOTA_BaseNPC:GetHasteFactor   ])
-- @return float
function C_DOTA_BaseNPC:GetHasteFactor(  ) end

---[[ C_DOTA_BaseNPC:GetHealthPercent  Get the current health percent of the unit. ])
-- @return int
function C_DOTA_BaseNPC:GetHealthPercent(  ) end

---[[ C_DOTA_BaseNPC:GetHullRadius  Get the collision hull radius of this NPC. ])
-- @return float
function C_DOTA_BaseNPC:GetHullRadius(  ) end

---[[ C_DOTA_BaseNPC:GetIdealSpeed  Returns speed after all modifiers. ])
-- @return float
function C_DOTA_BaseNPC:GetIdealSpeed(  ) end

---[[ C_DOTA_BaseNPC:GetIdealSpeedNoSlows  Returns speed after all modifiers, but excluding those that reduce speed. ])
-- @return float
function C_DOTA_BaseNPC:GetIdealSpeedNoSlows(  ) end

---[[ C_DOTA_BaseNPC:GetIncreasedAttackSpeed   ])
-- @return float
function C_DOTA_BaseNPC:GetIncreasedAttackSpeed(  ) end

---[[ C_DOTA_BaseNPC:GetLevel  Returns the level of this unit. ])
-- @return int
function C_DOTA_BaseNPC:GetLevel(  ) end

---[[ C_DOTA_BaseNPC:GetMagicalArmorValue  Returns current magical armor value. ])
-- @return float
function C_DOTA_BaseNPC:GetMagicalArmorValue(  ) end

---[[ C_DOTA_BaseNPC:GetMana  Get the mana on this unit. ])
-- @return float
function C_DOTA_BaseNPC:GetMana(  ) end

---[[ C_DOTA_BaseNPC:GetManaRegen   ])
-- @return float
function C_DOTA_BaseNPC:GetManaRegen(  ) end

---[[ C_DOTA_BaseNPC:GetMaxMana  Get the maximum mana of this unit. ])
-- @return float
function C_DOTA_BaseNPC:GetMaxMana(  ) end

---[[ C_DOTA_BaseNPC:GetModelRadius   ])
-- @return float
function C_DOTA_BaseNPC:GetModelRadius(  ) end

---[[ C_DOTA_BaseNPC:GetModifierStackCount  Gets the stack count of a given modifier. ])
-- @return int
-- @param pszScriptName string
-- @param hCaster handle
function C_DOTA_BaseNPC:GetModifierStackCount( pszScriptName, hCaster ) end

---[[ C_DOTA_BaseNPC:GetMoveSpeedModifier   ])
-- @return float
-- @param flBaseSpeed float
-- @param bReturnUnslowed bool
function C_DOTA_BaseNPC:GetMoveSpeedModifier( flBaseSpeed, bReturnUnslowed ) end

---[[ C_DOTA_BaseNPC:GetNightTimeVisionRange  Returns the vision range after modifiers. ])
-- @return int
function C_DOTA_BaseNPC:GetNightTimeVisionRange(  ) end

---[[ C_DOTA_BaseNPC:GetOpposingTeamNumber   ])
-- @return int
function C_DOTA_BaseNPC:GetOpposingTeamNumber(  ) end

---[[ C_DOTA_BaseNPC:GetPaddedCollisionRadius  Get the collision hull radius (including padding) of this NPC. ])
-- @return float
function C_DOTA_BaseNPC:GetPaddedCollisionRadius(  ) end

---[[ C_DOTA_BaseNPC:GetPhysicalArmorBaseValue  Returns base physical armor value. ])
-- @return float
function C_DOTA_BaseNPC:GetPhysicalArmorBaseValue(  ) end

---[[ C_DOTA_BaseNPC:GetPhysicalArmorValue  Returns current physical armor value. ])
-- @return float
-- @param bIgnoreBase bool
function C_DOTA_BaseNPC:GetPhysicalArmorValue( bIgnoreBase ) end

---[[ C_DOTA_BaseNPC:GetPlayerOwnerID  Get the owner player ID for this unit. ])
-- @return int
function C_DOTA_BaseNPC:GetPlayerOwnerID(  ) end

---[[ C_DOTA_BaseNPC:GetSecondsPerAttack   ])
-- @return float
function C_DOTA_BaseNPC:GetSecondsPerAttack(  ) end

---[[ C_DOTA_BaseNPC:GetTotalPurchasedUpgradeGoldCost  Get how much gold has been spent on ability upgrades. ])
-- @return int
function C_DOTA_BaseNPC:GetTotalPurchasedUpgradeGoldCost(  ) end

---[[ C_DOTA_BaseNPC:GetUnitLabel   ])
-- @return string
function C_DOTA_BaseNPC:GetUnitLabel(  ) end

---[[ C_DOTA_BaseNPC:GetUnitName  Get the name of this unit. ])
-- @return string
function C_DOTA_BaseNPC:GetUnitName(  ) end

---[[ C_DOTA_BaseNPC:HasAttackCapability   ])
-- @return bool
function C_DOTA_BaseNPC:HasAttackCapability(  ) end

---[[ C_DOTA_BaseNPC:HasFlyMovementCapability   ])
-- @return bool
function C_DOTA_BaseNPC:HasFlyMovementCapability(  ) end

---[[ C_DOTA_BaseNPC:HasFlyingVision   ])
-- @return bool
function C_DOTA_BaseNPC:HasFlyingVision(  ) end

---[[ C_DOTA_BaseNPC:HasGroundMovementCapability   ])
-- @return bool
function C_DOTA_BaseNPC:HasGroundMovementCapability(  ) end

---[[ C_DOTA_BaseNPC:HasItemInInventory  See whether this unit has an item by name. ])
-- @return bool
-- @param pItemName string
function C_DOTA_BaseNPC:HasItemInInventory( pItemName ) end

---[[ C_DOTA_BaseNPC:HasModifier  Sees if this unit has a given modifier. ])
-- @return bool
-- @param pszScriptName string
function C_DOTA_BaseNPC:HasModifier( pszScriptName ) end

---[[ C_DOTA_BaseNPC:HasMovementCapability   ])
-- @return bool
function C_DOTA_BaseNPC:HasMovementCapability(  ) end

---[[ C_DOTA_BaseNPC:HasScepter   ])
-- @return bool
function C_DOTA_BaseNPC:HasScepter(  ) end

---[[ C_DOTA_BaseNPC:IsAncient  Is this unit an Ancient? ])
-- @return bool
function C_DOTA_BaseNPC:IsAncient(  ) end

---[[ C_DOTA_BaseNPC:IsAttackImmune   ])
-- @return bool
function C_DOTA_BaseNPC:IsAttackImmune(  ) end

---[[ C_DOTA_BaseNPC:IsBarracks  Is this unit a Barracks? ])
-- @return bool
function C_DOTA_BaseNPC:IsBarracks(  ) end

---[[ C_DOTA_BaseNPC:IsBlind   ])
-- @return bool
function C_DOTA_BaseNPC:IsBlind(  ) end

---[[ C_DOTA_BaseNPC:IsBoss  Is this unit a boss? ])
-- @return bool
function C_DOTA_BaseNPC:IsBoss(  ) end

---[[ C_DOTA_BaseNPC:IsBuilding  Is this unit a building? ])
-- @return bool
function C_DOTA_BaseNPC:IsBuilding(  ) end

---[[ C_DOTA_BaseNPC:IsCommandRestricted   ])
-- @return bool
function C_DOTA_BaseNPC:IsCommandRestricted(  ) end

---[[ C_DOTA_BaseNPC:IsConsideredHero  Is this unit a considered a hero for targeting purposes? ])
-- @return bool
function C_DOTA_BaseNPC:IsConsideredHero(  ) end

---[[ C_DOTA_BaseNPC:IsControllableByAnyPlayer  Is this unit controlled by any non-bot player? ])
-- @return bool
function C_DOTA_BaseNPC:IsControllableByAnyPlayer(  ) end

---[[ C_DOTA_BaseNPC:IsCourier  Is this unit a courier? ])
-- @return bool
function C_DOTA_BaseNPC:IsCourier(  ) end

---[[ C_DOTA_BaseNPC:IsCreature  Is this a Creature type NPC? ])
-- @return bool
function C_DOTA_BaseNPC:IsCreature(  ) end

---[[ C_DOTA_BaseNPC:IsCreep  Is this unit a creep? ])
-- @return bool
function C_DOTA_BaseNPC:IsCreep(  ) end

---[[ C_DOTA_BaseNPC:IsCreepHero  Is this a creep hero? ])
-- @return bool
function C_DOTA_BaseNPC:IsCreepHero(  ) end

---[[ C_DOTA_BaseNPC:IsDisarmed   ])
-- @return bool
function C_DOTA_BaseNPC:IsDisarmed(  ) end

---[[ C_DOTA_BaseNPC:IsDominated   ])
-- @return bool
function C_DOTA_BaseNPC:IsDominated(  ) end

---[[ C_DOTA_BaseNPC:IsEvadeDisabled   ])
-- @return bool
function C_DOTA_BaseNPC:IsEvadeDisabled(  ) end

---[[ C_DOTA_BaseNPC:IsFort  Is this unit an Ancient? ])
-- @return bool
function C_DOTA_BaseNPC:IsFort(  ) end

---[[ C_DOTA_BaseNPC:IsFrozen   ])
-- @return bool
function C_DOTA_BaseNPC:IsFrozen(  ) end

---[[ C_DOTA_BaseNPC:IsHero  Is this a hero or hero illusion? ])
-- @return bool
function C_DOTA_BaseNPC:IsHero(  ) end

---[[ C_DOTA_BaseNPC:IsHexed   ])
-- @return bool
function C_DOTA_BaseNPC:IsHexed(  ) end

---[[ C_DOTA_BaseNPC:IsIllusion   ])
-- @return bool
function C_DOTA_BaseNPC:IsIllusion(  ) end

---[[ C_DOTA_BaseNPC:IsInventoryEnabled  Does this unit have an inventory. ])
-- @return bool
function C_DOTA_BaseNPC:IsInventoryEnabled(  ) end

---[[ C_DOTA_BaseNPC:IsInvisible   ])
-- @return bool
function C_DOTA_BaseNPC:IsInvisible(  ) end

---[[ C_DOTA_BaseNPC:IsInvulnerable   ])
-- @return bool
function C_DOTA_BaseNPC:IsInvulnerable(  ) end

---[[ C_DOTA_BaseNPC:IsLowAttackPriority   ])
-- @return bool
function C_DOTA_BaseNPC:IsLowAttackPriority(  ) end

---[[ C_DOTA_BaseNPC:IsMagicImmune   ])
-- @return bool
function C_DOTA_BaseNPC:IsMagicImmune(  ) end

---[[ C_DOTA_BaseNPC:IsMoving  Is this unit moving? ])
-- @return bool
function C_DOTA_BaseNPC:IsMoving(  ) end

---[[ C_DOTA_BaseNPC:IsMuted   ])
-- @return bool
function C_DOTA_BaseNPC:IsMuted(  ) end

---[[ C_DOTA_BaseNPC:IsNeutralUnitType  Is this a neutral? ])
-- @return bool
function C_DOTA_BaseNPC:IsNeutralUnitType(  ) end

---[[ C_DOTA_BaseNPC:IsNightmared   ])
-- @return bool
function C_DOTA_BaseNPC:IsNightmared(  ) end

---[[ C_DOTA_BaseNPC:IsOther  Is this unit a ward-type unit? ])
-- @return bool
function C_DOTA_BaseNPC:IsOther(  ) end

---[[ C_DOTA_BaseNPC:IsOutOfGame   ])
-- @return bool
function C_DOTA_BaseNPC:IsOutOfGame(  ) end

---[[ C_DOTA_BaseNPC:IsOwnedByAnyPlayer  Is this unit owned by any non-bot player? ])
-- @return bool
function C_DOTA_BaseNPC:IsOwnedByAnyPlayer(  ) end

---[[ C_DOTA_BaseNPC:IsPhantom  Is this a phantom unit? ])
-- @return bool
function C_DOTA_BaseNPC:IsPhantom(  ) end

---[[ C_DOTA_BaseNPC:IsRangedAttacker  Is this unit a ranged attacker? ])
-- @return bool
function C_DOTA_BaseNPC:IsRangedAttacker(  ) end

---[[ C_DOTA_BaseNPC:IsRealHero  Is this a real hero? ])
-- @return bool
function C_DOTA_BaseNPC:IsRealHero(  ) end

---[[ C_DOTA_BaseNPC:IsRooted   ])
-- @return bool
function C_DOTA_BaseNPC:IsRooted(  ) end

---[[ C_DOTA_BaseNPC:IsSilenced   ])
-- @return bool
function C_DOTA_BaseNPC:IsSilenced(  ) end

---[[ C_DOTA_BaseNPC:IsSpeciallyDeniable   ])
-- @return bool
function C_DOTA_BaseNPC:IsSpeciallyDeniable(  ) end

---[[ C_DOTA_BaseNPC:IsSpeciallyUndeniable   ])
-- @return bool
function C_DOTA_BaseNPC:IsSpeciallyUndeniable(  ) end

---[[ C_DOTA_BaseNPC:IsStunned   ])
-- @return bool
function C_DOTA_BaseNPC:IsStunned(  ) end

---[[ C_DOTA_BaseNPC:IsSummoned  Is this unit summoned? ])
-- @return bool
function C_DOTA_BaseNPC:IsSummoned(  ) end

---[[ C_DOTA_BaseNPC:IsTower  Is this a tower? ])
-- @return bool
function C_DOTA_BaseNPC:IsTower(  ) end

---[[ C_DOTA_BaseNPC:IsUnselectable   ])
-- @return bool
function C_DOTA_BaseNPC:IsUnselectable(  ) end

---[[ C_DOTA_BaseNPC:IsUntargetable   ])
-- @return bool
function C_DOTA_BaseNPC:IsUntargetable(  ) end

---[[ C_DOTA_BaseNPC:NoHealthBar   ])
-- @return bool
function C_DOTA_BaseNPC:NoHealthBar(  ) end

---[[ C_DOTA_BaseNPC:NoTeamMoveTo   ])
-- @return bool
function C_DOTA_BaseNPC:NoTeamMoveTo(  ) end

---[[ C_DOTA_BaseNPC:NoTeamSelect   ])
-- @return bool
function C_DOTA_BaseNPC:NoTeamSelect(  ) end

---[[ C_DOTA_BaseNPC:NoUnitCollision   ])
-- @return bool
function C_DOTA_BaseNPC:NoUnitCollision(  ) end

---[[ C_DOTA_BaseNPC:NotOnMinimap   ])
-- @return bool
function C_DOTA_BaseNPC:NotOnMinimap(  ) end

---[[ C_DOTA_BaseNPC:NotOnMinimapForEnemies   ])
-- @return bool
function C_DOTA_BaseNPC:NotOnMinimapForEnemies(  ) end

---[[ C_DOTA_BaseNPC:PassivesDisabled   ])
-- @return bool
function C_DOTA_BaseNPC:PassivesDisabled(  ) end

---[[ C_DOTA_BaseNPC:ProvidesVision   ])
-- @return bool
function C_DOTA_BaseNPC:ProvidesVision(  ) end

---[[ C_DOTA_BaseNPC:Script_GetAttackRange  Gets this unit's attack range after all modifiers. ])
-- @return float
function C_DOTA_BaseNPC:Script_GetAttackRange(  ) end

---[[ C_DOTA_BaseNPC:Script_IsDeniable   ])
-- @return bool
function C_DOTA_BaseNPC:Script_IsDeniable(  ) end

---[[ C_DOTA_BaseNPC:UnitCanRespawn  Can the unit respawn? ])
-- @return bool
function C_DOTA_BaseNPC:UnitCanRespawn(  ) end

---[[ C_DOTA_BaseNPC_Hero:GetAgility   ])
-- @return float
function C_DOTA_BaseNPC_Hero:GetAgility(  ) end

---[[ C_DOTA_BaseNPC_Hero:GetIntellect   ])
-- @return float
function C_DOTA_BaseNPC_Hero:GetIntellect(  ) end

---[[ C_DOTA_BaseNPC_Hero:GetStrength   ])
-- @return float
function C_DOTA_BaseNPC_Hero:GetStrength(  ) end

---[[ C_DOTA_Item:CanOnlyPlayerHeroPickup   ])
-- @return bool
function C_DOTA_Item:CanOnlyPlayerHeroPickup(  ) end

---[[ C_DOTA_Item:GetCurrentCharges   ])
-- @return int
function C_DOTA_Item:GetCurrentCharges(  ) end

---[[ C_DOTA_Item:GetInitialCharges   ])
-- @return int
function C_DOTA_Item:GetInitialCharges(  ) end

---[[ C_DOTA_Item:GetItemSlot   ])
-- @return int
function C_DOTA_Item:GetItemSlot(  ) end

---[[ C_DOTA_Item:GetSecondaryCharges   ])
-- @return int
function C_DOTA_Item:GetSecondaryCharges(  ) end

---[[ C_DOTA_Item:GetShareability   ])
-- @return int
function C_DOTA_Item:GetShareability(  ) end

---[[ C_DOTA_Item:IsAlertableItem   ])
-- @return bool
function C_DOTA_Item:IsAlertableItem(  ) end

---[[ C_DOTA_Item:IsCastOnPickup   ])
-- @return bool
function C_DOTA_Item:IsCastOnPickup(  ) end

---[[ C_DOTA_Item:IsDisassemblable   ])
-- @return bool
function C_DOTA_Item:IsDisassemblable(  ) end

---[[ C_DOTA_Item:IsDroppable   ])
-- @return bool
function C_DOTA_Item:IsDroppable(  ) end

---[[ C_DOTA_Item:IsInBackpack   ])
-- @return bool
function C_DOTA_Item:IsInBackpack(  ) end

---[[ C_DOTA_Item:IsItem   ])
-- @return bool
function C_DOTA_Item:IsItem(  ) end

---[[ C_DOTA_Item:IsKillable   ])
-- @return bool
function C_DOTA_Item:IsKillable(  ) end

---[[ C_DOTA_Item:IsMuted   ])
-- @return bool
function C_DOTA_Item:IsMuted(  ) end

---[[ C_DOTA_Item:IsPermanent   ])
-- @return bool
function C_DOTA_Item:IsPermanent(  ) end

---[[ C_DOTA_Item:IsPurchasable   ])
-- @return bool
function C_DOTA_Item:IsPurchasable(  ) end

---[[ C_DOTA_Item:IsRecipe   ])
-- @return bool
function C_DOTA_Item:IsRecipe(  ) end

---[[ C_DOTA_Item:IsRecipeGenerated   ])
-- @return bool
function C_DOTA_Item:IsRecipeGenerated(  ) end

---[[ C_DOTA_Item:IsSellable   ])
-- @return bool
function C_DOTA_Item:IsSellable(  ) end

---[[ C_DOTA_Item:IsStackable   ])
-- @return bool
function C_DOTA_Item:IsStackable(  ) end

---[[ C_DOTA_Item:RequiresCharges   ])
-- @return bool
function C_DOTA_Item:RequiresCharges(  ) end

---[[ C_DOTA_Item_Lua:CastFilterResult  Determine whether an issued command with no target is valid. ])
-- @return int
function C_DOTA_Item_Lua:CastFilterResult(  ) end

---[[ C_DOTA_Item_Lua:CastFilterResultLocation  (Vector vLocation) Determine whether an issued command on a location is valid. ])
-- @return int
-- @param vLocation Vector
function C_DOTA_Item_Lua:CastFilterResultLocation( vLocation ) end

---[[ C_DOTA_Item_Lua:CastFilterResultTarget  (HSCRIPT hTarget) Determine whether an issued command on a target is valid. ])
-- @return int
-- @param hTarget handle
function C_DOTA_Item_Lua:CastFilterResultTarget( hTarget ) end

---[[ C_DOTA_Item_Lua:GetAOERadius  Controls the size of the AOE casting cursor. ])
-- @return float
function C_DOTA_Item_Lua:GetAOERadius(  ) end

---[[ C_DOTA_Item_Lua:GetAbilityTextureName  Allows code overriding of the item texture shown in the HUD. ])
-- @return string
function C_DOTA_Item_Lua:GetAbilityTextureName(  ) end

---[[ C_DOTA_Item_Lua:GetBehavior  Return cast behavior type of this ability. ])
-- @return int
function C_DOTA_Item_Lua:GetBehavior(  ) end

---[[ C_DOTA_Item_Lua:GetCastRange  Return cast range of this ability. ])
-- @return int
-- @param vLocation Vector
-- @param hTarget handle
function C_DOTA_Item_Lua:GetCastRange( vLocation, hTarget ) end

---[[ C_DOTA_Item_Lua:GetChannelTime  Return the channel time of this ability. ])
-- @return float
function C_DOTA_Item_Lua:GetChannelTime(  ) end

---[[ C_DOTA_Item_Lua:GetChannelledManaCostPerSecond  Return mana cost at the given level per second while channeling (-1 is current). ])
-- @return int
-- @param iLevel int
function C_DOTA_Item_Lua:GetChannelledManaCostPerSecond( iLevel ) end

---[[ C_DOTA_Item_Lua:GetCooldown  Return cooldown of this ability. ])
-- @return float
-- @param iLevel int
function C_DOTA_Item_Lua:GetCooldown( iLevel ) end

---[[ C_DOTA_Item_Lua:GetCustomCastError  Return the error string of a failed command with no target. ])
-- @return string
function C_DOTA_Item_Lua:GetCustomCastError(  ) end

---[[ C_DOTA_Item_Lua:GetCustomCastErrorLocation  (Vector vLocation) Return the error string of a failed command on a location. ])
-- @return string
-- @param vLocation Vector
function C_DOTA_Item_Lua:GetCustomCastErrorLocation( vLocation ) end

---[[ C_DOTA_Item_Lua:GetCustomCastErrorTarget  (HSCRIPT hTarget) Return the error string of a failed command on a target. ])
-- @return string
-- @param hTarget handle
function C_DOTA_Item_Lua:GetCustomCastErrorTarget( hTarget ) end

---[[ C_DOTA_Item_Lua:GetEffectiveCastRange  Return cast range of this ability, taking modifiers into account. ])
-- @return int
-- @param vLocation Vector
-- @param hTarget handle
function C_DOTA_Item_Lua:GetEffectiveCastRange( vLocation, hTarget ) end

---[[ C_DOTA_Item_Lua:GetGoldCost  Return gold cost at the given level (-1 is current). ])
-- @return int
-- @param iLevel int
function C_DOTA_Item_Lua:GetGoldCost( iLevel ) end

---[[ C_DOTA_Item_Lua:GetManaCost  Return mana cost at the given level (-1 is current). ])
-- @return int
-- @param iLevel int
function C_DOTA_Item_Lua:GetManaCost( iLevel ) end

---[[ C_DOTA_Item_Lua:IsMuted  Returns whether this item is muted or not. ])
-- @return bool
function C_DOTA_Item_Lua:IsMuted(  ) end

---[[ C_DOTA_Modifier_Lua:AllowIllusionDuplicate  True/false if this modifier is active on illusions. ])
-- @return bool
function C_DOTA_Modifier_Lua:AllowIllusionDuplicate(  ) end

---[[ C_DOTA_Modifier_Lua:CanParentBeAutoAttacked   ])
-- @return bool
function C_DOTA_Modifier_Lua:CanParentBeAutoAttacked(  ) end

---[[ C_DOTA_Modifier_Lua:DestroyOnExpire  True/false if this buff is removed when the duration expires. ])
-- @return bool
function C_DOTA_Modifier_Lua:DestroyOnExpire(  ) end

---[[ C_DOTA_Modifier_Lua:GetAttributes  Return the types of attributes applied to this modifier (enum value from DOTAModifierAttribute_t ])
-- @return int
function C_DOTA_Modifier_Lua:GetAttributes(  ) end

---[[ C_DOTA_Modifier_Lua:GetAuraDuration  Returns aura stickiness ])
-- @return float
function C_DOTA_Modifier_Lua:GetAuraDuration(  ) end

---[[ C_DOTA_Modifier_Lua:GetAuraEntityReject  Return true/false if this entity should receive the aura under specific conditions ])
-- @return bool
-- @param hEntity handle
function C_DOTA_Modifier_Lua:GetAuraEntityReject( hEntity ) end

---[[ C_DOTA_Modifier_Lua:GetAuraRadius  Return the range around the parent this aura tries to apply its buff. ])
-- @return int
function C_DOTA_Modifier_Lua:GetAuraRadius(  ) end

---[[ C_DOTA_Modifier_Lua:GetAuraSearchFlags  Return the unit flags this aura respects when placing buffs. ])
-- @return int
function C_DOTA_Modifier_Lua:GetAuraSearchFlags(  ) end

---[[ C_DOTA_Modifier_Lua:GetAuraSearchTeam  Return the teams this aura applies its buff to. ])
-- @return int
function C_DOTA_Modifier_Lua:GetAuraSearchTeam(  ) end

---[[ C_DOTA_Modifier_Lua:GetAuraSearchType  Return the unit classifications this aura applies its buff to. ])
-- @return int
function C_DOTA_Modifier_Lua:GetAuraSearchType(  ) end

---[[ C_DOTA_Modifier_Lua:GetCritDamage  A Modifier that listens to MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE has to have a GetCritDamage implementation so we can know when to evaluate it. Value should be in 'times the original value format' e.g: 1.5 not 150 ])
-- @return float
function C_DOTA_Modifier_Lua:GetCritDamage(  ) end

---[[ C_DOTA_Modifier_Lua:GetEffectAttachType  Return the attach type of the particle system from GetEffectName. ])
-- @return int
function C_DOTA_Modifier_Lua:GetEffectAttachType(  ) end

---[[ C_DOTA_Modifier_Lua:GetEffectName  Return the name of the particle system that is created while this modifier is active. ])
-- @return string
function C_DOTA_Modifier_Lua:GetEffectName(  ) end

---[[ C_DOTA_Modifier_Lua:GetHeroEffectName  Return the name of the hero effect particle system that is created while this modifier is active. ])
-- @return string
function C_DOTA_Modifier_Lua:GetHeroEffectName(  ) end

---[[ C_DOTA_Modifier_Lua:GetModifierAura  The name of the secondary modifier that will be applied by this modifier (if it is an aura). ])
-- @return string
function C_DOTA_Modifier_Lua:GetModifierAura(  ) end

---[[ C_DOTA_Modifier_Lua:GetPriority  Return the priority order this modifier will be applied over others. ])
-- @return int
function C_DOTA_Modifier_Lua:GetPriority(  ) end

---[[ C_DOTA_Modifier_Lua:GetStatusEffectName  Return the name of the status effect particle system that is created while this modifier is active. ])
-- @return string
function C_DOTA_Modifier_Lua:GetStatusEffectName(  ) end

---[[ C_DOTA_Modifier_Lua:GetTexture  Return the name of the buff icon to be shown for this modifier. ])
-- @return string
function C_DOTA_Modifier_Lua:GetTexture(  ) end

---[[ C_DOTA_Modifier_Lua:HeroEffectPriority  Relationship of this hero effect with those from other buffs (higher is more likely to be shown). ])
-- @return int
function C_DOTA_Modifier_Lua:HeroEffectPriority(  ) end

---[[ C_DOTA_Modifier_Lua:IsAura  True/false if this modifier is an aura. ])
-- @return bool
function C_DOTA_Modifier_Lua:IsAura(  ) end

---[[ C_DOTA_Modifier_Lua:IsAuraActiveOnDeath  True/false if this aura provides buffs when the parent is dead. ])
-- @return bool
function C_DOTA_Modifier_Lua:IsAuraActiveOnDeath(  ) end

---[[ C_DOTA_Modifier_Lua:IsDebuff  True/false if this modifier should be displayed as a debuff. ])
-- @return bool
function C_DOTA_Modifier_Lua:IsDebuff(  ) end

---[[ C_DOTA_Modifier_Lua:IsHidden  True/false if this modifier should be displayed on the buff bar. ])
-- @return bool
function C_DOTA_Modifier_Lua:IsHidden(  ) end

---[[ C_DOTA_Modifier_Lua:IsPermanent   ])
-- @return bool
function C_DOTA_Modifier_Lua:IsPermanent(  ) end

---[[ C_DOTA_Modifier_Lua:IsPurgable  True/false if this modifier can be purged. ])
-- @return bool
function C_DOTA_Modifier_Lua:IsPurgable(  ) end

---[[ C_DOTA_Modifier_Lua:IsPurgeException  True/false if this modifier can be purged by strong dispels. ])
-- @return bool
function C_DOTA_Modifier_Lua:IsPurgeException(  ) end

---[[ C_DOTA_Modifier_Lua:IsStunDebuff  True/false if this modifier is considered a stun for purge reasons. ])
-- @return bool
function C_DOTA_Modifier_Lua:IsStunDebuff(  ) end

---[[ C_DOTA_Modifier_Lua:OnCreated  Runs when the modifier is created. ])
-- @return void
-- @param table handle
function C_DOTA_Modifier_Lua:OnCreated( table ) end

---[[ C_DOTA_Modifier_Lua:OnDestroy  Runs when the modifier is destroyed (after unit loses modifier). ])
-- @return void
function C_DOTA_Modifier_Lua:OnDestroy(  ) end

---[[ C_DOTA_Modifier_Lua:OnIntervalThink  Runs when the think interval occurs. ])
-- @return void
function C_DOTA_Modifier_Lua:OnIntervalThink(  ) end

---[[ C_DOTA_Modifier_Lua:OnRefresh  Runs when the modifier is refreshed. ])
-- @return void
-- @param table handle
function C_DOTA_Modifier_Lua:OnRefresh( table ) end

---[[ C_DOTA_Modifier_Lua:OnRemoved  Runs when the modifier is destroyed (before unit loses modifier). ])
-- @return void
function C_DOTA_Modifier_Lua:OnRemoved(  ) end

---[[ C_DOTA_Modifier_Lua:OnStackCountChanged  Runs when stack count changes (param is old count). ])
-- @return void
-- @param iStackCount int
function C_DOTA_Modifier_Lua:OnStackCountChanged( iStackCount ) end

---[[ C_DOTA_Modifier_Lua:RemoveOnDeath  True/false if this modifier is removed when the parent dies. ])
-- @return bool
function C_DOTA_Modifier_Lua:RemoveOnDeath(  ) end

---[[ C_DOTA_Modifier_Lua:SetHasCustomTransmitterData   ])
-- @return void
-- @param bHasCustomData bool
function C_DOTA_Modifier_Lua:SetHasCustomTransmitterData( bHasCustomData ) end

---[[ C_DOTA_Modifier_Lua:ShouldUseOverheadOffset  Apply the overhead offset to the attached effect. ])
-- @return bool
function C_DOTA_Modifier_Lua:ShouldUseOverheadOffset(  ) end

---[[ C_DOTA_Modifier_Lua:StatusEffectPriority  Relationship of this status effect with those from other buffs (higher is more likely to be shown). ])
-- @return int
function C_DOTA_Modifier_Lua:StatusEffectPriority(  ) end

---[[ C_PointWorldText:SetMessage  Set the message on this entity. ])
-- @return void
-- @param pMessage string
function C_PointWorldText:SetMessage( pMessage ) end

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
]]