script "autoFantasy.ash"

void main()
{
	// Prepare to run
	cli_execute("cast 3 brawn");
	visit_url("place.php?whichplace=realm_fantasy&action=fr_initcenter");
	run_choice(2);
	cli_execute("/uncloset 1 sea salt scrubs");
	cli_execute("outfit fantasy; familiar none; autoattack none; ccs fantasy");
	if (item_amount($item[FantasyRealm key]) == 0)
		buy($coinmaster[FantasyRealm Premium Rubee&trade; Store],1,$item[FantasyRealm key]);

	// Pre-launch setup
	string manaburn = get_property("manaBurningThreshold");
	string manatrigger = get_property("manaBurningTrigger");
	string manarecover = get_property("mpAutoRecovery");
	string manatarget = get_property("mpAutoRecoveryTarget");
	
	cli_execute("set manaBurningThreshold = 0.5");
	cli_execute("set manaBurningTrigger = 0.9");
	cli_execute("set mpAutoRecovery = 0.3"); 
	cli_execute("set mpAutoRecoveryTarget = 0.5");
	
	adventure(6,$location[The Cursed Village]);
	adventure(6,$location[The Towering Mountains]);
	adventure(6,$location[The Foreboding Cave]);
	adventure(6,$location[The Sprawling Cemetery]);
	
	// Restore mana state
	cli_execute("set manaBurningThreshold = " + manaburn);
	cli_execute("set manaBurningTrigger = " + manatrigger);
	cli_execute("set mpAutoRecovery = " + manarecover);
	cli_execute("set mpAutoRecoveryTarget = " + manatarget);
	
/* 	equip($slot[acc1],$item[none]);
	equip($slot[acc2],$item[none]);
	equip($slot[acc3],$item[none]); */
	
	cli_execute("ccs default; autoattack farming; /outfit none; shrug brawn; /closet 1 sea salt scrubs");
}