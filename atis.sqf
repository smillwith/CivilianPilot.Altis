/*
Set sample format to 16 bit PCM
Export to MP3 with Constant bit rate, at 128 or less (maybe higher is OK too)

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

  systemChat 'done';
};

  