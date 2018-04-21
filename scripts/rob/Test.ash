script "Test.ash"

void main()
{
	// Pre-launch settings
	string manaburn = get_property("manaBurningThreshold");
	string manatrigger = get_property("manaBurningTrigger");
	string manarecover = get_property("mpAutoRecovery");
	string manatarget = get_property("mpAutoRecoveryTarget");
	
	cli_execute("set manaBurningThreshold = 0.5");
	cli_execute("set manaBurningTrigger = 0.9");
	cli_execute("set mpAutoRecovery = 0.3"); 
	cli_execute("set mpAutoRecoveryTarget = 0.5");
	
	cli_execute("set manaBurningThreshold = " + manaburn);
	cli_execute("set manaBurningTrigger = " + manatrigger);
	cli_execute("set mpAutoRecovery = " + manarecover);
	cli_execute("set mpAutoRecoveryTarget = " + manatarget);
}