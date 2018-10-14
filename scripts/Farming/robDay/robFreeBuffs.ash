script "robFreeBuffs.ash"

/*******************************************************
*					robFreeBuffs()
*	Uses once off buffs that do not consume an item
*	or meat.
/*******************************************************/

void buffs()
{
	cli_execute("terminal enhance meat"); cli_execute("terminal enhance meat"); cli_execute("terminal enhance meat");
	use(1,$item[The Legendary Beat]);
	cli_execute("pool 1");
	cli_execute("concert 2");
	use_skill(1,$skill[Incredible Self-Esteem]);
	use(1,$item[defective game grid token]);
	
	// Witchness buff
	visit_url("campground.php?action=witchess");
	run_choice(3);
	run_choice(3);
	
	// KGB
	cli_execute("briefcase buff meat");
	cli_execute("briefcase buff mp");
	cli_execute("briefcase buff meat");
	cli_execute("briefcase buff meat");
	cli_execute("briefcase buff meat");
	cli_execute("briefcase buff meat");
	cli_execute("briefcase buff meat");
	cli_execute("briefcase stop");
	
	// Bastille
	cli_execute("bastille babar draftsman gesture");
	
	// Fortune Teller
	visit_url("clan_viplounge.php?preaction=lovetester");
	visit_url("choice.php?pwd&whichchoice=1278&option=1&which=-3&whichid=&q1=a&q2=a&q3=a");
}

void main()
{
	buffs();
}