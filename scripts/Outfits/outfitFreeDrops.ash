script "outfitswap.ash"
import <gbFun.ash>

/*******************************************************
*					outfitswap()
*	Swaps outfit piecemeal.
/*******************************************************/

item hat = 		$item[Hodgman's porkpie hat];
item weapon = 	$item[Spelunker's whip];
item offHand = 	$item[KoL Con 13 snowglobe];
item shirt = 	$item[Stephen's lab coat];
item back = 	$item[Buddy Bjorn];
item pants = 	$item[Hodgman's lobsterskin pants];
item acc1 = 	$item[Mr. Cheeng's spectacles];
item acc2 = 	$item[Mr. Screege's spectacles];
item acc3 = 	$item[Hodgman's bow tie];

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