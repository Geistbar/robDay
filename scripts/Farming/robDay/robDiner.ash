script "robDiner.ash"
import <gbFun.ash>
/*******************************************************
*					robDiner()
*	
/*******************************************************/

// getuse wobble

void diner()
{
	// Safety Check
	bjornify_familiar($familiar[Spooky Pirate Skeleton]);
	
	use_skill(1,$skill[Bind Lasagmbie]);
	if (have_effect($effect[temporary blindness]) > 0)
		cli_execute("hottub");
	if (have_effect($effect[temporary blindness]) > 0)
		cli_execute("shrug temporary blindness");
	if (have_effect($effect[everything looks yellow]) == 0)
		cli_execute("robyellowray.ash");
	// Get ready to adventure
	cli_execute("fold stinky cheese eye");
	use_familiar($familiar[Stocking Mimic]);
	// Buffs
	wobble($effect[Merry Smithsness], $item[Flaskfull of Hollow], 150);
	// Have fam, outfit, etc
	use_familiar($familiar[Stocking Mimic]);
	cli_execute("outfitFarming1.ash");
	//cli_execute("equip toyleporter");
	cli_execute("autoattack none");
	cli_execute("ccs farming");
	
	// Get early stuff done; CSA fire-starter kit & Bjorn familiar drops
 	adventure(45,$location[Sloppy seconds Diner]);
	cli_execute("outfitFarming2.ash");
	bjornify_familiar($familiar[Optimistic Candle]);
	adventure(15,$location[Sloppy seconds Diner]);
	bjornify_familiar($familiar[Spooky Pirate Skeleton]);
}

void main()
{
	diner();
}