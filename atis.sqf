/*

//Didn't actually need to do this
Set sample format to 16 bit PCM
Export to MP3 with Constant bit rate, at 128 or less (maybe higher is OK too)

//This worked

So:
Record the whole thing. Export to MP3 master
Trying the two chains - export to MP3_56 then export to ogg


*/
//[] spawn {[] call dingus_fnc_speechTest;};
dingus_fnc_speechTest = {
  playSound "AtisVO_this_is";
  sleep 0.5;

  playSound "AtisVO_tanoa";
  sleep 0.5;

  playSound "AtisVO_information";
  sleep 0.5;

  playSound "AtisVO_echo";
  sleep 0.5;

  playSound "AtisVO_main_landing_runway";
  sleep 1.5;

  playSound "AtisVO_zero";
  sleep 0.5;

  playSound "AtisVO_four";
  sleep 0.5;

  sleep 0.2;

  playSound "AtisVO_wind";
  sleep 0.5;

  playSound "AtisVO_two";
  sleep 0.4;

  playSound "AtisVO_zero";
  sleep 0.4;

  playSound "AtisVO_degrees";
  sleep 0.5;

  sleep 0.2;

  playSound "AtisVO_zero";
  sleep 0.4;

  playSound "AtisVO_three";
  sleep 0.4;

  playSound "AtisVO_knots";
  sleep 0.5;

  systemChat 'done';
};

//[] spawn {["altis", [0, 4], "bravo"] call dingus_fnc_DyanmicATIS};
//[] spawn {["molos", [2, 6], "delta"] call dingus_fnc_DyanmicATIS};
dingus_fnc_DyanmicATIS = {
  params ["_airport", "_runway", "_version"];

  // here's the template we want to use...
  //This is [airport] arrival information [version].
  [] call dingus_fnc_atis_say_this_is;
  [_airport] call dingus_fnc_atis_SayAirport;
  [] call dingus_fnc_atis_say_arrival;
  [] call dingus_fnc_atis_say_information;
  [_version] call dingus_fnc_atis_SayPhoenetic;

  sleep 0.5;
  // Main landing runway [runway].
  [] call dingus_fnc_atis_say_main_landing_runway;

  [_runway] call dingus_fnc_atis_SayRunway;
  [] call dingus_fnc_atis_say_four;

  sleep 0.5;

  // Winds: Zero-Zero degrees, Zero-One knots.
  [] call dingus_fnc_atis_say_winds;

  [] call dingus_fnc_atis_SayWinds;

  sleep 0.5;

  // Visibility: Zero One.
  [] call dingus_fnc_atis_say_visibility;
  [] call dingus_fnc_atis_say_zero;
  [] call dingus_fnc_atis_say_eight;
  [] call dingus_fnc_atis_say_kilometers;
  
  sleep 0.5;

  // Clouds: Scattered: Five Five Zero meters. Broken: Eight Zero Zero meters.
  ["conditions"] call dingus_fnc_atis_SayPhoenetic;
  [] call dingus_fnc_atis_say_scattered;
  [] call dingus_fnc_atis_say_eight;
  [] call dingus_fnc_atis_say_zero;
  [] call dingus_fnc_atis_say_zero;
  [] call dingus_fnc_atis_say_meters;

  sleep 0.2;

  [] call dingus_fnc_atis_say_broken;
  [] call dingus_fnc_atis_say_niner;
  [] call dingus_fnc_atis_say_zero;
  [] call dingus_fnc_atis_say_zero;
  [] call dingus_fnc_atis_say_meters;

  // Forecast: No significant change / Rain Expected / Winds expected
  //[] call dingus_fnc_atis_say_no;
  //[] call dingus_fnc_atis_say_;


  // Comms Rules: Contact Approach and Arrival callsign only.


  sleep 0.5;

  // End of information [version].
  [] call dingus_fnc_atis_say_end;
  [] call dingus_fnc_atis_say_of;
  [] call dingus_fnc_atis_say_information;
  [_version] call dingus_fnc_atis_SayPhoenetic;
};

dingus_fnc_atis_SayRunway = {
  params ["_runway"];

  { [_x] call dingus_fnc_atis_say_singleDigit } forEach _runway;
};

dingus_fnc_atis_say_singleDigit = {
  params ["_digit"];

  switch (_digit) do {
    case 0: { [] call dingus_fnc_atis_say_zero; };
    case 1: { [] call dingus_fnc_atis_say_one; };
    case 2: { [] call dingus_fnc_atis_say_two; };
    case 3: { [] call dingus_fnc_atis_say_three; };
    case 4: { [] call dingus_fnc_atis_say_four; };
    case 5: { [] call dingus_fnc_atis_say_five; };
    case 6: { [] call dingus_fnc_atis_say_six; };
    case 7: { [] call dingus_fnc_atis_say_seven; };
    case 8: { [] call dingus_fnc_atis_say_eight; };
    case 9: { [] call dingus_fnc_atis_say_niner; };
  };
};

dingus_fnc_atis_SayAirport = {
  params ["_airport"];

  switch (_airport) do {
    case "abdera": { [] call dingus_fnc_atis_say_abdera; };
    case "altis": { [] call dingus_fnc_atis_say_altis; };
    case "almyra": { [] call dingus_fnc_atis_say_almyra; };
    case "aac": { [] call dingus_fnc_atis_say_aac; };
    case "molos": { [] call dingus_fnc_atis_say_molos; };
    case "selakano": { [] call dingus_fnc_atis_say_selakano; };
    // default { systemChat format ["Bad airport code: %1.", _airport] };
  };
};

dingus_fnc_atis_SayPhoenetic = {
  params ["_pho"];

  switch (_pho) do {
    case "no": { [] call dingus_fnc_atis_say_no; };
    case "and": { [] call dingus_fnc_atis_say_and; };
    case "to": { [] call dingus_fnc_atis_say_to; };
    case "for": { [] call dingus_fnc_atis_say_for; };
    case "on": { [] call dingus_fnc_atis_say_on; };
    case "only": { [] call dingus_fnc_atis_say_only; };
    case "runway": { [] call dingus_fnc_atis_say_runway; };
    case "kilometer": { [] call dingus_fnc_atis_say_kilometer; };
    case "kilometers": { [] call dingus_fnc_atis_say_kilometers; };
    case "meter": { [] call dingus_fnc_atis_say_meter; };
    case "meters": { [] call dingus_fnc_atis_say_meters; };
    case "knot": { [] call dingus_fnc_atis_say_knot; };
    case "knots": { [] call dingus_fnc_atis_say_knots; };
    case "degree": { [] call dingus_fnc_atis_say_degree; };
    case "degrees": { [] call dingus_fnc_atis_say_degrees; };
    case "flight_level": { [] call dingus_fnc_atis_say_flight_level; };
    case "descend": { [] call dingus_fnc_atis_say_descend; };
    case "ascend": { [] call dingus_fnc_atis_say_ascend; };
    case "approach": { [] call dingus_fnc_atis_say_approach; };
    case "ground": { [] call dingus_fnc_atis_say_ground; };
    case "tower": { [] call dingus_fnc_atis_say_tower; };
    case "taxi": { [] call dingus_fnc_atis_say_taxi; };
    case "taxi_and_hold_short": { [] call dingus_fnc_atis_say_taxi_and_hold_short; };
    case "hold_short": { [] call dingus_fnc_atis_say_hold_short; };
    case "request": { [] call dingus_fnc_atis_say_request; };
    case "traffic": { [] call dingus_fnc_atis_say_traffic; };
    case "visual": { [] call dingus_fnc_atis_say_visual; };
    case "visibility": { [] call dingus_fnc_atis_say_visibility; };
    case "cleared": { [] call dingus_fnc_atis_say_cleared; };
    case "takeoff": { [] call dingus_fnc_atis_say_takeoff; };
    case "landing": { [] call dingus_fnc_atis_say_landing; };
    case "callsign": { [] call dingus_fnc_atis_say_callsign; };
    case "conditions": { [] call dingus_fnc_atis_say_conditions; };
    case "broken": { [] call dingus_fnc_atis_say_broken; };
    case "scattered": { [] call dingus_fnc_atis_say_scattered; };
    case "cumulonimbus_detected": { [] call dingus_fnc_atis_say_cumulonimbus_detected; };
    case "direct": { [] call dingus_fnc_atis_say_direct; };
    case "immediate": { [] call dingus_fnc_atis_say_immediate; };
    case "departure": { [] call dingus_fnc_atis_say_departure; };
    case "immediate_departure": { [] call dingus_fnc_atis_say_immediate_departure; };
    case "turn": { [] call dingus_fnc_atis_say_turn; };
    case "turn_to": { [] call dingus_fnc_atis_say_turn_to; };
    case "this_is": { [] call dingus_fnc_atis_say_this_is; };
    case "information": { [] call dingus_fnc_atis_say_information; };
    case "main_landing_runway": { [] call dingus_fnc_atis_say_main_landing_runway; };
    case "altis": { [] call dingus_fnc_atis_say_altis; };
    case "abdera": { [] call dingus_fnc_atis_say_abdera; };
    case "almyra": { [] call dingus_fnc_atis_say_almyra; };
    case "aac": { [] call dingus_fnc_atis_say_aac; };
    case "molos": { [] call dingus_fnc_atis_say_molos; };
    case "selakano": { [] call dingus_fnc_atis_say_selakano; };
    case "tanoa": { [] call dingus_fnc_atis_say_tanoa; };
    case "la_rochelle": { [] call dingus_fnc_atis_say_la_rochelle; };
    case "baja": { [] call dingus_fnc_atis_say_baja; };
    case "saint_george": { [] call dingus_fnc_atis_say_saint_george; };
    case "tuvanaka": { [] call dingus_fnc_atis_say_tuvanaka; };
    case "zero": { [] call dingus_fnc_atis_say_zero; };
    case "one": { [] call dingus_fnc_atis_say_one; };
    case "two": { [] call dingus_fnc_atis_say_two; };
    case "three": { [] call dingus_fnc_atis_say_three; };
    case "four": { [] call dingus_fnc_atis_say_four; };
    case "five": { [] call dingus_fnc_atis_say_five; };
    case "six": { [] call dingus_fnc_atis_say_six; };
    case "seven": { [] call dingus_fnc_atis_say_seven; };
    case "eight": { [] call dingus_fnc_atis_say_eight; };
    case "niner": { [] call dingus_fnc_atis_say_niner; };
    case "alpha": { [] call dingus_fnc_atis_say_alpha; };
    case "bravo": { [] call dingus_fnc_atis_say_bravo; };
    case "charlie": { [] call dingus_fnc_atis_say_charlie; };
    case "delta": { [] call dingus_fnc_atis_say_delta; };
    case "echo": { [] call dingus_fnc_atis_say_echo; };
    case "foxtrot": { [] call dingus_fnc_atis_say_foxtrot; };
    case "gulf": { [] call dingus_fnc_atis_say_gulf; };
    case "hotel": { [] call dingus_fnc_atis_say_hotel; };
    case "india": { [] call dingus_fnc_atis_say_india; };
    case "juliet": { [] call dingus_fnc_atis_say_juliet; };
    case "kilo": { [] call dingus_fnc_atis_say_kilo; };
    case "lima": { [] call dingus_fnc_atis_say_lima; };
    case "mike": { [] call dingus_fnc_atis_say_mike; };
    case "november": { [] call dingus_fnc_atis_say_november; };
    case "oscar": { [] call dingus_fnc_atis_say_oscar; };
    case "papa": { [] call dingus_fnc_atis_say_papa; };
    case "quebec": { [] call dingus_fnc_atis_say_quebec; };
    case "romeo": { [] call dingus_fnc_atis_say_romeo; };
    case "sierra": { [] call dingus_fnc_atis_say_sierra; };
    case "tango": { [] call dingus_fnc_atis_say_tango; };
    case "uniform": { [] call dingus_fnc_atis_say_uniform; };
    case "victor": { [] call dingus_fnc_atis_say_victor; };
    case "whiskey": { [] call dingus_fnc_atis_say_whiskey; };
    case "x_ray": { [] call dingus_fnc_atis_say_x_ray; };
    case "yankee": { [] call dingus_fnc_atis_say_yankee; };
    case "zulu": { [] call dingus_fnc_atis_say_zulu; };
    case "heavy": { [] call dingus_fnc_atis_say_heavy; };
    case "rain": { [] call dingus_fnc_atis_say_rain; };
    case "caesar": { [] call dingus_fnc_atis_say_caesar; };
    case "active": { [] call dingus_fnc_atis_say_active; };
    case "departures": { [] call dingus_fnc_atis_say_departures; };
    case "use": { [] call dingus_fnc_atis_say_use; };
    case "malden": { [] call dingus_fnc_atis_say_malden; };
    case "pegasus": { [] call dingus_fnc_atis_say_pegasus; };
    case "wind": { [] call dingus_fnc_atis_say_wind; };
    case "winds": { [] call dingus_fnc_atis_say_winds; };
    case "are": { [] call dingus_fnc_atis_say_are; };
    case "out": { [] call dingus_fnc_atis_say_out; };
    case "of": { [] call dingus_fnc_atis_say_of; };
    case "end": { [] call dingus_fnc_atis_say_end; };
    case "the": { [] call dingus_fnc_atis_say_the; };
    case "arrival": { [] call dingus_fnc_atis_say_arrival; };
    case "gusts": { [] call dingus_fnc_atis_say_gusts; };

    default { systemChat format ["Bad phoenetic code: %1.", _pho] };
  };
};


dingus_fnc_atis_SayNumber = {
  params ["_number"];

  // systemChat format ["%1", _number];

  _str = format ["%1", floor(_number)];

  if (_str == "niner") then {
    _str = "nine";
  };

  _ary = toArray _str;

  // Zero pad
  if (count _ary == 1) then {
    _ary = [48, 48] + _ary;
  };

  // Zero pad
  if (count _ary == 2) then {
    _ary = [48] + _ary;
  };

  { [_x] call dingus_fnc_SayCharacter; } forEach _ary;
};

dingus_fnc_SayCharacter = {
  params ["_char"];

  // systemChat format ['saying %1', _char];

  switch (_char) do {
    case 48: { [] call dingus_fnc_atis_say_zero; };
    case 49: { [] call dingus_fnc_atis_say_one; };
    case 50: { [] call dingus_fnc_atis_say_two; };
    case 51: { [] call dingus_fnc_atis_say_three; };
    case 52: { [] call dingus_fnc_atis_say_four; };
    case 53: { [] call dingus_fnc_atis_say_five; };
    case 54: { [] call dingus_fnc_atis_say_six; };
    case 55: { [] call dingus_fnc_atis_say_seven; };
    case 56: { [] call dingus_fnc_atis_say_eight; };
    case 57: { [] call dingus_fnc_atis_say_niner; };
    // default { systemChat format ["Bad airport code: %1.", _airport] };
  };
};

// Winds: Zero-Zero degrees, Zero-One knots.
dingus_fnc_atis_SayWinds = {
  _windDir = windDir;
  _gusts = gusts;
  _windStr = windStr;

  _strengthActual = _windStr * 10;
  _gustsActual = _gusts * 100;
  _directionActual = floor (_windDir);

  //systemChat format ["%1, %2, %3", _strengthActual, _gustsActual, _directionActual];

  [_directionActual] call dingus_fnc_atis_SayNumber;
  [] call dingus_fnc_atis_say_degrees;

  sleep 0.2;

  [_strengthActual] call dingus_fnc_atis_SayNumber;
  [] call dingus_fnc_atis_say_knots;

  sleep 0.2;

  [] call dingus_fnc_atis_say_gusts;
  [_gustsActual] call dingus_fnc_atis_SayNumber;
  [] call dingus_fnc_atis_say_knots;  
};

// Generated
dingus_fnc_atis_say_no = { playSound "AtisVO_no"; sleep 0.4; };
dingus_fnc_atis_say_and = { playSound "AtisVO_and"; sleep 0.4; };
dingus_fnc_atis_say_to = { playSound "AtisVO_to"; sleep 0.3; };
dingus_fnc_atis_say_for = { playSound "AtisVO_for"; sleep 0.5; };
dingus_fnc_atis_say_on = { playSound "AtisVO_on"; sleep 0.5; };
dingus_fnc_atis_say_only = { playSound "AtisVO_only"; sleep 0.5; };
dingus_fnc_atis_say_runway = { playSound "AtisVO_runway"; sleep 0.6; };
dingus_fnc_atis_say_kilometer = { playSound "AtisVO_kilometer"; sleep 0.7; };
dingus_fnc_atis_say_kilometers = { playSound "AtisVO_kilometers"; sleep 0.8; };
dingus_fnc_atis_say_meter = { playSound "AtisVO_meter"; sleep 0.4; };
dingus_fnc_atis_say_meters = { playSound "AtisVO_meters"; sleep 0.5; };
dingus_fnc_atis_say_knot = { playSound "AtisVO_knot"; sleep 0.4; };
dingus_fnc_atis_say_knots = { playSound "AtisVO_knots"; sleep 0.5; };
dingus_fnc_atis_say_degree = { playSound "AtisVO_degree"; sleep 0.5; };
dingus_fnc_atis_say_degrees = { playSound "AtisVO_degrees"; sleep 0.6; };
dingus_fnc_atis_say_flight_level = { playSound "AtisVO_flight_level"; sleep 0.8; };
dingus_fnc_atis_say_descend = { playSound "AtisVO_descend"; sleep 0.6; };
dingus_fnc_atis_say_ascend = { playSound "AtisVO_ascend"; sleep 0.6; };
dingus_fnc_atis_say_approach = { playSound "AtisVO_approach"; sleep 0.6; };
dingus_fnc_atis_say_ground = { playSound "AtisVO_ground"; sleep 0.4; };
dingus_fnc_atis_say_tower = { playSound "AtisVO_tower"; sleep 0.5; };
dingus_fnc_atis_say_taxi = { playSound "AtisVO_taxi"; sleep 0.5; };
dingus_fnc_atis_say_taxi_and_hold_short = { playSound "AtisVO_taxi_and_hold_short"; sleep 1.3; };
dingus_fnc_atis_say_hold_short = { playSound "AtisVO_hold_short"; sleep 0.75; };
dingus_fnc_atis_say_request = { playSound "AtisVO_request"; sleep 0.6; };
dingus_fnc_atis_say_traffic = { playSound "AtisVO_traffic"; sleep 0.6; };
dingus_fnc_atis_say_visual = { playSound "AtisVO_visual"; sleep 0.6; };
dingus_fnc_atis_say_visibility = { playSound "AtisVO_visibility"; sleep 0.7; };
dingus_fnc_atis_say_cleared = { playSound "AtisVO_cleared"; sleep 0.5; };
dingus_fnc_atis_say_takeoff = { playSound "AtisVO_takeoff"; sleep 0.7; };
dingus_fnc_atis_say_landing = { playSound "AtisVO_landing"; sleep 0.6; };
dingus_fnc_atis_say_callsign = { playSound "AtisVO_callsign"; sleep 0.8; };
dingus_fnc_atis_say_conditions = { playSound "AtisVO_conditions"; sleep 0.7; };
dingus_fnc_atis_say_broken = { playSound "AtisVO_broken"; sleep 0.5; };
dingus_fnc_atis_say_scattered = { playSound "AtisVO_scattered"; sleep 0.6; };
dingus_fnc_atis_say_cumulonimbus_detected = { playSound "AtisVO_cumulonimbus_detected"; sleep 1.3; };
dingus_fnc_atis_say_direct = { playSound "AtisVO_direct"; sleep 0.6; };
dingus_fnc_atis_say_immediate = { playSound "AtisVO_immediate"; sleep 0.6; };
dingus_fnc_atis_say_departure = { playSound "AtisVO_departure"; sleep 0.6; };
dingus_fnc_atis_say_immediate_departure = { playSound "AtisVO_immediate_departure"; sleep 0.9; };
dingus_fnc_atis_say_turn = { playSound "AtisVO_turn"; sleep 0.4; };
dingus_fnc_atis_say_turn_to = { playSound "AtisVO_turn_to"; sleep 0.6; };
dingus_fnc_atis_say_this_is = { playSound "AtisVO_this_is"; sleep 0.6; };
dingus_fnc_atis_say_information = { playSound "AtisVO_information"; sleep 0.8; };
dingus_fnc_atis_say_main_landing_runway = { playSound "AtisVO_main_landing_runway"; sleep 1.2; };
dingus_fnc_atis_say_altis = { playSound "AtisVO_altis"; sleep 0.7; };
dingus_fnc_atis_say_abdera = { playSound "AtisVO_abdera"; sleep 0.7; };
dingus_fnc_atis_say_almyra = { playSound "AtisVO_almyra"; sleep 0.7; };
dingus_fnc_atis_say_aac = { playSound "AtisVO_aac"; sleep 0.8; };
dingus_fnc_atis_say_molos = { playSound "AtisVO_molos"; sleep 0.75; };
dingus_fnc_atis_say_selakano = { playSound "AtisVO_selakano"; sleep 0.9; };
dingus_fnc_atis_say_tanoa = { playSound "AtisVO_tanoa"; sleep 0.7; };
dingus_fnc_atis_say_la_rochelle = { playSound "AtisVO_la_rochelle"; sleep 0.85; };
dingus_fnc_atis_say_baja = { playSound "AtisVO_baja"; sleep 0.7; };
dingus_fnc_atis_say_saint_george = { playSound "AtisVO_saint_george"; sleep 1; };
dingus_fnc_atis_say_tuvanaka = { playSound "AtisVO_tuvanaka"; sleep 0.8; };
dingus_fnc_atis_say_zero = { playSound "AtisVO_zero"; sleep 0.6; };
dingus_fnc_atis_say_one = { playSound "AtisVO_one"; sleep 0.4; };
dingus_fnc_atis_say_two = { playSound "AtisVO_two"; sleep 0.4; };
dingus_fnc_atis_say_three = { playSound "AtisVO_three"; sleep 0.4; };
dingus_fnc_atis_say_four = { playSound "AtisVO_four"; sleep 0.4; };
dingus_fnc_atis_say_five = { playSound "AtisVO_five"; sleep 0.5; };
dingus_fnc_atis_say_six = { playSound "AtisVO_six"; sleep 0.5; };
dingus_fnc_atis_say_seven = { playSound "AtisVO_seven"; sleep 0.55; };
dingus_fnc_atis_say_eight = { playSound "AtisVO_eight"; sleep 0.4; };
dingus_fnc_atis_say_niner = { playSound "AtisVO_niner"; sleep 0.5; };
dingus_fnc_atis_say_alpha = { playSound "AtisVO_alpha"; sleep 0.5; };
dingus_fnc_atis_say_bravo = { playSound "AtisVO_bravo"; sleep 0.5; };
dingus_fnc_atis_say_charlie = { playSound "AtisVO_charlie"; sleep 0.5; };
dingus_fnc_atis_say_delta = { playSound "AtisVO_delta"; sleep 0.7; };
dingus_fnc_atis_say_echo = { playSound "AtisVO_echo"; sleep 0.5; };
dingus_fnc_atis_say_foxtrot = { playSound "AtisVO_foxtrot"; sleep 0.8; };
dingus_fnc_atis_say_gulf = { playSound "AtisVO_gulf"; sleep 0.4; };
dingus_fnc_atis_say_hotel = { playSound "AtisVO_hotel"; sleep 0.65; };
dingus_fnc_atis_say_india = { playSound "AtisVO_india"; sleep 0.5; };
dingus_fnc_atis_say_juliet = { playSound "AtisVO_juliet"; sleep 0.5; };
dingus_fnc_atis_say_kilo = { playSound "AtisVO_kilo"; sleep 0.5; };
dingus_fnc_atis_say_lima = { playSound "AtisVO_lima"; sleep 0.5; };
dingus_fnc_atis_say_mike = { playSound "AtisVO_mike"; sleep 0.5; };
dingus_fnc_atis_say_november = { playSound "AtisVO_november"; sleep 0.6; };
dingus_fnc_atis_say_oscar = { playSound "AtisVO_oscar"; sleep 0.5; };
dingus_fnc_atis_say_papa = { playSound "AtisVO_papa"; sleep 0.4; };
dingus_fnc_atis_say_quebec = { playSound "AtisVO_quebec"; sleep 0.5; };
dingus_fnc_atis_say_romeo = { playSound "AtisVO_romeo"; sleep 0.6; };
dingus_fnc_atis_say_sierra = { playSound "AtisVO_sierra"; sleep 0.5; };
dingus_fnc_atis_say_tango = { playSound "AtisVO_tango"; sleep 0.5; };
dingus_fnc_atis_say_uniform = { playSound "AtisVO_uniform"; sleep 0.6; };
dingus_fnc_atis_say_victor = { playSound "AtisVO_victor"; sleep 0.4; };
dingus_fnc_atis_say_whiskey = { playSound "AtisVO_whiskey"; sleep 0.5; };
dingus_fnc_atis_say_x_ray = { playSound "AtisVO_x_ray"; sleep 0.5; };
dingus_fnc_atis_say_yankee = { playSound "AtisVO_yankee"; sleep 0.5; };
dingus_fnc_atis_say_zulu = { playSound "AtisVO_zulu"; sleep 0.4; };
dingus_fnc_atis_say_heavy = { playSound "AtisVO_heavy"; sleep 0.5; };
dingus_fnc_atis_say_rain = { playSound "AtisVO_rain"; sleep 0.5; };
dingus_fnc_atis_say_caesar = { playSound "AtisVO_caesar"; sleep 0.5; };
dingus_fnc_atis_say_active = { playSound "AtisVO_active"; sleep 0.4; };
dingus_fnc_atis_say_departures = { playSound "AtisVO_departures"; sleep 0.6; };
dingus_fnc_atis_say_use = { playSound "AtisVO_use"; sleep 0.4; };
dingus_fnc_atis_say_malden = { playSound "AtisVO_malden"; sleep 0.4; };
dingus_fnc_atis_say_pegasus = { playSound "AtisVO_pegasus"; sleep 0.65; };
dingus_fnc_atis_say_wind = { playSound "AtisVO_wind"; sleep 0.4; };
dingus_fnc_atis_say_winds = { playSound "AtisVO_winds"; sleep 0.5; };
dingus_fnc_atis_say_are = { playSound "AtisVO_are"; sleep 0.4; };
dingus_fnc_atis_say_out = { playSound "AtisVO_out"; sleep 0.3; };
dingus_fnc_atis_say_of = { playSound "AtisVO_of"; sleep 0.3; };
dingus_fnc_atis_say_end = { playSound "AtisVO_end"; sleep 0.4; };
dingus_fnc_atis_say_the = { playSound "AtisVO_the"; sleep 0.3; };
dingus_fnc_atis_say_arrival = { playSound "AtisVO_arrival"; sleep 0.6; };
dingus_fnc_atis_say_gusts = { playSound "AtisVO_gusts"; sleep 0.7; };