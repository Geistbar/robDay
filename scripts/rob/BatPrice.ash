script "BatPrice.ash"
import <zlib.ash>

boolean[item] rewards = $items[Kudzu salad,Mansquito Serum,Miss Graves' vermouth,The Plumber's mushroom stew,The Author's ink,The Mad Liquor,Doc Clock's thyme cocktail,Mr. Burnsger,The Inquisitor's unidentifiable object];


void main()
{
	foreach it in rewards
		print(it + ": " + mall_price(it),"blue");
}