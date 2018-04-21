script "HalloweenFarming.ash"

/*******************************************************
*	HalloweenFarming.ash
*
*	Farms halloween.
/*******************************************************/

int[item] invStart;
float meatStart;
float advStart;
int[item] invStop;
float meatStop;
float advStop;
int[item] invStartPvP;
int[item] invStopPvP;
float itemGain = 0;
float itemLoss = 0;
int itemGainPvP = 0;
float mpa;
float mpaTotal;
int wins;
int fights;
boolean spiderFought = FALSE;

/* -- Taken from zlib -- */
string rnum(int n) {
   return to_string(n,"%,d");
}
string rnum(float n, int place) {
   if (place < 1 || to_float(round(n)) == to_float(to_string(n,"%,."+place+"f"))) return rnum(round(n));
   return replace_all(create_matcher("0+$", to_string(n,"%,."+place+"f")),"");
}
string rnum(float n) { return rnum(n,2); }

/*******************************************************
*					Functions Start
/*******************************************************/

/*******************************************************
*					dataStart()
*	Stores basic inventory and meat data for calculating
*	meat per adventure. For use at start of day.
/*******************************************************/
void dataStart()
{
	invStart = get_inventory();
	foreach eqSlot in $slots[acc1, acc2, acc3, off-hand, weapon, hat, pants, back, shirt]
		invStart[equipped_item(eqSlot)]+=1;
	meatStart = my_meat();
	advStart = my_turncount();
}

/*******************************************************
*					dataEnd()
*	Stores basic inventory and meat data for calculating
*	meat per adventure. For use at end of day.
/*******************************************************/
void dataEnd()
{
	meatStop = my_meat();
	advStop = my_turncount();
	invStop = get_inventory();
	foreach eqSlot in $slots[acc1, acc2, acc3, off-hand, weapon, hat, pants, back, shirt]
		invStop[equipped_item(eqSlot)]+=1;
}

/*******************************************************
*					dataProcess()
*	Processes the stored data from dataStart and dataEnd
*	along with two PvP variables in order to calculate
*	daily profit.
/*******************************************************/
void dataProcess()
{
	print(""); // Formatting
	foreach it in invStop
	{
		int price = historical_price(it);
		int minPrice = max(100, autosell_price(it) * 2);
		if (!(price > minPrice))
			price = autosell_price(it);
		if (it == $item[stinky cheese eye])
			invStop[it] = invStart[it];
		if (invStop[it] > invStart[it])
			itemGain += price*(invStop[it]-invStart[it]);
		if (invStop[it] < invStart[it])
			itemLoss += price*(invStop[it]-invStart[it])*-1;
		if (historical_price(it)*(invStop[it]-invStart[it]) > 100000)
			print("Expensive item: " + (invStop[it]-invStart[it]) + " " + it, "purple");
		if (historical_price(it)*(invStart[it]-invStop[it]) > 100000)
			print("Expensive item lost: " + (invStart[it]-invStop[it]) + " " + it, "purple");
	}
	mpa = (meatStop - meatStart) / (advStop - advStart);
	mpaTotal = mpa + ((itemGain - itemLoss) / (advStop - advStart));
}

/*******************************************************
*					Functions Stop
/*******************************************************/

void main()
{
	dataStart();

	/*******************************************************
	*	Actual Halloween Stuff
	/*******************************************************/
	while (my_adventures() >= 5)
	{
		/* if (have_effect($effect[everything looks yellow]) == 0)
			cli_execute("robyellowray.ash"); */
		if ((have_effect($effect[vampin']) > 5))
			cli_execute("tricktreat.ash (1)");
		else
		{
			visit_url("place.php?whichplace=town&action=town_trickortreat");
			visit_url("choice.php?pwd&option=1&whichchoice=804");
			use(1,$item[bite-me-red lipstick]);
		}
	}
	
	/*******************************************************
	*	Assorted item maintenance
	/*******************************************************/
	dataEnd();
	dataProcess();
	
	// Print everything out
	print(""); // Formatting
	print("Total item expenses: " + rnum(itemLoss,2) + " meat","red");
	print("Total item gain: " + rnum(itemGain,2) + " meat","green");
	print("Total meat gained (base): " + rnum(meatStop - meatStart,2) + " meat","navy");
	print("Total meat gained (items): " + rnum((meatStop - meatStart)+itemGain-itemLoss,2) + " meat","navy");
	print("Meat per adventure (base): " + rnum(mpa,2),"navy");
	print("Meat per adventure (items): " + rnum(mpaTotal,2),"navy");
}