script "robEatDrink.ash"

/*******************************************************
*					robEatDrink()
*	Fills stomach, spleen, and liver with daily 
*	consumables.
/*******************************************************/

/*******************************************************
*					getChew()
*	Retrieves & uses a specified quantity of a spleen item.
/*******************************************************/
void getChew(int qty, item it)
{
	int qtyNeeded = qty - item_amount(it);
	if (qtyNeeded > 0)
		cli_execute("Buy " + qtyNeeded + " " + it);
	chew(qty,it);
}
/*******************************************************
*					getDrink()
*	Retrives & drinks a specified quantity of a drink.
/*******************************************************/
void getDrink(int qty, item it)
{
	int qtyNeeded = qty - item_amount(it);
	if (it == $item[Broberry brogurt] && qtyNeeded > 0) // Don't mall these
		buy($coinmaster[The Frozen Brogurt Stand],qty,it);
	else if (it == $item[Dinsey Whinskey] && qtyNeeded > 0)
		buy($coinmaster[The Dinsey Company Store],qty,it);
	else if (qtyNeeded > 0)
		cli_execute("Buy " + qtyNeeded + " " + it);
	drink(qty,it);
}
/*******************************************************
*					getEat()
*	Retrives & eats a specified quantity of a food.
/*******************************************************/
void getEat(int qty, item it)
{
	int qtyNeeded = qty - item_amount(it);
	if (qtyNeeded > 0 && it == $item[Karma shawarma])
		buy($coinmaster[The SHAWARMA Initiative],qty,it);
	else if (qtyNeeded > 0 && it == $item[dinsey food-cone])
		buy($coinmaster[The Dinsey Company Store],qty,it);
	else if (qtyNeeded > 0)
		cli_execute("Buy " + qtyNeeded + " " + it);
	eat(qty,it);
}
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

void eatDrink()
{
	equip($item[Brimstone Beret]);
	use_skill(2,$skill[The Ode to Booze]);
	getDrink(1,$item[splendid martini]); // Mime shotglass freebie
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