script "Test.ash"

void main()
{
	// Boxing Daycare
	visit_url("place.php?whichplace=town_wrong&action=townwrong_boxingdaycare");
	run_choice(1);
	run_choice(2);
	run_choice(3);
	run_choice(4);
}