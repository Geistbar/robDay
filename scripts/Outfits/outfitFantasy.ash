script "outfitswap.ash"
import <gbFun.ash>

/*******************************************************
*					outfitswap()
*	Swaps outfit piecemeal.
/*******************************************************/

item hat = 		$item[FantasyRealm Warrior's Helm];
item weapon = 	$item[LyleCo premium magnifying glass];
item offHand = 	$item[KoL Con 13 snowglobe];
item shirt = 	$item[sea salt scrubs];
item back = 	$item[protonic accelerator pack];
item pants = 	$item[Pantaloons of Hatred];
item acc1 = 	$item[LyleCo premium monocle];
item acc2 = 	$item[FantasyRealm G. E. M.];
item acc3 = 	$item[Mr. Screege's spectacles];

void main()
{
	equipIt(hat,$slot[hat], acc1, acc2, acc3);
	equipIt(weapon,$slot[weapon], acc1, acc2, acc3);
	equipIt(offHand,$slot[off-hand], acc1, acc2, acc3);
	equipIt(shirt,$slot[shirt], acc1, acc2, acc3);
	equipIt(back,$slot[back], acc1, acc2, acc3);
	equipIt(pants,$slot[pants], acc1, acc2, acc3);
	equipIt(acc1,$slot[acc1], acc1, acc2, acc3);
	equipIt(acc2,$slot[acc2], acc1, acc2, acc3);
	equipIt(acc3,$slot[acc3], acc1, acc2, acc3);
}