script "outfitswap.ash"
import <gbFun.ash>

/*******************************************************
*					outfitswap()
*	Swaps outfit piecemeal.
/*******************************************************/

item hat = 		$item[crumpled felt fedora];
item weapon = 	$item[Thor's Pliers];
item offHand = 	$item[tiny black hole];
item shirt = 	$item[Sneaky Pete's leather jacket];
item back = 	$item[Buddy Bjorn];
item pants = 	$item[wooly loincloth];
item acc1 = 	$item[Quiets-Your-Steps];
item acc2 = 	$item[sticky gloves];
item acc3 = 	$item[Lord Soggyraven's Slippers];

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