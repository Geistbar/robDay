script "rob---.ash"

/*******************************************************
*					robMPLove()
*	Does mana buffs and hits the love tunnel. Uses
*	free MP restores to cast librams.
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

void loveTunnel(int a, int b, int c)
{
	visit_url("place.php?whichplace=town_wrong&action=townwrong_tunnel");
	run_choice(1);
	visit_url("place.php?whichplace=town_wrong&action=townwrong_tunnel");
	run_choice(1);
	run_combat();
	visit_url("place.php?whichplace=town_wrong&action=townwrong_tunnel");
	run_choice(a);
	visit_url("place.php?whichplace=town_wrong&action=townwrong_tunnel");
	run_choice(1);
	run_combat();
	visit_url("place.php?whichplace=town_wrong&action=townwrong_tunnel");
	run_choice(b);
	visit_url("place.php?whichplace=town_wrong&action=townwrong_tunnel");
	run_choice(1);
	run_combat();
	visit_url("place.php?whichplace=town_wrong&action=townwrong_tunnel");
	run_choice(c);
	run_choice(2);
}

void MPbuffs()
{
	// Buffs that cost meat
	getUse(1,$item[Hawking's Elixir of Brilliance]);
	getUse(1,$item[tomato juice of powerful power]);
	getUse(1,$item[ointment of the occult]);
	
	// Setup
	if (item_amount($item[sea salt scrubs]) < 1)
		take_closet(1,$item[sea salt scrubs]);
	cli_execute("outfitMP.ash");
	use_familiar($familiar[disembodied hand]);
	cli_execute("cast * dice");
	cli_execute("ballpit");
	cli_execute("telescope high");
	cli_execute("spacegate vaccine 2"); // 50% myst
	
	use(1,$item[Platinum Yendorian Express Card]);
	
	// Get broad spectrum of librams
	use_skill(50,$skill[Ur-Kel's Aria of Annoyance]);
	use_skill(30,$skill[Summon Resolutions]);
	use_skill(10,$skill[Summon Party Favor]);
	use_skill(10,$skill[Summon Taffy]);
	use_skill(10,$skill[Summon BRICKOs]);
	
	// Do this twice because there's a hard limit on number of casts
	cli_execute("cast * dice");
	cli_execute("cast * dice");
	
	// Last MP refill
	use(1,$item[License to Chill]);
	cli_execute("cast * dice");
	
	// Get more mana from Love Tunnel
	cli_execute("autoattack LoveTunnel");
	use_familiar($familiar[Grim Brother]);
	equip($item[tiny black hole]);
	loveTunnel(3,2,3); // Third choice for each
	cli_execute("cast * dice");
}

void main()
{
	MPbuffs();
	cli_execute("autoattack none");
}