script "autoStartDay.ash";
import <zlib.ash>
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

// Assorted whatevers
cli_execute("Make 3 potion of punctual companionship");
cli_execute("shower ice");
use(1,$item[BittyCar MeatCar]);
visit_url("campground.php?action=dnapotion");
visit_url("campground.php?action=dnapotion");
visit_url("campground.php?action=dnapotion");

// Hit Vivi with stuff
/* if (item_amount($item[time's arrow]) == 0)
	buy(1,$item[time's arrow],20000);
cli_execute("throw time's arrow at skf"); */
cli_execute("/cast hug @ skf");

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
/* if (get_campground()[$item[fancy beer label]] == 6)
	cli_execute("garden pick"); */

// Tea Tree
cli_execute("teatree royal");
put_closet(1,$item[cuppa royal tea]);

// Source Terminal
cli_execute("terminal extrude food");
cli_execute("terminal extrude food");
cli_execute("terminal extrude food");

// Draw 3 cards
cli_execute("cheat island; cheat recall; cheat mickey; autosell 1952 Mickey Mantle card");

// Cop bucks
cli_execute("Detective Solver.ash");

// Get funfunds from maintenance
if (item_amount($item[bag of park garbage]) == 0)
	buy(1,$item[bag of park garbage]);
visit_url("place.php?whichplace=airport_stench&action=airport3_tunnels");
visit_url("choice.php?pwd&option=6&whichchoice=1067");