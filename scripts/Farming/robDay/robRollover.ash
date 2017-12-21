script "robRollover.ash"

/*******************************************************
*					robRollover()
*	Finishes character day and gets ready for rollover.
/*******************************************************/

void rollover()
{
	// Item Maintence
	put_shop(0,0,$item[Five Second Energy&trade;]);
	put_shop(0,0,$item[Jerks' Health&trade; Magazine]);
	put_closet(item_amount($item[black snowcone]),$item[black snowcone]);
	put_closet(item_amount($item[fish juice box]),$item[fish juice box]);
	put_closet(item_amount($item[rubber nubbin]),$item[rubber nubbin]);
	use(item_amount($item[bag of park garbage])-5,$item[bag of park garbage]);
	cli_execute("useMeatItems.ash");
	cli_execute("PvPItemCheck.ash");
	
	// Get ready for rollover
	equip($item[Pantsgiving]);
	while (get_property("timesRested").to_int() < total_free_rests())
		cli_execute("rest");
	cli_execute("swim sprints");
	cli_execute("use Oscus's neverending soda");
	cli_execute("cast * dice");
	
	// Change gear and familiar
	cli_execute("fold stinky cheese diaper");
	cli_execute("outfit Rollover");
	use_familiar($familiar[Trick-or-Treating Tot]);

	//	Drink nightcap
	cli_execute("shrug The Sonata of Sneakiness");
	use_skill(1,$skill[The Ode to Booze]);
	cli_execute("drink grogtini");
	cli_execute("mix grogtini");
	cli_execute("shrug ode");
	
	cli_execute("hottub");
	
	// Grab photocopy
	if (item_amount($item[photocopied monster]) == 0)
	{
		cli_execute("/whitelist generic clan name");
		cli_execute("fax get");
		cli_execute("/whitelist the clan of intelligent people");
		if (!visit_url("desc_item.php?whichitem=835898159").contains_text("Witchess Bishop"))
			cli_execute("faxbot witchess bishop");
	}
}

void main()
{
	rollover();
}