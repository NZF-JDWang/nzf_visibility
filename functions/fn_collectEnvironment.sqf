// Collect lightweight environment signals
private _u = player;

private _speed = speed _u;
private _stance = stance _u;
private _surface = surfaceType (getPosATL _u);
private _timeLight = sunOrMoon;
private _fog = fog;
private _overcast = overcast;
private _rain = rain;

// Cover density via nearby vegetation/rocks within small radius
private _pos = eyePos _u;
private _near = nearestTerrainObjects [_pos, ["BUSH","TREE","SMALL TREE"], 8, true];
private _cover = (count _near) min 12; // cap count
_cover = _cover / 12; // normalize 0..1


// Dense bush metric
private _density = 0;
{
	private _d = _u distance _x;
	private _w = linearConversion [0,8,_d,1,0,true];
	_density = _density + _w;
} forEach _near;
_density = (_density / 10) min 1;

private _dirs = [[1,0,0],[0,1,0],[-1,0,0],[0,-1,0],[0.7,0.7,0],[0.7,-0.7,0],[-0.7,0.7,0],[-0.7,-0.7,0]];
private _ocHits = 0;
{
	private _to = ASLToATL (_pos vectorAdd [(_x select 0)*3, (_x select 1)*3, -0.2]);
	private _res = lineIntersectsSurfaces [_pos, ATLToASL _to, _u, objNull, true, 1, "VIEW", "FIRE"];
	if ((count _res) > 0) then { _ocHits = _ocHits + 1; };
} forEach _dirs;
private _occlusion = _ocHits / (count _dirs);
private _denseBush = _density max _occlusion;

// Movement category
private _moveCat = 0; // 0 still, 1 walk, 2 run, 3 sprint
if (_speed > 1.5) then { _moveCat = 1; };
if (_speed > 6) then { _moveCat = 2; };
if (_speed > 8.5) then { _moveCat = 3; };

[_stance, _moveCat, _surface, _timeLight, _fog, _overcast, _rain, _cover, _denseBush]

