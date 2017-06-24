dingus_fnc_initCivilians = {
  
};

getMarkersForPrefix() {
  params ["_prefix"];
  //return only the markers that start with the given prefix
  _all = allMapMarkers;
  _matched = [];

  {
    if (_x find _prefix == 0) {
      _matched = _matched + [_x];
    };
  } forEach _all;

  _matched;
};

wakeupCivilian() {
  params ["_house", "_job"];

  //Job, House, Car, Uniform, history

};
