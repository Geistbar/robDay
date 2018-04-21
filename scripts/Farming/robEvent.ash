script "robBarf.ash"

/*******************************************************
*					robBarf()
*	Spends adventures at A Monorail Station to get meat.
*	Also gets in daily Conspiracy Island quest in, and
*	tries to perform a yellow ray every 100 adventures.
/*******************************************************/
boolean run_Conspiracy = TRUE;
int numberologyCount = 0;
int digitizeCount = 1;

/*******************************************************
*					getUse()
*	Retrives & uses a specified quantity of a item.
/*******************************************************/
void getUse(int qty, item it)
{
	int qtyNeeded = qty - item_amount(it);
	
	if (qtyNeeded > 0)
	{
		if ((it == $item[knob goblin pet-buffing spray]) || (it == $item[Knob Goblin nasal spray]))
		{
			cli_execute("/whitelist Intelligent Storage Inc.");
			take_stash(1,$item[Travoltan Trousers]);
			cli_execute("Buy " + qtyNeeded + " " + it);
			put_stash(1,$item[Travoltan Trousers]);
			cli_execute("/whitelist The Clan Of Intelligent People");
		}
		else
			cli_execute("Buy " + qtyNeeded + " " + it);
	}
	use(qty,it);
}

/*******************************************************
*					getEat()
*	Retrives & eats a specified quantity of a food.
/*******************************************************/
void getEat(int qty, item it)
{
	int qtyNeeded = qty - item_amount(it);
	if (qtyNeeded > 0 && it == $item[Karma shawarma])
		buy($coinmaster[The SHAWARMA Initiative],qty,it);
	else if (qtyNeeded > 0 && it == $item[dinsey food-cone])
		buy($coinmaster[The Dinsey Company Store],qty,it);
	else if (qtyNeeded > 0)
		cli_execute("Buy " + qtyNeeded + " " + it);
	eat(qty,it);
}

/*******************************************************
*					wobble()
*	Gets a specified buff from a specified item. 
*	Optimizes for your current turns and turns remaining
*	of the buff if you have it already.
/*******************************************************/
void wobble(effect buff, item source, int turns)
{
	int effectTurns = my_adventures() - have_effect(buff);
	getUse(effectTurns/turns + 1, source);
}

/*******************************************************
*					numberology(int digits)
*	Tries to get a numberology outcome with the ending
*	digits input. Only enter 2 digits.
/*******************************************************/
void numberology(int digits)
{
	if(cli_execute("numberology " + digits))
		numberologyCount+=1;
}

void digitizeUpdate()
{
	cli_execute("autoattack Copy3");
	visit_url("campground.php?action=witchess");
	run_choice(1);
	visit_url("choice.php?option=1&pwd=" + my_hash() + "&whichchoice=1182&piece=" + 1942, false);
	run_combat(); // Safety check
	cli_execute("autoattack Event");
}

void farm()
{
	// Safety checks
	cli_execute("outfit Event1");
	cli_execute("autoattack Event");
	
	// For Robortender
	use_familiar($familiar[Robortender]);
	cli_execute("buy single entendre; buy newark; buy drive-by shooting");
	cli_execute("robo single entendre; robo newark; robo drive-by shooting");

	// Buff updates
	wobble($effect[Wasabi Sinuses], $item[Knob Goblin nasal spray], 10);
	wobble($effect[Merry Smithsness], $item[Flaskfull of Hollow], 150);
	
	// Safety Check
	bjornify_familiar($familiar[Spooky Pirate Skeleton]);
	
	// Yellow Ray to start
	if (have_effect($effect[everything looks yellow]) == 0)
	{
		cli_execute("robYellowRay.ash");
		cli_execute("autoattack Event");
	}
	// Pantsgiving fullness
	adventure(2,$location[A Monorail Station]);
	getEat(1,$item[ice rice]);
	adventure(2,$location[A Monorail Station]);
	getEat(1,$item[jumping horseradish]);
	cli_execute("outfit Event2");
	// Adventure at A Monorail Station until Cheese is fully charged
	while(get_property("_stinkyCheeseCount").to_int() < 100)
		adventure(1,$location[A Monorail Station]);
	// Buffs
	cli_execute("pool 1"); cli_execute("pool 1");
	cli_execute("outfit Event3");
	
	// Finish adventuring -- Loop at final location while YRing
	while (my_adventures() > 0)
	{	
		if(numberologyCount < 3)
			numberology(69);
		if (digitizeCount < 3 && get_property("_sourceTerminalDigitizeMonsterCount").to_int() >= 5)
			digitizeUpdate();
		if (have_effect($effect[everything looks yellow]) == 0)
		{
			cli_execute("robYellowRay.ash");
			cli_execute("autoattack Event");
		}
		adventure(1,$location[A Monorail Station]);
	}
	// Assorted item maintenance
	autosell(item_amount($item[meat stack]),$item[meat stack]);
	use(item_amount($item[bag of park garbage])-5,$item[bag of park garbage]);
}

void main()
{
	farm();
}