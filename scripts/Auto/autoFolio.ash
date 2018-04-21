script "autoFolio.ash"
notify Giestbar;

/*******************************************************
*	autoFolio
*	r7
*
*	Completes the folio quest using predefined CCS and 
*	outfits. Leaves the final boss to the user to defeat.
/*******************************************************/

/*******************************************************
*	User defined settings. Leave blank to have mafia 
*	not change your gear, CCS, or autoattack.
*
*	disCCS: The CCS used while adventuring. This needs
*	to be able to handle the zone bosses.
*
*	disAutoattack: The autoattack used for non-bosses. 
*	optional so long as your CCS can handle the zones.
*
*	disFamiliar: The familiar to take with you. Optional.
*
*	disOutfit: The outfit to wear while completing the 
*	quest. Optional.
*
*	ignoreOutfit: If set to TRUE, instead of using the
*	outfit listed in disOutfit, the script will use
*	the CLI with "maximize -combat, -tie" to set an 
*	outfit for you.
/*******************************************************/
string disCCS = "";
string disAutoattack = "";
string disFamiliar = "";
string disOutfit = "";
boolean ignoreOutfit = FALSE;
/*******************************************************
*					END USER SETTINGS
/*******************************************************/

/*******************************************************
*					disBuffs()
*	Ensures you have enough turns of all the requisite 
*	buffs.
/*******************************************************/
void disBuffs()
{
	if (have_effect($effect[Dis Abled]) == 0)
		use(1,$item[Devilish folio]);
	if (have_effect($effect[Smooth Movements]) < have_effect($effect[Dis Abled]))
		use_skill(3,$skill[Smooth Movement]);
	if (have_effect($effect[The Sonata of Sneakiness]) < have_effect($effect[Dis Abled]))
		use_skill(3,$skill[The Sonata of Sneakiness]);
}

void main()
{
	// Get geared up
	cli_execute("ccs " + disCCS);
	cli_execute("autoattack " + disAutoattack);
	cli_execute("familiar " + disFamiliar);
	if (ignoreOutfit)
		cli_execute("maximize -combat, -tie");
	else
		cli_execute("outfit " + disOutfit);
	if (equipped_item($slot[back]) == $item[Buddy Bjorn] && have_familiar($familiar[Grimstone Golem]))
		bjornify_familiar($familiar[Grimstone Golem]);
	cli_execute("swim sprints");
	int jar = item_amount($item[psychoanalytic jar]);	// For SKF
	
	// Double-check item amounts
	foreach it in $items[dangerous jerkcicle, clumsiness bark, jar full of wind]
		if (item_amount(it) < 20)
		{
			int amountToBuy = 20 - item_amount(it);
			cli_execute("buy " + amountToBuy + " " + it);
		}
	
	// Go to each zone and get the stones
	while (item_amount($item[furious stone]) == 0 || item_amount($item[vanity stone]) == 0)
	{
		disBuffs();
		adventure(1,$location[The Clumsiness Grove]);
	}
	while (item_amount($item[jealousy stone]) == 0 || item_amount($item[lecherous stone]) == 0)
	{
		disBuffs();
		adventure(1,$location[The Maelstrom of Lovers]);
	}
	while (item_amount($item[gluttonous stone]) == 0 || item_amount($item[avarice stone]) == 0)
	{
		disBuffs();
		adventure(1,$location[The Glacier of Jerks]);
	}
	
	// Return state
	cli_execute("ccs default");
	if (item_amount($item[psychoanalytic jar]) > jar)
		print("You gained a psychoanalytic jar while in Dis.","green");
}