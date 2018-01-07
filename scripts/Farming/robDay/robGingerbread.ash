script "robGingerbread.ash"

/*******************************************************
*					robGingerbread()
*	Uses free kills at Gingerbread City to get either
*	candy or a latte.
/*******************************************************/

void gingerSetup(familiar f)
{
	// Setup equipment, familiar, autoattack
	cli_execute("autoattack GingerbreadKills");
	use_familiar(f);
	bjornify_familiar($familiar[Spooky Pirate Skeleton]);
	take_closet(1,$item[sour ball and chain]);
	take_closet(1,$item[gingerbread hoodie]);
	cli_execute("Outfit Freekills");
	
	// Move clock forward
	adv1($location[Gingerbread Civic Center],-1,"");
	run_choice(1);
	
	// Get sprinkles in the sewers
	adv1($location[Gingerbread Sewers],-1,"");
	cli_execute("autoattack Freekills");
	adv1($location[Gingerbread Sewers],-1,"");
	equip($item[Sugar raygun]);
	adv1($location[Gingerbread Sewers],-1,"");
}

// Gets batch of random candies
void gingerbreadCandy(familiar f)
{
	gingerSetup(f);
	adv1($location[Gingerbread Train Station],-1,"");
	run_choice(1);
	
	cli_execute("Outfit FreeDrops");
	put_closet(1,$item[sour ball and chain]);
	put_closet(1,$item[gingerbread hoodie]);
}

// Gets a Gingerbread spice latte
void gingerbreadPotion(familiar f)
{
	gingerSetup(f);
	adv1($location[Gingerbread Upscale Retail District],-1,"");
	run_choice(3);
	
	cli_execute("Outfit FreeDrops");
	put_closet(1,$item[sour ball and chain]);
	put_closet(1,$item[gingerbread hoodie]);
}

void main()
{
	familiar fam = $familiar[Chocolate Lab];
	gingerbreadPotion(fam);
}