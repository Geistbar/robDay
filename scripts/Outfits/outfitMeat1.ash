script "outfitswap.ash"
import <gbFun.ash>

/*******************************************************
*					outfitswap()
*	Swaps outfit piecemeal.
/*******************************************************/

item hat = 		$item[Lens of Hatred];
item weapon = 	$item[garbage sticker];
item offHand = 	$item[Half a Purse];
item shirt = 	$item[Sneaky Pete's leather jacket];
item back = 	$item[Buddy Bjorn];
item pants = 	$item[Pantsgiving];
item acc1 = 	$item[droll monocle];
item acc2 = 	$item[Uncle Hobo's belt];
item acc3 = 	$item[natty blue ascot];

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