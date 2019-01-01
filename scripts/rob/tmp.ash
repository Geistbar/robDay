script "tmp.ash"
/* -- Taken from zlib -- */
string rnum(int n) {
   return to_string(n,"%,d");
}

boolean[item] investments = $items[rethinking candy,Bastille Battalion control rig crate,FantasyRealm membership packet,God Lobster Egg,January's Garbage Tote (unopened),kitten burglar,latte lovers club card,Neverending Party invitation envelope,Pok&eacute;fam Guide to Capturing All of Them,SongBoom&trade; BoomBox Box,The Journal of Mime Science Vol. 1,The Journal of Mime Science Vol. 2,The Journal of Mime Science Vol. 3,The Journal of Mime Science Vol. 4,The Journal of Mime Science Vol. 5,The Journal of Mime Science Vol. 6,voter registration form ];


void main()
{
		mall_price($item[mr. accessory]);
	foreach it in investments
		mall_price(it);
	print("---");
	print("Mr. A: " + rnum(mall_price($item[mr. accessory])),"red");
	print("---");
	foreach it in investments
		print(it + ": " + rnum(mall_price(it)) + " | (Total: " + item_amount(it) + ")","blue");
}