// Automate trick-or-treating.
//
// CLI: tricktreat [number of blocks]
// "tricktreat outfits" lists the (profitable) candies you can get with the outfits you own, sorted by price.
//
// If you have outfits called "trick" and "treat" they will be used for combats and noncombats, respectively
// (so that you can, say, maximize item for combats and switch to an outfit for candies).
//
// If you have one called "newblock" it will be worn when scoping a new block (to restore MP/HP).

script "tricktreat.ash";
notify guyy;

void main(string blocks)
{
	int numblocks;

	if (contains_text(blocks.to_lower_case(),"outfits"))
	{
		string stuff = visit_url("http://kol.coldfront.net/thekolwiki/index.php/Trick_or_Treat!/Outfits");
	
		matcher data = create_matcher("Item Drops:</b> <a href=[^>]*>([^<]*?)</a>.*?</li>[^<]*<li><i>Note:</i> Only occurs [^>]*>([^<]*?)</a>", stuff);

		string[float] prices;

		while (find(data))
		{
			item ahtem = to_item(group(data,1));
			if (ahtem != $item[none] && have_outfit(group(data,2)))
			{
				float pricey = mall_price(ahtem);
				if (pricey > 100 && pricey > 2*autosell_price(ahtem))
				{
					float adj = 0.0;
					while (prices[pricey+adj] != "")
						adj += 0.01;
					pricey += adj;
					prices[pricey] = "<a href=\"http://kol.coldfront.net/newmarket/itemgraph.php?itemid="+ahtem.to_int()+"&"+"timespan=1"+"&"+"noanim=0"+"\">" + ahtem.to_string() + "</a> (" + group(data,2) + ((group(data,2)=="Cold Comforts")?" + Russian Ice":"") + ")";
				}
			}
		}
			
		sort prices by index;

		foreach value, fit in prices
			print_html(value.to_int()+" meat -- "+fit);
			
		print("WARNING: Many candies are rarely actually bought, regardless of mall price. Check Coldfront's sales graphs (linked above) to avoid farming up something that won't sell.","red");
			
		return;
	}
	else
	{
		numblocks = blocks.to_int();
		if (numblocks <= 0)
			abort("That's not a valid number of blocks!");
	}

	string advstring;
	boolean outfitted = false;
	boolean blocked = false;
	string bbs = get_property("betweenBattleScript");
	int[string] totalcandies;
	boolean[string] is_candy;
	
	string trick_page()
	{
		return visit_url("place.php?whichplace=town&action=town_trickortreat");
	}
	
	void trick_exit()
	{
		// not actually necessary, but makes Mafia realize it isn't stuck in a choice adventure
		visit_url("choice.php?whichchoice=804&pwd="+my_hash()+"&option=2");
	}
	
	void stahp(string msg)
	{
		trick_exit();
		if (outfitted || blocked)
			outfit("Backup");
		if (msg != "")
			abort(msg);
	}

	void post_combat_junk()
	{
		cli_execute("mood execute");
		//cli_execute("burn extra");   // for mimic farming, apparently
		if (bbs != "")
			cli_execute("call "+bbs);
		restore_hp(0);
		restore_mp(0);
	}
	
	// from Bale's treating-script
	string get_monster(string page) 
	{
		matcher mob = create_matcher("<span id='monname'>([^<]+)</span>", page);
		if(mob.find())
			return mob.group(1);
		return "";
	}
	
	void do_house(int i)
	{
		if (advstring.contains_text("whichhouse="+i+">"))
		{
			advstring = visit_url("choice.php?whichchoice=804&pwd="+my_hash()+"&option=3&whichhouse="+i);
			
			if (advstring.contains_text("You can't go Trick-or-Treating without a costume!"))
				stahp("You need a costume to trick-or-treat! Any normal outfit (Bugbear Costume, Mining Gear, etc.) counts as a costume."+((outfitted)?" Make sure your \"trick\" and \"treat\" outfits have costumes.":""));
			
			string kandykolor = "green";
			boolean revisit_block = true;
			int[item] candies;
			if (advstring.contains_text("A Fun-Size Dilemma"))
			{
				advstring = visit_url("choice.php?whichchoice=806&pwd="+my_hash()+"&option=2");
				print("House #"+(i+1)+" is the star house! Grabbed huge candy bowl.","blue");
				totalcandies["huge bowl of candy"] += 1;
			}
			else if (advstring.contains_text("You're fighting"))
			{
				if (advstring.contains_text("paulblart.gif") || advstring.contains_text("tooold.gif") || advstring.contains_text("vandalkid.gif"))
				{
					kandykolor = "orange";
					print("Battle! House #"+(i+1)+" contains "+get_monster(advstring)+".","orange");
					advstring = run_combat();
					post_combat_junk();
					if (contains_text(advstring,"You lose. You slink away, dejected and defeated."))
						print("You're getting beaten up! Maybe you should change your CCS?");
					else
						candies = extract_items(advstring);
				}
				else
				{
					if (advstring.contains_text("All-Hallow's Steve"))
						abort("Encountered Steve, the hallowed boss! You'd better fight this guy yourself.");
					else
						abort("Unidentified monster!");
				}
			}
			else
			{
				revisit_block = false;
				candies = extract_items(advstring);
			}
			foreach c in candies
			{
				totalcandies[c.to_string()] += candies[c];
				print("Looted "+((candies[c]!=1)?candies[c].to_string()+" ":"")+c+" from house #"+(i+1)+".",kandykolor);
				if (!revisit_block)
					is_candy[c.to_string()] = true;
			}
			if (revisit_block)
				advstring = trick_page();
		}
		else
			print("House #"+(i+1)+" has already been looted.","green");
	}
	
	//cli_execute("outfit save Backup");
	
	advstring = trick_page();
	trick_exit();
	if (!advstring.contains_text("tt_background.gif"))
		stahp("Can't get to the trick-or-treating area. Check the relay browser to make sure you can get there, and that it's actually Halloween.");
		
	int maxblox = (my_adventures()/5).to_int();
	if (advstring.contains_text("whichhouse="))
		maxblox += 1;
	if (maxblox == 0)
		stahp("Current block is empty, and you don't have enough adventures to go to the next one.");
	if (numblocks > maxblox)
		numblocks = maxblox;
	
	if (count(outfit_pieces("trick")) > 0 && count(outfit_pieces("treat")) > 0)
	{
		if (outfit("trick") && outfit("treat"))
			outfitted = true;
		else
			stahp("One of your trick/treat outfits failed to equip!");
		print("Wearing trick outfit for combats, and treat for noncombats.","blue");
	}
	
	if (count(outfit_pieces("newblock")) > 0)
	{
		if (outfit("newblock"))
			blocked = true;
		else
			stahp("You newblock outfit failed to equip!");
		if (!outfitted)
			outfit("Backup");
		print("Wearing newblock outfit for scoping blocks.","blue");
	}
		
	post_combat_junk();
	advstring = trick_page();
	
	if (get_property("tricktreatLitFam") == "")
		set_property("tricktreatLitFam","Trick-or-Treating Tot");
	
	for blok from 1 to numblocks
	{
		print("Trick-or-treating on block "+blok+" of "+numblocks+".","blue");
		//wait(3);
		
		if (!advstring.contains_text("whichhouse="))
		{
			if (blocked)
			{
				trick_exit();
				outfit("newblock");
				advstring = trick_page();
			}
			if (my_adventures() >= 5)
				advstring = visit_url("choice.php?whichchoice=804&pwd="+my_hash()+"&option=1");  //&confirm=true to skip an unfinished block
			else
				stahp("Not enough adventures to go to the next block.");
			if (blocked && !outfitted)
			{
				trick_exit();
				outfit("Backup");
				post_combat_junk();
				advstring = trick_page();
			}
		}
		
		matcher housematch;
		trick_exit();
		if (outfitted)
			outfit("trick");
		post_combat_junk();
		advstring = trick_page();
		for i from 0 to 11
		{
			housematch = create_matcher("whichhouse="+i+">[^>]*?house_d", advstring);
			if (find(housematch))
				do_house(i);
		}
		trick_exit();
		if (outfitted)
			outfit("treat");
		familiar treatfam = get_property("tricktreatLitFam").to_familiar();
		familiar trickfam = my_familiar();
		if (get_property("tricktreatLitFam").to_lower_case() != "none" && treatfam != $familiar[none] && have_familiar(treatfam) && trickfam != treatfam)
			use_familiar(treatfam);
		advstring = trick_page();
		for i from 0 to 11
			if (advstring.contains_text("whichhouse="+i+">"))
				do_house(i);
		if (trickfam != treatfam)
			use_familiar(trickfam);
	}
	
	string kolor;
	string candylist;
	foreach c in totalcandies
	{
		if (c == "huge bowl of candy")
			kolor = "blue";
		else if (is_candy[c])
			kolor = "green";
		else
			kolor = "orange";
		candylist += "<br><span style='color:"+kolor+";'>" + c + "</span> -- " + totalcandies[c];
	}
	print_html("<br><br><span style='color:blue;'>Done!</span> <span style='color:green;'>Candies</span> and <span style='color:orange;'>drops</span> collected:<br>"+candylist);
	stahp("");
}