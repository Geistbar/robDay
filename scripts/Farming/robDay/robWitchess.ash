script "robWitchess.ash"

/*******************************************************
*					robWitchess()
*	Fights chess pieces at the new witchness set.
*
*	Pawn: piece 1935
*	Knight: 1936
*	Ox: 1937
*	Rook: 1938
*	Queen: 1939
*	King: 1940
*	Witch: 1941
*	Bishop: 1942
/*******************************************************/

void chessFight(familiar f)
{
	// Fail-safe setup
	cli_execute("autoattack Farming");
	cli_execute("outfit FreeDrops");
	cli_execute("terminal educate digitize; terminal educate duplicate");
	bjornify_familiar($familiar[Grim Brother]);
	
	use_familiar(f);
	int n = 0;
	while (n < 4)
	{
		visit_url("campground.php?action=witchess");
		run_choice(1);
		visit_url("choice.php?option=1&pwd=" + my_hash() + "&whichchoice=1182&piece=" + 1936, false);
		run_combat(); // Safety check
		n+=1;
	}
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
}

void main()
{
	familiar fam = $familiar[Puck Man];
	chessFight(fam);
}