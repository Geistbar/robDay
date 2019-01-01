script "Investments"
/* -- Taken from zlib -- */
string rnum(int n) {
   return to_string(n,"%,d");
}

boolean[item] investmentIOTM = $items[January's Garbage Tote (unopened),Pok&eacute;fam Guide to Capturing All of Them,FantasyRealm membership packet,God Lobster Egg,SongBoom&trade; BoomBox Box,kitten burglar,Bastille Battalion control rig crate,Neverending Party invitation envelope,latte lovers club card,voter registration form, boxing day care package];

boolean[item] investmentOther = $items[The Journal of Mime Science Vol. 1,The Journal of Mime Science Vol. 2,The Journal of Mime Science Vol. 3,The Journal of Mime Science Vol. 4,The Journal of Mime Science Vol. 5,The Journal of Mime Science Vol. 6];


void main()
{
	int profit; int total;
	mall_price($item[mr. accessory]);
	foreach it in investmentIOTM
		mall_price(it);
	foreach it in investmentOther
		mall_price(it);
	print("---");
	print("Mr. A: " + rnum(mall_price($item[mr. accessory])),"red");
	print("---");
	foreach it in investmentIOTM
	{
		print(it + ": " + rnum(mall_price(it)) + " | (Total: " + item_amount(it) + ")" + " — Profit: " + rnum(((mall_price(it) - mall_price($item[mr. accessory]))*item_amount(it))),"blue");
		profit+=((mall_price(it) - mall_price($item[mr. accessory]))*item_amount(it));
		total+=(mall_price(it)*item_amount(it));
	}
	print("Total profit: " + rnum(profit),"green");
	print("---");
	foreach it in investmentOther
	{
		print(it + ": " + rnum(mall_price(it)) + " | (Total: " + item_amount(it) + ")","blue");
		total+=(mall_price(it)*item_amount(it));
	}
	print("Total: " + rnum(total),"Green");
}