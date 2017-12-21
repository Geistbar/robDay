# Distention / dog hair pills

void sdhp()
{
	visit_url("inv_use.php?pwd&whichitem=5172");
	run_choice(1); // Down the hatch
	run_choice(1); // drink
	run_choice(2); // that one door
	run_choice(2); // green girl (1) for smirk
}

void dp()
{
	visit_url("inv_use.php?pwd&whichitem=5172");
	run_choice(1); // Down the hatch
	run_choice(1); // drink
	run_choice(2); // that one door
	run_choice(1); // smirk (2) for green girl
}

void main()
{
	while (item_amount($item[Map to Safety Shelter Grimace Prime]) > 0)
	{
		dp();
		sdhp();
	}
}