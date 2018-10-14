script "gbFun.ash"

/*******************************************************
*					gbFun
*	Has functions I use over and over again.
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
*					wobble()
*	Gets a specified buff from a specified item. 
*	Optimizes for your current turns and turns remaining
*	of the buff if you have it already.
/*******************************************************/
void wobble(effect buff, item source, int turns)
{
	int effectTurns = my_adventures() - have_effect(buff);
	getUse(effectTurns/turns + 1, source);
}

/*******************************************************
*					accessoryCheck(item it, slot s)
*	Performs a check to ensure that an accessory is 
*	equipped without failure with equipIt(), while also
*	allowing multi-used accessories to work.
/*******************************************************/
void accessoryCheck(item it, slot s, item acc1, item acc2, item acc3)
{
	if (s == $slot[acc1])
	{
		if ((equipped_item($slot[acc2]) == it) && acc2 != it)
			equip($slot[acc2],$item[none]);
		if ((equipped_item($slot[acc3]) == it) && acc3 != it)
			equip($slot[acc3],$item[none]);
	}
	if (s == $slot[acc2])
	{
		if ((equipped_item($slot[acc1]) == it) && acc1 != it)
			equip($slot[acc1],$item[none]);
		if ((equipped_item($slot[acc3]) == it) && acc3 != it)
			equip($slot[acc3],$item[none]);
	}
	if (s == $slot[acc3])
	{
		if ((equipped_item($slot[acc1]) == it) && acc1 != it)
			equip($slot[acc1],$item[none]);
		if ((equipped_item($slot[acc2]) == it) && acc2 != it)
			equip($slot[acc2],$item[none]);
	}
}

/*******************************************************
*					equipIt(item it, slot s)
*	Equips a specific item after making various checks
*	to ensure it is equipped properly.
/*******************************************************/
void equipIt(item it, slot s, item acc1, item acc2, item acc3)
{
	if (equipped_item(s) == it)
		return;
	if (s == $slot[acc1] || s == $slot[acc2] || s == $slot[acc3])
		accessoryCheck(it, s, acc1, acc2, acc3);
	if (it != $item[none])
	{
		if (item_amount(it) == 0)
			take_closet(1,it);
		equip(s,it);
	}
}