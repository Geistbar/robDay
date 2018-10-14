script "outfitswap.ash"
import <gbFun.ash>

/*******************************************************
*					outfitswap()
*	Swaps outfit piecemeal.
/*******************************************************/

item hat = 		$item[];
item weapon = 	$item[];
item offHand = 	$item[];
item shirt = 	$item[];
item back = 	$item[];
item pants = 	$item[];
item acc1 = 	$item[];
item acc2 = 	$item[];
item acc3 = 	$item[];

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