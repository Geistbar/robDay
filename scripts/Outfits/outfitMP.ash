script "outfitswap.ash"
import <gbFun.ash>

/*******************************************************
*					outfitswap()
*	Swaps outfit piecemeal.
/*******************************************************/

item hat = 		$item[feathered headdress];
item weapon = 	$item[Hand that Rocks the Ladle];
item offHand = 	$item[Hand that Rocks the Ladle];
item shirt = 	$item[sea salt scrubs];
item back = 	$item[sea shawl];
item pants = 	$item[Hodgman's lobsterskin pants];
item acc1 = 	$item[Brimstone Bracelet];
item acc2 = 	$item[Brimstone Brooch];
item acc3 = 	$item[Talisman of Baio];

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