// Copy the Bishop for extra drops
cli_execute("autoattack Copy1");
use_familiar($familiar[Obtuse Angel]);
visit_url("campground.php?action=witchess");
run_choice(1);
visit_url("choice.php?option=1&pwd=" + my_hash() + "&whichchoice=1182&piece=" + 1942, false);
run_combat(); // Safety check

// After fight re-setting
cli_execute("autoattack Farming");
cli_execute("terminal educate extract; terminal educate digitize");