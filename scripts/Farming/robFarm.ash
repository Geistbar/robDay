import <gbFun.ash>

/*******************************************************
*					Scriptwide Variables
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
float mpa; float days1; float days2;
float goal = 1000000000;
float mpaTotal;
int wins;
int fights;

/* -- Taken from zlib -- */
string rnum(int n) {
   return to_string(n,"%,d");
}
string rnum(float n, int place) {
   if (place < 1 || to_float(round(n)) == to_float(to_string(n,"%,."+place+"f"))) return rnum(round(n));
   return replace_all(create_matcher("0+$", to_string(n,"%,."+place+"f")),"");
}
string rnum(float n) { return rnum(n,2); }

/* -- Taken from zlib -- */
/*-----------------------------------------------------
*					Sub-Functions Start
/*----------------------------------------------------*/

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
	foreach it in invStopPvP
	{
		if (it == $item[buddy bjorn] || it == $item[half a purse])
			invStopPvP[it] = invStartPvP[it];
		if (invStopPvP[it] > invStartPvP[it])
		{
			itemGainPvP+=historical_price(it)*(invStopPvP[it]-invStartPvP[it]);
			if ((invStopPvP[it]-invStartPvP[it])*historical_price(it) > 10000)
				print("PvP Prize! : " + it + " @ " + rnum(historical_price(it)), "maroon");
		}
	}
	mpa = (meatStop - meatStart) / (advStop - advStart);
	mpaTotal = mpa + ((itemGain - itemLoss) / (advStop - advStart));
	
	days1 = (goal - meatStop) / (meatStop - meatStart);
	days2 = (goal - meatStop) / ((meatStop - meatStart)+(itemGain-itemLoss));
	// PvP Detail!
	string[int] logs = session_logs(1);
	string[int] lines = logs[0].split_string();
	foreach line in lines
	{
		if (contains_text(lines[line], "and won the PvP fight,"))
			wins+=1;
	}
}

void printOutput()
{
	dataProcess();
	
	// Print everything out
	print("-----------------"); // Formatting
	print("Total item expenses: " + rnum(itemLoss,2) + " meat", "red");
	print("Total item gain: " + rnum(itemGain,2) + " meat", "green");
	print("Total meat gained (base): " + rnum(meatStop - meatStart,2) + " meat", "navy");
	print("Total meat gained (+items): " + rnum((meatStop - meatStart)+itemGain-itemLoss,2) + " meat", "navy");
	print("Meat per adventure (base): " + rnum(mpa,2), "navy");
	print("Meat per adventure (+items): " + rnum(mpaTotal,2), "navy");
	print("Approximate days remaining to reach one billion meat: " + rnum(days2,2) + " to " + rnum(days1,2));
	print(""); // Formatting
	print("Total PvP item profits: " + rnum(itemGainPvP,2) + " meat", "maroon");
	print(""); // Formatting
	print("You won " + wins + " out of " + fights + " PvP fights!", "maroon");
}

/*-----------------------------------------------------
*					Functions Stop
/*----------------------------------------------------*/

void main()
{
	dataStart();
	
 	cli_execute("robstartday.ash");
	cli_execute("autovolcano.ash");
	cli_execute("nuns"); // Get mana  
	cli_execute("robSnojo.ash");
	//cli_execute("robBrickos.ash");
	cli_execute("robMachinetunnels.ash");
	cli_execute("robFreeBuffs.ash");
	cli_execute("robMP-LOVE.ash");
	cli_execute("robParty.ash");
	cli_execute("nuns"); // Get mana 
	cli_execute("robFreeRun.ash");
	cli_execute("robWitchess.ash");
	cli_execute("robGingerbread.ash");
	cli_execute("robFax.ash");
	cli_execute("robYellowRay.ash");
	cli_execute("robJelly.ash");
	cli_execute("Cast Bind Spaghetti Elemental");
	cli_execute("autoConspiracy.ash");
	cli_execute("nuns; cast Cannelloni Cocoon"); // Get mana
	cli_execute("robEldritch.ash");
	cli_execute("robDiner.ash");
	cli_execute("robEatDrink.ash");
	cli_execute("robBarf.ash");
	
	dataEnd();
	
	fights = pvp_attacks_left(); invStartPvP = get_inventory();
	cli_execute("robpvp.ash"); invStopPvP = get_inventory();
	
	cli_execute("robrollover.ash");
	
	printOutput();
}