
/*
I want the pilots themselves to announce fuel situations
I want the controllers to announce arrivals in their airspace
I need to add fuel trucks to the places
I need to disable AI on fuel trucks until it is needed - to prevent them from running out and getting in the way of AI planes
*/

// Change the markers so they only fly to and from airports
// and they always land
// but they don't always refuel

// Fix the player issue
// fix the cycle issue
// make auto spawn
// ISSUE: How do I clear the landing flag? Or work around it?
//  I use it so they don't get land applied to them over and over again
//  But it will currently prevent them from landing a second time if it's not cleared

//Requirements:

// 1 or more 'Waypoint' markers
// These are markers named 'driver_waypoint_{x}' where {x} is a number from 0 to whatever
// These are the randomly selected destinations that drivers will go to

// 1 or more 'Driver Spawn' markers
// Named 'driver_spawn_air_{x}'
// Drivers will spawn here. Note: these can be flat on the ground in 2D / Map view beacuse the
// height is set through code

// Triggers that activate over an airport
// 

//====================================================
// These need to change depending on your map.
//====================================================

dingus_fnc_getDriverMarkers = {
  //populate the markers array dynamically
  _midx = 0;
  _mmax = 11;      // <--- Update to use the total number of blank markers for drivers
  _markers = [];

  while {_midx <= _mmax} do {
    _markerName = (format ['driver_waypoint_%1', _midx]);
    _pos = markerPos _markerName;
    _pos3D = [];
    _pos3D set [0, _pos select 0];
    _pos3D set [1, _pos select 1];
    _pos3D set [2, (floor random 200) + 200];
    _markerName setMarkerPos _pos3D;
    _markers pushBack _markerName;
    _midx = _midx + 1;
  };

  _markers;
};

dingus_fnc_getAirportMarkers = {
  _markers = ["m_airport_aacairfield", "m_airport_almyra", "m_airport_abdera", "m_airport_molos", "m_airport_pyrgos", "m_airport_selakano"];
  _markers;
};

dingus_fnc_getDriverSpawnMarkers = {
  //populate the markers array dynamically
  _midx = 0;
  _mmax = 8;      // <--- Update to use the total number of blank markers for drivers
  _markers = [];

  while {_midx <= _mmax} do {
    _markers pushBack (format ['driver_spawn_air_%1', _midx]);
    _midx = _midx + 1;
  };

  _markers;
};


//====================================================
// Main AI spawn and waypoint / trigger Functions
//====================================================

// This is the main function that spawns drivers using markers as starting points
// ex: [] spawn {[] call dingus_fnc_spawnAI};
dingus_fnc_spawnAI = {
  _models = ["C_Man_casual_1_F_tanoan", "C_man_sport_1_F_afro", "C_Man_casual_1_F_asia", "C_man_1"];
  _vehicles = ["C_Plane_Civil_01_F"];

  //Randomly generated drivers
  _markers = [] call dingus_fnc_getAirportMarkers; //dingus_fnc_getDriverMarkers;
  _spawnMarkers = [] call dingus_fnc_getDriverSpawnMarkers;
  _maxDrivers = 8;   //<--- MAX DRIVERS per Call
  _driverIdx = 0;
  _markerIdx = 0;

  while { ((_driverIdx < _maxDrivers) && (_markerIdx < count _markers)) } do {
    //Create a vehicle, group and leader
    //_startingMarker = _markers select floor random count _spawnMarkers;
    //_startingMarker = (_spawnMarkers select _markerIdx);

    _group = createGroup [civilian, true];
    _group setFormation "LINE";
    _group setBehaviour "SAFE";

    //This version lets createVehicle pick which location to use...and supports Z axis locations
    _vehicle = createVehicle [(_vehicles select floor random count _vehicles), [0, 0, 0], _spawnMarkers, 0, "FLY"];
    //_vehicle allowDamage false;

    _leader = _group createUnit [_models select floor random count _models, (getPos _vehicle), [], 2, "NONE"];
    _leader assignAsDriver _vehicle;
    _leader moveInDriver _vehicle;
    _grp = group _leader;
    _grp setGroupId [format ["Caesar N1%1J", floor random 999]];
    
    _vehicle flyInHeight ((floor random 200) + 150);
    
    [_leader] call dingus_fnc_addDriverWaypoints;
    
    _driverIdx = (_driverIdx + 1);
    _markerIdx = (_markerIdx + 1);
    
    //Need to wait a few seconds in case you end up spawning two planes at the same marker
    sleep 15;
  };

  systemChat format ["Spawned %1 fresh drivers for ya.", _driverIdx];
};

dingus_fnc_getDriverMarkers = {
  //populate the markers array dynamically
  _midx = 0;
  _mmax = 11;      // <--- Update to use the total number of blank markers for drivers
  _markers = [];

  while {_midx <= _mmax} do {
    _markerName = (format ['driver_waypoint_%1', _midx]);
    _pos = markerPos _markerName;
    _pos3D = [];
    _pos3D set [0, _pos select 0];
    _pos3D set [1, _pos select 1];
    _pos3D set [2, (floor random 200) + 200];
    _markerName setMarkerPos _pos3D;
    _markers pushBack _markerName;
    _midx = _midx + 1;
  };

  _markers;
};


dingus_fnc_getDriverSpawnMarkers = {
  //populate the markers array dynamically
  _midx = 0;
  _mmax = 8;      // <--- Update to use the total number of blank markers for drivers
  _markers = [];

  while {_midx <= _mmax} do {
    _markers pushBack (format ['driver_spawn_air_%1', _midx]);
    _midx = _midx + 1;
  };

  _markers;
};

dingus_fnc_addDriverWaypoints = {
  params ["_unit"];

  _markers = [] call dingus_fnc_getAirportMarkers;

  //systemChat format ['creating waypoints for: %1', _unit];

  _count = 2; //Number of waypoints to use before cycling
  _idx = 0;

  //Capture their starting position
  _startingPos = (getPosATL _unit);

  while { _idx < _count } do {
    //Get a random marker
    _marker = _markers select floor random count _markers;

    //systemChat format ['marker pos: %1', markerPos _marker];

    //Add the waypoint
    _wp = (group _unit) addWaypoint [getMarkerPos _marker, _idx];
    _wp setWaypointSpeed "FULL";
    _idx = _idx + 1;
  };

  //Add a cycle waypoint? It works but the statement never fires as far as I can see
  _wpc = (group _unit) addWaypoint [_startingPos, _idx];
  _wpc setWaypointType "CYCLE";
  _wpc setWaypointStatements ["true", "hint 'hello i just cycled';"];
};

//Trigger, repeatable, 3D over the airport but about 100m above the ground, activation anyone
//[thisList, "AAC"] call dingus_fnc_OverAirportTriggerActivated;
dingus_fnc_OverAirportTriggerActivated = {
  params ["_units", "_code"];

  //systemChat format ['over %2 with %1', count _units, _code];

  {
    if (!isPlayer _x) then {
      _height = ((getPosATL (vehicle _x)) select 2);
      _fuel = (fuel vehicle _x);
      _landing = (_x getVariable ["Landing", "0"]);
      _direction = getDir _x;
      
      if (_fuel < 0.1) then {
        _x setVariable ["Landing", "0"];
        (vehicle _x) setFuel 1;
      };

      //TODO: Get the controller at this place and have him announce this
      systemChat format ['%3 entering %4 airspace. %1m, Hdng: %5, Fuel: %2/100.', floor _height, floor (_fuel * 100), group _x, _code, floor _direction];

      if (_height > 50 && _landing == "0") then {
        (vehicle _x) land "LAND";
        _x setVariable ["Landing", "1"];
        
        //Hack! auto-refuel in some cases
        if (_fuel < 0.5) then {
          (vehicle _x) setFuel 1;
          (vehicle _x) setDamage 0;
        };

        systemChat format ["%1 landing at %2", group _x, _code];
      } else {
        if (_landing == "1" && _height < 180) then {
          _x setVariable ["Landing", "0"];
          systemChat format ["%1 appears to have taken off from %2", group _x, _code];
        } else {
          if (_landing == "0") then {

          }
        }
      };
    };

  } forEach _units;
}
