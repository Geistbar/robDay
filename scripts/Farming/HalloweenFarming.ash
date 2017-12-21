script "farmingHalloween.ash"
import <zlib.ash>

/*******************************************************
*	farmingHalloween.ash
*	version r2
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

/*******************************************************
*					Functions Start
/*******************************************************/

/*******************************************************
*					yellowRay()
*	Does a yellow ray at the inner wolf gym. If no
*	adventures are consumed, the function assumes
*	that this means the end of skid row has been reached
*	and thus uses a new grimstone mask and calls itself
*	again.
/*******************************************************/
void yellowRay()
{
	// Check to see if you reached the end of the gym
	if (contains_text(visit_url("questlog.php?which=1"),"Time Left: 3")) 
	{
		visit_url("inv_use.php?pwd&whichitem=7061");
		visit_url("choice.php?pwd&option=2&whichchoice=829");
	}
	cli_execute("autoattack yellowRay");
	use_familiar($familiar[He-Boulder]);
	adventure(1,$location[The Inner Wolf Gym]);
}

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
		if ((invStop[it] > invStart[it]) && (it == $item[rubber nubbin]))
			spiderFought = TRUE;
		if ((invStop[it] < invStart[it]) && (it == $item[ChibiBuddy&trade; (on)]))
			invStop[it]+=1;	// Script doesn't handle chibi buddies well
		if ((invStop[it] < invStart[it]) && (it == $item[ChibiBuddy&trade; (off)]))
			invStop[it]+=1;	// Script doesn't handle chibi buddies well
		if (invStop[it] > invStart[it])
			itemGain += historical_price(it)*(invStop[it]-invStart[it]);
		if (invStop[it] < invStart[it])
			itemLoss += historical_price(it)*(invStop[it]-invStart[it])*-1;
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
			yellowRay(); */
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
	print(""); // Formatting
	print("Total PvP item profits: " + rnum(itemGainPvP,2) + " meat", "maroon");
	print(""); // Formatting
	print("You won " + wins + " out of " + fights + " PvP fights!", "maroon");
}