script "autoMoon.ash"

/*******************************************************
*	autoMoon.ash
*	r1
*
*	Uses the four moon maps to get the spooky little girl
*	for the quest "Repair the Elves' Shield Generator."
/*******************************************************/

void getHarness()
{
	visit_url("inv_use.php?pwd&whichitem=5172");			// Safety shelter Grimace prime
	visit_url("choice.php?pwd&option=1&whichchoice=536");	// Down the hatch
	visit_url("choice.php?pwd&option=2&whichchoice=536");	// Coat check
	visit_url("choice.php?pwd&option=1&whichchoice=536");	// Stage left
	visit_url("choice.php?pwd&option=2&whichchoice=536");	// Duke of hazard
	visit_url("choice.php?pwd&option=1&whichchoice=536");	// Enter the transporter
}

void getHelmet()
{
	visit_url("inv_use.php?pwd&whichitem=5172");			// Safety shelter Grimace prime
	visit_url("choice.php?pwd&option=1&whichchoice=536");	// Down the hatch
	visit_url("choice.php?pwd&option=2&whichchoice=536");	// Coat check
	visit_url("choice.php?pwd&option=2&whichchoice=536");	// Stage right
	visit_url("choice.php?pwd&option=2&whichchoice=536");	// Starboard door
	visit_url("choice.php?pwd&option=1&whichchoice=536");	// Enter the transporter
}

void getJoystick()
{
	visit_url("inv_use.php?pwd&whichitem=5171");			// Safety shelter Ronald prime
	visit_url("choice.php?pwd&option=1&whichchoice=535");	// Look around
	visit_url("choice.php?pwd&option=2&whichchoice=535");	// Armory
	visit_url("choice.php?pwd&option=2&whichchoice=535");	// My left door
	visit_url("choice.php?pwd&option=1&whichchoice=535");	// Ventilation duct
	visit_url("choice.php?pwd&option=1&whichchoice=535");	// Go Back the Way You Came
}

void getThrusters()
{
	visit_url("inv_use.php?pwd&whichitem=5171");			// Safety shelter Ronald prime
	visit_url("choice.php?pwd&option=1&whichchoice=535");	// Look around
	visit_url("choice.php?pwd&option=1&whichchoice=535");	// Swimming pool
	visit_url("choice.php?pwd&option=2&whichchoice=535");	// Left, left
	visit_url("choice.php?pwd&option=1&whichchoice=535");	// Red door
	visit_url("choice.php?pwd&option=1&whichchoice=535");	// Glowy-Orange Thing
}

void main()
{
	if (item_amount($item[E.M.U. harness]) == 0)
		getHarness();
	if (item_amount($item[E.M.U. helmet]) == 0)
		getHelmet();
	if (item_amount($item[E.M.U. rocket thrusters]) == 0)
		getThrusters();
	if (item_amount($item[E.M.U. joystick]) == 0)
		getJoystick();
}