void main()
{
	cli_execute("autoattack Farming");
	use_familiar($familiar[Stocking Mimic]);
	cli_execute("Outfit Crimbo1");
	
	cli_execute("make 20 ten-leaf clover");
	adventure(20,$location[The Cheerless Spire (Level 2)]);
	cli_execute("use * ten-leaf clover");
}