titleText ["Please wait...", "BLACK OUT", 0];

_handle = execVM "common.sqf"; 
waitUntil { scriptDone _handle };

["HelpersVisible", "0"] call dingus_fnc_setVar;
["MarkersVisible", "1"] call dingus_fnc_setVar;
["TaskLocations", "1"] call dingus_fnc_setVar;

["Boarding", "0"] call dingus_fnc_setVar;
["Boarded", "0"] call dingus_fnc_setVar;
["Transporting", "0"] call dingus_fnc_setVar;
["Arrived", "0"] call dingus_fnc_setVar;

//This is important to keep for now
["CurrentAirport", "aacairfield"] call dingus_fnc_setVar;

["DestinationAirport", ""] call dingus_fnc_setVar;

//Default vehicle
["CurrentPlane", plane1] call dingus_fnc_setVar;

["CurrentPassenger", nil] call dingus_fnc_setVar;
["CurrentCompanion", nil] call dingus_fnc_setVar;

execVM "ai.sqf";
execVM "atis.sqf";
execVM "passengers.sqf";
execVM "planeHelpers.sqf";

titleFadeOut 6;
