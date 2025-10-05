// Collect lightweight environment signals
private _u = player;

private _speed = speed _u;
private _stance = stance _u;
private _surface = surfaceType (getPosATL _u);
private _timeLight = sunOrMoon;
private _fog = fog;
private _overcast = overcast;
private _rain = rain;

// Enhanced cover detection with multiple object types and distance weighting
private _pos = getPosATL _u;  // Ground level for terrain object detection
private _eyePos = eyePos _u;  // Eye level for occlusion checks

// Immediate cover (5m radius) - bushes and small trees (best natural camouflage)
private _immediateObjects = nearestTerrainObjects [_pos, ["BUSH","TREE","SMALL TREE"], 5, true];
private _immediateCover = (count _immediateObjects) min 8;
_immediateCover = _immediateCover / 8; // normalize 0..1

// Medium cover (8m radius) - trees and small trees
private _mediumObjects = nearestTerrainObjects [_pos, ["TREE","SMALL TREE"], 8, true];
private _mediumCover = (count _mediumObjects) min 12;
_mediumCover = _mediumCover / 12; // normalize 0..1

// Forest/Jungle density - larger area check for overall environment
private _forestObjects = nearestTerrainObjects [_pos, ["TREE","SMALL TREE"], 25, true];
private _forestDensity = ((count _forestObjects) min 30) / 30; // normalize 0..1 for dense forest

// Distance-weighted cover calculation (immediate vicinity gets more weight)
private _density = 0;
{
	private _d = _u distance _x;
	private _w = linearConversion [0,5,_d,1,0,true]; // 5m max for immediate cover
	_density = _density + _w;
} forEach _immediateObjects;
_density = (_density / 8) min 1; // normalize based on max immediate objects

private _dirs = [[1,0,0],[0,1,0],[-1,0,0],[0,-1,0],[0.7,0.7,0],[0.7,-0.7,0],[-0.7,0.7,0],[-0.7,-0.7,0]];
private _ocHits = 0;
{
	private _to = ASLToATL (_eyePos vectorAdd [(_x select 0)*3, (_x select 1)*3, -0.2]);
	private _res = lineIntersectsSurfaces [_eyePos, ATLToASL _to, _u, objNull, true, 1, "VIEW", "FIRE"];
	if ((count _res) > 0) then { _ocHits = _ocHits + 1; };
} forEach _dirs;
private _occlusion = _ocHits / (count _dirs);
private _denseBush = _density max _occlusion;

// Movement category - based on actual Arma 3 speeds
private _moveCat = 0; // 0 still, 1 walk, 2 jog, 3 sprint
if (_speed > 3) then { _moveCat = 1; };      // Walking: ~5.5 km/h
if (_speed > 10) then { _moveCat = 2; };     // Jogging: ~14.5 km/h  
if (_speed > 15) then { _moveCat = 3; };     // Sprinting: ~18.5 km/h

[_stance, _moveCat, _surface, _timeLight, _fog, _overcast, _rain, _immediateCover, _mediumCover, _denseBush, _forestDensity]

