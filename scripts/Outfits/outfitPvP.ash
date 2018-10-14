script "outfitswap.ash"
import <gbFun.ash>

/*******************************************************
*					outfitswap()
*	Swaps outfit piecemeal.
/*******************************************************/

item hat = 		$item[bounty-hunting helmet];
item weapon = 	$item[broken champagne bottle];
item offHand = 	$item[Spelunker's whip];
item shirt = 		$item[flaming pink shirt];
item back = 		$item[Camp Scout backpack];
item pants = 	$item[plexiglass pants];
item acc1 = 		$item[Red Balloon of Valor];
item acc2 = 		$item[Order of the Silver Wossname];
item acc3 = 		$item[Uranium Omega of Temperance];

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