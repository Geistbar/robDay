script "robEvent.ash"

/*******************************************************
*					robEvent()
*	For doing special adventures during an event.
/*******************************************************/

/*******************************************************
*					getUse()
*	Retrives & uses a specified quantity of a item.
/*******************************************************/
void getUse(int qty, item it)
{
	int qtyNeeded = qty - item_amount(it);
	
	if (qtyNeeded > 0)
		cli_execute("Buy " + qtyNeeded + " " + it);
	use(qty,it);
}

void eventAdv()
{
	cli_execute("autoattack Farming");
	if (item_amount($item[worksite credentials]) == 0)
		take_closet(1,$item[worksite credentials]);
	if (item_amount($item[mafia organizer badge]) == 0)
		take_closet(1,$item[mafia organizer badge]);
	
	cli_execute("Outfit Lyle");
	cli_execute("Familiar Jumpsuited Hound Dog");
	cli_execute("cast 3 musk of the moose");
	cli_execute("cast 2 Carlweather's Cantata of Confrontation");
	getUse(3,$item[handful of pine needles]);
		
	cli_execute("adv 21 monorail work site");
	
	cli_execute("outfit Farming4"); // Just need to change outfit
	put_closet(item_amount($item[worksite credentials]),$item[worksite credentials]);
	put_closet(item_amount($item[mafia organizer badge]),$item[mafia organizer badge]);
	
	cli_execute("shrug Carlweather's Cantata of Confrontation");
	// Grab horse
	visit_url("place.php?whichplace=town_right&action=town_horsery");
	run_choice(2);
}

void main()
{
	eventAdv();
}