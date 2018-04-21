script "autoQuarters.ash"
#import <zlib.ash>

/*******************************************************
*	autoQuarters
*	r1
*
*	Cashes in the bullshit at the end of the island war.
/*******************************************************/

int war = 2; // Change to 1 if war was fought as a hippy
string garter = "bigisland.php?action=getgear&pwd&whichcamp=2&whichitem=2402&quantity=";
string stein = "bigisland.php?action=getgear&pwd&whichcamp=2&whichitem=2686&quantity=";
string poultice = "bigisland.php?action=getgear&pwd&whichcamp=1&whichitem=2369&quantity=";
string seashell = "bigisland.php?action=getgear&pwd&whichcamp=1&whichitem=2685&quantity=";

// Visits the cash-in url according to item id # and the amount of the item
void hippyCash(int id, int qty)
{
string url = "bigisland.php?action=turnin&pwd&whichcamp=2&whichitem=" + id + "&quantity=" + qty;
visit_url(url);
}

// Visits the cash-in url according to item id # and the amount of the item
void fratCash(int id, int qty)
{
string url = "bigisland.php?action=turnin&pwd&whichcamp=1&whichitem=" + id + "&quantity=" + qty;
visit_url(url);
}

// Counts how many Quarters you have, returns as an integer
int countQuarters()
{
	string txt = visit_url("bigisland.php?place=camp&whichcamp=2");
	txt = excise(txt,"You've got "," quarter");
	int num = txt.to_int();
	return num;
}

// Counts how many Dimes you have, returns as an integer
int countDimes()
{
	string txt = visit_url("bigisland.php?place=camp&whichcamp=1");
	txt = excise(txt,"You've got "," dime");
	int num = txt.to_int();
	return num;
}

void main()
{
	if (war == 1)
	{
		if (item_amount($item[red class ring]) > 0)
			hippyCash(2382,item_amount($item[red class ring]));
		if (item_amount($item[blue class ring]) > 0)
			hippyCash(2383,item_amount($item[blue class ring]));
		if (item_amount($item[white class ring]) > 0)
			hippyCash(2384,item_amount($item[white class ring]));
		if (item_amount($item[PADL Phone]) > 0)
			hippyCash(2065,item_amount($item[PADL Phone]));
			
		// Cash in dimes
		int dimes = countDimes();
		if (dimes % 5 == 0)
			visit_url(poultice + "5");
		if (dimes % 5 == 1)
			visit_url(poultice + "8");
		if (dimes % 5 == 2)
			visit_url(poultice + "6");
		if (dimes % 5 == 3)
			visit_url(poultice + "4");
		if (dimes % 5 == 4)
			visit_url(poultice + "7");
			
		// Buy seashells
		dimes = countDimes();
		string qty = (dimes / 5);
		visit_url(seashell + qty);
	}
	if (war == 2)
	{
		// Cash in garbage to get quarters
		if (item_amount($item[pink clay bead]) > 0)
			hippyCash(2358,item_amount($item[pink clay bead]));
		if (item_amount($item[purple clay bead]) > 0)
			hippyCash(2359,item_amount($item[purple clay bead]));
		if (item_amount($item[green clay bead]) > 0)
			hippyCash(2360,item_amount($item[green clay bead]));
		if (item_amount($item[communications windchimes]) > 0)
			hippyCash(2354,item_amount($item[communications windchimes]));
		
		// Cash in quarters
		int quarters = countQuarters();
		if (quarters % 5 == 0)
			visit_url(garter + "5");
		if (quarters % 5 == 1)
			visit_url(garter + "8");
		if (quarters % 5 == 2)
			visit_url(garter + "6");
		if (quarters % 5 == 3)
			visit_url(garter + "4");
		if (quarters % 5 == 4)
			visit_url(garter + "7");
			
		// Buy steins
		quarters = countQuarters();
		string qty = (quarters / 5);
		visit_url(stein + qty);
	}
}