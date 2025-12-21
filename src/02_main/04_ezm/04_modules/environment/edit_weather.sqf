MAZ_EZM_fnc_editWeatherConditionsModule = {
			fogParams params ["_fogValue","_fogDecay","_fogBase"];
			["Edit Weather Conditions",[
				[
					"SLIDER",
					["Time for Effect","The time it takes for the changes to take effect, in in-game minutes."],
					[0,60,0]
				],
				[
					"SLIDER",
					["Cloud Cover","Amount of cloud cover, in percent."],
					[0,100,round (overcast * 100)]
				],
				[
					"SLIDER",
					["Fog","Amount of fog in percent."],
					[0,100,round (_fogValue * 100)]
				],
				[
					"SLIDER",
					["Fog Decay","How fast the fog decays as it moves upwards in the atmosphere, a percentage."],
					[0,10,round (_fogDecay * 100)]
				],
				[
					"SLIDER",
					["Fog Base","The base of the fog, in meters."],
					[-1000,1000,_fogBase]
				],
				[
					"SLIDER",
					["Rain Chance","The chance for it to rain, in percent.\nIn clear skies it will not rain."],
					[0,100,round (rain * 100)]
				],
				[
					"SLIDER",
					["Waves Strength","Strengths of the ocean waves, in percent."],
					[0,100,round (waves * 100)]
				],
				[
					"SLIDER",
					["Wind Strength","Strength of the wind, in percent."],
					[0,100,round (windStr * 100)]
				],
				[
					"SLIDER",
					["Gusts Strength","Strength of the wind gusts, in percent."],
					[0,100,round (gusts * 100)]
				],
				[
					"SLIDER",
					["Wind Direction","Direction of the wind and gusts, in degrees."],
					[0,360,round windDir]
				]
			],{
				params ["_values","_pos","_display"];
				_display closeDisplay 1;
				[_values,{
					params ["_time","_overcast","_fog","_fogDecay","_fogBase","_rain","_waves","_windStr","_gustStr","_windDir"];
					_time setOverCast (_overcast/100);
					_time setFog [(_fog/100),(_fogDecay/100),_fogBase];
					_time setRain (_rain/100);
					_time setWaves (_waves/100);
					_time setWindStr (_windStr/100);
					_time setGusts (_gustStr/100);
					_time setWindDir _windDir;
					if(_time == 0) then {
						forceWeatherChange;
					};
				}] remoteExec ['spawn',2];

			},{
				params ["_values","_args","_display"];
				_display closeDisplay 2;
			},[]] call MAZ_EZM_fnc_createDialog;
		};