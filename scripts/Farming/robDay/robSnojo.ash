script "robSnojo.ash"

/*******************************************************
*					robSnojo()
*	
/*******************************************************/
void snojo(familiar f)
{
	// Fail-safe setup
	cli_execute("autoattack none; ccs farming");
	cli_execute("outfitFreeDrops.ash");
	bjornify_familiar($familiar[Grimstone Golem]);

	use_familiar(f);

	while(get_property("_snojoFreeFights").to_int() < 10)
		adv1($location[The X-32-F Combat Training Snowman],-1,"");
}


void main()
{
	familiar fam = $familiar[Puck Man];
	snojo(fam);
}