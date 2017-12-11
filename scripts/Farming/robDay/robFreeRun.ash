script "robFreeRun.ash"

/*******************************************************
*					robFreeRun()
*	Uses daily free runaways in order to try and
*	encounter an Ultra Rare. Also makes use of 
*	pickpocket to ensure some profit no matter what.
/*******************************************************/

/*******************************************************
*					availableRunaways()
*	Calculates available runaways with stomping boots.
/*******************************************************/
int availableRunaways()
{
	int usedRuns = get_property("_banderRunaways").to_int();
	int weight = familiar_weight($familiar[Pair of Stomping Boots])	+ numeric_modifier("familiar weight");
	int maxRuns = weight / 5;
	
	return (maxRuns - usedRuns);
}
/*******************************************************
*					bootsRun()
*	Runs away a specified quantity of times from 
*	specified place.
/*******************************************************/
void bootsRun(int times, location place)
{
	int iterations = 0;
	while (iterations < times)
	{
		iterations+= 1;
		adv1(place,-1,"");
	}
}

void freeRun()
{
	location place = $location[A Mob of Zeppelin Protesters];
	
	// Fail-safe setup
	cli_execute("autoattack BootRunaway");
	//take_closet(1,$item[Lord Soggyraven's Slippers]);
	cli_execute("outfit BootRunaway");
	bjornify_familiar($familiar[Spooky Pirate Skeleton]);
  	use_skill(1,$skill[Bind Spice Ghost]);
	use_familiar($familiar[Pair of Stomping Boots]);
	cli_execute("equip snow suit");
	
	// Cycle through location, switching gear to buff weight
	bootsRun(availableRunaways(),place);
	equip($slot[acc3],$item[belt of loathing]);
	bootsRun(availableRunaways(),place);
	equip($slot[acc1],$item[over-the-shoulder Folder Holder]);
	bootsRun(availableRunaways(),place);
	equip($item[Great Wolf's beastly trousers]);
	bootsRun(availableRunaways(),place);
	equip($item[gnawed-up dog bone]);
	bootsRun(availableRunaways(),place);
	equip($item[Stephen's lab coat]);
	bootsRun(availableRunaways(),place);
	equip($item[Wal-Mart snowglobe]);
	bootsRun(availableRunaways(),place);
	
	// Return to closet
	//put_closet(1,$item[Lord Soggyraven's Slippers]);
}

void main()
{
	freeRun();
}