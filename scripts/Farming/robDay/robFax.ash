script "robFax.ash"

/*******************************************************
*					robFax()
*	
/*******************************************************/

void fax(familiar f)
{
	use_familiar(f);
	cli_execute("outfit meat2");
	cli_execute("autoattack Copy2");
	
	visit_url("place.php?whichplace=chateau&action=chateau_painting"); 
	run_combat();
	
	use(1,$item[Rain-Doh box full of monster]);
	use(1,$item[Rain-Doh box full of monster]);
	use(1,$item[Rain-Doh box full of monster]);
	use(1,$item[Rain-Doh box full of monster]);
	
	cli_execute("autoattack Farming");
	use(1,$item[Rain-Doh box full of monster]);
	use(1,$item[Spooky Putty monster]);
	use(1,$item[photocopied monster]);
	
}

void main()
{
	familiar fam = $familiar[Hobo Monkey];
	fax(fam);
}