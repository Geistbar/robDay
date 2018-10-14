script "robEatDrink.ash"
import <gbFun.ash>

/*******************************************************
*					robEatDrink()
*	Fills stomach, spleen, and liver with daily 
*	consumables.
/*******************************************************/

void eatDrink()
{
	equip($item[Brimstone Beret]);
	use_skill(2,$skill[The Ode to Booze]);
	getDrink(2,$item[splendid martini]); // Mime shotglass freebie + learning to drink
	getDrink(1,$item[Ambitious Turkey]);
	getDrink(3,$item[Broberry brogurt]);
	getDrink(1,$item[perfect cosmopolitan]);
	getDrink(1,$item[Dinsey Whinskey]);
	cli_execute("shrug ode");
	equip($item[crumpled felt fedora]);
	
	getChew(3,$item[grim fairy tale]);
	getChew(1,$item[prismatic wad]);
	cli_execute("synthesis meat");
	getUse(1,$item[chocolate pasta spoon]);
	
	getUse(2,$item[milk of magnesium]);
	eat(1,$item[spaghetti breakfast]);
	getEat(3,$item[jumping horseradish]);
	getEat(3,$item[Dinsey food-cone]);
	getEat(1,$item[Karma shawarma]);
	while ((fullness_limit() - my_fullness() > 4) && (get_property("_timeSpinnerMinutesUsed").to_int() < 8))
		cli_execute("timespinner eat karma shawarma");
	getEat((fullness_limit() - my_fullness() ) / 5,$item[Karma shawarma]);
}
void main()
{
	eatDrink();
}