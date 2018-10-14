script "robBarf.ash"
import <gbFun.ash>
/*******************************************************
*					robBarf()
*	Spends adventures at Barf Mountain to get meat.
*	Also gets in daily Conspiracy Island quest in, and
*	tries to perform a yellow ray every 100 adventures.
/*******************************************************/
boolean run_Conspiracy = TRUE;
int numberologyCount = 0;
int digitizeCount = 1;

//getuse geteat wobble

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
	cli_execute("autoattack none");
}

void farm()
{
	// Safety checks
	cli_execute("outfitFarming2.ash");
	cli_execute("ccs farming");
	cli_execute("autoattack none");
 	
	// Buff updates
	equip($slot[weapon],$item[garbage sticker]);
	wobble($effect[Wasabi Sinuses], $item[Knob Goblin nasal spray], 10);
	wobble($effect[Merry Smithsness], $item[Flaskfull of Hollow], 150);
	wobble($effect[How to Scam Tourists], $item[How to Avoid Scams], 20);
	
	// Safety Check
	bjornify_familiar($familiar[Spooky Pirate Skeleton]);
	
	// Yellow Ray to start
	if (have_effect($effect[everything looks yellow]) == 0)
		cli_execute("robYellowRay.ash");
	
	// Pantsgiving fullness
	adventure(2,$location[Barf Mountain]);
	getEat(1,$item[ice rice]);
	adventure(2,$location[Barf Mountain]);
	getEat(1,$item[jumping horseradish]);
	// Adventure at Barf Mountain until Cheese is fully charged
	while(get_property("_stinkyCheeseCount").to_int() < 100)
		adventure(1,$location[Barf Mountain]);
	// Buffs
	cli_execute("pool 1"); cli_execute("pool 1");
	cli_execute("outfitFarming4.ash");
	
	// Finish adventuring -- Loop at final location while YRing
	while (my_adventures() > 0)
	{	
		if(numberologyCount < 3)
			numberology(69);
		if (digitizeCount < 3 && get_property("_sourceTerminalDigitizeMonsterCount").to_int() >= 5)
			digitizeUpdate();
		if (have_effect($effect[everything looks yellow]) == 0)
			cli_execute("robYellowRay.ash");
		adventure(1,$location[Barf Mountain]);
	}
	// Assorted item maintenance
	autosell(item_amount($item[meat stack]),$item[meat stack]);
	use(item_amount($item[bag of park garbage])-5,$item[bag of park garbage]);
}

void main()
{
	farm();
}