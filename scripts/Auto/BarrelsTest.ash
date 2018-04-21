script "Test.ash"

boolean[item] barrels = $items[little firkin, normal barrel, big tun, weathered barrel, dusty barrel, disintegrating barrel, moist barrel, rotting barrel, mouldering barrel, barnacled barrel];
boolean[item] rares = $items[bottle of Amontillado, barrel-aged martini, barrel gun, barrel cracker, barrel pickle, tiny barrel, cute mushroom, vibrating mushroom, barrel beryl, water log];
boolean[item] allit = $items[barrel-aged martini,gibson,gin and tonic,mimosette,tequila sunset,vodka and tonic,zmobie,a little sump'm sump'm,barrel gun,pink pony,rockin' wagon,roll in the hay,slip 'n' slide,slap and tickle,martini,screwdriver,strawberry daiquiri,margarita,vodka martini,tequila sunrise,bottle of Amontillado,barrel beryl,cast,concentrated magicalness pill,enchanted barbell,giant moxie weed,Mountain Stream soda,Doc Galaktik's Ailment Ointment,extra-strength strongness elixir,jug-o-magicalness,Marquis de Poivre soda,suntan lotion of moxiousness,creepy ginger ale,cute mushroom,haunted battery,scroll of drastic healing,synthetic marrow,the funk,vibrating mushroom,barrel cracker,bean burrito,enchanted bean burrito,jumping bean burrito,spicy bean burrito,spicy enchanted bean burrito,spicy jumping bean burrito,tiny barrel,insanely spicy bean burrito,insanely spicy enchanted bean burrito,insanely spicy jumping bean burrito,banana,barrel pickle,Alewife&trade; Ale,bazookafish bubble gum,beefy fish meat,eel battery,glistening fish meat,ink bladder,pufferfish spine,shark cartilage,slick fish meat,slug of rum,slug of shochu,slug of vodka,temporary teardrop tattoo,water log];
/*******************************************************
*					barrelSum()
*	Returns the total number of barrels you have.
/*******************************************************/
int barrelSum()
{
	int sum;
	foreach barrel in barrels
		sum += item_amount(barrel);
	return sum;
}

/*******************************************************
*					findNonZero()
*	Returns a barrel that you have more than zero of.
/*******************************************************/
item findNonZero()
{
	foreach barrel in barrels
		if (item_amount(barrel) > 0)
			return barrel;
	return $item[normal barrel];
}

void main()
{
	int[item] invStart = get_inventory();	// For data purposes
	int sum = barrelSum();
	int smashTotal = barrelSum();
	item bar;
	int as;
	bar = findNonZero();
	int id = to_int(bar);
	visit_url("inv_use.php?pwd&whichitem=" + to_string(id) + "&choice=1");	// Start party
	while (sum >= 100)
	{
		visit_url("choice.php?pwd&whichchoice=1101&option=2");
		sum += -100;
	}
	int[item] invStop = get_inventory();	// For data purposes
	// Output
	foreach it in allit
		as+=autosell_price(it) * (invStop[it] - invStart[it]);
	foreach rare in rares
	{
		if(invStop[rare] > invStart[rare])
			print("You gained: " + (invStop[rare] - invStart[rare]) + " " + rare, "green");
	}
	print("Autosell value of all items from smashing: " + as,"blue");
	print("You smashed: " + smashTotal + " barrels","blue");
}