script "robEldritch.ash"

/*******************************************************
*					robEldritch()
*	Summons Eldritch Horror for a free combat.
/*******************************************************/

void eldritchFight(familiar f)
{
	cli_execute("OutfitFreeDrops.ash");
	cli_execute("ccs Farming");
	use_familiar(f);
	
	use_skill(1,$skill[Evoke Eldritch Horror]);
	run_combat();
}

void main()
{
	familiar fam = $familiar[Stocking Mimic];
	eldritchFight(fam);
}