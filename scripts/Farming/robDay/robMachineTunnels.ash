script "robMachineTunnels.ash"

/*******************************************************
*					robMachineTunnels()
*	Gets daily five free combats from the machine tunnels.
/*******************************************************/
void machineTunnels()
{
	// Fail-safe setup
	cli_execute("autoattack MachineElf");
	cli_execute("outfitFreeDrops.ash");
	bjornify_familiar($familiar[Grim Brother]);
	
	use_familiar($familiar[Machine Elf]);
	
	while(get_property("_machineTunnelsAdv").to_int() < 5)
		adv1($location[The Deep Machine Tunnels],-1,"");
}

void main()
{
	machineTunnels();
	cli_execute("autoattack none");
}