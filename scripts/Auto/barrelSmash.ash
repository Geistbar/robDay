script "barrelSmash.ash"
notify Giestbar;
/*******************************************************
*	barrelSmash.ash
*	Version r1
*
*	Smashes every single one of the barrels dropped by
*	the Shrine to the Barrel God item of the month. Will
*	output the number of rare barrel items you gained.
/*******************************************************/

/*******************************************************
*	Item list variables
/*******************************************************/
boolean[item] barrels = $items[little firkin, normal barrel, big tun, weathered barrel, dusty barrel, disintegrating barrel, moist barrel, rotting barrel, mouldering barrel, barnacled barrel];
boolean[item] rares = $items[bottle of Amontillado, barrel-aged martini, barrel gun, barrel cracker, barrel pickle, tiny barrel, cute mushroom, vibrating mushroom, barrel beryl, water log];

/*******************************************************
*					barrelSum()
*	Returns the total number of barrels you have.
/*******************************************************/
int barrelSum()
{
	int sum;
	foreach barrel in barrels
		sum += item_amount(barrel);
	return sum;
}

/*******************************************************
*					smashBarrels(item barrel)
*	Visits the barrel smashing url once for every
*	argument barrel you have.
/*******************************************************/
void smashBarrels(item barrel)
{
	int number = item_amount(barrel);
	int id = to_int(barrel);
	int times = 0;
	
	visit_url("inv_use.php?pwd&whichitem=" + to_string(id) + "&choice=1");	// Start party
	while (number > times)
	{
		visit_url("choice.php?whichchoice=1101&pwd&option=1&iid=" + to_string(id));
		times+=1;
	}
}

/*******************************************************
*					smash100()
*	Uses the "smash 100" button while possible.
/*******************************************************/
void smash100()
{
	int sum = barrelSum();
	while (sum >= 100)
	{
		item bar;
		while (bar == $item[none])
		{
			foreach barrel in barrels
			{
				if (item_amount(barrel) > 0)
					bar = barrel;
			}
		}
		int id = to_int(bar);
		visit_url("inv_use.php?pwd&whichitem=" + to_string(id) + "&choice=1");	// Start party
		visit_url("choice.php?pwd&whichchoice=1101&option=2");
		sum = barrelSum();
	}
}

void main()
{
	int[item] invStart = get_inventory();		// For data purposes
	//smash100();
	// Go through each barrel and call smashBarrels() with it
	foreach barrel in barrels
	{
		if (item_amount(barrel) > 0)
			smashBarrels(barrel);
	}
	int[item] invStop = get_inventory();		// For data purposes
	// Tell user how many rare barrel items were received
	foreach rare in rares
	{
		if(invStop[rare] > invStart[rare])
			print("You gained: " + (invStop[rare] - invStart[rare]) + " " + rare, "green");
	}
}