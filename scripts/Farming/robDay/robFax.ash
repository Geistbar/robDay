script "robFax.ash"

/*******************************************************
*					robFax()
*	
/*******************************************************/

void fax()
{
	//visit_url("place.php?whichplace=chateau&action=chateau_painting"); run_combat();
	
	// Change setup
	cli_execute("autoattack Copy2");
	use(1,$item[Rain-Doh box full of monster]);
	use(1,$item[Rain-Doh box full of monster]);
	use(1,$item[Rain-Doh box full of monster]);
	use(1,$item[Rain-Doh box full of monster]);
	cli_execute("autoattack Farming");
	use(1,$item[Rain-Doh box full of monster]);
	use(1,$item[Spooky Putty monster]);
	//use(1,$item[photocopied monster]);
}

void main()
{
	fax();
}