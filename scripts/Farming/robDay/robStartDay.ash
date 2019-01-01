script "autoStartDay.ash";
//import <zlib.ash>
// _DayStart.ash
// Does beginning of day stuff that Mafia still doesn't do automatically

// Buy elemental wads if necessary
foreach it in $items[cold wad, hot wad, stench wad, sleaze wad, spooky wad, twinkly wad]
	if (item_amount(it) < 3)
	{
		int amountToBuy = 3 - item_amount(it);
		cli_execute("buy " + amountToBuy + " " + it);
	}
// Skills
if (have_skill($skill[Rainbow Gravitation]))
	use_skill(3,$skill[Rainbow Gravitation]);
if (have_skill($skill[Summon Annoyance]))
	use_skill($skill[Summon Annoyance]);
if (have_skill($skill[Canticle of Carboloading]))
	use_skill($skill[Canticle of Carboloading]);
if (have_skill($skill[Summon Carrot]))
	use_skill($skill[Summon Carrot]);
if (have_skill($skill[Summon Kokomo Resort Pass]))
	use_skill($skill[Summon Kokomo Resort Pass]);

// Sandwich
cli_execute("cast request sandwich");
cli_execute("cast request sandwich");
cli_execute("cast request sandwich");

// Set song
visit_url("inv_use.php?pwd=&pwd&which=3&whichitem=9919");
run_choice(5);

// Assorted whatevers
cli_execute("Make 3 potion of punctual companionship");
cli_execute("shower ice");
use(1,$item[BittyCar MeatCar]);
visit_url("campground.php?action=dnapotion");
visit_url("campground.php?action=dnapotion");
visit_url("campground.php?action=dnapotion");

// Hit Vivi with stuff
// if (item_amount($item[time's arrow]) == 0)
// buy(1,$item[time's arrow],20000);
// cli_execute("throw time's arrow at skf");
//cli_execute("/cast hug @ skf");

// Call default Mafia breakfast
cli_execute("breakfast");
visit_url("place.php?whichplace=chateau&action=chateau_desk2");

// Barrel god
visit_url("da.php?barrelshrine=1");
visit_url("choice.php?pwd&whichchoice=1100&option=4");

// Pick beer garden if at day 7
if (visit_url("campground.php").contains_text("beergarden7.gif"))
{
	cli_execute("garden pick");
	cli_execute("make artisanal homebrew gift package");
}

// 3 wishes
string wish = "I was rich"; //"More wishes"; //
int times = 0;
while (times < 3)
{
	visit_url("inv_use.php?whichitem=9529");
	visit_url("choice.php?whichchoice=1267&option=1&wish=" + wish);
	times+=1;
}

// Sea Jelly
use_familiar($familiar[Space Jellyfish]);
visit_url("place.php?whichplace=thesea&action=thesea_left2");
run_choice(1);

// Tea Tree
int rng = random(3);
if (rng == 0)
{
	cli_execute("teatree Voraci tea");
	put_closet(1,$item[Cuppa Voraci tea]);
}
else if (rng > 0)
{
	cli_execute("teatree Sobrie tea");
	put_closet(1,$item[Cuppa Sobrie tea]);
}
// Source Terminal
cli_execute("terminal extrude booze");
cli_execute("terminal extrude booze");
cli_execute("terminal extrude booze");

/* // Grab horse
visit_url("place.php?whichplace=town_right&action=town_horsery");
run_choice(2); */

// Draw 3 cards
cli_execute("cheat island; cheat recall; cheat mickey; autosell 1952 Mickey Mantle card");

// Cop bucks
cli_execute("Detective Solver.ash");

// Get funfunds from maintenance
if (item_amount($item[bag of park garbage]) == 0)
	buy(1,$item[bag of park garbage]);
visit_url("place.php?whichplace=airport_stench&action=airport3_tunnels");
visit_url("choice.php?pwd&option=6&whichchoice=1067");

// Splendid martinis
cli_execute("briefcase collect");

// Farfuture booze
cli_execute("Farfuture booze");
put_shop(0,0,$item[Shot of Kardashian Gin]);

if (item_amount($item[photocopied monster]) == 0)
{
	cli_execute("/whitelist generic clan name");
	cli_execute("fax get");
	cli_execute("/whitelist the clan of intelligent people");
	if (!visit_url("desc_item.php?whichitem=835898159").contains_text("Knob Goblin Embezzler"))
			cli_execute("faxbot Knob Goblin Embezzler");
}

// Use mumming trunk
use_familiar($familiar[stocking mimic]);
visit_url("inv_use.php?pwd&whichitem=9592");
run_choice(1);

// New crappy skills
use_skill(1,$skill[Acquire Rhinestones]);
use_skill(1,$skill[Love Mixology]);


// Stupid print screen button
if (mall_price($item[bacon]) < 500)
	cli_execute("create print screen button");
	
// Boxing Daycare
visit_url("place.php?whichplace=town_wrong&action=townwrong_boxingdaycare");
run_choice(1);
run_choice(2);
run_choice(3);
run_choice(4);

// Breakfast
cli_execute("breakfast");
cli_execute("use * ten-leaf clover");